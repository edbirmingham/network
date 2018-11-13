# Used in the network events controller for member searching.
# The returned data structure is intended to be used in a
# select2-based multiselect field.
class NetworkEventsContactsService
  GROUPS = [
    {id: "ALLSCHOOLCONTACTS", text: "All School Contacts"},
    {id: "ALLSITECONTACTS", text: "All Site Contacts"},
    {id: "ALLVOLUNTEERS", text: "All Volunteers"}
  ].freeze

  def self.call(params, query=NetworkEventContactsQuery)
    new(params, query).call
  end

  def initialize(params, query=nil)
    @params = params
    @query  = query
  end

  def call
    grouped_query_results
  end

  private

  def grouped_query_results
    @grouped_query_results ||= @query.call(@params[:id], term).group_by{|d| d['type'] }.map do |group|
      {text: group.first.humanize.titleize, children: group.last}
    end
  end

  def term
    @term ||= @params.fetch(:q, {}).fetch(:term, nil)
  end
end
