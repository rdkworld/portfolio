#Q&A chatbot
from langchain.llms import OpenAI
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain.llms import HuggingFaceHub


#Load environment variables
from dotenv import load_dotenv
load_dotenv()

import streamlit as st
import os

#Load OpenAI model and get responses
def get_openai_response(question):
    llm = OpenAI(openai_api_key = os.environ.get("OPENAI_API_KEY"), model_name="gpt-3.5-turbo-instruct", temperature=0.5)
    response = llm(question)
    return response

#Load GeminiPro model and get responses
def get_gemini_pro_response(question):
    llm = ChatGoogleGenerativeAI(google_api_key = os.environ.get("GOOGLE_API_KEY"), model="gemini-pro", temperature=0.5)
    response = llm.invoke(question)
    return response

#Load GeminiPro model and get responses
def get_huggingface_response(question):
    llm = HuggingFaceHub(repo_id="google/flan-t5-large",model_kwargs={"temperature": 0.5, "max_length": 64})
    response = llm(question)
    return response

#Initialize streamlit app
st.set_page_config(page_title="Q&A Demo")
st.header("Langchain Application")

input = st.text_input("Input = ", key = "input")
#response = get_openai_response(input)
print(input)
# response = get_gemini_pro_response(input)
response = get_huggingface_response(input)

submit = st.button("Ask the question")

#If ask button is clicked
if submit:
    st.subheader("The Response is ")
    st.write(response)