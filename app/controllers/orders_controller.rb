class OrdersController < ApplicationController
    before_action :authenticate_customer!
    before_action :validate_cart, only: [:new, :edit_shipping_address, :update_shipping_address]
    before_action :validate_shipping_address, only: [:new]

    def index
        @orders = current_customer.orders
    end

    def show
        @order = current_customer.orders.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end

    def new
        @pokemon_cards = PokemonCard.where(id: @cart.pluck("id"))

        @subtotal = @cart.sum { |item| item["quantity"] * @pokemon_cards.find(item["id"]).price }

        @tax_history = current_customer.province.tax_histories.order(created_at: :desc).first

        @pst = @subtotal * (@tax_history&.pst || 0) / 100
        @gst = @subtotal * (@tax_history&.gst || 0) / 100
        @hst = @subtotal * (@tax_history&.hst || 0) / 100

        @total = @subtotal + @pst + @gst + @hst
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

        redirect_to new_order_path
    end

    private

    def validate_cart
        redirect_to cart_index_path if @cart.empty?
    end

    def validate_shipping_address
        redirect_to edit_shipping_address_orders_path if current_customer.address.empty? || current_customer.province_id.nil?
    end
end
