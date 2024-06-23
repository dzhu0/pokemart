class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :load_cart
    before_action :load_total_quantity

    private

    def load_cart
        session[:cart] ||= []
        @cart = session[:cart]
    end

    def load_total_quantity
        @total_quantity = @cart.sum { |item| item["quantity"] }
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :address, :province_id, :password, :password_confirmation]
        devise_parameter_sanitizer.permit :account_update, keys: [:username, :email, :address, :province_id, :password, :password_confirmation, :current_password]
    end
end
