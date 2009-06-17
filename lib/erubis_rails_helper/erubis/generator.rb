##
## This is a copy of the generator.rb from the Erubis 2.6.4 gem
## The modification I made was that you can substitute any variable name (i.e. @output_buffer) for _buf.
## This is necessary for Erubis to work with Rails 2.3 and 2.2 because ActionView code like CaptureHelper
## relies on @output_buffer to be used and not _buf to work correctly.
##

##
## $Rev: 77 $
## $Release: 2.6.4 $
## copyright(c) 2006-2009 kuwata-lab.com all rights reserved.
##

require 'erubis/engine'
require 'erubis/enhancer'


module Erubis


  ##
  ## code generator for Ruby
  ##
  module RubyGenerator
    include Generator
    #include ArrayBufferEnhancer
    include StringBufferEnhancer

    def init_generator(properties={})
      super
      
      @escapefunc ||= "Erubis::XmlHelper.escape_xml"
      
      set_eoutvar(properties[:eoutvar] || '_buf')
    end

    def self.supported_properties()  # :nodoc:
      return []
    end

    def escape_text(text)
      text.gsub(/['\\]/, '\\\\\&')   # "'" => "\\'",  '\\' => '\\\\'
    end

    def escaped_expr(code)
      return "#{@escapefunc}(#{code})"
    end

    #--
    #def add_preamble(src)
    #  src << "_buf = [];"
    #end
    #++

    def add_text(src, text)
      #src << " _buf << '" << escape_text(text) << "';" unless text.empty?
      src << " #{eoutvar} << '" << escape_text(text) << "';" unless text.empty?
    end

    def add_stmt(src, code)
      #src << code << ';'
      src << code
      src << ';' unless code[-1] == ?\n
    end

    def add_expr_literal(src, code)
      #src << ' _buf << (' << code << ').to_s;'
      src << " #{eoutvar} << (" << code << ").to_s;"
    end

    def add_expr_escaped(src, code)
      #src << ' _buf << ' << escaped_expr(code) << ';'
      src << " #{eoutvar} << " << escaped_expr(code) << ';'
    end

    def add_expr_debug(src, code)
      code.strip!
      s = (code.dump =~ /\A"(.*)"\z/) && $1
      src << ' $stderr.puts("*** debug: ' << s << '=#{(' << code << ').inspect}");'
    end

    #--
    #def add_postamble(src)
    #  src << "\n_buf.join\n"
    #end
    #++

    private
    ##
    ## Added to set the buffer variable name. defaults to _buf.
    ##
    def set_eoutvar(new_eoutvar = '_buf')
      @eoutvar = new_eoutvar
    end
    
    def eoutvar
      @eoutvar || '_buf'
    end
  end
end
