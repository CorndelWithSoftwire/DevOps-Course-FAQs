# Glossary

## Technical terms

These are technical terms that appear in the course content and assessment criteria.

This mostly exists as a reference, but is also worth looking through as part of your preparation for the End Point Assessment as the assessor may use these terms and will expect you to understand them.

**Acceptance Criteria** - A set of requirements that must be met to mark a user story as complete. Often abbreviated to "AC".  
_Module 6_

**Accessibility** - Whether a system is accessible (easy to use) to all users. For example, ensuring your software can be used with a screen reader.  
_Module 6_

**ACL** - "Access Control List", a list of users and the actions they are permitted to take as a way of implementing Authorisation.
An evolution of this is RBAC, Role Based Access Control, where users have roles and roles have permissions.  
_Module 10_

**Affinity mapping** - Organizing related facts/points into distinct clusters. Can be used for sorting through user feedback.  
_Module 6_

**API** - "Application Programming Interface", a defined interface between two computer systems. We use a few web APIs using JSON over HTTP during workshops and the project exercise.  
_Module 2_

**Authentication** - The process of verifying the identity of a user. Sometimes referred to as AuthN.  
_Module 10_

**Authorisation** - Determining what resources a user has access to. Sometimes referred to as AuthZ.  
_Module 10_

**Blameless culture** - A workplace culture that encourages looking for potential system improvements after incidents occur rather than assigning blame to individuals.
One of the core principals of DevOps culture.  
_Module 6_

**Branching by abstraction** - A technique for avoiding long lived branches for large feature changes by introducing an abstraction that can switch between two underlying implementations, often using a feature toggle.
See <https://martinfowler.com/bliki/BranchByAbstraction.html>.  
_Module 2_

**Deming cycle**/plan-do-check-act - A process/methodology for making improvements to a system or organisation. See <https://en.wikipedia.org/wiki/PDCA>.  
_Module 6_

**Distributed Source Control** - A source control/version control system where each user has a full copy of the repository. Git is a good example of this.  
_Module 1_

**Continuous Integration/CI** - The practice of merging all developers' working copies to a shared main branch regularly.
A Continuous Integration pipeline assists with this by checking the state of repository branches, that might include running tests, static analysis tools and building the application.  
_Module 7_

**Continuous Delivery/CD** - The ability to deploy software at any time using an automated deployment pipeline.
The pipeline may still have steps that have to be manually approved.  
_Module 8_

**Continuous Deployment** - An extension of Continuous Delivery where each viable commit to a main branch is automatically deployed through to production with no manual intervention.  
_Module 8_

**CPD** - "Continued Professional Development", continually improving your own knowledge and skills.  
_Module 6_

**Dependency Checking** - Automated analysis of a systems dependencies to ensure they do not have any known vulnerabilities.  
_Module 10_

**Feature toggle** - A flag used to alter the behaviour of a system, for example to turn a new feature on and off.
Using feature toggles allows short lived branches to be used for large features that need to be turned on all at once.  
_Module 2_

**Functional/non-functional requirements** - Functional requirements pertain to features of an application.
Non-functional requirements (NFRs) describe other attributes of a system, such as performance, accessibility and security.
NFRs are often not explicitly written down on tickets, but are nonetheless critical to building a working application.  
_Module 6_

**IaC** - Infrastructure as Code, managing the provisioning of Cloud infrastructure as code rather than through manual processes.
Examples of Infrastructure as Code tools are Terraform, Pulumi, ARM templates and CloudFormation.  
_Module 12_

**Immutable Infrastructure** - Treating servers as immutable, that is they are only created and destroyed, never updated in place.
This ensures your servers are recycled with each release, which makes it easier to know what state they are in and can allow for easier rollbacks if you leave the old servers up until each release is complete.  
_Module 5_

**Impact mapping** - A diagram connecting business goals to deliverable tasks, see <https://www.impactmapping.org/drawing.html>.  
_Module 6_

**Metrics** - Properties of a service that you monitor over time. Could be CPU or Memory usage, the number of requests or errors, or a custom metric that's specific to your application.  
_Module 13_

**Microservices** - An architectural pattern using lots of small services to form a system rather than one large monolith.

**Mob programming** - Programming with a group (>2, that would be Pair Programming) of people.  
_Module 2_

**MTBF** - "Mean Time Between Failures", a measure of how often a service fails. MTTF "Mean Time To Failure" is a similar measure for equipment that eventually fails permanently, like a hard drive, though they are sometimes used interchangeably when talking about services.  
_Module 6_

**MTTR** - "Mean Time To Recovery", how long it takes to fix critical system failures.
DevOps principles encourage aiming to reduce MTTR over increasing MTBF as a better route to moving quickly with low downtime.  
_Module 6_

**Penetration testing** - AKA Pen testing. Evaluating the security of a system by attempting to breach it.  
_Module 10_

**Patching** - Applying "patches" (updates) to a server/service, which might be to the operating system, components like web servers or direct library dependencies.
It's important to apply security patches quickly when they become available.
CD, Immutable infrastructure and containerisation can all help make easier.
Tools like Dependabot or Renovate can automate raising PRs to update dependencies.  
_Module 5_

**Pipeline** - An automated CI/CD process. The pipeline analogy comes from having several steps run in sequence, like passing through a pipe.  
_Module 7_

**Post-Mortem** - A review session after an incident to determine what went wrong and how to prevent a repeat.
Sometimes called a retro or retrospective.  
_Module 6_

**Refactoring** - Improving the layout of code without changing behaviour.  
_Module 2_

**Refreshing** (a server) - Refreshing or recycling a server refers to spinning up a replacement server when using immutable infrastructure.  
_Module 5_

**Retrospective** - A review session to reflect and suggest improvements to your processes.  
_Module 6_

**SaaS** - "Software as a Service" software that you pay for, often per-user, and don't have to maintain.
This is in comparison to enterprise software you might purchase and host yourself, or bespoke software that you write and host yourself.  
_Module 11_

**Test double** - When writing tests you might want to exclude some code, or an external dependency, to make your tests faster to write and run.
A few types of test double are (these terms are often used interchangeably in practice):

* Stub - a stub implementation is a test double that returns fixed responses to calls
* Fake - a implementation that behaves a bit like the real thing, for example, using a hash table instead of a Redis instance
* Mock - similar to a stub, but with some extra tricks, like recording (spying on) calls to it so that you can assert that a specific function was called

_Module 3_

**TDD** - "Test Driven Development", the practice of writing failing tests before writing code.  
_Module 3_

**Test Pyramid** - A diagram showing the idea of having fewer higher level end-to-end tests built on many lower level unit tests.  
_Module 3_

**UAT** - "User Agent Testing" manual testing performed by the end user to determine whether a system satisfies the requirements. Also known as Acceptance Testing.  
_Module 3_

**User story** - A translation of user needs into something a developer can act on, often in the format "_As a \<role or persona>, I can \<functionality> so that \<reason>_"  
_Module 6_

## EPA terms

These are the names and acronyms given to the various parts of the EPA process.
You don't need to know these, but we define them here for reference if you're not sure what something means.

**EPA** - "End Point Assessment", the assessment period for the DevOps apprenticeship. It will start after you have finished the course and submitted a project plan.
The EPA has two components:

* _Work-based project_ and associated _Practical Assessment_
  * In the standard, "Assessment method 1: Project and Practical Assessment"
* _Professional Discussion_ interview
  * In the standard, "Assessment method 2: Professional discussion"

**EPAO** - "End Point Assessment Organisation", in our case BCS, the British Computer Society.

**KSBs** - "Knowledge, Skills and Behaviours". These represent the learning outcomes of the course and are part of the apprenticeship standard.  
[_DevOps KSBs_](https://www.instituteforapprenticeships.org/apprenticeship-standards/devops-engineer-v1-0#K1)

**Practical Assessment** - After you have finished your Work-based project and submitted your evidence, the assessor will organise a Practical Assessment.
This is a three hour interview where you will present and demonstrate your Work-based project.

**Professional Discussion** - The second, smaller component of the EPA. A one hour interview about your work and organisation during the apprenticeship that will allow you to demonstrate your knowledge and skills in the areas that are difficult to demonstrate in the work-based project.
The Professional Discussion typically occurs about half way through your Work-based project.

**Work-based project** - The 12 week EPA project during which you must demonstrate your knowledge of the course topics.
You will submit a plan for this project before starting EPA, and once the project is finished you will have a Practical Assessment interview to demonstrate it.
