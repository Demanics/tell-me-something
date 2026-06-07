from typing import List
from sentence_transformers import SentenceTransformer
import numpy as np


# class SortSourceService:
#     def __init__(self):
#         self.embedding_model=SentenceTransformer('all-miniLM-L6-v2')
    
#     def sort_sources(self, query:str, search_results:List[dict]):
#         query_embedding=self.embedding_model.encode(query)
#         relevent_docs=[]
#         for res in search_results:
#             res_embedding=self.embedding_model.encode(res["content"])
            
#             similarity=np.dot(query_embedding,res_embedding)/(np.linalg.norm(query_embedding)*np.linalg.norm(res_embedding))
#             print(similarity)
            
#             res['relevance_score']=similarity
#             if(similarity >0.3):
#                 relevent_docs.append(res)
                
#         return sorted(relevent_docs, key=lambda x: x['relevance_score'], reverse=True )

class SortSourceService:
    def __init__(self):
        self.embedding_model = SentenceTransformer('all-MiniLM-L6-v2')
    
    def sort_sources(self, query: str, search_results: List[dict]) -> List[dict]:
        query_embedding = self.embedding_model.encode(query)
        relevent_docs = []
        
        for res in search_results:
            if res is None or not isinstance(res, dict) or res.get('content') is None:
                continue
                
            content_text = str(res['content']).strip()
            if not content_text:
                continue
            
            res_embedding = self.embedding_model.encode(content_text)
            
            dot_product = np.dot(query_embedding, res_embedding)
            norm_q = np.linalg.norm(query_embedding)
            norm_r = np.linalg.norm(res_embedding)
            
            if norm_q == 0 or norm_r == 0:
                continue
                
            similarity = dot_product / (norm_q * norm_r)
            res['relevance_score'] = float(similarity)
            
            if similarity > 0.3:
                relevent_docs.append(res)
                
        return sorted(relevent_docs, key=lambda x: x['relevance_score'], reverse=True)