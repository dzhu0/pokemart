class PokemonCardsController < ApplicationController
    def index
        @pokemon_cards = PokemonCard.where("stock_quantity > 0")

        if params[:filter].present?
            case params[:filter]
            when "new"
                @pokemon_cards = @pokemon_cards.where("created_at >= ?", 3.days.ago)
            when "recently_updated"
                @pokemon_cards = @pokemon_cards.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago)
            end
        end

        @pokemon_cards = @pokemon_cards.page(params[:page]).per(15)
    end
end
