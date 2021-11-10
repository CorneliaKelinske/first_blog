defmodule FirstBlog.Email.Captcha do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, Captcha.get())
  end

  def view(pid) do
    GenServer.call(pid, :view)
  end

  def init(captcha) do
   {:ok, captcha}
  end

  def handle_call(:view, from, captcha) do
    {:reply, captcha, captcha}
  end

end
