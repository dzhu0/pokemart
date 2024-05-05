class TypesController < ApplicationController
    def show
        @type = Type.find(params[:id])
        @pokemon_cards = @type.pokemon_cards.where("stock_quantity > 0")

        if params[:filter].present?
            case params[:filter]
            when "new"
                @pokemon_cards = @pokemon_cards.where("created_at >= ?", 3.days.ago)
            when "recently_updated"
                @pokemon_cards = @pokemon_cards.where("updated_at >= ? AND created_at < ?", 3.days.ago, 3.days.ago)
            end
        end

        @pokemon_cards = @pokemon_cards.page(params[:page]).per(15)
    rescue ActiveRecord::RecordNotFound
        render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
end
