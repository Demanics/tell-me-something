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
        
        The following content contains web search results collected from multiple online sources. The results may include headlines, snippets, descriptions, rankings, dates, metadata, and extracted text from webpages.
        Use the search results as contextual evidence rather than assuming every statement is fully verified. Multiple sources may contain overlapping information, conflicting details, promotional language, or incomplete context.

        Instructions:
        * Identify important themes, facts, and recurring patterns across the search results.
        * Prioritize information supported by multiple sources.
        * Distinguish between facts, opinions, and assumptions where possible.
        * Ignore duplicate information and reduce noise.
        * If information conflicts, mention the uncertainty instead of forcing a conclusion.
        * Infer broader context only when it is strongly supported by the provided data.
        * Do not invent missing facts that are not present in the search results.
        * Base the response primarily on the supplied information.
        """
        
        response=self.model.generate_content(full_prompt, stream=True)
        for chunk in response:
            yield chunk.text
        