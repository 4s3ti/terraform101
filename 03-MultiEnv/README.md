# Multi environment setup

Now you need multiple environments, and as you figured out before, creating more environments from basic terraform structure is a nightmare. You have searched a bit more and you found out that terraform allows you to use variables, so you defined a bunch of local variables.

* Apply production environment
    * Go ahead and estroy it just you can understand how it looks like fully working. 
* There is something wrong with Dev, can you understand what? (hint: `terraform validate`)
    * Fix it and apply
    * Is there a solution for this? 
* PLEASE DO NOT APPLY, Just read and think!
    * What happens now if you want a test environment, and you forget to update the state path? 
* What is DRY Code? How can it become more DRY and easier? 
* Destroy all resources and move on to next chapter
