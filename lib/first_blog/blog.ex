defmodule FirstBlog.Blog do
  @moduledoc "The blog context"
  use Postex,
    prefix: "https://connie.codes.com/posts/", # required
    external_links_new_tab: true, # default
    per_page: 10 # default
end
