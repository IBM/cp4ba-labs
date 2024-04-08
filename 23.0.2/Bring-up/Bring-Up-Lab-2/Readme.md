# Bring-up Lab - Lab 2 – Using Regular Deployment Scripts

Version 1.0

## Authors

* Thomas Schulze - [ThomasSchulze@de.ibm.com](mailto:ThomasSchulze@de.ibm.com)
* Matthias Jung - [matthias.jung@de.ibm.com](mailto:matthias.jung@de.ibm.com)
* Jorge D. Rodriguez - [jorgedr@us.ibm.com](mailto:jorgedr@us.ibm.com)
* Zhong Tao Gao - [gaozt@cn.ibm.com](mailto:gaozt@cn.ibm.com)

---

# Introduction

## IBM Cloud Pak for Business Automation

IBM Cloud Pak for Business Automation (CP4BA) assembles certified software from the IBM Automation Platform for Digital Business on multiple cloud infrastructures. It offers design, build, run, and automation services to rapidly scale your programs and fully execute and operationalize an automation strategy.

You can read more about CP4BA here: https://www.ibm.com/docs/en/cloud-paks/cp-biz-automation/23.0.2?topic=overview-what-is-cloud-pak-business-automation

## Lab Overview

In this Lab, you will learn how to **configure and install the CP4BA Production mode** on an OpenShift cluster using the regular deployment scripts. 

The regular deployment scripts cover a wide area of different deployments, support Air-Gap deployment and encryption of all communication channel, 
and are thus the preferred choice for deployment of customer environments which can be used on Production environments. They are available on 
**public GitHub** (https://github.com/IBM/cloud-pak/blob/master/repo/case/ibm-cp-automation/index.yaml) and, therefore, can be used by customers, 
business partners, and IBMers.

The regular deployment scripts are available for **all CP4BA versions**.

As part of this Lab, you will only **deploy PostgreSQL and CP4BA**. All other required steps were already completed, so you can concentrate 
on the essential part: **Configure and Install IBM Cloud Pak for Business Automation version 23.0.2 on Red Hat OpenShift**.

We have created a TechZone environment preconfigured with a bastion host and a three-worker node Red Hat OpenShift cluster. In addition, 
IBM Security Directory Server (SDS) was installed and configured on the bastion host required by CP4BA. To fit the size of the OpenShift 
cluster, it is recommended to use Content pattern for use by the regular deployment scripts. This pattern will install foundational services 
required by CP4BA and Filenet Content Manager components.

While inclusion of other patterns is very similar, including other patterns would increase system resources required for building a deployment, 
beyond resources available on the TechZone environment. 

During the first exercise, you will reserve an environment on TechZone, access it, and verify that your RedHat OpenShift cluster is working correctly.

The following seven exercises will guide you through configuring and installing CP4BA version 23.0.2.

Finally, a chapter with troubleshooting instructions is available for you to work through.

## Notation

Paragraphs formatted like the below contain excerpts from configuration files, or commands to enter in a Terminal window.
The paragraph can be copied to the clipboard by using an icon available on the right edge of the grey area.

```sh
whoami
```

Paragraphs like the below contain additional information, which would help to understand further concepts. While it is not needed to read them, if the only wish is to follow the guide to get a CP4BA environment running, the information in those sections might also be used on badge questions.

> The above command shows the name of the user, who was used to logon to the operation system. While you typically know who you are, and might not need it, this command is often used in shellscripts.

**Approximate Duration:** 8 hours

# Table of Exercises

- [Exercise 1: Prepare yourself for this Bring-Up Lab](Exercise-1-Prepare.md) 
  
  Guides you through reserving of the Lab Environment, customization of the Bastion node, and consistency checking of the Openshift environment.

- [Exercise 2: Deploy the CP4BA Operator](Exercise-2-Deploy-Operator.md)

  The Case Package is downloaded, and the clusteradmin setup script used to deploy the CP4BA Operators. Required preconditions are verified.

- [Exercise 3: Preparing the Deployment](Exercise-3-Prepare-Deployment.md)

  A script in the case package is used to specify the deployment to be done. The script generates property files to supply further configuration, as a result.

- [Exercise 4: Deployment of Database](Exercise-4-Deploy-PostgreSQL.md)

  A database operator is used from the OCP Operator hub, and used to deploy a PostgreSQL database. The configuration values for database server, and portname are extracted, and verified. The database server and user property configuration files are modified with required configuration values.
  
- [Exercise 5: Configure LDAP](Exercise-5-Configure-LDAP.md)

  Connectivity to the pre-configured SDS installation from the Openshift Cluster is verified, along with the LDAP Password, and the user and group names. The information is used to update the LDAP property file of the CP4BA deployment.
  
- [Exercise 6: Generate CP4BA Configuration and Databases](Exercise-6-Generating-DBs.md)

  The CP4BA Configuration Prerequisites are generated, this creates database creation scripts and Kubernetes Secrets. The 
  
- [Exercise 7: Deploy CP4BA](Exercise-7-Deploy-CP4BA.md)

  The last part is generated, this is the so-called "Custom Resource". The file is handed over to Openshift for building the cluster.
  
- [Exercise 8: Post Deployment Steps](Exercise-8-PostDeployment.md)

  Find out if deployment has completed, make cp4badmin user a real administrator, and find the URLs of the deployed components
  
- [Apppendix A: Troubleshooting CP4BA Deployment](Appendinx-A-Troubleshooting.md)

  If things dont work as they should, this section might help to identify the cause of the problem.
  
# Notices

This information was developed for products and services offered in the USA.

IBM may not offer the products, services, or features discussed in this document in other countries. Consult your local IBM representative for information on the products and services currently available in your area. Any reference to an IBM product, program, or service is not intended to state or imply that only that IBM product, program, or service may be used. Any functionally equivalent product, program, or service that does not infringe any IBM intellectual property right may be used instead. However, it is the user's responsibility to evaluate and verify the operation of any non-IBM product, program, or service.

IBM may have patents or pending patent applications covering subject matter described in this document. The furnishing of this document does not grant you any license to these patents. You can send license inquiries, in writing, to:

IBM Director of Licensing  
IBM Corporation  
North Castle Drive, MD-NC119  
Armonk, NY 10504-1785  
United States of America  

The following paragraph does not apply to the United Kingdom or any other country where such provisions are inconsistent with local law: INTERNATIONAL BUSINESS MACHINES CORPORATION PROVIDES THIS PUBLICATION "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE. Some states do not allow disclaimer of express or implied warranties in certain transactions, therefore, this statement may not apply to you.

This information could include technical inaccuracies or typographical errors. Changes are periodically made to the information herein; these changes will be incorporated in new editions of the publication. IBM may make improvements and/or changes in the product(s) and/or the program(s) described in this publication at any time without notice. 

Any references in this information to non-IBM websites are provided for convenience only and do not in any manner serve as an endorsement of those websites. The materials at those websites are not part of the materials for this IBM product and use of those websites is at your own risk.

IBM may use or distribute any of the information you supply in any way it believes appropriate without incurring any obligation to you.

Information concerning non-IBM products was obtained from the suppliers of those products, their published announcements or other publicly available sources. IBM has not tested those products and cannot confirm the accuracy of performance, compatibility or any other claims related to non-IBM products. Questions on the capabilities of non-IBM products should be addressed to the suppliers of those products.

This information contains examples of data and reports used in daily business operations. To illustrate them as completely as possible, the examples include the names of individuals, companies, brands, and products. All of these names are fictitious and any similarity to the names and addresses used by an actual business enterprise is entirely coincidental.

# Trademarks

- IBM, the IBM logo, and ibm.com are trademarks or registered trademarks of International Business Machines Corp., registered in many jurisdictions worldwide. Other product and service names might be trademarks of IBM or other companies. A current list of IBM trademarks is available on the web at “Copyright and trademark information” at www.ibm.com/legal/copytrade.shtml.

- Adobe, the Adobe logo, PostScript, and the PostScript logo are either registered trademarks or trademarks of Adobe Systems Incorporated in the United States, and/or other countries. 

- Cell Broadband Engine is a trademark of Sony Computer Entertainment, Inc. in the United States, other countries, or both and is used under license therefrom. 

- Intel, Intel logo, Intel Inside, Intel Inside logo, Intel Centrino, Intel Centrino logo, Celeron, Intel Xeon, Intel SpeedStep, Itanium, and Pentium are trademarks or registered trademarks of Intel Corporation or its subsidiaries in the United States and other countries. 

- IT Infrastructure Library is a Registered Trade Mark of AXELOS Limited. 

- ITIL is a Registered Trade Mark of AXELOS Limited. 

- Java and all Java-based trademarks and logos are trademarks or registered trademarks of Oracle and/or its affiliates. 

- Linear Tape-Open, LTO, the LTO Logo, Ultrium, and the Ultrium logo are trademarks of HP, IBM Corp. and Quantum in the U.S. and other countries. 

- Linux is a registered trademark of Linus Torvalds in the United States, other countries, or both. 

- Microsoft, Windows, Windows NT, and the Windows logo are trademarks of Microsoft Corporation in the United States, other countries, or both. 

- UNIX is a registered trademark of The Open Group in the United States and other countries.

© Copyright International Business Machines Corporation 2024. 

This document may not be reproduced in whole or in part without the prior written permission of IBM.
US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.

  