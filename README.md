# Perfect Programming - a pragmatic approach

## Preface

Perfect programming - and perfect code as a result - is a highly subjective topic. 

Solid, clean code, twelve-factor app, etc... there are dozens if not hundreds of programming guidelines out there - all somewhat religious or debatable in some details. Mostly they focus on the **how**, not on the **why**.

If I have to reason in a code review about using `!!` or `(bool)` to cast a variable it's political nonsense to me - at least if there is no autistic person in the involved teams. 

I think there are some things that can be derived from common problems a developer is faced and tooling he is equipped with. Things that can be derived can be argued about. Thus, bringing programming out of the religious zone. 

This programming guide is fork-able at [GitHub](https://github.com/koudela/perfect-programming/). Please file an issue there if you disagree on some of my statements to a substantial extend or if a reason is not understandable enough.

## Basics I - programming is about data

In programming there is only data. Variables, loops, ifs, functions, methods, classes, streams, databases, apis and all the other things a developer has to master are there to handle data.

This handling of data can be categorized in three big domains:
1. data representation (models and views of data)
2. data transformation (the business logic of the data)
3. data persistence (retrieval an saving of data)

Frontend developers focus on the data representation. 
Backend developers focus on the data transformation and persistence.
Fullstack developers can not decide.

## Basics II - programming is about maintaining code

Beginners may think programming is about writing code. But that is **not true**: 

1. Codebases are huge. Today's apps consists of hundred thousand of lines or even more.
    - No human being can process hundred thousand of lines in his brain at once. Thus code has to be written incrementally.
    - Large Codebases are written by many developers or even many teams of developers. Thus code written by others has to be taken in account.
2. In a competing world reinventing the wheel is not a good idea. Libraries and Packages are mandatory but get outdated regularly and force code adjustments. 
3. Programming languages evolve and thus get outdated too. The codebase can not ignore the forced changes.
4. Bugs in the codebase stand out mor than bugs in the documentation. Thus, the codebase is the only source of truth.
5. For most businesses the functionality of the app has a greater priority than the accuracy of the documentation. Again the codebase is the only source of truth.
6. Developers forget about the tons of code they have read and written regularly, and they change their employer on a regular basis too. You get the point: The codebase is the only source of truth.

Developers never just write code. They add to the codebase, and they make changes to the codebase. Programming is about the codebase. Programming is about maintaining code.

## Basics III - code quality is measured by time

If programming is about maintaining code then code quality is measured by the maintainability of the code.

How to measure maintainability?

Let's answer that for businesses: All is measured in money. 

The money spent is (in most cases) proportional to the time one or more developers have to invest to make additions or changes to the codebase (bug fixing included). 

The better the code the less time is needed to add or make changes to the codebase. Thus code quality is measured by time.

Very little time is used to actually write code (maybe 1 percent or less).

The most time is split between three things:
1. Finding the right (or at least a good) spot to add or make changes to the code.
2. Understanding the code just enough to know what changes or additions are needed for the current feature or fix to work.
3. Be a hundred percent sure (or something very near) that the additions or changes do not mess things up.

Thus, the time measured for these three points dominate the quality of code.

## Code quality I - finding the right spot: programming is about breadcrumbs

Good code makes it easy finding the right spot. That is pretty obvious. But what does that mean?

Let's do some examples.

Suppose you are a frontend web developer and should give the new design to the product box of the product listing. The only thing you know about the project is how to set it up and there is no one to guide you. How do you start? You set up the project. You browse the project instance to find a product listing page. You open the inspector to examine the html that belongs to the product box. Now it gets interesting: You have to find the relevant templates in the codebase. You can try to find in the codebase a file containing "productBox" or "product-box" or "product\_box" in its name with content that maps to the html examined. If that does not work out well you may use a fulltext-search to search for some promising css class, html attribute or other text snippet that sound rare enough to narrow down the search result to a few hits. If none text snippets fit well enough you have to walk up or down the html tree to find something promising. The further you go the more time-consuming will be the walk through the templates. The more search result hits you get the more time-consuming will be the filtering.

What does it take to make your life as a frontend web developer easy? It is a text snippet in the right place that is unique to the code and an obvious search candidate to a developer. Thus, good template code is sprinkled with rare speaking names. These you can see as breadcrumbs that the developer leaves behind to guide his kind. As a rule of thumb each (sub-)component should have a such a breadcrumb in its outer markup.

Now we go to the backend.

Suppose you are a backend developer on a shop project, and you have the task of altering the delivery price logic. Once again the only thing you know about the project is how to set it up and there is no one to guide you. Once again you can start by either trying to find some "deliveryCost", "delivery-cost" or "delivery\_cost" thing or following breadcrumbs down the template road. Take a product and get to the checkout. Find the right template to find out the variables name and trace it back to some model or entity object. If the apps frontend is driven by some more sophisticated framework you may take api calls and data-attributes in account. Having found a model/entity with the delivery costs attached use static code analysis or the fulltext-search again to analyse all the setters (praying that no dynamic code or reflection logic is used in the project). It is likely you find some method/function down the logic road that is calculating the delivery costs. 

What does it take to make your life as a backend developer easy? It's naming things properly, unique and consistent, honour static code analysis and make it easy following the logic road by direct function/method calls. These are the breadcrumbs of the logic driven code. 

There are two additional breadcrumb types which are only relevant for hunting bugs: Logs and Exception handling. And one breadcrumb type that has special voodoo powers: Version control commits. I get back to these topics later on.

## Code quality II - understanding code: programming is about structure

There are three factors contributing to the speed of understanding code:
1. How many lines has a developer to read to fully understand a piece of code.
2. Has a developer to run the code to understand it. (Setting breakpoints, stepping through it, inspecting variables, etc.)
3. How many thoughts hat to be given to the lines (and time for consulting other resources) to fully understand what is going on.

### How can we cut the lines down?

The most effective thing is containerizing the code and naming the containers after what they are doing. Using object methods or functions to accomplish this is a matter of taste. Knowing what a function/method does (by its name) immediately tells the developer if he has to enter the function/method to get to the bottom of the current problem/question or not. 

The corresponding programming principle is called separation of concerns (SoC). Although it acts on a wider scale too - as code containers can be containerized again. For example methods are grouped together in a class. Or classes grouped in a module. The grouping in a class/module separates it from other classes/modules. Containerizing code and SoC reduces coupling and increases cohesion. 

The other programming principle that is applicable to containerizing code is the locality of behaviour (LoB). It also acts on a wider scale as containerized behaviour can be clustered further by behaviour aspects. Lob also reduces coupling an increases cohesion. 

SoC and LoB can be seen as the same principle acting on reversed signs. LoB is gravity between code and SoC is repulsion of code.

### How can we prevent the need to run a piece of code?

Running code gives two insights to the developer:
1. An example of the program flow followed.
2. An example of the data used.

The flow can be made obvious by keeping things simple: Containerize code, naming things right, keeping the branching complexity low by using early returns instead of ifs, sizing functions/methods right and writing code that supports static code analysis. And last but not least: writing code that is **not** configurable and **not** dynamic. 

Always think about programming patterns twice. For example: The observer pattern can make branching easy and the interface pattern can make the reuse of code easy but both can make it complicated to find all code executed or not accomplishable at all - as both patterns can be used to include additional logic further down the road or even at runtime. 

The data used can be explained by using data-objects. They have to be properly sized (not containing too much data that is irrelevant), named and type-hinted. Same goes for the properties of them.

Beside saving time there is a second argument against running code to understand it: The result is always an example but can make the developer think he gets the whole picture if it connects well with the code. 

Perfect code never has to be run (in the context of understanding it).

### How can we cut down the thoughts?

The fewer lines of relevance and the more explicit the flow and the data, the lesser thoughts are needed. 

A fundamental concept to the code complexity and the needed thoughts is the branching graph complexity. If you treat every code container as node and every function/method call as edge then code branching spans a graph.

When it comes to cycles understanding code becomes complicated most of the time. Thus keeping cycles small or such big that one can call them live cycles is mandatory. 

Shrinking the small cycles to logic nodes and cutting the big live cycles the remaining logic spans a tree. This tree is more understandable if it is flat. Keeping the depth beneath or equal 3 or at most 5 can contribute a lot to the understandability of code.

Cutting thoughts in templates is easy: Do not use logic other than loops, existence testing ifs and simple filters/mappings in templates. Logic in templates is hard to read and most of the time does not support statically code analysis. Getting the data-model right before rendering is mandatory. Data representation, data transformation and data persistence are three separate concepts. Keep them separate in the code is part of SoC. 

Do not mix different views in one template. This is hard to understand and error-prone as every view adds a dimension/layer to the template. Markup duplication is **not** the brother of code/logic duplication. 

### Understanding code - summary

Containerize code! Name things right! Keep branching complexity low! Size functions/methods right! Use typed properly sized data-objects! Use type hints! Balance logic trees! Keep things out of templates that does not belong to rendering! Support static code analysis! Use architectural patterns in a sensible way! ...that is a lot to consider. It can be summarized as: Sensible structured code is better code (as it supports the understanding of the code).

## Code quality III - not messing things up: programming is about locality

Let's go back to the backend developer who is on the task of altering the delivery price logic. We have found the logic and altered it. How can we be sure that our task is done? We can't! Not knowing anything about the project we have to spot every point where a delivery price is displayed - which can be hard enough. We have to follow every spot down the rabbit hole to see if it uses our altered logic or if it uses its own logic. And no - we don't have days for this task. In reality, you can spend two or three hours at most. This is why code duplication is one of the original sins in programming. And it should be named logic duplication as you can have the same code that does different things and the same logic can come in completely different code. Thus, the programming principle don't repeat yourself (DRY) is somewhat bad coined.

Keeping things together that belong together (LoB) is the antidote. This saves you a lot of time and bugs.

There is a second thing that can kill the confidence in your code changes. Data that escapes the local scope. This can be a static property of an object, a service (visitor pattern) with a property, a closure with a local variable or a persisted value. State outside the local scope can alter the program state/flow in an unexpected way (at least unexpected for the feature/fix the developer is on). This impact is called side effect. 

Side effects are the brother of logic duplication. The developer has to follow (and understand) all the logic the escaped data plays a role in. This can easily burst the time and the brain power available.

Of course data leaves the local scope when it is persisted to the database. But the impact of saved data will never come unexpected to a seasoned developer. Thus, it is not called side effect. 

Whenever there is the need of state/data outside the current scope use the database or a sensible named model as proxy, such that the altering of the programm state/flow is never unexpected.

Good code keeps unexpected things local. Good code does not have side effects.

## Code quality IV - boundaries of the feature domain and exception handling

One of the most underestimated and misunderstood tools in programming are exceptions. Exceptions are closely related to the scope of the feature domain. They are the crash barrier if the infrastructure, the data or the flow get out of the line and are not as expected. It is more a rescue kit than a point of failure.

A feature domain always has a scope in witch it is well-defined. Outside it is not. For example an import of data can not be done if the data-source is not available. Although the handling of such an unprocessable state can be within the feature domain. For example if the import is triggered by a user action there can be a message displayed that the data-source is missing. Or if it is triggered by a cron job an email can be sent to notify a responsible person.

It is the responsibility of the developer to be aware of the scope of the feature domain, identify the boundaries and handle unprocessable state. Customers, project-owner and other stakeholder are not that aware of thees boundaries but may have to be consulted to decide about the handling.

Exceptions contribute to the breadcrumbs and understandability part of the code and are therefore part of the (measurable) code quality.

As a rule of thumb catching an exception and throw another exception is pure coding as it disguises the origin of the unprocessable state. Using a specific exception class or an uuid in the exception message can contribute to the code quality as it can speed things up when an exception should be fixed (e.g. the real feature domain differs from the implemented feature domain) but a trace is not available.

As sooner the unprocessable state is detected the better. For example if a null value is persisted to a database column where no null value is allowed an exception is thrown. But it has been decided before that there will be a null value. The leaving of the feature domain may come long before throwing the exception. This can cost a considerable amount of time if the leaving of the feature domain has to be debugged. Data (source) validation may increase the code quality in this example as validation handels the boundaries of the feature domain too and can be done anywhere in the code. 

## Code quality V - logging

Logs can be seen as external infrastructure. But logging contributes to the code quality as it supports understanding failures. If the bug is not reproducible often debugging cannot be done without. The evaluation of log entries can contribute to the feature quality in the midterm.

Logging can be categorized in five big areas:
1. Event logging - e.g. exception logging
2. Bookkeeping -  e.g. cron event logging
3. Story logging - e.g. cron output logging
4. Archiving - e.g. moving used data files to an archive folder
5. State logging - e.g. data source/sink logging

There are structured logs and unstructured logs. A structured log is typically written to a separate data sink that supports it structure. For example a database table or csv. An unstructured log is most of the time a logfile which lines consists of log entries from different sources witch can be grepped by their context and log message to filter specific logging events.

In terms of code quality more logging is better. If you do not log you do something wrong. At least the logging of unhandled exceptions and crucial data from/to external apis should always be done. Structured logs are better than unstructured logs. More context is better the than less context. But logging has to be balanced against disk-space and code-execution-time. Therefore, it is often done based on the environment and with some sort of log rotation.

## Code quality VI - documentation

There are five types of documentation:
1. Feature documentation (about using the feature)
2. Integration documentation (about setting the feature up)
3. Interface documentation (about extending the feature without touching the code)
4. Implementation documentation (about how the feature works/is implemented)
5. In code documentation (documentation written between the lines of code)

Not all types may be applicable to a feature but all types can speed up adding or making changes to the codebase and are thus part of the code quality. Mixing these types of documentation is never a good idea as every type targets another type of work.

### Enforcing the use of the documentation

Although it may be of help in their work developers may ignore even a perfect documentation. They have to balance the time invested in the searching the documentation against the time saved by the information extracted.

Big codebases result in a lot of things that may be documented. Finding all relevant documentation can be challenging in the first place. There are several strategies to enhance the search:
1. A well structure and maintained table of contents
2. A fulltext search
3. Linking relevant sections of the document from prevalent feature entry-points in the code.

Nowadays, the searching ability may be further improved by a KI powered search.

An augmenting strategy is linking relevant sections in the ticket by its creator, project owner or ticket refiner. 

### Keeping documentation up to date

Outdated documentation can contribute negatively to code quality. Thus, developer tend to ignore poorly maintained documentation as resource and with respect of updating it. It can be very challenging for a developer team to get out of this deadlock.

There is only one promising strategy for keeping documentation up to date: **All** documentation has to be covered by tests **and** the relevant sections have to be linked by the test. 

Thus, outdated documentation results in failure of tests. The developer in charge knows he is not finished yet and can spot the relevant documentation parts immediately.

### What has to be documented and to what extent? 

1. **Feature documentation**: The responsibility to answer that question for the feature documentation does not lie in the developer domain. It is hold by the project owner or other stakeholder. Thus, it can not be answered here.
2. **Integration documentation**: The integration documentation should cover all relevant use cases as it is time-consuming extracting the relevant bits from the code. The elaborateness has to depend on the targeted group of persons e.g. in house developer, out house developer, administration, project owner, user with no qualification/training, etc. 
3. **Interface documentation**: If the targeted groups of persons are third party developers all relevant use cases have to be covered - provided the stakeholder does not decide differently. In house developer may take the relevant bits from the code. Thus, the time consumption of maintaining and consulting the documentation has to be balanced against the time consumption consulting the code. This balancing covers what has to be documented and how elaborate it has to be.
4. **Implementation documentation**: Code should be self documenting. But there are boundaries to this concept as very many lines of code may be read and understood to get the whole picture of a big feature. Thus, the implementation documentation should focus on the big picture. This can be key concepts used by a feature, background info and linked documentation of used infrastructure, feature details not suitable for the feature documentation, the generalized data flow, architecture insights and many more. There is no generalized answer. The time consumption of creating, maintaining and consulting the documentation has to be balanced against its usefulness.
5. **In code documentation**. In code documentation should never be used at all for two main reasons: First of all code should be structured and named such that he is self documenting supporting code quality I-III. That does mean: If code has to be clarified its quality is bad in the first place. Second in code documentation can not be linked from automated tests. Thus, there is no way to enforce the validity of in code documentation.


*(c) 2024 Thomas Koudela - last modified 13.10.2024*

## ...coming up soon:


### Code quality VII - automated testing
### Code quality VIII - good and bad abstractions
### Code quality IX - dependency management
### Code quality X - technical dept (and refactorings)
### Basics IV - feature quality vs. code quality
### Basics V - programming is about asking questions
### Basics VI - programming is about balancing tradeoffs
### Basics VII - programing is about real world domains
### Basics VIII - workflow and how to handle big features
### Basics IX - principles of good programming
