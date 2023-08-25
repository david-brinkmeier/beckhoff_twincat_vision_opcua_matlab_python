clc
clearvars

% serverList = opcuaserverinfo('opc.tcp://YOURIPADDRESS:4840'); % server might host multiple opcua servers
serverList = opcuaserverinfo('localhost');
ServerInfo = findDescription(serverList, serverList(1).Description); % in that case we specify based on description
uaClient = opcua(ServerInfo); % and generate an instance of a opcua client to that connection
setSecurityModel(uaClient,'None'); % if required security is set before (!) connection
connect(uaClient); % then we connect

% the code below expects a scalar variable
% select a "counter" or "systemtime" variable from the OPC UA variables
% Nodelist can contain handles to multiple variables of different types

% warning on off only bc mathworks implementation of nodelist gui is
% actually deprecated and throws warnings
warning off
NodeList = browseNamespace(uaClient); % opens GUI, select OPCUA_Image_1 or 2
warning on

if ~isempty(NodeList) && length(NodeList) == 1 && isempty(NodeList.ServerArrayDimensions)
    abort = false;
else
    abort = true;
    warning('Select a scalar OPC UA Variable');
end

close all force
while ~abort % exit by pressing any keyboard character in figure
    tic
    [Values,Timestamps,Qualities] = readValue(uaClient, NodeList);
    fprintf('Value: %i, time = %.3f ms\n',Values,toc*1e3);
end
disconnect(uaClient); % good practice to disconnect