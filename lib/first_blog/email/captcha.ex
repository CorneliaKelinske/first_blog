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
    Process.send_after(self(), :refresh, 1_000, [])
    {:ok, :no_captcha}
  end

  def handle_call(:view, _from, :no_captcha) do
    Process.send(self(), :refresh, [])

    {:reply, {:error, :no_captcha}, :no_captcha}
  end

  def handle_call(:view, _from, {captcha_image, captcha_text} = state) do
    Process.send(self(), :refresh, [])

    {:reply, {:ok, captcha_image, captcha_text}, state}
  end

  def handle_info(:refresh, _state) do
    case Captcha.get(10_000) do
      {:ok, captcha_image, captcha_text} ->
        {:noreply, {captcha_image, captcha_text}}

      {:timeout} ->
        Process.send_after(self(), :refresh, 1_000, [])
        {:ok, :no_captcha}
    end
  end
end
