defmodule FirstBlog.Email.Captcha do
  @moduledoc "GenServer for obtaining and storing the contact form captcha, in order to avoid slow-downs
  due to capture being generated every time before the form is displayed"
  use GenServer

  # Client

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def view() do
    GenServer.call(__MODULE__, :view)
  end

  # Server

  def init(_) do
    # Don't handle failure, just let it crash and restart
    {:ok, captcha_image, captcha_text} = Captcha.get()

    {:ok, {captcha_image, captcha_text}}
  end

  def handle_call(:view, _from, captcha) do
    Process.send(self(), :refresh, [])

    {:reply, captcha, captcha}
  end

  def handle_info(:refresh, _state) do
    {:ok, captcha_image, captcha_text} = Captcha.get()

    {:noreply, {captcha_image, captcha_text}}
  end
end
