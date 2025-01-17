# frozen_string_literal: true

module V2
  class TemplatesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_member!, only: %i[update destroy]

    def index
      presenter = V2::Templates::IndexPresenter.new

      render json: V2::Templates::IndexView.render(presenter), status: :ok
    end

    def show
      presenter = V2::Templates::ShowPresenter.new(current_user, template)

      render json: V2::Templates::ShowView.render(presenter), status: :ok
    end

    def create
      create_form.save
      presenter = V2::Templates::ShowPresenter.new(current_user, create_form.template)

      render json: V2::Templates::ShowView.render(presenter), status: :created
    end

    def update
      update_form.save
      presenter = V2::Templates::ShowPresenter.new(current_user, update_form.template)

      render json: V2::Templates::ShowView.render(presenter), status: :ok
    end

    def destroy
      template.destroy!

      head :no_content
    end

    private

    def authorize_member!
      authorize [:v2, template]
    end

    def template
      @template ||= Template.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @template

      @template
    end

    def create_form
      @create_form ||= V2::Templates::BasicForm.new(
        current_user.templates.build,
        params: create_params,
        user: current_user
      )
    end

    def update_form
      @update_form ||= V2::Templates::BasicForm.new(
        template,
        params: update_params,
        user: current_user
      )
    end

    def create_params
      params.require(:template).permit(
        :name, :destination, sections: [
          :name, :width, :group, :position, :sensitive, :_destroy,
          { skills: %i[name value needToImprove] }
        ]
      )
    end

    def update_params
      params.require(:template).permit(
        :name, :destination, sections: [
          :id, :name, :group, :width, :position, :sensitive, :_destroy,
          { skills: %i[name value needToImprove] }
        ]
      )
    end
  end
end
