# Tell Me Something
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/Demanics/tell-me-something)

This repository contains a full-stack, multi-platform question-answering application. The frontend is built with Flutter, and the backend is a Python server using FastAPI. The application takes a user's query, performs a real-time web search for relevant information, and then uses Google's Gemini LLM to generate a comprehensive, sourced answer that is streamed back to the user.

## Architecture

The project is divided into a frontend client and a backend server.

*   **Frontend (Flutter):** A cross-platform application built with the Flutter framework. It provides the user interface for entering queries and displaying the streamed results.
    *   **UI:** Built with standard Flutter widgets, `google_fonts` for typography, and `skeletonizer` for loading states.
    *   **Communication:** Uses the `web_socket_client` package to establish a persistent connection with the backend for real-time data streaming.
    *   **Rendering:** Displays generated answers using the `flutter_markdown_plus` package to render Markdown content.

*   **Backend (Python/FastAPI):** A high-performance server that handles the logic for search, ranking, and answer generation.
    *   **API:** Built with FastAPI, providing a WebSocket endpoint (`/ws/chat`) for real-time communication with the Flutter client.
    *   **Web Search:** Utilizes the `tavily-python` client to perform web searches and `trafilatura` to extract content from source URLs.
    *   **Relevance Ranking:** Employs `sentence-transformers` to embed the user query and search results, sorting sources by semantic relevance.
    *   **LLM Integration:** Uses the `google-generativeai` library to stream responses from the Gemini Large Language Model.

## Features

- **Real-time Web Search:** Gathers up-to-date information from the web using the Tavily API to answer queries.
- **Sourced Answers:** Provides a list of sources used to generate the answer, ranked by relevance.
- **Streaming Responses:** The backend streams both search results and the LLM-generated answer to the frontend via WebSockets for a responsive user experience.
- **Multi-Platform UI:** The Flutter frontend is designed to run on web, desktop, and mobile platforms.
- **Markdown Support:** Renders the LLM's response, including formatting and code blocks, as Markdown.

## How It Works

1.  The user enters a query in the Flutter application.
2.  The app sends the query to the FastAPI backend over a WebSocket connection.
3.  The backend performs a web search using Tavily to find relevant pages.
4.  Content is extracted from each source URL.
5.  A sentence transformer model calculates the relevance of each source to the query.
6.  The backend sends the sorted list of sources to the Flutter app, which displays them immediately.
7.  The backend then sends the query and the content of the relevant sources to the Gemini LLM.
8.  As the LLM generates the answer, it is streamed token-by-token over the WebSocket to the Flutter app.
9.  The Flutter UI renders the answer as it arrives, providing a real-time, typewriter-like effect.

## Getting Started

### Prerequisites
- Flutter SDK
- Python 3.8+
- API keys for Tavily AI and Google AI Studio (for Gemini).

### Backend Setup

1.  Navigate to the `server` directory:
    ```sh
    cd server
    ```
2.  Create a virtual environment and activate it:
    ```sh
    python -m venv venv
    source venv/bin/activate  # On Windows, use `venv\Scripts\activate`
    ```
3.  Install the required Python packages:
    ```sh
    pip install "fastapi[all]" "sentence-transformers" "numpy" "tavily-python" "trafilatura" "google-generativeai" "python-dotenv" "pydantic-settings"
    ```
4.  Create a `.env` file in the `server` directory and add your API keys:
    ```
    TAVILY_API_KEY="your_tavily_api_key"
    GEMINI_API_KEY="your_gemini_api_key"
    ```
5.  Run the backend server:
    ```sh
    uvicorn main:app --host 0.0.0.0 --port 8000
    ```

### Frontend Setup

1.  From the root directory of the project, get the Flutter dependencies:
    ```sh
    flutter pub get
    ```
2.  Run the application on your desired platform (e.g., Chrome, macOS, Windows):
    ```sh
    flutter run -d chrome
