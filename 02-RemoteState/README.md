# Terraform remote backend

Local terraform states are not reliable even when commiting them to git. Should only be used for testing purposes and even then its debatable, you can end up leaving resources around because the state got lost and then you have to delete them all manually. 

* Notice the changes on the outputs `[*]`
* What happens if you change anything?
    * Try changing the instance count to 2 (Do not commit and push changes)
    * What happens if another user clones the repository and runs Apply? 
    * Commit and push changes
    * What happens now if another user pulls the latest change and runns Apply?
    * Change back the count to 1
        * User 2 forgot to commit and push, what happens if you update the count? 
* Now your app is ready for production, and you need more environments. 
    * Try creating dev, qa, prod environment 
    * What are the dificulties with it? what issues you notice? 
* Destroy and move to next chapter
