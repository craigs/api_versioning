class Api::BaseApi
  
  attr_accessor :api_version

  API_VERSION_REGEX = /v[0-9]+(_[0-9]+)*/i
  
  def initialize(version=nil)
    set_api_version(version)
  end
  
  def render(data)
    respond_to?(api_version) ? self.send(api_version, data) : nil
  end
  
  def timestamps(json, data)
    json.id data.id.to_s
    json.created_at data.created_at
    json.updated_at data.updated_at
  end
  
  private
  def latest_version
    api_versions.sort.last
  end

  def api_versions
    @@api_versions ||= self.class.instance_methods.grep(API_VERSION_REGEX)
  end
  
  def api_version?(version)
    return false if version.nil?
    api_versions.include?(version.to_sym)
  end

  def set_api_version(version)
    self.api_version = (api_version?(version) ? version.to_sym : latest_version)
  end

end