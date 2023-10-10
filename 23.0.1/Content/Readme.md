# IBM FileNet Content Services

## Overview

IBM FileNet Content Services is a flexible, full-featured content management solution that provides the foundation for IBM Cloud Pak® for Business Automation. In the labs you will get introduced to important core concepts of FileNet Content Platform Engine and Content Services GraphQL and IBM Content Navigator which will enable you to use FileNet Content Platform Engine to build the information architecture for automation projects realized with Cloud Pak for Business Automation. 

## Labs

**Track 2 - Developer Role / Solution Implementation**

The three labs offered for Content Services are independent of each other. Its not needed to finish one in order to work on another, and you can do them in any order.

- **[Setting up FileNet Content Manager for Automation Projects on Cloud Pak for Business Automation](CONTENT%20Lab%201%20-%20CPE.pdf)**:
  In this lab, you will create a small hierarchy of Document classes to
  capture different kinds of documents together with custom metadata,
  and will learn about the most important security concepts. You will
  explore Document storage and learn to migrate documents between
  different Storage Areas.  Further you will determine how to trigger
  custom actions for example when new documents have arrived, and how to
  configure and test functionality of content based retrieval,
  i.e. searches for documents based on information contained in the
  documents themselves, not (only) on their metadata.

  On this lab, for triggering the custom actions, a custom javascript is
  used to file a newly uploaded document into a folder, those identity
  is derived from a search. The script is available in the [Lab
  Data](lab%20data) folder. 

  **Approximate Duration**: 1.5 hours

- **[Interfacing FileNet Content Platform Engine with GraphQL on Cloud Pak for Business Automation](CONTENT%20Lab%202%20-%20GraphQL.pdf)**:
  In the second lab on GraphQL you learn through a series of
  examples, how to build the most important queries using Content Services GraphQL.  The
  examples also show how to download documents using GraphQL, how to
  create folders, and modify security settings.

  **Approximate Duration**: 1.5 hours

- **[Content Navigator on Cloud Pak for Business Automation](CONTENT%20Lab%203%20-%20ICN.pdf)**:
  In the third lab you can learn important concepts which allow you to configure IBM Content Navigator for a business application.
  The administration parts of the lab cannot be performed in the context of the shared lab environment of the JAM, and
  are provided as Walkthroughs in the lab guide.
  
  **Approximate Duration**: 1.5 hours
