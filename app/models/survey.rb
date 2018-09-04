class Survey
  def initialize(user)
    @user = user
  end
  
  def find(id)
    api.surveys._(id).get.parsed_body
  end
  
  def find_all
    api.
      surveys.
      get(
        query_params: { include: "response_count"}
      ).
      parsed_body
  end
  
  def recipients(id)
    result = []
    collectors(id).each do |collector|
      result << api.
        collectors.
        _(collector[:id]).
        recipients.
        get(
          query_params: { include: "survey_response_status,survey_link"}
        ).
        parsed_body[:data]
    end
    
    result.flatten
  end
  
  private
  
  def api
    SendGrid::Client.new(
      host: 'https://api.surveymonkey.com/v3', 
      request_headers: {
        'Authorization' => "Bearer #{bearer_token}", 
        "Content-Type" => "application/json"
      }
    )
  end
  
  def bearer_token
    @user.surveymonkey_token
  end
  
  def collectors(id)
    api.surveys._(id).collectors.get.parsed_body[:data]
  end
end