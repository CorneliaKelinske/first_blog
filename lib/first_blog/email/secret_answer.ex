defmodule FirstBlog.Email.SecretAnswer do
  @moduledoc """
  GenServer storing the text of the generated Captcha along with
  a UIID assigned to each individual user so that the user's captcha
  answer can be verified
  """
  use GenServer


  # Client

  def start_link(%{}) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def check_in(captcha_text) do
    GenServer.call(__MODULE__, {:check_in, captcha_text})
  end

  def check_out({text, form_id}) do
    GenServer.call(__MODULE__, {:check_out, text, form_id})
  end

  # Server

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:check_in, captcha_text}, _from, state) do
    id = UUID.uuid4()
    {:reply, {:ok, id}, state}
  end

  def handle_call({:check_out, text, form_id}, _from, state) do
    Process.send(self(), {:delete, form_id}, [])
    IO.inspect(state, label: "during call")
    case Map.fetch(state, form_id) do
      {:ok, ^text} ->  {:reply, :ok, state}
      {:ok, _} -> {:reply, {:error, :wrong_captcha}, state}
      _ -> {:reply, :error, state}
    end
  end

  def handle_info({:delete, form_id}, state) do
    state = Map.delete(state, form_id)
    {:noreply, state}
  end

end
