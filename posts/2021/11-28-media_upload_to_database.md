==title==
How to upload multimedia files to and display them from your database in a Phoenix project

==author==
Cornelia Kelinske

==description==
When I decided to store multimedia uploads for a small personal Phoenix project directly in my database and to display them from there, I found only scattered information on how to achieve this online. This post provides a comprehensive guide, all in one place. 


==tags==
coding, personal

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


Before I start to 









will split in 3 parts: uploading the file into the database, displaying file in a eex template (for Phoenix 1.5) and then in a heex template in (Phoenix 1.6)


├── lib
│   ├── the_little_thinkers_space
│   │   ├── accounts
│   │   │   ├── profile.ex
│   │   │   └── user.ex
│   │   ├── accounts.ex
│   │   ├── application.ex
│   │   ├── content
│   │   │   └── upload.ex
│   │   ├── content.ex
│   │   └── repo.ex
│   ├── the_little_thinkers_space.ex
│   ├── the_little_thinkers_space_web
│   │   ├── channels
│   │   │   └── user_socket.ex
│   │   ├── controllers
│   │   │   ├── auth.ex
│   │   │   ├── fallback_controller.ex
│   │   │   ├── page_controller.ex
│   │   │   ├── profile_controller.ex
│   │   │   ├── session_controller.ex
│   │   │   ├── upload_controller.ex
│   │   │   └── user_controller.ex
│   │   ├── endpoint.ex
│   │   ├── gettext.ex
│   │   ├── router.ex
│   │   ├── telemetry.ex
│   │   ├── templates
│   │   │   ├── layout
│   │   │   │   ├── app.html.eex
│   │   │   │   ├── navigation_home.html.eex
│   │   │   │   └── navigation_landing.html.eex
│   │   │   ├── page
│   │   │   │   ├── home.html.eex
│   │   │   │   └── index.html.eex
│   │   │   ├── profile
│   │   │   │   ├── edit.html.eex
│   │   │   │   ├── form.html.eex
│   │   │   │   ├── index.html.eex
│   │   │   │   ├── new.html.eex
│   │   │   │   └── show.html.eex
│   │   │   ├── session
│   │   │   │   └── new.html.eex
│   │   │   ├── upload
│   │   │   │   ├── edit.html.eex
│   │   │   │   ├── form.html.eex
│   │   │   │   ├── index.html.eex
│   │   │   │   ├── new.html.eex
│   │   │   │   └── show.html.eex
│   │   │   └── user
│   │   │       ├── edit.html.eex
│   │   │       ├── form.html.eex
│   │   │       ├── index.html.eex
│   │   │       ├── new.html.eex
│   │   │       └── show.html.eex
│   │   └── views
│   │       ├── error_helpers.ex
│   │       ├── error_view.ex
│   │       ├── layout_view.ex
│   │       ├── page_view.ex
│   │       ├── profile_view.ex
│   │       ├── session_view.ex
│   │       ├── upload_view.ex
│   │       └── user_view.ex
│   └── the_little_thinkers_space_web.ex