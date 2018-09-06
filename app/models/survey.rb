class Survey
  def initialize(user)
    @user = user
  end
  
  def add_recipients(id, recipients)
    collector = new_collector(id)
    message = new_message(collector[:id])
    
    contacts = recipients.map do |recipient|
      {
        email: recipient.email,
        first_name: recipient.first_name,
        last_name: recipient.last_name,
        custom_fields: {
          "1": recipient.id.to_s
        }
      }
    end
    
    results = api.
      collectors.
      _(collector[:id]).
      messages.
      _(message[:id]).
      recipients.
      bulk.
      post(request_body: { contacts: contacts }).
      parsed_body
    
    results
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
    
    result.flatten.compact
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
  
  def new_collector(survey_id)
    api.
      surveys.
      _(survey_id).
      collectors.
      post(request_body: { type: 'email', name: 'Network generated' }).
      parsed_body
  end
  
  def collectors(survey_id)
    api.surveys._(survey_id).collectors.get.parsed_body[:data]
  end
  
  def new_message(collector_id)
    api.
      collectors.
      _(collector_id).
      messages.
      post(request_body: { type: 'invite' }).
      parsed_body
  end
  
end