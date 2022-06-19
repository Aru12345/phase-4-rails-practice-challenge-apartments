class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid,with: :render_unprocessable_entity_response
    def index
        tenant=Tenant.all
        render json: tenant,status: :ok

    end

    def create
        tenant=Tenant.create!(tenant_params)
        render json: tenant,status: :created

    end

    def update
        tenant=find_tenant
        if tenant
            tenant.update(tenant_params)
            render json: tenant
        else
            render json: {error: "Tenant not found"},

        end

    end

    def destroy
        tenant=find_tenant
        tenant.destroy
        head :no_content

    end

    private
    def tenant_params
        params.permit(:name,:age)

    end

    def find_tenant
        Tenant.find(params[:id])

    end
    def render_not_found_response
        render json: {error:"Apartment not found"},status: :not_found
    end

    def render_unprocessable_entity_response
        render json: { errors: exception.record.errors.full_messages },status: :unprocessable_entity
    end
end
