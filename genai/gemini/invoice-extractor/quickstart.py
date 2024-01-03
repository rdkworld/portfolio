import pathlib
import textwrap
import os

import google.generativeai as genai

from dotenv import load_dotenv
load_dotenv()

#Securely store API key
GOOGLE_API_KEY = os.getenv('GOOGLE_API_KEY')

#Alternative HTTP REST call
#curl \
#  -H 'Content-Type: application/json' \
#  -d '{"contents":[{"parts":[{"text":"Write a story about a magic backpack"}]}]}' \
#  -X POST https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=GOOGLE_API_KEY

genai.configure(api_key=GOOGLE_API_KEY)

for m in genai.list_models():
  if 'generateContent' in m.supported_generation_methods:
    print(m.name)

