module HttpResponseConcern
  extend ActiveSupport::Concern
  # this would be more for rendering unauthorized users with status 401 but
  # wanted to see your thoughts of perhaps adding something like this 
  # for external resources that may be used in the future
  def render_404
    render file: 'public/404.html', status: 404, layout: false
  end
  
  def render_500
    render file: 'public/500.html', status: 500, layout: false
  end
end