defmodule FirstBlog.Email.Captcha do
  @moduledoc "GenServer for obtaining and storing the contact form captcha"
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def view() do
    GenServer.call(__MODULE__, :view)
  end

  def init(_) do
    captcha = Captcha.get()

    {:ok, captcha}
  end

  def handle_call(:view, _from, captcha) do
    Process.send(self(), :refresh, [])

    {:reply, captcha, captcha}
  end

  def handle_info(:refresh, _state) do
    {:noreply, Captcha.get()}
  end
end
