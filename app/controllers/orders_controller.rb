class OrdersController < ApplicationController
    before_action :authenticate_customer!

    def index
        @orders = current_customer.orders
    end

    def show
        @order = current_customer.orders.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
end
