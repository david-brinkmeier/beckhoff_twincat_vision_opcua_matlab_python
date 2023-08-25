# TwinCAT OPC UA including TwinCAT Vision + MATLAB Fix + MATLAB / Python client/communication

This is a full example project which includes a working sample project that publishes scalars and arrays using OPC UA including TwinCAT Vision Images (derived from TwinCAT Vision ITcVnImage images). TwinCAT Vision is used to enable real-time processing of images acquired using GigE cameras directly on the PLC, but the data is not easily accessible / exported beyond the PLC environment. This sample project shows how to publish images to the built-in OPC UA Server.
The variables are read using a [MATLAB and Python client implementation](/MATLAB_Python_Client).

![](!doc/img1.png?raw=true)

## Prerequisites

- [Beckhoff TwinCAT XAE / Development Environment][tcxae_download]
- [TwinCAT OPC UA Server + Configurator][tcOPCua]
- [UaExpert][uaexpert] for testing purposes / verifying connection to OPC UA server
- TwinCAT actual or sample licenses (activate 7 day evaluation licenses for free) TC1200 (PLC), TF6100 (TC3 OPC UA), TF7100 (TC Vision Base)

## OPC UA: Getting started

- First, you should attempt an initial setup of a working OPC UA server using TwinCAT.
- I found these tutorials helpful: [1][opcua1], [2][opcua1], [3][opcua1].
- Make sure you can connect using UaExpert!
- **The Matlab/Python client expects to connect as Anonymous user using security policy 'none'**. 
  Verify you can connect as "Anonymous" using UaExpert to your OPC UA Server.

  ### TwinCAT OPC UA Pitfalls
  - (Here I highlight a few of the key settings you need to make, this information is contained in the tutorials linked above.)
  - In TcXaeShell: Enable View-Toolbars-OPC UA Configurator.
  - After enabling the TF6100 OPC-UA License a system reboot is required.
  - TwinCAT connectivity project: Data Access -> PLC -> set ADS Port to 851
  - Right-click on TwinCAT taskbar icon -> Router -> Here is your AMS Net ID. Use this for the next step, or use localhost...
  - TwinCAT connectivity project: Set AMS Net ID to Localhost, i.e. 127.0.0.1.1, yourNetworkIp.1.1 or specify the AMS Net ID of a remote Beckhoff IPC.
  - In PLC - PLC_Project: Enable Target File [x] TMC File. This is required so that variables using identifier "{attribute 'OPC.UA.DA' := '1'}" are sent from PLC to the OPC UA server.
 
## TwinCAT Vision: Getting started

- Open TwinCAT-Windows-ADS Image watch in the menu bar. After a PLC restart you need to reload "PLC Ports".
- The TwinCAT sample project in this repository uses a basic implementation of TwinCAT Vision nearly completely based on the [Beckhoff Example][tcvision1] using a FileSource for testing purposes. In a production environment the image source is a GigE camera and images are processed directly on the PLC.
- If you are working with TwinCAT Vision for the first time, complete the linked tutorial first!
- The test images in folder [TwinCAT/TCFileSource_testIMG][/TwinCat/TCFileSource_testIMG] need to be loaded and streamed in **Vision-TCVision-FileSource1 - Tab "FileSourceControl"**. The arrays for the OPC UA communication expect 8bit INT images, when loading the images you will be asked by the dialog if you want these images to be interpreted as 8bit.

  ### TwinCAT Vision Pitfalls
  - [You forgot to do the symbol initialization][tcvision2]. Every TwinCAT POU that accesses the images needs requires this.


[tcxae_download]: <https://www.beckhoff.com/en-en/support/download-finder/search-result/?search=TwinCAT%203%20download%20%7C%20eXtended%20Automation%20Engineering%20%28XAE%29>
[tcOPCua]: <https://www.beckhoff.com/en-en/products/automation/twincat/tfxxxx-twincat-3-functions/tf6xxx-connectivity/tf6100.html#tab_productdetails_3>
[uaexpert]: <https://www.unified-automation.com/products/development-tools/uaexpert.html>
[opcua1]: <https://www.dmcinfo.com/latest-thinking/blog/id/10396/getting-started-with-opc-ua-in-beckhoff-twincat-3>
[opcua2]: <http://soup01.com/en/2022/01/25/beckhoffusing-twincat-tf6100-to-startup-opcua-server/>
[opcua3]: <https://community.factoryio.com/t/using-opc-ua-with-twincat/1546/4>
[tcvision1]: <https://infosys.beckhoff.com/content/1033/tf7xxx_tc3_vision/4360672267.html?id=2729457735100044965>
[tcvision2]: <https://infosys.beckhoff.com/content/1033/tf7xxx_tc3_vision/5495389195.html?id=7427240198670145993>
