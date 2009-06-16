module Erubis
  module Rails
    module TemplateConverter
      def _convert_template(template)    # :nodoc:
        preprocessor = _create_preprocessor(template)
        template = preprocessor.evaluate(_preprocessing_context_object())        
        
        properties = {:eoutvar => "@output_buffer"}
        src = ::Erubis::Eruby.new(template, properties).src
        return src
      end
      
      def _create_preprocessor(template)
        return Erubis::PreprocessingEruby.new(template, :escape=>true)
      end
      
      def _preprocessing_context_object
        return self
      end
      
    end
  end
end