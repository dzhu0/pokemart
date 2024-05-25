class SearchController < ApplicationController
    def index
        @pokemon_cards = PokemonCard.where("stock_quantity > 0")

    if params[:search].present?
        search_query = "%#{params[:search]}%"
        @pokemon_cards = @pokemon_cards.where("pokemon_cards.name LIKE ? OR pokemon_cards.description LIKE ?", search_query, search_query)
    end

    if params[:type].present?
        @pokemon_cards = @pokemon_cards.joins(:types).where(types: { id: params[:type] })
    end

        @pokemon_cards = @pokemon_cards.page(params[:page]).per(15)
    end
end
