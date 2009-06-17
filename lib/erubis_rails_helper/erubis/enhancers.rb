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
end