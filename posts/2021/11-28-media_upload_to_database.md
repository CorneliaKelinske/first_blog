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

I am currently working on my own Phoenix app that allows users to upload their image and video files in order to
show them to others. A fun little project that, per se, is nothing crazy or new. I was able to use *Programming Phoenix 1.4* by Chris McCord, Bruce Tate and José Valim as a great reference to get me started and then there are numerous other resources online. However, when it came to the actual file upload and display part of my project, I found that in most cases files are either not uploaded, but linked to via hyperlink in the template, or files are uploaded into the cloud storage space provided by a third party, like Amazon. 