# Exercise 3: Preparing the Deployment

## 3.1 Introduction

Also in older versions of Coud Pak For Business Automation, the case package contained a script, with which a deployment of Cloud Pak for Business Automation can be generated. This script is called `cp4a-deployment.sh`, and is still used to generate the so-called "*CR*" file, which is a YAML file for the ICP4ACluster custom resource definition and specifies, which components to install for a Cloud Pak For Business Automation Deployment.

In more recent versions, support for generating prerequisites, and verification of settings was added to the case package, via a script called `cp4a-prerequisites.sh`. That script covers creation of required databases, Kubernetes secrets, and can also verify the configuration for known problems. 

In order to create the correct databases, when running the `cp4a-prerequisites.sh` already, information about the deployment is required, i.e. what components need to be installed. That information can later be re-used when running the `cp4a-deployment.sh` script. The `cp4a-prerequisites.sh` script is used in different stages, those stages are provided to the script by mode values. The first mode, which will also be used here, is the **property** mode, in which the script will ask about details on the CP4BA deployment to be done, and generate property files. These property then need to be filled out and through this, specificy names of databases, ldap groups, et cetera.

Filling out the property values will be done in the next two exercises, step by step. When the property values are all filled out, the `cp4a-prerequisites.sh` can be invoked in **generate** mode. In this mode the provided information is taken to create the database creation scripts, as well as the Kuberetes secret definitions. With the generated files, the CP4BA databases need to be created. When this has been completed, with the last mode called **validate**, the integrity of the prerequisite configuration can be checked, so that the deployment can be completed.


## 3.2 Exercise Instructions

1.	Switch to the **Terminal** window. Change to the cert-kubernetes/scripts directory.

    ```sh
    cd $HOME/cp4ba/cert-kubernetes/scripts
	```

3.	Run the cp4a-prerequisites.sh script in prepare mode. In this mode, information about the deployment is gathered, and property files are generated to supply required parameters.

    ```sh
    ./cp4a-prerequisites.sh -m property
    ```

    > When running it without parameters, it supplies a usage.
	
    > ![Prerequisite Script Usage](Images/4.1-prerequisites-script-usage.png)
 
5.	First step is to collect, which components should be deployed. Select there only the FileNet Content Manager, by selecting **1**. Then simply press Return to continue.

    ![Selecting the Components](Images/4.1-selecting-components.png)

	> Note that the selection of the components does not need to be repeated, when running the `cp4a-deployment.sh` script later, as the selected settings are stored and the information is reused.
 
6.	The IBM Content Navigator / Business Automation Navigator and GraphQL will automatically be deployed too. Select the "Content Search Services" and "Content Manager Interoperability Services" as well, by selecting **1** followed by **2**, then press Return to continue.

    ![Selecting optional components](Images/4.1-optional-components.png)
 
7.	As the next step, the script asks for the kind of LDAP server, which will be used. Select the "IBM Tivoli Directory Server / Security Directory Server".

8.	As the next step, the script asks for the name of the storage class for slow, medium and fast storage volumes, and for block storage volumes. In the last exercise it was shown how to obtain the value. The cluster has only one storage class named **nfs-client**. Provide that value on all four questions.

    ![Select Storage Classes](Images/4.1-storageclasses.png)
 
     > **Note:** the names of the storage classes are not checked at this point. Checking is done towards the end when invoking the `cp4a-prerequisites.sh` in validate mode. This allows to create the storage classes as part of the prerequisite installation.
 
9.	Next question is on the deployment size. Select to perform a "small" deployment.

10.	Next question is to select the kind of database to be used for the deployment. In the next exercise, a Postgres database will be created, so select "PostgreSQL".

11.	The deployment scripts supports usage of multiple different database servers on a deployment. To differentiate between them, alias names need to be provided. This deployment will use only 1, so select **db1** as the alias name(s).
 
    ![Select DB instances](Images/4.1-db-instances.png)
	
12.	Supply the name of the Openshift Project / Namespace to deploy into, the value is **ibm-cp4ba**

13.	On the question whether to restrict outbound communication to unknown destinations, select "No". 

    ![Restrict outbound communication](Images/4.1-restrict-outbound-communication.png)
 
14.	On the question how many object stores to deploy, select 2.

This concludes the information gathering, and a result page is printed in the Terminal window. 

# 3.3 Verification

The script should have created a directory with property files, for further configuration. 

List the files in the generated directory:

```sh
ls -ltR cp4ba-prerequisites
```
	
![Generated Configuration Files](Images/4.1-generated-config-files.png)
 

These configuration files need to be filled with values. Before we get to it, we will first deploy the database in the [next exercise](Exercise-4-Deploy-PostgreSQL.md).


