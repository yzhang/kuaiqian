require 'rails/generators'

class KuaiqianGenerator < Rails::Generators::Base
  def install_douban
    copy_file("kuaiqian.yml", 'config/kuaiqian.yml')
  end
  
  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end
end
