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
    
    gemspec.files = FileList[
    				'lib/*.rb',
    				'lib/erubis_rails_helper/erubis/*.rb',
    				'lib/erubis_rails_helper/template_handlers/*.rb'
    			    ]

  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end
