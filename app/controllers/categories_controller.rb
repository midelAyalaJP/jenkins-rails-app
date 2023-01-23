class CategoriesController < ApplicationController

    before_action :set_category, only: %i[ show update destroy ]




    def index
        @categories = Category.all();
        render json: @categories, status: :ok
    end

    def show
        
        render json: @category, status: :ok;
    end

    def create
        ActiveRecord::Base.transaction do
            @category = Category.new(create_params); #method con '!' para que entre en trycatch
            if @category.save
                render json: @category, status: :created;
            else
                render json: {error: @category.errors}, status: :unprocessable_entity
            end
        end
    end

    def update
        ActiveRecord::Base.transaction do
           
            if @category.update(update_params)
                render json: @category, status: :ok;
            else
                render json: {error: @category.errors}, status: :unprocessable_entity
            end
        end
    end


    def destroy
        ActiveRecord::Base.transaction do
            
            @category.destroy
            render json: {message: "deleted"}, status: :ok;
        end
    end



    private

    def set_category
        @category = Category.find(params[:id]);
    end

    def create_params
        params.require(:category).permit(:spanish_description,:english_description);
    end
    def update_params
        params.require(:category).permit(:spanish_description,:english_description);
    end

    
end