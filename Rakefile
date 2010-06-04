require 'rake'
require 'rake/rdoctask'

desc 'Default: run specs.'
task :default => :spec

desc 'Generate documentation for the kuaiqian plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Tenpay'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "kuaiqian"
    s.summary = "A Ruby wrapper of Kauqian(快钱) Payment API"
    s.email = "zhangyuanyi@gmail.com"
    s.homepage = "http://github.com/yzhang/kuaiqian"
    s.description = "A Ruby wrapper of Kauqian(快钱) Payment API"
    s.authors = ["Yuanyi Zhang"]
    s.files =  FileList["[A-Z]*", "{lib}/**/*", '.gitignore']
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end