module ActionView
  module Helpers
    module CaptureHelper
      def capture(*args, &block)
        # Return captured buffer in erb.
        if block_called_from_erb?(block)
          with_output_buffer { block.call(*args) }
        elsif block_called_from_erubis?(block)
          buffer = eval( "@output_buffer", block.binding, __FILE__, __LINE__) rescue nil
          if buffer
            puts "[inside capture] buffer.object_id = #{buffer.object_id}\n"
          end
           
          with_output_buffer { block.call(*args) }
          
#          puts "hello...block_called_from_erubis?(block)...\n"
#          buffer = eval( "@output_buffer", block.binding, __FILE__, __LINE__) rescue nil 
#          if buffer.nil?
#            puts "hello...if buffer.nil?...\n"
#            block.call(*args)
#          else
#            puts "hello...else of if buffer.nil?...#{buffer.length}\n"
#            pos = buffer.length
#            block.call(*args)
#            
#            puts "buffer = #{buffer.inspect}\n"
#            puts "buffer[pos..-1] = #{buffer[pos..-1]}\n"
#            
#            result = buffer[pos..-1]
#            buffer[pos..-1] = ''
#            
#            puts "result = #{result}\n"
#            puts "buffer = #{buffer.inspect}\n"
#            result
#          end            
        else
          # Return block result otherwise, but protect buffer also.
          with_output_buffer { return block.call(*args) }
        end
      end    
      
      # Use an alternate output buffer for the duration of the block.
      # Defaults to a new empty string.
      def with_output_buffer(buf = '') #:nodoc:
        
        #self.output_buffer, old_buffer = buf, output_buffer
        
        puts "10 [inside with_output_buffer] self.output_buffer.object_id = #{self.output_buffer.object_id}\n"
        puts "10 [inside with_output_buffer] self.output_buffer.object_id = #{self.output_buffer.object_id}\n"
        puts "20 [inside with_output_buffer] buf.object_id = #{buf.object_id}\n"
        old_buffer = self.output_buffer
        puts "30 [inside with_output_buffer] old_buffer.object_id = #{old_buffer.object_id}\n"
        self.output_buffer = buf
        puts "40 [inside with_output_buffer] self.output_buffer.object_id = #{self.output_buffer.object_id}\n"
        
        yield
        
        puts "50 [inside with_output_buffer] old_buffer.object_id = #{old_buffer.object_id}\n"
        puts "60 [inside with_output_buffer] self.output_buffer.object_id = #{self.output_buffer.object_id}\n"
        puts "65 [inside with_output_buffer] output_buffer = #{output_buffer}\n"
        output_buffer
      ensure
        self.output_buffer = old_buffer
        
        puts "70 [inside with_output_buffer] old_buffer.object_id = #{old_buffer.object_id}\n"
        puts "80 [inside with_output_buffer] self.output_buffer.object_id = #{self.output_buffer.object_id}\n"        
        puts "90 [inside with_output_buffer] output_buffer = #{output_buffer}\n"
      end
      
      private
      BLOCK_CALLED_FROM_ERUBIS = 'defined? __in_erubis_template'

      if RUBY_VERSION < '1.9.0'
        def block_called_from_erubis?(block)
          block && eval(BLOCK_CALLED_FROM_ERUBIS, block)
        end
      else
        def block_called_from_erubis?(block)
          block && eval(BLOCK_CALLED_FROM_ERUBIS, block.binding)
        end
      end   

    end
  end
end