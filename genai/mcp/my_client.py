from fastmcp import Client
import asyncio

# client = Client("my_server.py")

# async def call_tool(name: str):
#     async with client:
#         result = await client.call_tool("greet", {"name": name})
#         print(result)

# asyncio.run(call_tool("Kanav"))

async def example():
    async with Client("http://127.0.0.1:8000/mcp") as client:
        await client.ping()

if __name__ == "__main__":
    asyncio.run(example())