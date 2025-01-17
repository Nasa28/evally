# frozen_string_literal: true

module V2
  class EvaluationEmployablesController < ApplicationController
    before_action :authenticate_user!

    def index
      evaluations = evaluations_scope.draft.order(updated_at: :desc)

      render json: V2::Evaluations::EmployableSerializer.render(evaluations), status: :ok
    end

    def draft
      presenter = V2::Evaluations::ShowPresenter.new(draft_evaluation, current_user)

      render json: V2::Evaluations::EmployableShowView.render(presenter), status: :ok
    end

    def completed
      presenter = V2::Evaluations::ShowPresenter.new(completed_evaluation, current_user)

      render json: V2::Evaluations::EmployableShowView.render(presenter), status: :ok
    end

    def form
      presenter = V2::Evaluations::FormPresenter.new(current_user)

      render json: V2::Evaluations::FormView.render(presenter), status: :ok
    end

    def create
      create_form.save
      presenter = V2::Evaluations::ShowPresenter.new(create_form.draft, current_user)

      render json: V2::Evaluations::EmployableShowView.render(presenter), status: :created
    end

    def update
      update_form.save
      presenter = V2::Evaluations::ShowPresenter.new(update_form.draft, current_user)

      render json: V2::Evaluations::EmployableShowView.render(presenter), status: :ok
    end

    def destroy
      draft_evaluation.destroy!

      head :no_content
    end

    private

    def evaluations_scope
      V2::EvaluationPolicy::EmployableScope
        .new(current_user, Evaluation).resolve.includes(:evaluable)
    end

    def draft_evaluation
      @draft_evaluation ||= evaluations_scope.draft.find_by(id: params[:id])
      raise ErrorResponderService.new(:record_not_found, 404) unless @draft_evaluation

      @draft_evaluation
    end

    def completed_evaluation
      @completed_evaluation ||=
        evaluations_scope.completed.find_by(id: params[:id], evaluable_id: params[:employee_id])

      raise ErrorResponderService.new(:record_not_found, 404) unless @completed_evaluation

      @completed_evaluation
    end

    def create_form
      @create_form ||= V2::Evaluations::EmployableCreateForm.new(
        create_params,
        user: current_user
      )
    end

    def update_form
      @update_form ||= V2::Evaluations::EmployableUpdateForm.new(
        draft_evaluation,
        params: update_params,
        user: current_user
      )
    end

    def create_params
      params.require(:evaluation).permit(:employee_id, :template_id, :use_latest)
    end

    def update_params
      params.require(:evaluation).permit(
        :state, :next_evaluation_on, sections: [:id, { skills: %i[name value needToImprove] }]
      )
    end
  end
end
