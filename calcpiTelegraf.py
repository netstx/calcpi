#!/usr/bin/env python3
import requests
import os


#  Run CalcPi JSON
jsonRAW = os.popen('/usr/bin/bash /root/calcpijson.sh')

# Read data
jsonData = jsonRAW.read()[:-1]

# Uncomment for debugging purposes
#print(jsonData)

headers = {
    'Content-Type': "application/json",
    'cache-control': "no-cache",
    }

# Telegraf URL
url = "http://telegraf.example.com:9090/telegraf/json/calcpi"

# Generate response
response = requests.request("POST", url, data=jsonData, headers=headers)

# Uncomment for debugging purposes
#print(response)
#print(response.text)
