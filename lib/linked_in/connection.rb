module LinkedIn
  # Used to perform requests against LinkedIn's API.
  class Connection < ::Faraday::Connection

    ::Faraday::Response.register_middleware mash: ::LinkedIn::MashMiddleware

    def initialize(url=nil, options=nil, &block)

      if url.is_a? Hash
        options = url
        url = options[:url]
      end

      url = default_url if url.nil?

      super url, options, &block

      self.response :mash
      self.response :raise_error
    end


    private ##############################################################


    def default_url
      LinkedIn.config.api + LinkedIn.config.api_version
    end
  end
end
