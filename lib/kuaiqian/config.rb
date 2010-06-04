module Kuaiqian
  class Config
    class << self
      def spid; config['spid'];  end
      def key; config['key']; end
    
      def config
        @@config ||= lambda do
          require 'yaml'
          filename = "#{Rails.root}/config/kuaiqian.yml"
          file     = File.open(filename)
          yaml     = YAML.load(file)
          return yaml[Rails.env]
        end.call
      end
    end
  end
end