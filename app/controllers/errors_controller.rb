class ErrorsController < ApplicationController
  def not_found
    render file: 'public/404.html', status: 404, layout: true
  end
  def internal_server_error
    render file: 'public/500.html', status: 500, layout: true
  end
end

