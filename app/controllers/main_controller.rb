# frozen_string_literal: true

class MainController < ApplicationController
  def index; end

  def result
    if params[:start_date].empty? && params[:end_date].empty?
      redirect_to root_path, alert: t('alert.empty')
    elsif params[:start_date].empty?
      redirect_to root_path, alert: t('alert.empty_start')
    elsif params[:end_date].empty?
      redirect_to root_path, alert: t('alert.empty_end')
    elsif params[:start_date] > params[:end_date]
      redirect_to root_path, alert: t('alert.bigger')
    else
      @start_date = params[:start_date].to_date
      @end_date = params[:end_date].to_date
      @days = (@end_date - @start_date).to_i
      anniversaries if params[:anniversaries].eql?('1')
    end
  end

  private

  def anniversaries
    need_days
    @anniversary100 = @end_date + @days100.days
    @anniversary500 = @end_date + @days500.days
    @anniversary1000 = @end_date + @days1000.days
    @anniversary5000 = @end_date + @days5000.days
    @anniversary10000 = @end_date + @days10000.days
  end

  def need_days
    @days100 = 100 - (@days % 100)
    @days500 = 500 - (@days % 500)
    @days1000 = 1_000 - (@days % 1_000)
    @days5000 = 5_000 - (@days % 5_000)
    @days10000 = 10_000 - (@days % 10_000)
  end
end
