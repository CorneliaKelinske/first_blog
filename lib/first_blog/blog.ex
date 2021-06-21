defmodule FirstBlog.Blog do
  @moduledoc "The blog context"
  use Postex,
    prefix: "https://conniecodes.com/posts/", # required
    external_links_new_tab: true, # default
    per_page: 10 # default
end
