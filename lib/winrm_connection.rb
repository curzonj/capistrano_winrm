require 'winrm'

class WINRM
  attr_reader :server
  alias :xserver :server

  def initialize(server, options)
    @user = options[:winrm_user]
    @pass = options[:winrm_password]
    @server = server
    @ssl_ca_store = options[:winrm_ssl_ca_store]
    @int_hash = {
      :server => server,
      :options => options
    }
  end

  def [](key)
    @int_hash[key.to_sym]
  end
  
  def []=(key, value)
    @int_hash[key.to_sym] = value
  end

  def open_channel
    yield self
  end

  def endpoint
    http_method = ( server.port.to_s=~/(443|5986)/ ? 'https' : 'http' )
    "#{http_method}://#{server}/wsman"
  end

  def exec(cmd)
    inst = WinRM::SOAP::WinRMWebService.new endpoint
    inst.set_auth(@user, @pass)
    inst.set_ca_trust_path(@ssl_ca_store) unless @ssl_ca_store.nil?
    @ios = inst.run_cmd(cmd)
  end

  def process_data
    @ios[:data].each do |ds|
      key = ds.keys.first
      stream = (key == :stdout) ? :out : :err
      yield self, stream, ds[key]
    end
    self[:status] = @ios[:exitcode]
  end

  def on_data; self; end
  def on_extended_data; self; end
  def on_request(req_type); self; end
  def on_close; self; end

end
