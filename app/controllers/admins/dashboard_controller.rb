# frozen_string_literal: true

module Admins
  class DashboardController < Admins::BaseController
    before_action :set_order, only: %w[edit update]
    before_action :set_params, only: %w[index edit update]

    def index
      @orders = Order.includes(:user).all

      if params[:order].present?
        @orders = @orders.where(user_id: params[:order][:user_id]) if params[:order][:user_id].present? && params[:order][:user_id].to_i.positive?
        @orders = @orders.where(status: params[:order][:status]) if params[:order][:status].present? && Order.statuses.include?(params[:status])
      end

      @orders
    end

    def edit; end

    def update
      @order.update(status: set_params[:status]) if set_params[:status].present? && Order.statuses.include?(set_params[:status])

      flash[:success] = 'Update success'
      redirect_to admins_dashboard_index_path
    end

    private

    def set_params
      params[:order]
    end

    def set_order
      @order = Order.find(params[:id])
    end
  end
end
