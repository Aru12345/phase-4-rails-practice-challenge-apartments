class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid,with: :render_unprocessable_entity_response
    def index
        apartment=Apartment.all 
        render json: apartment,status: :ok

    end

    def create
        apartment=Apartment.create!(apartment_params)
        render json: apartment,status: :created

    end

    def update
        apartment=find_apartment
        if apartment
            apartment.update(apartment_params)
            render json: apartment
        else
            render json: {error: "Apartment not found"},
        end

    end

    def destroy
        tenant=find_apartment
        tenant.destroy
        head :no_content

    end

    private

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find(params[:id])

    end

    def render_not_found_response
        render json: {error:"Apartment not found"},status: :not_found
    end

    def render_unprocessable_entity_response
        render json: { errors: exception.record.errors.full_messages },status: :unprocessable_entity
    end

    end
end
