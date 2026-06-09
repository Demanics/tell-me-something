import google.generativeai as genai
from config import Settings

settings=Settings()

class LLMService:
    def __init__(self):
        genai.configure(api_key=settings.GEMINI_API_KEY)
        self.model=genai.GenerativeModel("gemini-flash-lite-latest")
        
    
    def generate_response(self,query:str,search_results:list[dict]):
        context_text="\n\n".join([
            f"Source {i+1} {result['url']}:\n{result['content']}" 
            for i, result in enumerate(search_results)
        ])
        
        full_prompt=f"""
        Context from web search:
        {context_text}
        
        Query: {query}
        
        You are provided with web search results from multiple sources including documentation, articles, code examples, discussions, metadata, and extracted content.\n\nTreat results as contextual evidence, not guaranteed truth. Information may be outdated, duplicated, incomplete, conflicting, biased, or promotional.\n\nRules:\n- Base responses primarily on supplied results.\n- Do not invent facts, sources, references, statistics, code behavior, or conclusions.\n- Prefer information supported by multiple reliable sources.\n- Distinguish facts, opinions, assumptions, estimates, and speculation.\n- If sources conflict, explain uncertainty instead of forcing conclusions.\n- Remove duplicates and avoid repetition.\n- Infer broader context only when strongly supported.\n- Consider source reliability; prioritize official documentation, primary sources, research, and established publications.\n- Treat forums, social media, opinions, and promotional content cautiously.\n\nQuestion answering:\n- Answer directly first, then provide supporting context.\n- Stay relevant and precise.\n\nSummarization:\n- Extract key themes, findings, trends, and disagreements.\n\nComparison:\n- Compare objectively and mention trade-offs.\n\nData extraction:\n- Return structured information where possible.\n- Do not fabricate missing values; use \"Unknown\" or \"Not provided\".\n\nCode and debugging:\n- Generate complete code with imports, dependencies, setup, and configuration when possible.\n- Follow best practices.\n- Do not invent APIs or unsupported syntax.\n- Explain assumptions and uncertainty.\n- For debugging, identify likely causes and supported fixes.\n\nReferences:\n- Preserve attribution.\n- Do not create fake citations.\n- Cite only provided information.\n\nRecommendations:\n- Base suggestions on evidence and explain trade-offs.\n\nOutput:\n- Keep responses accurate, structured, concise when possible, detailed when necessary, and minimize hallucinations.\n\nSearch results begin below:
        """
        response=self.model.generate_content(full_prompt, stream=True)
        for chunk in response:
            yield chunk.text
        