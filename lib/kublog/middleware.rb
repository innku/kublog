module Kublog
  class Middleware
    def initialize app
      @app = app
    end

    def call env
      status, headers, response = @app.call(env)
      wants_json = env['HTTP_ACCEPT'].to_s.include?('application/json')
      gives_json = headers['Content-Type'].to_s.include?('application/json')

      if !wants_json && gives_json
        new_body = <<-HTML
          <script type="text/json">
          <!--[CDATA[
          #{response.body}
          ]]-->
          </pre>
          HTML
        headers['Content-Type'] = 'text/html'
        response.body = new_body
      end
      [status, headers, response]
    end
  end
end