# frozen_string_literal: true

module Admins
  class DashboardController < Admins::BaseController
    before_action :set_order, only: %w[edit update]
    before_action :order_params, only: %w[index edit update]

    def index
      @orders = Order.includes(:user).all

      if params[:user_id].present? && params[:user_id].to_i.positive?
        @orders = @orders.where(user_id: params[:user_id])
      end

      if params[:status].present? && Order.statuses.keys.include?(params[:status])
        @orders = @orders.where(status: params[:status])
      end

      @orders = @orders.order(name: :desc)
    end

    def edit; end

    def update
      if order_params[:status].present? && Order.statuses.include?(order_params[:status])
        @order.update(status: order_params[:status])

        flash[:success] = 'Update success'
      else
        flash[:alert] = 'Update failed'
      end

      redirect_to admins_dashboard_index_path
    end

    private

    def order_params
      params[:order]
    end

    def set_order
      @order = Order.find_by(id: params[:id])

      if @order.blank?
        flash[:error] = 'Order is not found'
        redirect_to admins_root_path
      end
    end
  end
end
