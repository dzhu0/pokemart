class PokemonCardsController < ApplicationController
    def index
        @pokemon_cards = PokemonCard.where("stock_quantity > 0")

        @pokemon_cards = @pokemon_cards.page(params[:page]).per(15)
    end
end
