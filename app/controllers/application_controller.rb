class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    def render_404(e = nil)
        logger.info "Rendering 404 with exception: #{e.message}" if e
        render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
    end
end
