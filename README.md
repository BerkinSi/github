Thank you for dedicating your time when you are going to review this code.

I want to clarify several points:

1. I don't use DTOs directly in my views. There are two reasons: First of all, API does not belong to us and it might change. Secondly, view should not know about the entity.
2. I used VIPER as architecture. 
3. For brevity, I aimed to target iOS 13+.
4. For brevity, I restricted the pagination parameters as follows: per_page = 10 and page = 1
5. There is no Main.storyboard in this project. Application starts with whatever controller is passed in SceneDelegate. This is because when requirements change in the way that another page wanted to be start point, then all we have to do is changing createModule, which creates the entire VIPER module for that specific page.
6. Search Helper is for throttling the search requests so that when user starts to type, network call is not going to be performed immediately.
7. Project is divided into three modules:
    a. Github is the main module. This is the application's itself.
    b. GithubAPI is the networking layer. This is for calling APIs.
    c. GithubUI is the common UI library layer for project. 
8. I have chosen to use Kingfisher to manage the images. Of course downloading the images would be fine, too. That's the reason why I provided ImageDownloadServiceProtocol, but did not use it.
    
    Splitting projects into modules allow multiple teams to work in parallel and reduces build time. This is the reason why I decided to use it.
