# frozen_string_literal: true

class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback: :none

  def current_budget
    @current_budget ||= Budget.friendly.find(params[:budget_id])
  end
end
