require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MerchantApp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end
module GoogleDistanceMatrix
  # Public: Represents a distance matrix.
  #
  # Enables you to set up a origins and destinations and get
  # a distance matrix from Google. For documentation see
  # https://developers.google.com/maps/documentation/distancematrix
  #
  # Examples
  #
  #   origin_1 = GoogleDistanceMatrix::Place.new address: "Karl Johans gate, Oslo"
  #   origin_2 = GoogleDistanceMatrix::Place.new address: "Askerveien 1, Asker"
  #
  #   destination_1 = GoogleDistanceMatrix::Place.new address: "Drammensveien 1, Oslo"
  #   destination_2 = GoogleDistanceMatrix::Place.new lat: 1.4, lng: 1.3
  #
  #   matrix = GoogleDistanceMatrix::Matrix.new(
  #     origins: [origin_1, origin_2],
  #     destinations: [destination_1, destination_2]
  #   )
  #
  # You may configure the matrix. See GoogleDistanceMatrix::Configuration for options.
  #

  #
  # You can set default configuration by doing: GoogleDistanceMatrix.configure_defaults { |c| c.sensor = true }
  #
  #
  # Query API and get the matrix back
  #
  #   matrix.data   # Returns a two dimensional array.
  #                 # Rows are ordered according to the values in the origins.
  #                 # Each row corresponds to an origin, and each element within that row corresponds to
  #                 # a pairing of the origin with a destination.
  #
  #
  class Matrix
    include ActiveModel::Validations

    validates :origins, length: {minimum: 1, too_short: "must have at least one origin"}
    validates :destinations, length: {minimum: 1, too_short: "must have at least one destination"}
    validate { errors.add(:configuration, "is invalid") if configuration.invalid? }

    attr_reader :origins, :destinations, :configuration

    def initialize(attributes = {})
      attributes = attributes.with_indifferent_access

      @origins = Places.new attributes[:origins]
      @destinations = Places.new attributes[:destinations]
      @configuration = attributes[:configuration] || GoogleDistanceMatrix.default_configuration.dup
    end


    delegate :route_for,  :routes_for,  to: :routes_finder
    delegate :route_for!, :routes_for!, to: :routes_finder
    delegate :shortest_route_by_distance_to,  :shortest_route_by_duration_to,   to: :routes_finder
    delegate :shortest_route_by_distance_to!, :shortest_route_by_duration_to!,  to: :routes_finder
    delegate :shortest_route_by_duration_in_traffic_to,  to: :routes_finder
    delegate :shortest_route_by_duration_in_traffic_to!, to: :routes_finder


    # Public: The data for this matrix.
    #
    # Returns a two dimensional array, the matrix's data
    def data
      @data ||= load_matrix
    end

    def reload
      clear_from_cache!
      @data = load_matrix
      self
    end

    def reset!
      @data = nil
    end

    def loaded?
      @data.present?
    end



    def configure
      yield configuration
    end

    def url
      UrlBuilder.new(self).url
    end


    def inspect
      attributes = %w[origins destinations]
      attributes << "data" if loaded?
      inspection = attributes.map { |a| "#{a}: #{public_send(a).inspect}" }.join ', '

      "#<#{self.class} #{inspection}>"
    end


    private

    def routes_finder
      @routes_finder ||= RoutesFinder.new self
    end

    def load_matrix
      parsed = JSON.parse client.get(url, instrumentation: {elements: origins.length * destinations.length}).body

      parsed["rows"].each_with_index.map do |row, origin_index|
        origin = origins[origin_index]

        row["elements"].each_with_index.map do |element, destination_index|
          route_attributes = element.merge(origin: origin, destination: destinations[destination_index])
          Route.new route_attributes
        end
      end
    end

    def client
      client = Client.new

      if configuration.cache
        ClientCache.new client, configuration.cache
      else
        client
      end
    end

    def clear_from_cache!
      if configuration.cache
        configuration.cache.delete ClientCache.key(url)
      end
    end
  end
end
