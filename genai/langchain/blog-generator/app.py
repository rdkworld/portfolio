import streamlit as st
from langchain.prompts import PromptTemplate
from langchain.llms import CTransformers
from langchain.llms import HuggingFaceHub
from transformers import AutoModelForSeq2SeqLM, AutoTokenizer

#Load environment variables
from dotenv import load_dotenv
load_dotenv()

## Function To get response from LLAma 2 model

def getLLamaresponse(input_text,no_words,blog_style):

    #LOCAL COPY OF LLAMA 2 MODEL
    ### LLama2 model
    # llm=CTransformers(model='models/llama-2-7b-chat.ggmlv3.q8_0.bin',
    #                   model_type='llama',
    #                   config={'max_new_tokens':256,
    #                           'temperature':0.01})
    
    #HUGGING FACE MODEL
    # Load model and tokenizer from Hugging Face
    model_name = "meta-llama/Llama-2-7b-chat"  # Replace with the exact model name on Hugging Face
    tokenizer = AutoTokenizer.from_pretrained(model_name)
    model = AutoModelForSeq2SeqLM.from_pretrained(model_name)

    # Create a function to handle text generation (assuming CTransformers has a `generate_text` method)
    def generate_text(prompt, max_length=256, temperature=0.01):
        input_ids = tokenizer.encode(prompt, return_tensors="pt")
        output = model.generate(
            input_ids,
            max_length=max_length,
            temperature=temperature,
    )   
    generated_text = tokenizer.decode(output[0], skip_special_tokens=True)
    return generated_text

    ## Prompt Template

    template="""
        Write a blog for {blog_style} job profile for a topic {input_text}
        within {no_words} words.
            """
    
    prompt=PromptTemplate(input_variables=["blog_style","input_text",'no_words'],
                          template=template)
    
    ## Generate the ressponse from the LLama 2 model
    response=llm(prompt.format(blog_style=blog_style,input_text=input_text,no_words=no_words))
    print(response)
    return response

st.set_page_config(page_title="Generate Blogs",
                    page_icon='🤖',
                    layout='centered',
                    initial_sidebar_state='collapsed')

st.header("Generate Blogs 🤖")

input_text=st.text_input("Enter the Blog Topic")

## creating to more columns for additonal 2 fields

col1,col2=st.columns([5,5])

with col1:
    no_words=st.text_input('No of Words')
with col2:
    blog_style=st.selectbox('Writing the blog for',
                            ('Researchers','Data Scientist','Common People'),index=0)
    
submit=st.button("Generate")

## Final response
if submit:
    st.write(getLLamaresponse(input_text,no_words,blog_style))