class OrdersController < ApplicationController
    before_action :authenticate_customer!
    before_action :validate_cart, only: [:edit_shipping_address, :update_shipping_address]

    def index
        @orders = current_customer.orders
    end

    def show
        @order = current_customer.orders.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end

    def edit_shipping_address
        @address = session.delete(:address) || current_customer.address
        @province_id = session.delete(:province_id) || current_customer.province_id
    end

    def update_shipping_address
        flash[:errors] = []
        session[:address] = params[:address] || ""
        session[:province_id] = params[:province_id] || ""

        if session[:address].empty?
            flash[:errors] << "Address can't be blank"
        end

        if session[:province_id].empty?
            flash[:errors] << "Province can't be blank"
        else
            begin
                Province.find(session[:province_id])
            rescue ActiveRecord::RecordNotFound
                flash[:errors] << "Province is invalid"
            end
        end

        return redirect_to edit_shipping_address_orders_path if flash[:errors].present?

        current_customer.address = session[:address]
        current_customer.province_id = session[:province_id]
        current_customer.save

        # redirect_to new_order_path
    end

    private

    def validate_cart
        redirect_to cart_index_path if @cart.empty?
    end
end
