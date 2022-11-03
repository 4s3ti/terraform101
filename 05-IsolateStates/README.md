# State Isolation

Now terraform states and compositions are isolated, there is more flexibility, less risk of introducing breaking changes, but at a cost: Code Duplication

* Experiment re-creating all other environments
    * notice how much effort and care it needs
* Notice the ammount of Duplicated Code
* Notice the requirement for using data sources to fetch information from other components
    * Notice the different types of data sources, each one is good in different secenarios
* Notice the need for adding outputs on components that already have them on the module
* Notice that its hard to set a standard, and have uniform code
* Is there a way to bennefit from the DRY code from chapter 04 and the security of state isolation of chpter 05? 
    * It is possible to somewhat achieve this with terraform variables files, but it doesn't quite get there. There is still plenty of duplicated Code
* Is there a way that does not require usage of data sources? 
* Is there a way to make the code Really DRY? 
