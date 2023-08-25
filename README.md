# Twincat OPC UA including TwinCat Vision + MATLAB Fix + MATLAB / Python client/communication

This is a full example project which includes a working sample project that publishes scalars and arrays using OPC UA including TwinCat Vision Images (derived from TwinCat Vision ITcVnImage images). TwinCat Vision is used to enable real-time processing of images acquired using GigE cameras directly on the PLC, but the data is not easily accessible / exported beyond the PLC environment. This sample project shows how to publish images to the built-in OPC UA Server.
The variables are read using a [MATLAB and Python client implementation](/MATLAB_Python_Client).

![](!docs/img1.png?raw=true)

## Prerequisites

- [Beckhoff TwinCat XAE / Development Environment][[tcxae_download]]
- [TwinCat OPC UA Server + Configurator][tcOPCua]
- [UaExpert][uaexpert] for testing purposes / verifying connection to OPC UA server
- TwinCat actual or sample licenses (activate 7 day evaluation licenses for free) TC1200 (PLC), TF6100 (TC3 OPC UA), TF7100 (TC Vision Base)



[tcxae_download]: <https://www.beckhoff.com/en-en/support/download-finder/search-result/?search=TwinCAT%203%20download%20%7C%20eXtended%20Automation%20Engineering%20%28XAE%29>
[tcOPCua]: <https://www.beckhoff.com/en-en/products/automation/twincat/tfxxxx-twincat-3-functions/tf6xxx-connectivity/tf6100.html#tab_productdetails_3>
[uaexpert]: <https://www.unified-automation.com/products/development-tools/uaexpert.html>
