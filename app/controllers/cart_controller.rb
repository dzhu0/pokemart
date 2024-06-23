class CartController < ApplicationController
    def index
        @pokemon_cards = PokemonCard.where(id: @cart.pluck("id"))
        @subtotal = @cart.sum { |item| item["quantity"] * @pokemon_cards.find(item["id"]).price }
    end
end
