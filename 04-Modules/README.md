# Using Modules

Now you discovered the concept of DRY Code, and no one likes to repeat the same things over and over right? One thing that can help with that is Modules. 

In modules we have a new type of variable, this one are not local to the module itself, but they can be overriden and can be used to determine mandatory values required to use the module. 

Variables cannot containt interpolation expressions, while local variables can. 

* Notice how there is much less code per environment
* Notice how the same code is now re-used accross environments
* Notice how we can easily change settings from one environment to the other
* Always think at scale, here its few resources one can thing "its wasn't that much anyway"
* Notice that we can also call modules from elesewhere, using existing opensource modules its always much faster and easier than having to develop and maintain your own. 
* What would happen if a change is done in one module?
    * Try Changing Adding one more rule to the security group
    * Try adding another subnet on the VPC module
* What are the problems you can thing of with this approach? 
    * What happens with terraform state? 
        * Terraform state of all infrastructure is in a single file on a single bucket
        * When applying change to a single resource all infrastructure is chceked agains the provider
    * What happens if the terraform state is lost? 
        * All resources are left dangling in the account
    * What happens if you only want to change the EC2 Instances and not everything else? 
        * Terraform will go thru all the resources regardless of needing to read them. 
        * If any unnoticed // unwanted changes on any given part of infrastructure will be applied. 
* How can we isolate resources further?
    * to avoid loosing all infrastructure state
    * to avoid having to go thru all the infrastructure uncessarily? 
