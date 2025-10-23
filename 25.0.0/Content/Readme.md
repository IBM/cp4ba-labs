# IBM FileNet Content Manager

## Overview

IBM FileNet Content Manager is a flexible, full-featured content management solution that provides the foundation for IBM Cloud Pak® for Business Automation. In labs you will get introduced to important core concepts of FileNet Content Platform Engine and Content Services GraphQL and IBM Content Navigator which will enable you to use FileNet Content Platform Engine to build the information architecture for automation projects realized with Cloud Pak for Business Automation. 

## Labs

**Track 2 - Developer Role / Solution Implementation**

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

  On this lab, for triggering the custom actions, a custom JavaScript is
  used to file a newly uploaded document into a folder, those identity
  is derived from a search. The script is available in the [Lab
  Data](Lab%20Data) folder. Be aware that in the script, some
  replacements need to be made, to make it refer to the right
  properties. The username prefix is denoted by usrxxx in the script,
  and the xxx part needs to be updated.

  **Approximate Duration**: 4 - 5 hours

- **[Interfacing FileNet Content Platform Engine with GraphQL on Cloud Pak for Business Automation](CONTENT%20Lab%202%20-%20GraphQL.pdf)**:
  The second lab on GraphQL builds on top of the first one, as the
  searches performed using GraphQL use the documents and document
  classes defined in the first lab.  Here you learn by a series of
  example, how to build the most important queries using GraphQL.  The
  examples also show how to download documents using GraphQL, how to
  create folders, and modify security settings.

  **Approximate Duration**: 1.5 - 2 hours

- **[Introduction to Content Navigator in Cloud Pak for Business Automation](CONTENT%20Lab%203%20-%20ICN.pdf)**:
  The third lab on IBM Content Navigator builds on top of the first, but not the second one.
  In it you can learn important concepts which allow you to configure IBM Content Navigator for a business application.
  The administration parts of the lab cannot be performed in the context of the shared lab environment, and
  are provided as Walkthroughs in the lab guide.
  
  **Approximate Duration**: 1.5 - 2 hours


- **[AI-Powered Insights from FileNet Documents](CONTENT%20LAB%204%20-%20ICA.pdf)**:
  The fourth lab demonstrates how IBM Content Assistant leverages Artificial Intelligence to extract information and insights from documents
  stored in an IBM FileNet Content Engine Object Store. It ensures secure access by restricting query results to documents the user is authorized
  to view.

  The lab begins with an introduction to the IBM Content Assistant user interface, presented as an AI chat window in the lower-right corner of an
  IBM Content Navigator desktop. It also highlights the "Ask the Repository" feature, which enables users to query the AI across all documents
  in the FileNet repository.
  
  The second part of the lab explores the underlying architecture. It explains the components of the IBM Content Assistant add-on and how they
  enable integration with custom applications via the FileNet Content Engine API—such as the Client Onboarding Application.
  
  The final section provides GraphQL example mutations and queries, which can be used as blueprints in such integrations.

  **Approximate Duration**: 2 - 3 hours
   
