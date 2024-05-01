---
title: DAMA
---

```{=org}
#+STARTUP: overview
```
# DAMA {#dama-1}

## Motivation for Data Management

-   Visibility
-   Reliability
-   Security
-   Scalability

## challenges

-   reduce cost
-   increase storage
-   deliver stream data for more IoT

## Motivation for Research Data Management

-   the amonut of data growth fast
-   new technologies
-   more accessible data due to standardisation
-   Required by funding agency
-   Scientific

## Key difference between Data management Vs Data Science

-   Acquisition
-   Storage
-   Quality
-   Governance
-   Integrity

## Data Science Life Cycle

Acquirement, clean, **explore, preprocessing, model**, validation,
present

## Research Data Life Cycle

**Plan**, Collect, Assure, Describe, Submit, Preserve, Discover,
Integrate, Analysis, Publish

## Research Data Life Cycle 2

Analysis \<- discovery $\downarrow$ $\uparrow$ Archiving processing -\>
Distribution

-   version controll
-   provenance
-   normalization
-   integrity preservation
-   curation

## Storage & Preseveration

-   storage, mid-term, on my own disk
-   preseveration, long term, accessible for other
-   321
-   Accessibility, Authenticity, Longevity

# Data Model

## model

-   why? to save the data in the database or information system,
    conceptual representation of data objects, associcated with other
    data object
-   benefits, helpful for visual representation, busisses rules,
    regulatory compliances, consistancy conventions

## data moduling technologies

-   ERM, Entity Relation Model
-   UML, Unified Modeling Language

## Data modul Types

-   Conceptual
-   Logical
-   Physical

## Data Type

### Structured

### Semi-Structured

self-describing structur json, XML, Email, Key-value-Store

### Unstuctured

## Data Acquire

-   Harvesting from external into system storage

-   Ingesting from different storages to different step for processing

# Database

## Hierarchical database

-   hierarchical structured
-   1 to 1, 1 to n,
-   XML

## Network database

-   Predecessor of relational database
-   more than one parent
-   allow n to n
-   uses a direct graph with direct link
-   can becomes a complex structure

## Relational Database

-   not sufficient for fast growth of big data and its complexity
-   hard to scale horizontally
-   Normalization, reduce the disk space
-   DeNormalization, fast and optimised for query
-   Snowflake schema,
    -   less disk space
    -   normalized
    -   minimal redundency
    -   powerful for data analysis
    -   allow many to many relationship
-   Star Schema(denormalization)
    -   simple to understand and build
    -   fast querying, no join

## Object-Oriented Database

## No-SQL database

-   for big data

## ACID compliance

-   potential failures, server, power, OS
-   Atomicity
-   Consistency
-   Isolation
-   durablity [IMB
    Statement](https://www.ibm.com/docs/en/cics-ts/5.4?topic=processing-acid-properties-transactions)

## CAP Theorem

-   Consistency
-   Availability
-   Partition tolerance
-   sql(CAx), no-sql(xAP)

## ETL Process

-   E, Extract: Read data from source
-   L, Load, store data in the final data store
-   T, Transform: modify data based on the requirement
-   mostly is **ELT**
-   but if the data source allow modification, **TEL** is also possible

## Data Warehouse

-   integrated data from different source
-   resructure data (denormalization)
-   optimized for analysis
-   Building
    -   Data source Layer: integrate internal and external data
    -   Staging layer: conduct transformation
    -   Storage Layer: host a database

## Dagtabase

-   real time data
-   optimized for modification and querying(very efficient)
-   normalized data

## Data access in system

-   OLTP: Normalized
-   OLAP: Denormalized

## Data Marts

-   subject-oriented database
-   to meet the specific group of users
-   data access with higher performance
-   Data maintenance, different department can have their own controll
-   Easy setup, simple design, required less technical
-   Analysis, KPIs,
-   Easy input

## Data Lake

  -------------------- ----------------------
  data Warehouse       Data Lake
  processed            raw
  structured           all possible and raw
  ready for analysis   open
  business user        data scientists
  costly               easy
  more secure          less
  sql                  no sql
  fast result          slow resulte
  -------------------- ----------------------

## Data Mesh

-   domain-oriented decentralized data owership and architecture
-   data as a product
-   self-serve data infrastructure as platform
-   federated computational governance
-   architecture for data governance

## Data Fabric

-   conceptual
-   focus on highly automating and integrating
-   need more matedata

# Meta Data

Meta data is must, a connect(descripation) data of data, necessary for
control and efficiency while processing data, also important and
required for access and discovery. problem, stored in different place
also different form.

## FAIR Principes

-   Findable
-   Accessable
-   interoperable
-   Reuseable
-   The principles emphasise **machine-actionability**, because humans
    increasingly rely on computational support to deal with data as a
    result of the increase in volume, complexity, and creation speed of
    data.

## Type

## direction

-   who created it, what it is, when, where, how, licence.

## Meaning

-   Controlled Vocabular
    -   list of words, to tag the information
    -   predefined and authorized
    -   reduce ambiguities of natural language
    -   improve retrievablilty
    -   support interoperable
-   Texonomies
    -   with hierarchical structur
-   Thesaui
    -   control of terms
    -   Hierarchical, Equivalence, Association relationship within terms
    -   support consistent indexing
    -   serve interoperability
-   Ontologies, large Thesaui

## Linked Data

-   URIs (Uniform Resource Identifiers) to name individual things
-   HTTP URIs to find things in web
-   linked data 2, all conceptual things should start with http

## Signposting

An approach to make the scholarly web more friendly to machines.

## PIDs

standard, invariant and long-term reference of a digital resource,
regardless of status location or current owner

### Actionable IDs

A Persistent Identifier (PID) policy for the European Open Science Cloud

### Machine Actionable

means that a formal statement is syntactically and semantically
specified enabling computing systems to carry out automatic processing.

### URLS

-   subset of URIs
-   related to IP address

### Sustainability by technology

-   reliable
-   robust
-   long term perspective

### PID data type

Types are Metadata Elements

# Data Governance

## define

-   Data governance determines what the data represents and what it can
    be used for
-   Authentication and Authorization required

## dimensions

-   Organization, roles, responsibilites(RACI model)
-   Process,
-   Technology
-   People, Trust, Ethics
-   Data

## Role

-   Formed
-   Accountable
-   Consulted
-   Responsiable

# Data Quality

-   Data quality describes how good it fits for its intended use:
    Operations, Decision making, Planning, Researching

## Dimension

-   accessibility or availability
-   accuracy or correctness
-   comparability
-   completeness or comprehensiveness
-   consistency, coherence, or clarity
    -   refers to whether the same data kept at different places do or
        do not match.
    -   ACID ensure from one valid to another
    -   peer-2-peer may be violated
-   credibility, reliability, or reputation
-   flexibility
-   plausibility
-   relevance, pertinence, or usefulness
-   timeliness or latency
-   uniqueness
-   validity or reasonableness

# Data Management(DAMA)

Dimension is defined as a measurable features of an object

-   Accuracy
-   Availability
-   Clarity
-   Completeness

# Data Security

Definition, planning, development, and execution of security policies
and procedures to provide proper authentication, authorization, access,
and auditing of data and information assets.

## Access

-   role based access control
-   attribute-based access control

# GraphQL

It\'s smart API, query intersting data in a smart way

# Microservice Architecture

Api for difference Applications, also standardized

## Function as a service

S3 Amazon

# Data Operation

to improve the terms of time for data analysis

# Data Flow Diagram

representing the flow of data through a process or system

## Rules

-   a process must have at least one input data and one output data
-   data stroe must have at least one data flow in and data flow out
-   data stroage must through a process
-   all prcesses will go to another process or end up with data store
-   data can not flow between entities

## event dirven Data handing

-   Synchronous
-   Asynchronous

## Message Queue

-   producer/consumer
-   Eventual consistency / strong consistency(consistency)
-   At-least-once/Exactly-once/At-most-once(Processing models)

# Read-only Data store

## Principles

-   they are immutable
-   only original data source can deliver to RDS
-   one RDS for each application
-   each are specific applications
-   hosting near the original data
-   data provider is responsible for data integrity
