# -*- coding: utf-8 -*-
"""
Created on Wed Aug 16 13:33:06 2023

@author: davidbrinkmeier
"""

# library: https://github.com/FreeOpcUa/python-opcua (deprecated)

from opcua import Client
import sys
import time
import datetime

url = "opc.tcp://127.0.0.1:4840"

try:
    client = Client(url)
    client.connect()
    print("Connected")
except Exception as err:
    print("err", err)
    sys.exit(1)
    
if __name__ == '__main__':
    counter_node = client.get_node("ns=4;s=GVL_MAIN.systemTime")
    counter_value = counter_node.get_value()
    print("Counter value is: ", counter_value)
    
# %%
class Timer(object):
    def __init__(self, divider=1, name=None, filename=None):
        self.divider = divider
        self.name = name
        self.filename = filename

    def __enter__(self):
        self.tstart = time.time()

    def __exit__(self, type, value, traceback):
        message = 'Elapsed: %.6f milliseconds' % (((time.time() - self.tstart)*1000)/self.divider)
        if self.name:
            message = '[%s] ' % self.name + message
        print(message)
        if self.filename:
            with open(self.filename,'a') as file:
                print(str(datetime.datetime.now())+": ",message,file=file)
    
# %% read some variables and test how long it takes per read
    
var_array = [0] * 1000

with Timer(1000):
    for x in range(1000):
        counter_value = counter_node.get_value()
        #print("Counter value is: ", counter_value)