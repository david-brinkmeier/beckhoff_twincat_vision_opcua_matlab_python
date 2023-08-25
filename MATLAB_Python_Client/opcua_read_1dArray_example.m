clc
clearvars

% serverList = opcuaserverinfo('opc.tcp://YOURIPADDRESS:4840'); % server might host multiple opcua servers
serverList = opcuaserverinfo('localhost');
ServerInfo = findDescription(serverList, serverList(1).Description); % in that case we specify based on description
uaClient = opcua(ServerInfo); % and generate an instance of a opcua client to that connection
setSecurityModel(uaClient,'None'); % if required security is set before (!) connection
connect(uaClient); % then we connect

% the code below expects a 1D array
% select GVL_MAIN.opcUA_array
% Nodelist can contain handles to multiple variables of different types

% warning on off only bc mathworks implementation of nodelist gui is
% actually deprecated and throws warnings
warning off
NodeList = browseNamespace(uaClient); % opens GUI, select OPCUA_Image_1 or 2
warning on

if ~isempty(NodeList) && length(NodeList) == 1 && length(NodeList.ServerArrayDimensions) == 1
    abort = false;
else
    abort = true;
    warning('Select ONE 1D array OPC UA Variable');
end

close all force
while ~abort % exit by pressing any keyboard character in figure
    tic
    [Values,Timestamps,Qualities] = readValue(uaClient, NodeList);
    if exist('h',"var") && ishandle(h)
        h.YData = Values;
        f.Children.Title.String = sprintf('%s',datestr(Timestamps,'HH:MM:SS:FFF'));
        opcua_statusCode = OPCUA_Statuscode.(sprintf('statuscode_%i',Qualities.uint32));
    else
        f = figure;
        h = plot(Values);
    end 
    drawnow
    if f.CurrentCharacter > 0
        break;
    end
    toc
end
disconnect(uaClient); % good practice to disconnect