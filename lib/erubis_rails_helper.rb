unless defined?(Rails) and defined?(ActionController)
  $stderr.puts %[This erubis_rails requires actionpack 2.2.2 or higher]
end

begin
  require 'erubis'
  require 'erubis/preprocessing'
rescue LoadError
  $stderr.puts %[This erubis_rails requires erubis 2.6.4\n
                 Add "config.gem 'erubis', :version => 2.6.4" to config/environment.rb]
end  

require 'erubis_rails_helper/erubis/generator'
require 'erubis_rails_helper/erubis/enhancers'
require 'erubis_rails_helper/erubis/eruby'
require 'erubis_rails_helper/erubis/utils'
require 'erubis_rails_helper/helpers/capture_helper'
require 'erubis_rails_helper/template_handlers/erubis'

## finish
if defined?(Rails) and defined?(ActionController)
  ActionController::Base.new.logger.info "** Erubis #{::Erubis::VERSION}"
end
$stdout.puts "** Erubis #{::Erubis::VERSION}"
