==title==
How to upload multimedia files to and display them from your database in a Phoenix project

==author==
Cornelia Kelinske

==description==
When I decided to store multimedia uploads for a small personal Phoenix project directly in my database and to display them from there, I found only scattered information on how to achieve this online. This post provides a comprehensive guide, all in one place. 


==tags==
coding

==body==

# 1. Project background


I am currently working on a personal little project which evolves around a Phoenix video/image sharing app.
Nothing crazy, nothing new. There are a lot of similar projects out there and I had, at least for the most part, no
problems finding reference material and resources to answer my questions along the way.

There were, however, two major sticking points, namely media file upload and media file display.


# 2. The sticking points


Unlike the projects that I used as reference for my own, I neither wanted to share videos or images via hyperlink in my .eex template nor did I want to use a third-party cloud storage provider, such as Amazon. My thought was: why not treat users' multimedia files just like all other user data? Why not store them directly in the database and then retrieve and display them from there in my .(h)eex templates?

I was able to find bits and pieces of information on how to achieve this scattered across various threads and blog posts, but there was no comprehensive guide addressing both steps: 1. uploading multimedia files from a web app into the repository and 2. displaying those files via the .(h)eex templates.

While step 1 was relatively easy, it took me a while to figure out the right format for the image and video display in my .eex template, and then, after I switched over to Phoenix 1.6, to find a way to do the same in my .heex template. 

Since I believe that storing multimedia files directly in the database is a good solution for small-scale projects, I would like to save those developers who agree with me there some time. Please find below the comprehensive guide I wish I had had.


# 3. Prerequisites


Before we get down to the nitty-gritty, let's make sure we are on the same page. I am assuming that you have set up your Phoenix project including your database and your uploads and user schemas.  
For reference, my project has an accounts context in which I am defining my user schema and my upload schema is defined in my content context. Accordingly, my /lib/my_project folder has the following structure:

```
├── lib
│   ├── my_project
│   │   ├── accounts
│   │   │   ├── profile.ex
│   │   │   └── user.ex
│   │   ├── accounts.ex
│   │   ├── application.ex
│   │   ├── content
│   │   │   └── upload.ex
│   │   ├── content.ex
│   │   └── repo.ex
│   ├── my_project.ex

```
And then I have the usual suspects, controllers, views, templates in the /lib/my_project_web folder.


# 4. Upload schema and file type

The first step was to define my "uploads" schema in my upload.ex file. What's notable in this regard is that I am storing the  image/video file as a binary data.

I also added module attributes specifying valid image types and valid video types as well as a combination of both. In order to be able to use the valid image and video types in my templates, I created corresponding functions returning the valid file types.
I am using my changeset function to verify that the file type of the file the user wants to upload is included in the valid file types.

```
defmodule MyProject.Content.Upload do
  
  use Ecto.Schema
  import Ecto.Changeset
  
  @valid_image_types ["image/jpeg", "image/jpg", "image/png"]
  @valid_video_types ["video/mp4", "video/quicktime"]
  @valid_file_types @valid_image_types ++ @valid_video_types

  def valid_image_types, do: @valid_image_types
  def valid_video_types, do: @valid_video_types
  def valid_file_types, do: @valid_file_types

  schema "uploads" do
    field :description, :string
    field :file, :binary
    field :file_type, :string
    field :title, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(upload, attrs) do
    upload
    |> cast(attrs, [:file, :file_type, :title, :description])
    |> validate_required([:file, :file_type, :title, :description],
      message: "This box must not be empty!"
    )
    |> validate_inclusion(:file_type, @valid_file_types, message: "Wrong file type!")
  end
end
```
And just to be extra thorough: my content.ex file includes a create_upload function, which I will not elaborate on, since I believe that it is one of the functions that the Phoenix generator generates by default.


# 5. Upload controller

The upload controller was where things started to get interesting. 

Plug.Upload(https://hexdocs.pm/plug/Plug.Upload.html) => file is stored temporarily and represented with a Plug.Upload struct (=> I can pattern match on this!!!)


 
# 6. Upload view and templates (Phoenix 1.5)

# 7. Upload view and template (Phoenix 1.6)