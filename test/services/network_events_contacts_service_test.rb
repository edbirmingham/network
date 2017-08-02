require 'test_helper'

class NetworkEventsContactsServiceTest < ActiveSupport::TestCase 
  setup do
    @network_event = network_events(:tuggle_network)
  end

  test "returns a special list of member groupings if the query starts with 'all'" do
    assert_equal([{:text=>"All", :children=>[{"id"=>NetworkEventContactsQuery::ALL_VOLUNTEERS, "type"=>"All", "text"=>"All Volunteers"}]}],
      NetworkEventsContactsService.call({id: @network_event.id, q: { term: "all vol"} }))
  end

  test "returns an empty set when there are no matches" do
    assert_equal [], NetworkEventsContactsService.call({})
  end

  test "delegates searching to a query object" do
    query = mock('Query Object')
    data = [
      {"type" => "Site Contact", text: "bob", id: "1234"},
      {"type" => "Site Contact", text: "bobby", id: "5678"}
    ]
    query.expects(:call).with(@network_event.id, "bob").returns(data)

    # This assertion is checking the results are grouped under the type.
    # This allows select2 to show the results under a 'Site Contact' group (similar to <optgroup>)
    assert_equal([
      {
        text: "Site Contact",
        children: [
          {"type" => "Site Contact", text: "bob", id: "1234"},
          {"type" => "Site Contact", text: "bobby", id: "5678"}
       ]
      }
    ], NetworkEventsContactsService.call({id: @network_event.id, q: {term: "bob"}}, query))
  end
end
