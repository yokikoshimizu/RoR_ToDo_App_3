class TasksController < ApplicationController
  # ビューで利用したい全タスクのデータを取得してビューへ伝えるために、インスタンス変数@taskに全データを格納できるようにする
  def index
    @task = Task.all
  end

  def show
  end

  # 新しいTaskオブジェクトを生成して、インスタンス変数@taskに代入する
  def new
    @task = Task.new
  end

  def edit
  end
end
