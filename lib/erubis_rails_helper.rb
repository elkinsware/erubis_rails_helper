unless defined?(Rails) and defined?(ActionController)
  $stderr.puts %[This erubis_rails requires actionpack 2.2.2 or higher]
end

begin
  require 'erubis'
  require 'erubis/preprocessing'
  require 'erubis/helpers/rails_helper'

  require 'erubis_rails_helper/erubis/generator'
  require 'erubis_rails_helper/template_handlers/erubis'

rescue LoadError => e
  $stderr.puts %[This erubis_rails requires erubis 2.6.4\n
                 Add "config.gem 'erubis', :version => 2.6.4" to config/environment.rb]
  raise e
end
