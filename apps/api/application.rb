require 'hanami/helpers'

module Api
  class Application < Hanami::Application
    configure do

      root __dir__

      load_paths << %w[controllers resources]

      handle_exceptions true

      routes 'config/routes'

      default_request_format :json
      default_response_format :json
      body_parsers :json
      controller.format jsonapi: 'application/vnd.api+json'


      ##
      # SECURITY
      #

      security.x_frame_options 'DENY'

      # X-Content-Type-Options prevents browsers from interpreting files as
      # something else than declared by the content type in the HTTP headers.

      security.x_content_type_options 'nosniff'

      # X-XSS-Protection is a HTTP header to determine the behavior of the
      # browser in case an XSS attack is detected.

      security.x_xss_protection '1; mode=block'

      security.content_security_policy %{
        form-action 'self';
        frame-ancestors 'self';
        base-uri 'self';
        default-src 'none';
        script-src 'self';
        connect-src 'self';
        img-src 'self' https: data:;
        style-src 'self' 'unsafe-inline' https:;
        font-src 'self';
        object-src 'none';
        plugin-types application/pdf;
        child-src 'self';
        frame-src 'self';
        media-src 'self'
      }

      controller.prepare do
      end
    end

    ##
    # DEVELOPMENT
    #
    configure :development do
      # Don't handle exceptions, render the stack trace
      handle_exceptions false
    end

    ##
    # TEST
    #
    configure :test do
      # Don't handle exceptions, render the stack trace
      handle_exceptions false
    end
  end
end
