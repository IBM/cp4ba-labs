# Exercise 8: Post Deployment Steps / Deployment Verification

# 8.1 Introduction

In the previous exercises, the prerequisites for deployment of Cloud Pak For Business Automation have been setup, and a Content-deployment has been started. In this exercise it is shown how to determine, if the deployment is completed, or if errors have happened during the deployment. In the second part, required Post-Deployment steps are performed, and the URLs for usage of ACCE and Content Navigator are extracted from the Openshift Environment.

# 8.2 Exercise Instructions

1.	Switch to the **Firefox** window, and login to the **Openshift Web Console**. Open the **Home** menu, and select **Search**. Make sure you use the **ibm-cp4ba** project. Click on **Resources** and type in **Content**. Press return to display all custom resources for the "Content" Custom Resource Definition, in project ibm-cp4ba.

    ![Finding Content Resource](Images/8.2-Find-Content-Resource.png)
 
2.	This is displaying the same object as was generated and defined in the last exercise. Click on it. On the lower part of the screen, the conditions of this deployment are listed. The deployment is complete when the row with Type "Ready" reaches status "true", as outlined below.
 
    ![Status: Ready true means its completed](Images/8.2-status-ready.png)    
 
3.	Open the **Workloads** section in the menu, and select the **Pods** menu. There should be **57 pods** now in running state, plus some in Completed stages. None should be in Pending or in CrashLoopBackoff state.

    ![47 pods in running state](Images/8.2-47pods.png)		
	
4.  Open the **Configmaps** section, and use the filter to display the configmap with the name **content-initialization-config**. 

    ![InitConfig](Images/8.2-initialization-config.png)
	
5.  Click on it to display its values. When you scroll down, you see that all the settings, cpe_initialized, css_initialized and nav_initialized are set to true. This means, that the initialization of the FileNet Content Platform Domain, and the Content Navigator was successful, i.e. the FileNet Domain and Object Stores were created, the Content Search Server configured, and Content Navigator initialized with Repository connections and Desktops.
	
	![InitUnsuccessful](Images/8.2-init-successful.png)
	
	
4.  Optionally, for further troubleshooting, use the script [deploymentStatus.sh](LabData/deploymentStatus.sh). By right-clicking the **Raw**  button the script can be saved to a local directory and executed. On a healthy environment it should print following output:

    ```
    Content CR named content found
    Custom Resource of type Content is applied
    Running	True	Running	Running reconciliation
    Ready	True	Successful	

    ZenService Deployment Progress: 100% (The Current Operation Is Completed) 
    ZenStatus: zen operator 5.1.4 build 3:  Completed

    Foundation:
        Running reconciliation
        Prerequisites execution done.

    Initialization Status:
    {
        cpe_initialized: True,
        cpe_os_number: 2,
        css_initialized: True,
        nav_initialized: True
    }

    IAM Login details: cpadmin / <password>
    ````    	
    
    
The following post-deployment steps described here follow the description in the knowledge center under "What to do next": https://www.ibm.com/docs/en/cloud-paks/cp-biz-automation/23.0.2?topic=cpd-option-1-installing-production-deployment-in-openshift-console 

1.	Choose the ConfigMaps menu in the Openshift Web Console in section Workloads. In the search box, type in **access-info**, and find the **content-cp4ba-access-info**. This is one of the places where you can get the URLs of the deployed CP4BA components. 

    > Note that the access info page is one of the resources, those name is derived from the name of the custom resource definition.
	
6.	Next, choose the **Secrets** menu in the Openshift Web Console in section **Workloads**. In the search box, search for the secret named **platform-auth-idp-credentials**.  Click to open the secret, and then click on Reveal values. 

7.	Still in the Openshift Web Console, open section **Networking** in the menu and click on entry **Routes**. Find the route called **cpd**. It contains the link to the **Cloud Pak Dashboard**. Right click the link, and select Open in New Private Window. 

8.	If the environment is configured with self-signed certificates, you will need to accept the security exception (up to two times). Then select **IBM provided credentials** and login with the credentials from the  platform-auth-idp-credentials secret. 

    ![Initial Login](Images/8.2-Initial-login.png)
 
9.	In the Cloud Pak Dashboard, click on the Manage Users tile

    ![Manage Users](Images/8.2-Manage-Users.png)
 
10.	The Access Control window opens. In the top right corner, there is a link to the Identity Provider Configuration window. There, the identity providers connected to the environment can be selected. Click on it, and note it has two entries, one for the LDAP, and one for the users defined on Openshift. 

    ![Identity Providers](Images/8.2-IdentityProviders.png)
 
11.	Use Browser-Back button to get back to the Access Control. Click the row with the cp4badmin user. 
 
    ![CP4BAdmin User](Images/8.2-cp4badmin.png)
 
12.	Click on the Assign roles button. The Assign roles window opens.  Assign all roles to the user, then click on the Assign 4 roles button in bottom right corner.

    ![Assign 4 Roles](Images/8.2-assign-4-roles.png)
 
13.	Close the private browser window, and open a new one by right clicking on the crd route again, in the Openshift Web Console. Accept the self-signed certificate, if needed. 
In the login window, this time select **Enterprise LDAP**, and supply the administrator username **cp4badmin**, and password **passw0rd** with a zero. 

    ![Second Login](Images/8.2-second-login.png)
 
14.	The Cloud Pak Dashboard should open again now, allowing administration access also for the  cp4badmin user. Verify that the Manage Users tile is still visible.

    ![Manage Users is still visible](Images/8.2-manage-users-2.png)
 
15.	Leave the private browser window open, and get back to the Openshift Web Console. In the Openshift Web Console, choose menu entry Installed Operators from the Operators section.  Click on the Name of the CP4BA FileNet Content Manager Operator. 

    ![Content Operator Tile](Images/8.2-content-operator.png)
 
16.	The Operator page opens. Select the **All Instances** tab. Here you see an alternative for checking on the deployment status. When the deployment is ready, the status column will contain the Condition Ready.

    ![Condition Ready on finished deployment](Images/8.2-condition-ready.png)
 
17.	Click on the content link. The CP4BA FileNet Content Manager Deployment overview window opens. It lists the configuration made previously through the Custom Resource Definition, and also includes links to the components.

    ![Content CR with Links](Images/8.2-Content.png)
 
18.	Copy the link to ACCE into the clipboard (right-click and invoke Copy Link), and paste it in the Private Window’s URL entry. The ACCE link has the name "CPE Login URL" in the list.

    No login should be needed, as the environment uses single sign-on through the Cloud Paks Identity Provider. In the opened ACCE window, verify that both Object Stores have been defined. 

    > Note: At this step you can investigate a bit yourself and look around. Determine for example if an Advanced Storage Area and an Index Area have been defined for the Object Stores.
	
19.	In the Openshift Web Console, copy the link to the Content Navigator. There are two, only the one with the name Navigator Login URL for CP4BA works. The other link is intended for other deployment types. Paste the link again into the Private Windows URL entry box (right click and select "Paste and Go")

20. Again, login will be skipped, and the Content Navigator desktop is shown. In the Content Navigator desktop, click the hamburger menu at the top left corner, and select the "Administration" feature there. Notice that there is also a feature for "Work", which allows access to FileNet Process Engine workflow system. It got enabled through the modifications performed on the Custom Resource in the previous chapter.

    ![Administration Feature](Images/8.2-Administration.png)

21. In the navigation area of the Content Navigator Administration feature, select "Desktops", and verify that the specified desktop was created automatically.

    ![ICN Desktops](Images/8.2-Desktops.png)


Congratulations, at this stage the deployment of the Cloud Pak For Business Automation is has been completed, and the environment could be handed over to a customer. 
