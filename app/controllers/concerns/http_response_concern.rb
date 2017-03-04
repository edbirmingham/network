module HttpResponseConcern
  extend ActiveSupport::Concern
  def render_404
    render file: 'public/404.html', status: 404, layout: false
  end
  
  def render_500
    render file: 'public/500.html', status: 500, layout: false
  end
end