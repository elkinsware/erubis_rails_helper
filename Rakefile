#require 'rubygems' unless ENV['NO_RUBYGEMS']
#%w[rake rake/clean fileutils newgem rubigen].each { |f| require f }
#require File.dirname(__FILE__) + '/lib/erubis_rails_helper'
#
#ENV['HOME'] ||= ENV['HOMEPATH']
#
## Generate all the Rake tasks
## Run 'rake -T' to see list of generated tasks (from gem root directory)
#$hoe = Hoe.new('erubis_rails_helper', ErubisRailsHelper::VERSION) do |p|
#  p.developer('dave elkins', 'dave@elkinsware.com')
#  p.changes              = p.paragraphs_of("History.txt", 0..1).join("\n\n")
#  p.post_install_message = 'PostInstall.txt' # TODO remove if post-install message not required
#  p.rubyforge_name       = p.name # TODO this is default value
#  p.extra_deps         = [
#     ['actionpack','>= 2.2.2'],
#     ['erubis','>= 2.6.2']
#  ]
#  p.extra_dev_deps = [
#    ['newgem', ">= #{::Newgem::VERSION}"]
#  ]
#  
#  p.clean_globs |= %w[**/.DS_Store tmp *.log]
#  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
#  p.remote_rdoc_dir = File.join(path.gsub(/^#{p.rubyforge_name}\/?/,''), 'rdoc')
#  p.rsync_args = '-av --delete --ignore-errors'
#end
#
#require 'newgem/tasks' # load /tasks/*.rake
#Dir['tasks/**/*.rake'].each { |t| load t }
#
## TODO - want other tests/tasks run by default? Add them to the list
## task :default => [:spec, :features]

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "erubis_rails_helper"
    gemspec.summary = "Drop in replacement for the Rails integration in the Erubis gem so that Erubis will work with Rails 2.3."
    gemspec.email = "dave@elkinsware.com"
    gemspec.homepage = "http://github.com/elkinsware/erubis_rails_helper/tree/master"
    gemspec.description = "Drop in replacement for the Rails integration in the Erubis gem so that Erubis will work with Rails 2.3."
    gemspec.authors = ["Dave Elkins"]
    
    gemspec.add_dependency('actionpack', '>= 2.2.2')
    gemspec.add_dependency('erubis', '>= 2.6.2')    
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
