require 'hanami/helpers'
require 'hanami/assets'

module Web
  class Application < Hanami::Application
    configure do
      ##
      # BASIC
      #

      # Define the root path of this application.
      # All paths specified in this configuration are relative to path below.
      #
      root __dir__

      # Relative load paths where this application will recursively load the
      # code.
      #
      # When you add new directories, remember to add them here.
      #
      load_paths << %w[controllers views]

      # Handle exceptions with HTTP statuses (true) or don't catch them (false).
      # Defaults to true.
      #
      # handle_exceptions true

      ##
      # HTTP
      #

      # Routes definitions for this application
      routes 'config/routes'

      # Configure Rack middleware for this application
      #
      # middleware.use Rack::Protection

      # Default format for the requests that don't specify an HTTP_ACCEPT header
      # Argument: A symbol representation of a mime type, defaults to :html
      #
      # default_request_format :html

      # Default format for responses that don't consider the request format
      # Argument: A symbol representation of a mime type, defaults to :html
      #
      # default_response_format :html

      ##
      # TEMPLATES
      #

      # The layout to be used by all views
      #
      layout :application # It will load Web::Views::ApplicationLayout

      # The relative path to templates
      templates 'templates'

      assets do
        sources << [
          'assets'
        ]
      end

      ##
      # SECURITY
      #

      # X-Frame-Options is a HTTP header supported by modern browsers.
      # It determines if a web page can or cannot be included via <frame> and
      # <iframe> tags by untrusted domains.
      #
      # Web applications can send this header to prevent Clickjacking attacks.
      #
      # Read more at:
      #
      #   * https://developer.mozilla.org/en-US/docs/Web/HTTP/X-Frame-Options
      #   * https://www.owasp.org/index.php/Clickjacking
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

      ##
      # FRAMEWORKS
      #

      # Configure the code that will yield each time Web::Action is included
      # This is useful for sharing common functionality

      controller.prepare do
        # include MyAuthentication # included in all the actions
        # before :authenticate!    # run an authentication before callback
      end

      # Configure the code that will yield each time Web::View is included
      # This is useful for sharing common functionality

      view.prepare do
        include Hanami::Helpers
        include Web::Assets::Helpers
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

    ##
    # PRODUCTION
    #
    configure :production do
      assets do
        # Don't compile static assets in production mode (eg. Sass, ES6)
        compile false
        # Use fingerprint file name for asset paths
        fingerprint true
        # Subresource Integrity
        subresource_integrity :sha256
      end
    end
  end
end
