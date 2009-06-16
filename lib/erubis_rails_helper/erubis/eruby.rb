module Erubis   
  class Eruby
    #include ErboutEnhancer      # will generate '_erbout = _buf = ""; '
    include OutputBufferEnhancer
    include ::Erubis::PercentLineEnhancer
    include ::Erubis::DeleteIndentEnhancer
  end

  class FastEruby
    #include ErboutEnhancer      # will generate '_erbout = _buf = ""; '
    include OutputBufferEnhancer 
    include ::Erubis::PercentLineEnhancer
    include ::Erubis::DeleteIndentEnhancer    
  end
end