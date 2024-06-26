class CartController < ApplicationController
    before_action :load_pokemon_card, only: [:create, :update, :destroy]
    before_action :validate_quantity, only: [:create, :update]
    before_action :load_cart_item, only: [:create, :update, :destroy]

    def index
        @pokemon_cards = PokemonCard.where(id: @cart.pluck("id"))
        @subtotal = @cart.sum { |item| item["quantity"] * @pokemon_cards.find(item["id"]).price }
    end

    def create
        if @cart_item
            temp_quantity = @cart_item["quantity"] + @quantity
            return redirect_to root_path unless temp_quantity <= @pokemon_card.stock_quantity
            @cart_item["quantity"] = temp_quantity
        else
            @cart.unshift({ "id" => @pokemon_card.id, "quantity" => @quantity })
        end

        redirect_to cart_index_path
    end

    def update
        return redirect_to root_path unless @cart_item

        @cart_item["quantity"] = @quantity

        redirect_to cart_index_path
    end

    def destroy
        @cart.delete(@cart_item) if @cart_item

        redirect_to cart_index_path
    end

    private

    def load_pokemon_card
        @pokemon_card = PokemonCard.find_by(id: params[:id])
        redirect_to root_path unless @pokemon_card
    end

    def validate_quantity
        @quantity = params[:quantity].to_i
        redirect_to root_path unless @quantity.positive? && @quantity <= @pokemon_card.stock_quantity
    end

    def load_cart_item
        @cart_item = @cart.find { |item| item["id"] == @pokemon_card.id }
    end
end
