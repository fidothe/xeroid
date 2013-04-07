module Credentials
  def self.fetch
    @credentials ||= YAML.load_file(File.expand_path('../../../spec/credentials.yml', __FILE__))
  end
end
