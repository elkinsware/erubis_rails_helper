module ActionView
  module TemplateHandlers
    class Erubis < TemplateHandler
      include Compilable
      include ::Erubis::Rails::TemplateConverter
      include ::Erubis::PreprocessingHelper

      def compile(template)
        properties = {}
        
        #src =  ::Erubis::Eruby.new(template.source, properties).src
        src =  _convert_template("#{template.source}") 
        
        logger.debug("** Erubis: src==<<'END'\n#{src}END\n")
        # Ruby 1.9 prepends an encoding to the source. However this is
        # useless because you can only set an encoding on the first line
        RUBY_VERSION >= '1.9' ? src.sub(/\A#coding:.*\n/, '') : src        
      end

      #copied from methodmissing-erubis_template_handler
      def self.install!
        ActionView::Template.register_default_template_handler(:erb, self)
        ActionView::Template.register_template_handler(:rhtml, self)
      end
      
      protected
      def logger
        @logger ||= ActionController::Base.new.logger
      end

    end
  end
end

#class ActionView::Base   # :nodoc:
#  include Erubis::Rails::TemplateConverter
#  include ::Erubis::PreprocessingHelper
#  
#  private
#  # convert template into ruby code
#  def convert_template_into_ruby_code(template)
#    return _convert_template(template)
#  end
#end

ActionView::TemplateHandlers::Erubis.install!