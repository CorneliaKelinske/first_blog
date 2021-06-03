defmodule FirstBlog.Repo do
  use Ecto.Repo,
    otp_app: :first_blog,
    adapter: Ecto.Adapters.Postgres
end
