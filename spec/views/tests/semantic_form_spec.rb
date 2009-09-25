require File.dirname(__FILE__) + '/../../spec_helper'

class SemanticUser < ActiveRecord::Base
end

def render_form
    render :inline => %Q{
      <%form_for SemanticUser.new, :url => '', :builder => SemanticFormBuilder do |f|%>
       #{yield}
      <%end%>
    }

end

describe 'semantic form builder' do

  shared_examples_for "a form field" do
    it "should have a surrounding div" do
      response.should have_tag "form div.#{@field_type}-field"
    end

    it "should have a label" do
      response.should have_tag "form div label[for=#{@field_id}]"
    end
  end

  shared_examples_for "a non-required field" do
    it "should not have a required marking" do
      response.should_not have_tag 'form>sup', '*'
    end

    it "should not have a surrounding div with required class" do
      response.should_not have_tag "form div.#{@field_type}-field.required"
    end
  end

  shared_examples_for "a field without help" do
    it "should not have a help message" do
      response.should_not have_tag 'form>span.help'
    end
  end

  shared_examples_for "a required field" do
    it "should indicate the field is required" do
      response.should have_tag "form div.#{@field_type}-field.required"
      response.should have_tag 'form div label strong sup', '*'
    end
  end

  shared_examples_for "a field with help" do
    it "should have a help message" do
      response.should have_tag 'form div label>span.help', 'i need pants'
    end
  end

  describe "text_field" do
    before(:each) do
      @field_type = 'text'
      @field_id = 'semantic_user_name'
    end

    describe "no options" do
      before(:each) do
        render_form do
          %Q{<%=f.text_field :name%>}
        end
      end

      it_should_behave_like "a form field"
      it_should_behave_like "a non-required field"
      it_should_behave_like "a field without help"

      it "should render an input field" do
        response.should have_tag 'form div>div.input>input#semantic_user_name[type="text"]'
        response.should_not have_tag "input#semantic_user_name.required"
      end
    end    

    describe "with all options" do
      before(:each) do
        render_form do
          %Q{<%=f.text_field :name, :required => true, :help => 'i need pants'%>}
        end
      end

      it_should_behave_like "a form field"
      it_should_behave_like "a required field"
      it_should_behave_like "a field with help"

      it "should have a correctly formatted input field" do
        response.should have_tag 'form div>div.input>input#semantic_user_name.required[type="text"]'
      end
    end
  end

  describe "password_field" do
    before(:each) do
      @field_type = 'password'
      @field_id = 'semantic_user_password'
    end

    describe "no options" do
      before(:each) do
        render_form do
          %Q{<%=f.password_field :password%>}
        end
      end
      
      it_should_behave_like "a form field"
      it_should_behave_like "a non-required field"
      it_should_behave_like "a field without help"

      it "should render an input field" do
        response.should have_tag "form div>div.input>input#semantic_user_password[type='password']"
        response.should_not have_tag "input#semantic_user_password.required"
      end
    end

    describe "with all options" do
      before(:each) do
        render_form do
          %Q{<%=f.password_field :password, :required => true, :help => 'i need pants'%>}
        end
      end

      it_should_behave_like "a form field"
      it_should_behave_like "a required field"
      it_should_behave_like "a field with help"

      it "should have a correctly formatted input field" do
        response.should have_tag 'form div>div.input>input#semantic_user_password.required[type="password"]'
      end
    end
    
  end

  describe "text_area" do
    before(:each) do
      @field_type = 'textarea'
      @field_id = 'semantic_user_body'
    end

    describe "no options" do
      before(:each) do
        render_form do
          %Q{<%=f.text_area :body%>}
        end
      end

      it_should_behave_like "a form field"
      it_should_behave_like "a non-required field"
      it_should_behave_like "a field without help"

      it "should render an input field" do
        response.should have_tag 'form div>div.input>textarea#semantic_user_body'
        response.should_not have_tag "textarea#semantic_user_body.required"
      end
    end    

    describe "with all options" do
      before(:each) do
        render_form do
          %Q{<%=f.text_area :body, :required => true, :help => 'i need pants'%>}
        end
      end

      it_should_behave_like "a form field"
      it_should_behave_like "a required field"
      it_should_behave_like "a field with help"

      it "should have a correctly formatted input field" do
        response.should have_tag 'form div>div.input>textarea#semantic_user_body.required'
      end
    end
  end

  describe "file_field" do
    before(:each) do
      @field_type = 'file'
      @field_id = 'semantic_user_file'
    end

    describe "no options" do
      before(:each) do
        render_form do
          %Q{<%=f.file_field :file%>}
        end
      end

      it_should_behave_like "a form field"
      it_should_behave_like "a non-required field"
      it_should_behave_like "a field without help"

      it "should render an input field" do
        response.should have_tag 'form div>div.input>input#semantic_user_file[type="file"]'
        response.should_not have_tag "input#semantic_user_file.required"
      end
    end    

    describe "with all options" do
      before(:each) do
        render_form do
          %Q{<%=f.file_field :file, :required => true, :help => 'i need pants'%>}
        end
      end

      it_should_behave_like "a form field"
      it_should_behave_like "a required field"
      it_should_behave_like "a field with help"

      it "should have a correctly formatted input field" do
        response.should have_tag 'form div>div.input>input#semantic_user_file.required[type="file"]'
      end
    end
  end

  describe "select" do
    before(:each) do
      @field_type = 'select'
      @field_id = 'semantic_user_option'
    end

    describe "no options" do
      before(:each) do
        render_form do
          %Q{<%=f.select :option, ["one", "two"]%>}
        end
      end

      it_should_behave_like "a form field"
      it_should_behave_like "a non-required field"
      it_should_behave_like "a field without help"

      it "should render options" do
        response.should have_tag "form div>div.input>select#semantic_user_option" do
          with_tag "option[value='one']", "one"
          with_tag "option[value='two']", "two"
        end
      end

      it "should render an input field" do
        response.should have_tag 'form div>div.input>select#semantic_user_option'
        response.should_not have_tag "select#semantic_user_option.required"
      end
    end    

    describe "with all options" do
      before(:each) do
        render_form do
          %Q{<%=f.select :option, ["one", "two"], {:required => true, :help => 'i need pants'}, {:class => "bob"}%>}
        end
      end

      it_should_behave_like "a form field"
      it_should_behave_like "a required field"
      it_should_behave_like "a field with help"

      it "should render options" do
        response.should have_tag "form div>div.input>select#semantic_user_option" do
          with_tag "option[value='one']", "one"
          with_tag "option[value='two']", "two"
        end
      end

      it "should have a correctly formatted input field" do
        response.should have_tag 'form div>div.input>select#semantic_user_option.required'
      end
    end
  end
end
