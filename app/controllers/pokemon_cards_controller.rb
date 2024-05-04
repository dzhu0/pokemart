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

    def show
        @pokemon_card = PokemonCard.find(params[:id])
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false unless @pokemon_card.stock_quantity > 0
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
end
