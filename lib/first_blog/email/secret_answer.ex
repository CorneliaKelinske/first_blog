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
    GenServer.call(__MODULE__, {:check_in, {form_id, text}})
  end

  # Server

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:check_in, captcha_text}, _from, state) do
    id = UUID.uuid4()
    state = Map.put(state, id, captcha_text)
    {:reply, {:ok, id}, state} |> IO.inspect(label: "33", limit: :infinity, charlists: false)
  end

  def handle_call({:check_out, {text, form_id}, _from, %{form_id: text} = state}) do

    {:reply, :ok, state} |> IO.inspect(label: "38", limit: :infinity, charlists: false)
  end

  def handle_call({:check_out, {_text, form_id}, _from, %{form_id: _captcha_text} = state}) do
    {:reply, {:error, :wrong_captcha}, state} |> IO.inspect(label: "42", limit: :infinity, charlists: false)
  end

  def handle_call({:check_out, {_text, _form_id}, _from, state}) do
    {:reply, :error, state} |> IO.inspect(label: "46", limit: :infinity, charlists: false)
  end
end
