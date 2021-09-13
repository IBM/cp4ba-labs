# IBM FileNet Content Manager

## Overview

IBM FileNet Content Manager is a flexible, full-featured content management solution that provides the foundation for IBM Cloud Pak® for Business Automation. In labs you will get introduced to important core concepts of FileNet Content Platform Engine and Content Services GraphQL which will enable you to use FileNet Content Platform Engine to build the information architecture for automation projects realized with Cloud Pak for Business Automation. 

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

  On this lab, for triggering the custom actions, a custom javascript is
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

