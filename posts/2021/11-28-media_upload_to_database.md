==title==
How to upload media files to and display them from your database in a Phoenix 1.6 project

==author==
Cornelia Kelinske

==description==
A guide for how to store image and video uploads directly in the database (without the need to resort to a third-party cloud
storage provider) and how to display them in the Phoenix 1.6 heex template.

==tags==
coding, personal

==body==

I am currently working on a personal little project which evolves around a Phoenix video/image sharing app.
Nothing crazy, nothing new. There are a lot of similar projects out there and I had, at least for the most part, no
problems finding reference material and resources to answer my questions along the way.

There were, however, two major sticking points, namely media file upload and media file display.

# 1. File upload

The first time I encountered some difficulties with finding information on how to make my code work was when it came to the part where I wanted to allow my user to upload video and image files. I found that most of the resources I found either shared 
media content by linking to files via hyperlink or uploaded media content into the cloud storage provided by a third party (e.g. Amazon). Since I wanted a user to actually upload files from their computer, I ruled out the hyperlink option right away, but I also did not want to subscribe to a third-party service, since, at least for now, my project runs on such a small scale.

So my thought was: why not upload the media files into the database? 
