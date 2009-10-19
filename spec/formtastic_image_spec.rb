# coding: utf-8
require File.dirname(__FILE__) + '/test_helper'
require File.expand_path(File.join(File.dirname(__FILE__), '../init.rb'))
require 'ruby-debug'

class User
  
  attr_accessor :id, :name
  
  def self.attachment_definitions
    {:avatar => {:styles => {:small => '100x100>', :large => '300x300>'}}}
  end
  
end

class EnumField
  attr_accessor :id, :title
end

describe "Formtastic" do
  
  include ActionView::Helpers::FormHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::ActiveRecordHelper
  include ActionView::Helpers::RecordIdentificationHelper
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::CaptureHelper
  include ActiveSupport
  include ActionController::PolymorphicRoutes

  include Formtastic::SemanticFormHelper

  attr_accessor :output_buffer
  
  def protect_against_forgery?; false; end
  
  before do
    
    @output_buffer = ''

    @user = User.new
    
    def user_path(o); "/users/1"; end
    def users_path; "/users"; end
    
  end
  
  it "should have included the ElanDesign::Formtastic::Image module" do
    Formtastic::SemanticFormBuilder.included_modules.should include(ElanDesign::Formtastic::Image)
  end
  
  it "should render an :as => :image field as a file input" do
    semantic_form_for @user do |builder|
      concat(
        builder.inputs { 
          concat(builder.input(:avatar, :as => :image))
        }
      )
    end
    output_buffer.should have_tag("li.image input[type=file]")
  end
  
end