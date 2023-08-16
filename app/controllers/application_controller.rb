class ApplicationController < ActionController::Base

	helper_method :breadcrumbs
	before_action :set_breadcrumbs
	before_action :set_headers
	before_action :set_theme

	Cyrillizer.language = :russian

	def breadcrumbs
	  @breadcrumbs ||= []
	end
  
	def add_breadcrumb(name, path = nil)
	  breadcrumbs << Breadcrumb.new(name, path)
	end

    def set_breadcrumbs
		add_breadcrumb("Панель админитсратора", control_panel_path) if session[:admin]
		add_breadcrumb("Главная", root_url(subdomain: false)) if !session[:admin]
	end

	def not_found
		raise ActionController::RoutingError.new('Not Found')
	rescue
		render file: "#{Rails.root}/public/404.html", status: :not_found
	end

	def unprocessable_entity 
		raise ActionController::RoutingError.new('Unprocessable entity')
	rescue
		render file: "#{Rails.root}/public/422.html", status: :unprocessable_entity
	end

	def internal_server_error
		raise ActionController::RoutingError.new('Internal server error')
	rescue
		render file: "#{Rails.root}/public/500.html", status: :internal_server_error
	end

	def loggedin
		if session[:admin]
			return
		else
			not_found
		end
	end

	def set_theme	
		if cookies[:theme].nil?
			cookies[:theme] = "default"
		end
	end

	private

	def set_headers
		@headers = Header.all
	end

end
