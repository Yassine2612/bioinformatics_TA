
Infrastructure (20min)
----------------------

The resources for this course are provided in the form of a virtual machine. All required software is preinstalled and we provide sufficient storage for all data. The data you create will be provided to you after the course via our website.

----

Connection to the Virtual Machine
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Each of you got a piece of paper with a username (d\biolcourse-XX) and a password. Use this login token for the Virtual Machine and also to login to the ETH supercomputer (euler). Don't share the login token with other users or you will be logged out as the other user logs in.

You need to login to the Virtual Machine with one of the following routines. Windows 10, Windows 8 and users with the latest Windows 7 patch use the first option. MacOS users with recent versions >= (10.13) can use the second option. The last option is for Linux and old Windows/macOS users. The first two options will be faster and easier to use.

Windows 10, 8, 7 (latest patch)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Tested on Windows 10 1803 (20180801)


* open control panel
* Select view: small icons
* open "RemoteApp and Desktop Connections"
* click "Access RemoteApp and desktops" on the left hand side of the window (this also works if another remoteapp resources is configured already)
* Enter the URL: "https://biolcourse.ethz.ch/RDWeb/Feed/webfeed.aspx" and click "Next"
* click next again and enter your nethz credentials (example: d\biolcourse-XX) and click "next"
* If the remote resources have been added successfully you can click finish and find the resources in your start menu

macOS >= 10.13
~~~~~~~~~~~~~~

Tested on macOS 10.13.5 (High Sierra) using Microsoft Remote Desktop Client Version 10.1.8 (983)  (20180723)


* download the Microsoft `Remote Desktop Client <https://apps.apple.com/ch/app/microsoft-remote-desktop-10/id1295203466?l=en>`_ from the Apple App Store (apple ID required)
* start the microsoft remote desktop client
* click on the "+" icon in the menu bar and select "Feed"
* enter the URL: "https://biolcourse.ethz.ch/RDWeb/feed/webfeed.aspx" and click "Find Feed"
* under user account select "Add User Account..."
* Enter your nethz credentials (e.g. d\biolcourse-XX) and click "Save"
* click "Add Feed" and the remote resources should be downloaded
* you can now find the resources under the "Feeds/biolcourse".
* Double click the link and the Virtual Machine will start

Linux, old Windows/macOS
~~~~~~~~~~~~~~~~~~~~~~~~


* go to `https://biolcourse.ethz.ch/RDWeb/webclient/index.html  <https://biolcourse.ethz.ch/RDWeb/webclient/index.html>`_
* login with your nethz credentials (e.g. d\biolcourse-XX)
* click the "biolcourse"
* You will be connected to the Virtual Machine via your web browser

----

Inside the Virtual Machine
--------------------------

Tools required for the tutorial are preinstalled and highlighted. Some other tools have been added for your convenience.


* Required software

  * **mobaXterm**
  * **R 3.5.0**
  * **RStudio**

* Additional software

  * python version: 3.6.8
  * anaconda: 2019.03  
  * anaconda-navigator: 1.9.7
  * conda version : 4.6.14
  * jupyterlab: 0.35.4
  * Jupyter Notebook: 5.7.8
  * FileZilla
  * Acrobat
  * MS Office

The VM runs Windows 10. After logging in you will be asked if you want to install updates. Ignore this message.
Try opening RStudio and mobaXterm and see if they work.
Open the network drive on the Desktop (Workshop_Bern). All data used and produced in this course will be stored here.

**Use only the subfolder with your username for writing!. E.g biolcourse-35.**
