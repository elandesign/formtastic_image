module ElanDesign
  module Formtastic
    module Image
      
      def self.included(base)
        base.send(:extend, ClassMethods)
      end
      
      module ClassMethods
        
        @@image_preview_sizes = [ :preview, :thumbnail, :thumb, :small ]
        
        def image_preview_sizes
          @@image_preview_sizes
        end
        
        def image_preview_sizes=(value)
          @@image_preview_sizes = value
        end
        
      end

        
      protected
    
      def image_input(method, options)
        html_options = options.delete(:input_html) || {}
        
        self.label(method, options_for_label(options)) +
        self.image_preview(method, options) + 
        self.send(:file_field, method, html_options)
      end
    
      def detect_preview_size(method)
        self.class.send(:image_preview_sizes).each do |size|
          return size if object.class.attachment_definitions[method][:styles].has_key?(size)
        end
      end
    
      def image_preview(method, options)
        preview_size = options[:preview_size] || detect_preview_size(method)
        if object.send("#{method}?")
          template.content_tag(:span, template.image_tag(object.send(method).url(preview_size)), :class => "preview #{preview_size}")
        else
          ''
        end
      end
              
    end
  end
end
