module Erubis
  ##
  ## convert "<h1><%=title%></h1>" into "@output_buffer << %Q`<h1>#{title}</h1>`"
  ##
  ## this is only for Eruby.
  ##
  module InterpolationEnhancer

    def self.desc   # :nodoc:
      "convert '<p><%=text%></p>' into '@output_buffer << %Q`<p>\#{text}</p>`'"
    end

    def convert_input(src, input)
      pat = @pattern
      regexp = pat.nil? || pat == '<% %>' ? Basic::Converter::DEFAULT_REGEXP : pattern_regexp(pat)
      pos = 0
      is_bol = true     # is beginning of line
      str = ''
      input.scan(regexp) do |indicator, code, tailch, rspace|
        match = Regexp.last_match()
        len  = match.begin(0) - pos
        text = input[pos, len]
        pos  = match.end(0)
        ch   = indicator ? indicator[0] : nil
        lspace = ch == ?= ? nil : detect_spaces_at_bol(text, is_bol)
        is_bol = rspace ? true : false
        _add_text_to_str(str, text)
        ## * when '<%= %>', do nothing
        ## * when '<% %>' or '<%# %>', delete spaces iff only spaces are around '<% %>'
        if ch == ?=              # <%= %>
          rspace = nil if tailch && !tailch.empty?
          str << lspace if lspace
          add_expr(str, code, indicator)
          str << rspace if rspace
        elsif ch == ?\#          # <%# %>
          n = code.count("\n") + (rspace ? 1 : 0)
          if @trim && lspace && rspace
            add_text(src, str)
            str = ''
            add_stmt(src, "\n" * n)
          else
            str << lspace if lspace
            add_text(src, str)
            str = ''
            add_stmt(src, "\n" * n)
            str << rspace if rspace
          end
        else                     # <% %>
          if @trim && lspace && rspace
            add_text(src, str)
            str = ''
            add_stmt(src, "#{lspace}#{code}#{rspace}")
          else
            str << lspace if lspace
            add_text(src, str)
            str = ''
            add_stmt(src, code)
            str << rspace if rspace
          end
        end
      end
      #rest = $' || input                       # ruby1.8
      rest = pos == 0 ? input : input[pos..-1]  # ruby1.9
      _add_text_to_str(str, rest)
      add_text(src, str)
    end

    def add_text(src, text)
      return if !text || text.empty?
      #src << " _buf << %Q`" << text << "`;"
      if text[-1] == ?\n
        text[-1] = "\\n"
        src << " @output_buffer << %Q`" << text << "`\n"
      else
        src << " @output_buffer << %Q`" << text << "`;"
      end
    end

    def _add_text_to_str(str, text)
      return if !text || text.empty?
      text.gsub!(/['\#\\]/, '\\\\\&')
      str << text
    end

    def add_expr_escaped(str, code)
      str << "\#{#{escaped_expr(code)}}"
    end

    def add_expr_literal(str, code)
      str << "\#{#{code}}"
    end
  end
  
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

class ActionView::Base   # :nodoc:
  include ::Erubis::Helpers::RailsHelper::TemplateConverter
  include ::Erubis::PreprocessingHelper
  
  private
  # convert template into ruby code
  def convert_template_into_ruby_code(template)
    #ERB.new(template, nil, @@erb_trim_mode).src
    return _convert_template(template)
  end
end

module ActionView
  module TemplateHandlers
    class Erubis < TemplateHandler
      include Compilable
      include ::Erubis::Helpers::RailsHelper::TemplateConverter
      include ::Erubis::PreprocessingHelper

      def compile(template)
        src =  _convert_template("<% __in_erb_template=true %>#{template.source}") 
        
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