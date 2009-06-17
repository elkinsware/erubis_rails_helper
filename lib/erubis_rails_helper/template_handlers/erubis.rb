module Erubis
  module OutputBufferEnhancer
    def self.desc   # :nodoc:
      "set '@output_buffer = _buf = \"\";'"
    end

    def add_preamble(src)
      src << "@output_buffer = _buf = '';"
    end

    def add_postamble(src)
      src << "\n" unless src[-1] == ?\n
      src << "@output_buffer.to_s\n"
    end
  end
  
  class Eruby
    include ::Erubis::PercentLineEnhancer
    include ::Erubis::DeleteIndentEnhancer
    include OutputBufferEnhancer    
  end

  class FastEruby
    include ::Erubis::PercentLineEnhancer
    include ::Erubis::DeleteIndentEnhancer    
    include OutputBufferEnhancer    
  end  
  
  module Helpers
    ##
    ## helper module for Ruby on Rails
    ##
    ## howto:
    ##
    ## 1. add the folliwng code in your 'config/environment.rb'
    ##
    ##      require 'erubis/helpers/rails_helper'
    ##      #Erubis::Helpers::RailsHelper.engine_class = Erubis::Eruby # or Erubis::FastEruby
    ##      #Erubis::Helpers::RailsHelper.init_properties = {}
    ##      #Erubis::Helpers::RailsHelper.show_src = false       # set true for debugging
    ##      #Erubis::Helpers::RailsHelper.preprocessing = true   # set true to enable preprocessing
    ##
    ## 2. restart web server.
    ##
    ## if Erubis::Helper::Rails.show_src is true, Erubis prints converted Ruby code
    ## into log file ('log/development.log' or so). if false, it doesn't.
    ## if nil, Erubis prints converted Ruby code if ENV['RAILS_ENV'] == 'development'.
    ##  
    module RailsHelper
      #cattr_accessor :init_properties
      @@engine_class = ::Erubis::Eruby
      #@@engine_class = ::Erubis::FastEruby
      def self.engine_class
        @@engine_class
      end
      def self.engine_class=(klass)
        @@engine_class = klass
      end

      #cattr_accessor :init_properties
      @@init_properties = {}
      def self.init_properties
        @@init_properties
      end
      def self.init_properties=(hash)
        @@init_properties = hash
      end

      #cattr_accessor :show_src
      @@show_src = nil
      def self.show_src
        @@show_src
      end
      def self.show_src=(flag)
        @@show_src = flag
      end

      #cattr_accessor :preprocessing
      @@preprocessing = false
      def self.preprocessing
        @@preprocessing
      end
      def self.preprocessing=(flag)
        @@preprocessing = flag
      end    
      
      ## define class for backward-compatibility
      class PreprocessingEruby < Erubis::PreprocessingEruby   # :nodoc:
      end
        
      module TemplateConverter
        def _convert_template(template)    # :nodoc:
          
          klass      = ::Erubis::Helpers::RailsHelper.engine_class
          properties = ::Erubis::Helpers::RailsHelper.init_properties || {}
          
          if preprocess?
            preprocessor = _create_preprocessor(template)
            template = preprocessor.evaluate(_preprocessing_context_object())        
          end
          
          src = klass.new(template, properties.merge(:eoutvar => "@output_buffer")).src
          return src
        end
        
        def _create_preprocessor(template)
          return PreprocessingEruby.new(template, :escape=>true)
        end
        
        def _preprocessing_context_object
          return self
        end
        
        def preprocess?
          ::Erubis::Helpers::RailsHelper.preprocessing
        end
      end      
    end
  end
end

module ActionView
  module TemplateHandlers
    class Erubis < TemplateHandler
      include Compilable
      include ::Erubis::Helpers::RailsHelper::TemplateConverter
      include ::Erubis::PreprocessingHelper

      def compile(template)
        src =  _convert_template("#{template.source}") 
        
        if show_source?
          logger.debug("** Erubis: src==<<'END'\n#{src}END\n") if logger
        end
        
        # Ruby 1.9 prepends an encoding to the source. However this is
        # useless because you can only set an encoding on the first line
        RUBY_VERSION >= '1.9' ? src.sub(/\A#coding:.*\n/, '') : src        
      end
     
      protected
      def logger
        @logger ||= ActionController::Base.new.logger
      end    

      def show_source?
        return ::Erubis::Helpers::RailsHelper.show_src if not ::Erubis::Helpers::RailsHelper.show_src.nil?
        ENV['RAILS_ENV'] == 'development' if ::Erubis::Helpers::RailsHelper.show_src.nil?
      end 
    end
    
    handler_klass = TemplateHandlers::Erubis
    Template.register_default_template_handler(:erb, handler_klass)
    Template.register_template_handler(:rhtml, handler_klass)
  end
end