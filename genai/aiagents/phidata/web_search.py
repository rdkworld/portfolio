from phi.agent import Agent
from phi.model.openai import OpenAIChat
from  phi.tools.duckduckgo import DuckDuckGo

web_agent = Agent(
    name='web_agent',   
    model=OpenAIChat(id="gpt-3.5-turbo"),   
    tools=[DuckDuckGo()],       
    instructions="Alway s include sources",
    show_tool_calls=True,
    markdown=True       
)

web_agent.print_response("Tell mme about OpenAI Sora?",  stream=True)   
