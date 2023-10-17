#!/usr/bin/env python3
import os
import requests

#path to data
path = "/data/feedback/"

keys = ["title","name","date","feedback"]

folder = os.listdir(path)
for file in folder:
        keycount = 0
        fb = {}
        with open(path + file) as f1:
                for line in f1:
                        value = line.strip()
                        fb[keys[keycount]] = value
                        keycount += 1
        print(fb)
        response = requests.post("http://35.202.109.12/feedback/",json=fb)
print(response.request.body)
print(response.status_code)
