# Bring-up Lab - Lab 1 – Using Rapid Deployment Scripts

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

You can read more about CP4BA here: **https://www.ibm.com/docs/en/cloud-paks/cp-biz-automation/23.0.2?topic=overview-what-is-cloud-pak-business-automation**

## Lab Overview

In this Lab, you will learn how to **configure and install a CP4BA production deployment** on an OpenShift cluster using the **rapid deployment scripts** developed by the IBM Business Automation and Digital Labor SWAT team.

The rapid deployment scripts cover a small area of deployments, and are thus the preferred choice for rapid deployment of PoC or Demo environments. They are available on **public GitHub** (**https://github.com/IBM/cp4ba-rapid-deployment**) and, therefore, can be used by customers, business partners, and IBMers.

The rapid deployment scripts are available for **some selected CP4BA versions**.

As part of this Lab, you will only **deploy DB2 and CP4BA**. All other required preparation steps (OpenShift, LDAP, storage, preparation of bastion host, ...) were already completed on the provided environment, so you can concentrate on the essential part: **Configure and Install IBM Cloud Pak for Business Automation version 23.0.2 on Red Hat OpenShift**.

We have created a TechZone environment preconfigured with a bastion host and a three-worker node Red Hat OpenShift cluster. In addition, IBM Security Directory Server (SDS) was installed and configured on the bastion host required by CP4BA. To fit the size of the OpenShift cluster, it is recommended to use our FoundationContent template for use by the rapid deployment scripts. This template will install foundational services required by CP4BA and Filenet Content Manager components.

Using other templates that would deploy more CP4BA components is very similar, but would require more system resources for building such a larger deployment, that are not available on the provided TechZone environment.

During the first exercise, you will reserve an environment on TechZone, access it, and verify that your RedHat OpenShift cluster is working correctly.

The following exercises will guide you through configuring and installing DB2 containerized and CP4BA version 23.0.2 IF002 on OCP using the rapid deployment scripts.

Complete this Lab to be able to earn a badge.

## Notation

Paragraphs formatted like the below contain excerpts from configuration files, or commands to enter in a Terminal window. The paragraph can be copied to the clipboard by using an icon available on the right edge of the grey area.

```sh
whoami
```

Paragraphs like the below contain additional information, which would help to understand further concepts. While it is not needed to read them, if the only wish is to follow the guide to get a CP4BA environment running, the information in those sections might also be used on badge questions.

> The above command shows the name of the user, who was used to logon to the operation system. While you typically know who you are, and might not need it, this command is often used in shellscripts.

**Approximate Duration:** 6 hours

# Table of Exercises

- **[Exercise 1: Prepare yourself for this Bring-Up Lab](Exercise-1-Prepare.md)**

  Guides you through reserving of the Lab Environment, customization of the Bastion node, and consistency checking of the Openshift environment.
  
- **[Exercise 2: Deploy DB2](Exercise-2-Deploy-DB2.md)**

  In this exercise you will deploy DB2 operator and a DB2 instance on your OpenShift environment using the rapid deployment scripts.
  
- **[Exercise 3: Create DB2 Databases](Exercise-3-Create-DB2-Databases.md)**

  See how easy it is to create the needed databases using the rapid deployment scripts.
  
- **[Exercise 4: Deploy CP4BA Operator](Exercise-4-Deploy-CP4BA-Operator.md)**

  The Case Package is downloaded, and the clusteradmin setup script is used to deploy the CP4BA Operators. Required preconditions are verified.
  
- **[Exercise 5: Deploy CP4BA](Exercise-5-Deploy-CP4BA.md)**

  Last but not least, let's deploy a CP4BA instance.
  
- Once you completed all these exercises, you can do the Quiz to earn a Badge.
  
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

- IBM, the IBM logo, and ibm.com are trademarks or registered trademarks of International Business Machines Corp., registered in many jurisdictions worldwide. Other product and service names might be trademarks of IBM or other companies. A current list of IBM trademarks is available on the web at “Copyright and trademark information” at **www.ibm.com/legal/copytrade.shtml**.

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

  
