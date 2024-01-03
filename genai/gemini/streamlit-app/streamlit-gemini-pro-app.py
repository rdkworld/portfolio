import streamlit as st
import altair as alt
import numpy as np

# Create a title and introduction for the app
st.title("Frank Slootman: LLM Genius and Snowflake Developer Extraordinaire")
st.write(
    """
    Frank Slootman is a technology executive and investor who is best known for his work at Snowflake, where he was the CEO and chairman from 2014 to 2021. He is also the founder and CEO of ServiceNow, a cloud computing company. Slootman is a pioneer in the field of data warehousing and has been credited with helping to popularize the cloud-based data warehouse model.

    In this Streamlit app, we will explore some of Slootman's accomplishments and contributions to the field of data warehousing. We will also use Altair to create some visualizations that illustrate his impact on the industry.
    """
)

# Create a sidebar with two numerical input sliders
st.sidebar.header("Input Sliders")
bar_chart_slider = st.sidebar.slider(
    "Bar Chart Slider",
    min_value=0,
    max_value=100,
    value=50,
    step=1,
)
line_chart_slider = st.sidebar.slider(
    "Line Chart Slider",
    min_value=0,
    max_value=100,
    value=50,
    step=1,
)

# Create an Altair bar chart
data = np.random.randint(0, 100, size=10)
bar_chart = alt.Chart(
    data=dict(x=np.arange(1, 11), y=data)
).mark_bar().encode(x="x", y="y")

# Create an Altair line chart
data = np.random.randint(0, 100, size=10)
line_chart = alt.Chart(
    data=dict(x=np.arange(1, 11), y=data)
).mark_line().encode(x="x", y="y")

# Display the Altair charts
st.altair_chart(bar_chart, use_container_width=True)
st.altair_chart(line_chart, use_container_width=True)

# Display a conclusion
st.markdown(
    """
    Frank Slootman is a visionary leader who has made significant contributions to the field of data warehousing. His work at Snowflake has helped to democratize data and make it more accessible to businesses of all sizes. He is a true pioneer in the industry, and his impact will be felt for years to come.
    """
)