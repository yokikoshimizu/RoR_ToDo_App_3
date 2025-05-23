class TasksController < ApplicationController
  # ビューで利用したい全タスクのデータを取得してビューへ伝えるために、インスタンス変数@taskに全データを格納できるようにする
  def index
    @task = Task.all
  end

  def show
    # findメソッドを使って、詳細画面に表示するためのTaskオブジェクトを取得
    # findはidによって、モデルオブジェクトに対応するレコードを検索する
    # 引数としてparams[:id]（タスクのID）を渡している
    @task = Task.find(params[:id])
    # 見つけたIDデータをインスタンス変数@taskに代入
  end

  # 新しいTaskオブジェクトを生成して、インスタンス変数@taskに代入する
  def new
    @task = Task.new
  end

  def create
  @task = Task.new(task_params)
    # @task = Task.new(task_params)
    # フォームで送られてきたデータ（params[:task]）を使って、Taskモデルの新しいインスタンスを作成
    # task_params...フォームから送られるパラメータを「安全に」扱うためのRailsの標準構文
    if @task.save
      redirect_to tasks_url, notice: "タスクを登録しました"
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(task_params)
    if @task.update(task_params)
      redirect_to task_path(@task), notice: "タスクを更新しました"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private

  # そもそもtask_paramsメソッドは、フォームからのリクエストパラメータとして送られてきた情報が
  # 想定通り{task: {...}}の形であることをチェックし、{...}の部分の中から受け取る想定である
  # name(名称)とdescription(詳しい説明)の情報だけを抜き取る役割をする
  # プライベートメソッド」として定義されることが多い、コントローラー内部専用のメソッドで、
  # 通常、create や update アクションから呼び出される
  def task_params
    params.require(:task).permit(:name, :description)
  end
  # params は、リクエスト（フォーム送信やURLパラメータなど）から
  # 受け取ったデータが入った ハッシュのようなオブジェクト
  # 例：params[:task][:title] などでアクセス可能
  # ここではparams の中から、キーが :task の値を取り出すということ
  # .require(...) は、指定したキーが 存在しなければ例外を発生させる
  # .permit(...) は、指定されたキー（属性）だけを通す ホワイトリスト的な指定
  # ここでは :title と :description だけを許可しており、
  # 悪意あるユーザーが admin: true などの不要なデータを送りつけても保存されない
end
