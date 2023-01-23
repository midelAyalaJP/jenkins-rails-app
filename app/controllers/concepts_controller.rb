class ConceptsController < ApplicationController

    before_action :set_concept, only: %i[ show update destroy ]








    def index
        @concepts = Concept.all();
        render json: @concepts, status: :ok, route: "index"
    end

    def show
        render json: @concept, status: :ok, route: "show";
    end

    def create
        ActiveRecord::Base.transaction do
            @concept = Concept.new(create_params);
            if @concept.save
                render json: @concept, status: :created, route: "create";
            else
                render json: {error: @concept.errors}, status: :unprocessable_entity
            end
        end
    end

    def update
        ActiveRecord::Base.transaction do
            
            if @concept.update(update_params)
                render json: @concept, status: :ok, route: "update";
            else
                render json: {error: @concept.errors}, status: :unprocessable_entity
            end
        end
    end


    def destroy
        ActiveRecord::Base.transaction do
            
            @concept.destroy
            render json: {message: "deleted"}, status: :ok;
        end
    end



    private

    def set_concept
        @concept = Concept.find(params[:id]);
    end

    
    def create_params
        params.require(:concept).permit(:spanish_description, :english_description, :category_id);
    end
    def update_params
        params.require(:concept).permit(:spanish_description, :english_description, :category_id);
    end

    
end