class GatlingGun
  class ApiCall
    BASE_URL = "https://sendgrid.com/api/newsletter"
    CA_PATH  = File.join(File.dirname(__FILE__), *%w[.. .. data ca-bundle.crt])
    
    def initialize(action, parameters)
      @action     = action
      @parameters = parameters
    end
    
    def response
      url = URI.parse("#{BASE_URL}/#{@action}.json")
      res = HTTParty.post("#{url}?", :query => @parameters, :format => :json)
      Response.new(res)
    rescue Timeout::Error, Errno::EINVAL,        Errno::ECONNRESET,
           EOFError,       Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError,
           Net::ProtocolError => error
      Response.new("error" => error.message)
    end
  end
end
