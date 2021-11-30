==title==
How to upload media files to and display them from your database in a Phoenix 1.6 project

==author==
Cornelia Kelinske

==description==
When I decided to store multimedia uploads for a small personal Phoenix project directly in my database and to display them from there, I found only scattered information on how to achieve this online. This post fixes this situation by providing a comprehensive guide.


==tags==
coding, personal

==body==

# 1. Project background
I am currently working on a personal little project which evolves around a Phoenix video/image sharing app.
Nothing crazy, nothing new. There are a lot of similar projects out there and I had, at least for the most part, no
problems finding reference material and resources to answer my questions along the way.

There were, however, two major sticking points, namely media file upload and media file display.

The first time I encountered some difficulties with finding information on how to make my code work was when it came to the part where I wanted to allow my users to upload video and image files. I found that most of the resources I found either shared media content by linking to files via hyperlink or uploaded media content into the cloud storage provided by a third party (e.g. Amazon). Since my goal was to allow users to actually upload files from their computer, I ruled out the hyperlink option right away, but I also did not want to subscribe to a third-party service, since, at least for now, my project runs on  a very small scale.

So my thought was: why not treat users' multimedia files just like all other user data? Why not store them directly as binary in the database and then retrieve and display them from there in my (h)eex templates?

While I was able to find bits and pieces of information on how to succeed in this endeavour scattered across various resources, I did not find a comprehensive guide in one place. 




project is pretty straightforward
it is small-scale 
but people who might be interested in working on such a small scale are maybe just starting out and therefore could be handy to have this guide

will split in 3 parts: uploading the file into the database, displaying file in a eex template (for Phoenix 1.5) and then in a heex template in (Phoenix 1.6)


lib
│   ├── my_little_project
│   │   ├── accounts
│   │   │   ├── profile.ex
│   │   │   ├── user.ex
│   │   │   ├── user_notifier.ex
│   │   │   └── user_token.ex
│   │   ├── accounts.ex
│   │   ├── application.ex
│   │   ├── content
│   │   │   └── upload.ex
│   │   ├── content.ex
│   │   ├── mailer.ex
│   │   └── repo.ex
│   ├── my_little_project.ex
│   ├── muy_little_project_web

