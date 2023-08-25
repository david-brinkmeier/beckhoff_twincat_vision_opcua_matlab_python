# -*- coding: utf-8 -*-
"""
Created on Thu Aug 17 10:21:29 2023

@author: davidbrinkmeier
"""

# library https://github.com/FreeOpcUa/opcua-asyncio

import asyncio
from asyncua import Client

async def fetch_data() -> str:
    print('fetching data')
    async with Client(url='opc.tcp://127.0.0.1:4840') as client:
        node = client.get_node('ns=4;s=GVL_MAIN.systemTime')
        value = await node.read_value()
        print(value)


if __name__ == '__main__':
    asyncio.create_task(fetch_data())