module Erubis
  module OutputBufferEnhancer

    def self.desc   # :nodoc:
      #puts "inside OutputBufferEnhancer.desc\n"
      
      "set '@output_buffer = _buf = \"\";'"
    end

    def add_preamble(src)
      #puts "inside OutputBufferEnhancer.add_preamble(src)\n"
      
      src << "__in_erubis_template=true; @output_buffer = _buf = '';"
    end

  end
end