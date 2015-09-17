class DrinksController < ApplicationController
  def home
    @today = Date.today

    # 本日のデータを取得
    from  = Time.now.at_beginning_of_day
    to    = from + 1.day
    @todays_data = Drink.where(created_at: from...to)

    # 本日の飲んだ水の杯数/総量(ml)を計算
    @todays_amount = @todays_data.sum(:water)
    @todays_qty    = @todays_data.length

    # 2000mlまでの残りの水の量を計算
    @todays_rest = (2000 - @todays_amount)/350

    # 新規登録form用のモデル
    @drink_new = Drink.new
  end

  def create
    @drink = Drink.new(drink_params)
    @drink.save
    redirect_to root_path
  end

  private
    def drink_params
      params.require(:drink).permit(:water)
    end

end
