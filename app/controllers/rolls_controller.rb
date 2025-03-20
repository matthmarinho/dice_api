class RollsController < ApplicationController
  def roll
    expression = roll_params[:expression]
    result = DiceRollerService.roll(expression)

    if result.nil?
      render json: { error: "Invalid expression" }, status: :unprocessable_entity
    else
      Roll.create(expression: expression, result: result[:total])
      render json: { expression: expression, rolls: result[:rolls], best_or_worst: result[:best_or_worst], modifier: result[:modifier], total: result[:total] }
    end
  end

  def history
    rolls = Roll.order(created_at: :desc).limit(10)
    render json: rolls
  end

  private

  def roll_params
    params.permit(:expression)
  end
end
