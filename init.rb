if Object.const_defined?("Formtastic")
  require 'formtastic_image'
  Formtastic::SemanticFormBuilder.send(:include, ElanDesign::Formtastic::Image)
end
