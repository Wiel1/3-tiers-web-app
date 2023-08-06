You are the lead DevOps engineer for a team developing a number of Java microservices application that will be containerised and deployed on an AWS EKS cluster. All the teams and application will 
share a single EKS cluster (multi-tenancy) but the applications and responsibilities must be clearly separated siloed to prevent cross-tenant access. The applications will use RDS as 
their persistent store. The application frontend should be capable of scaling to handle traffic from the internet. Considering the following design principles, discuss how you would go about this.


# Design principles
* Design with the end in mind
* Separation of responsibilities
* Component lifecycle
* Component operational management
