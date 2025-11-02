---
name: transcribe-and-summarize
description: Transcribe and summarize content from URLs (articles, videos, audio), documents, and other sources. Extracts text/audio content and provides comprehensive summaries with key points.
---

# Transcribe and Summarize Skill

## Overview

This skill helps extract, transcribe, and summarize content from various sources including:
- **Web articles and blog posts** (HTML pages)
- **YouTube videos** (via transcript APIs or third-party services)
- **Audio files** (MP3, WAV, M4A, etc.)
- **PDF documents**
- **Social media posts**
- **Research papers and documents**

Use this skill when:
- User asks to summarize a URL, article, or video
- User wants to transcribe audio content
- User needs key points extracted from long-form content
- User wants to save extracted content as text files

## Instructions

### For URL/Article Content:
1. Identify the content type from the URL
2. Use appropriate extraction method:
   - For web articles: Use WebFetch to extract and convert to markdown
   - For YouTube videos: Extract transcript using YouTube Transcript API or helper script
   - For PDFs: Extract text content using PDF tools
3. Generate a comprehensive summary with:
   - Main topic/overview
   - Key points (bulleted list)
   - Important quotes or statistics
   - Conclusion or main takeaway

### For YouTube Videos:
1. User provides YouTube URL (any format: youtube.com, youtu.be, etc.)
2. Extract video ID from URL
3. Attempt transcript extraction using multiple methods:
   - **Method 1**: YouTube Transcript API (if youtube-transcript-api installed)
   - **Method 2**: Built-in helper script at `scripts/youtube_transcript.py`
   - **Method 3**: Manual extraction instructions if automated fails
4. If transcript obtained, create summary with:
   - Video title and duration
   - Video description summary
   - Transcript formatted by topics/sections
   - Key takeaways and main points
   - Important quotes with timestamps (if available)
   - Suggested next topics/related videos
5. If transcript unavailable:
   - Provide clear instructions for manual extraction
   - Suggest alternative transcript services
   - Guide user on how to use the helper script

### For Local PDF Files:
1. Ask user for file path (absolute path recommended)
2. Use Read tool to extract PDF content
3. Identify document structure (title, sections, pages)
4. Extract all text, tables, and important visual descriptions
5. Create structured summary:
   - Document title and metadata
   - Main sections breakdown
   - Key findings or points from each section
   - Tables and data summary
   - Conclusion or abstract

### For Local Word Documents (DOCX):
1. Ask user for file path
2. Extract text content using available tools
3. Preserve document structure (headings, sections, formatting)
4. Summarize content by section
5. Extract tables and key data points
6. Include bullet points and numbered lists

### For Local Excel Files (XLSX):
1. Ask user for file path
2. Extract sheet names and structure
3. For each relevant sheet:
   - Identify columns and data types
   - Extract key statistics (totals, averages, counts)
   - Summarize trends or patterns
   - Note any formulas or calculated fields
4. Create summary highlighting:
   - Data overview and structure
   - Key metrics and findings
   - Relationships between sheets (if applicable)

### For Local Video Files:
1. Ask user for file path and video format (MP4, MOV, AVI, etc.)
2. Note: Direct video transcription requires external tools
3. If transcript/captions available:
   - Extract subtitle file (.srt, .vtt) if present
   - Use extracted captions for transcription
4. Alternative: Ask user to:
   - Extract captions from video using subtitle tools
   - Provide pre-recorded transcript
5. Extract video metadata:
   - Duration
   - Resolution
   - Frame rate
6. Create summary with:
   - Video title and description
   - Transcript (if available)
   - Key scenes/timestamps
   - Main topics covered

### For Local Audio Files (MP3, WAV, M4A, OGG):
1. Ask user for file path and audio format
2. Note: Direct audio transcription requires external services
3. Alternative approaches:
   - If transcription already exists, use that
   - Ask user to use transcription service (Whisper, Rev, etc.)
   - Extract audio metadata (duration, bitrate, artist info)
4. If transcript provided:
   - Create detailed summary by sections/timestamps
   - Extract key quotes or important statements
   - Note speaker information
5. Summary should include:
   - Audio title and duration
   - Speaker/artist information
   - Transcript (if available)
   - Key points and timestamps
   - Main topics covered

### For Multiple Files:
1. Process each file sequentially
2. Create individual summaries for each
3. Optionally create:
   - Combined comparison summary
   - Cross-file references and connections
   - Master index of all content

### For Audio Content:
1. Check if the user can provide the audio file path or URL
2. If transcript available, use that
3. Provide summary of the audio content
4. Highlight speaker, duration, and main topics

### For Multiple URLs/Files:
1. Process each URL/file sequentially
2. Create individual summaries
3. Optionally create a comparison or combined summary

## Examples

### Example 1: Summarizing a Blog Article
```
User: "Summarize this article: https://example.com/blog/ai-trends-2024"

Claude response:
1. Uses WebFetch to extract article content
2. Converts HTML to markdown format
3. Provides structured summary:
   - Overview of AI trends in 2024
   - Key points (e.g., GPT improvements, multimodal AI, etc.)
   - Notable statistics
   - Conclusion
```

### Example 2: YouTube Video Transcription
```
User: "Can you transcribe and summarize this video: https://www.youtube.com/watch?v=DKrBGOFs0GY"

Claude response:
1. Extracts video ID: DKrBGOFs0GY
2. Attempts transcript extraction:
   - First tries youtube-transcript-api
   - Then tries helper script: scripts/youtube_transcript.py
   - Falls back to manual instructions if needed
3. If successful:
   - Extracts full video transcript
   - Creates comprehensive summary with timestamps
   - Organizes by topics/sections
   - Highlights key quotes and takeaways
4. If transcript unavailable:
   - Provides step-by-step manual extraction guide
   - Lists alternative transcript services
   - Offers guide for using python helper script
```

### Example 2b: YouTube with Helper Script
```
User: "I want to transcribe https://youtu.be/DKrBGOFs0GY using the helper script"

Claude response:
1. Install youtube-transcript-api if needed:
   pip install youtube-transcript-api

2. Run the helper script:
   python ~/.claude/skills/transcribe-and-summarize/scripts/youtube_transcript.py "https://youtu.be/DKrBGOFs0GY"

3. Script will output transcript to stdout
4. You can save to file:
   python ... youtube_transcript.py "https://youtu.be/..." > transcript.txt

5. Then request summary:
   "Summarize this YouTube transcript: /path/to/transcript.txt"
```

### Example 3: PDF Document Summary
```
User: "Summarize this research paper: /Users/name/Documents/research.pdf"

Claude response:
1. Reads PDF file using Read tool
2. Identifies document structure (abstract, sections, conclusion)
3. Provides executive summary with key findings
4. Extracts main citations and references
5. Saves summary as text file if requested
```

### Example 4: Excel Data Summary
```
User: "Summarize this Excel file: /Users/name/Documents/Q4_Sales.xlsx"

Claude response:
1. Reads Excel file structure
2. Identifies sheets and columns
3. Extracts key statistics (totals, trends, comparisons)
4. Creates summary with:
   - Data structure overview
   - Key metrics and findings
   - Visualized data trends in text format
5. Offers to export summary as CSV or text
```

### Example 5: Word Document Analysis
```
User: "Create a summary of this document: /Users/name/Documents/report.docx"

Claude response:
1. Extracts text from Word document
2. Preserves section structure and headings
3. Summarizes each section
4. Extracts key data points and tables
5. Provides formatted summary with main findings
```

### Example 6: Video Transcription Request
```
User: "I have a video file at /Users/name/Videos/presentation.mp4, can you summarize it?"

Claude response:
1. Notes the video file location and format
2. Explains transcription requirements:
   - If video has embedded captions: extract those
   - Otherwise: ask for subtitle file (.srt, .vtt)
   - Or: ask user to use external transcription tool
3. If transcript provided: creates detailed summary with:
   - Key topics and timestamps
   - Main points from each section
   - Important quotes or insights
```

### Example 7: Audio File with Transcript
```
User: "Summarize this podcast: /Users/name/Audio/episode123.mp3 (transcript available)"

Claude response:
1. Reads transcript file
2. Creates summary by topic/section
3. Extracts key quotes and insights
4. Provides formatted summary with:
   - Episode title and duration
   - Speaker information
   - Main topics covered
   - Key takeaways
```

### Example 8: Multiple Files Comparison
```
User: "Compare these three PDFs about climate change: file1.pdf, file2.pdf, file3.pdf"

Claude response:
1. Summarizes each PDF individually
2. Creates comparison matrix of key points
3. Identifies common themes
4. Highlights unique perspectives
5. Provides master summary with all sources cited
```

## Implementation Details

### Supported Content Types

#### Remote/Web Content
- **Web articles**: HTML pages, blog posts, news sites
- **YouTube videos**: Full transcript extraction with multiple methods
  - Supports all YouTube URL formats (youtube.com, youtu.be, etc.)
  - Automatic video ID extraction
  - Multiple extraction methods (API, helper script, manual fallback)
- **Other video platforms**: Vimeo (if publicly available)
- **Structured data**: JSON articles, RSS feeds

#### Local Files (Fully Supported)
- **Documents**: PDF, DOCX (.docx), TXT
- **Spreadsheets**: XLSX (.xlsx), CSV
- **Transcripts**: .txt, .srt, .vtt (from YouTube or other sources)
- **Media files with transcripts**: MP4, MOV, AVI (if subtitles available), MP3, WAV, M4A, OGG (if transcript available)
- **Archive files**: ZIP (extractable documents)

### Tools Used
- `Read`: For extracting local file content (PDF, DOCX, TXT, XLSX)
- `WebFetch`: For extracting web content
- `Bash`: For file metadata and format detection
- `Glob`: For finding files by pattern
- Third-party APIs: YouTube transcript API, transcription services (when needed)
- Markdown conversion: Converting HTML and documents to readable markdown

### Best Practices
1. Always preserve important quotes and data points in summaries
2. Use clear hierarchical formatting for readability
3. Include source URLs and dates in summaries
4. For video content, mention duration and format
5. For audio, note speaker/presenter information
6. Offer to save summaries as files when appropriate

## Limitations and Fallbacks

- **YouTube**: Direct API access limited; suggest transcript extraction or captions
- **Paywalled content**: Cannot access restricted articles
- **Non-English content**: May require translation services
- **Complex multimedia**: Heavy video/image content may need alternative approaches
- **Audio quality**: Low-quality audio may affect transcription accuracy

## When to Use This Skill

Activate automatically when:
- User provides a URL to summarize
- User asks to "extract key points" from an article
- User mentions "transcribe" or "summarize" with content source
- User wants to convert long-form content to concise overview
- User asks to save/export extracted content

Do NOT use this skill when:
- User is asking general questions (use normal conversation)
- User needs to modify or edit content (use document editors)
- User is asking about content without providing a source
- Request is about video editing or audio production