# -*- coding: utf-8 -*-
"""
Created on Thu Aug 17 11:19:02 2023

@author: davidbrinkmeier
"""

# library https://github.com/FreeOpcUa/opcua-asyncio
# using sync API wrapper

from asyncua.sync import Client

if __name__ == "__main__":

    with Client("opc.tcp://127.0.0.1:4840") as client:
        # get a specific node knowing its node id
        var = client.get_node("ns=4;s=GVL_MAIN.systemTime")
        value = var.read_value() # get value of node as a python builtin
        print(value)
        
# %% deswegen wird es hier explizit benötigt
client = Client("opc.tcp://ifsw-st-dbrink:4840")
client.connect()
var = client.get_node("ns=4;s=GVL_Kameraueberwachung.systemTime_OPCua")
value = var.read_value() # get value of node as a python builtin
print(value)
client.disconnect()