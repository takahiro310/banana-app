class TopController < ApplicationController
  def index
    # NOP.
  end

  def show
    @asfor = Hash.new
    @asfor = Asfor.find_by!(:url_key => params[:url_key])

    # 次のお題はanswerがquestionになるよ
    @asfor.question = @asfor.answer
    @asfor.answer = ""

    render template: "top/index"
  end
end
