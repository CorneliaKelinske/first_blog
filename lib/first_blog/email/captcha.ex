defmodule FirstBlog.Email.Captcha do
  @moduledoc "GenServer for obtaining and storing the contact form captcha, in order to avoid slow-downs
  due to capture being generated every time before the form is displayed"
  use GenServer
  require Logger

  # Client

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def view() do
    GenServer.call(__MODULE__, :view)
  end

  # Server

  @impl GenServer
  def init(_) do
    Process.send(self(), :refresh, [])
    Logger.debug("GenServer initiated")
    {:ok, :no_captcha}
  end

  @impl GenServer
  def handle_call(:view, _from, :no_captcha) do
    Process.send(self(), :refresh, [])

    Logger.debug("HILFE Helmut! we have no captcha!")
    {:reply, {:error, :no_captcha}, :no_captcha}
  end

  @impl GenServer
  def handle_call(:view, _from, state) do
    Process.send(self(), :refresh, [])

    Logger.debug("Captcha sent on view")
    {:reply, {:ok, state}, state}
  end

  @impl GenServer
  def handle_info(:refresh, state) do
    case Captcha.get(10_000) do
      {:ok, _text, ""} ->
        Logger.debug("#{inspect __MODULE__} Empty string, discarding")
        {:noreply, state}

      {:ok, text, image} ->
        Logger.debug("#{inspect __MODULE__} Captcha created on refresh: #{inspect image}")
        {:noreply, %{image: image, text: text}}

        {:timeout} ->
        Logger.debug("#{inspect __MODULE__} Timeout on refresh")
        Process.send_after(self(), :refresh, 1_000, [])
        {:noreply, :no_captcha}
    end
  end

  @impl GenServer
  def handle_info({_port, {:data, <<text::bytes-size(5), image::binary>>}}, _state) do
    Logger.debug("#{inspect __MODULE__} Received binary: #{inspect image}")
    {:noreply, %{image: image, text: text}}
  end
end
