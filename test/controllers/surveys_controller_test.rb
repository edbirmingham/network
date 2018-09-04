require 'test_helper'

class SurveysControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    sign_in users(:one)
  end

  test "should get index" do
    survey = MiniTest::Mock.new
    survey.expect :find_all, find_all_response
    
    Survey.stub :new, survey do
      get :index
      assert_response :success
    end
  end

  test "should get show" do
    survey = MiniTest::Mock.new
    survey.expect :find, find_response, ['2222']
    survey.expect :recipients, recipients_response, ['2222']
    
    Survey.stub :new, survey do
      get :show, params: { id: '2222' }
      assert_response :success
    end
  end

  private
  
  def find_all_response
    {
      :per_page=>50, 
      :total=>1, 
      :data=>[
        {
          :response_count=>1, 
          :href=>"https://api.surveymonkey.com/v3/surveys/156361936", 
          :nickname=>"", 
          :id=>"156361936", 
          :title=>"Anthony's Test Survey"
        }
      ], 
      :page=>1, 
      :links=>{
        :self=>"https://api.surveymonkey.net/v3/surveys?page=1&per_page=50"
      }
    }
  end
  
  def find_response
    {
      :response_count=>1, 
      :page_count=>1, 
      :date_created=>"2018-08-17T13:10:00", 
      :buttons_text=>{
        :done_button=>"Done", 
        :prev_button=>"Prev", 
        :exit_button=>"", 
        :next_button=>"Next"
      }, 
      :folder_id=>"1740371", 
      :custom_variables=>{}, 
      :nickname=>"", 
      :id=>"156361936", 
      :question_count=>2, 
      :category=>"other", 
      :preview=>"https://www.surveymonkey.com/r/Preview/?sm=xZUY_2BxPPqsF0RqmCIon32qARpLSfQmSLhFQ7_2Fb5bAiapXDoe4ZJh8_2BukqiH3OY5i", 
      :is_owner=>true, 
      :language=>"en", 
      :footer=>true, 
      :date_modified=>"2018-09-04T00:40:00", 
      :analyze_url=>"https://www.surveymonkey.com/analyze/SZUKjwIqiyd6lBRcUyZC1_2Fd_2FBfSx13yYoV3csfey_2FbA_3D", 
      :summary_url=>"https://www.surveymonkey.com/summary/SZUKjwIqiyd6lBRcUyZC1_2Fd_2FBfSx13yYoV3csfey_2FbA_3D", 
      :href=>"https://api.surveymonkey.com/v3/surveys/156361936", 
      :title=>"Anthony Test", 
      :collect_url=>"https://www.surveymonkey.com/collect/list?sm=SZUKjwIqiyd6lBRcUyZC1_2Fd_2FBfSx13yYoV3csfey_2FbA_3D", 
      :edit_url=>"https://www.surveymonkey.com/create/?sm=SZUKjwIqiyd6lBRcUyZC1_2Fd_2FBfSx13yYoV3csfey_2FbA_3D"
    }
  end
  
  def recipients_response
    [
      {
        :survey_response_status=>"completely_responded", 
        :href=>"https://api.surveymonkey.com/v3/collectors/21541045/recipients/407284707", 
        :id=>"407278707", 
        :survey_link=>"https://www.surveymonkey.com/r/?sm=bor3i1iYLtpH_2Fl71tcgzRQ_3D_3D", 
        :email=>"example@gmail.com"
      }, {
        :survey_response_status=>"not_responded", 
        :href=>"https://api.surveymonkey.com/v3/collectors/21540445/recipients/407274708", 
        :id=>"407278408", 
        :survey_link=>"https://www.surveymonkey.com/r/?sm=Yec3dRDakLgcm3M75_2FbTwA_3D_3D", 
        :email=>"example2@gmail.com"
      }
    ]
  end
end
