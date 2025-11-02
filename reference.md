# Transcribe and Summarize - Local Files Reference Guide

## YouTube Video Transcription Guide

### How YouTube Transcription Works

The skill supports three methods for extracting YouTube transcripts:

#### Method 1: YouTube Transcript API (Recommended)
**Installation**:
```bash
pip install youtube-transcript-api
```

**How it works**:
- Automatically detects available transcripts for any YouTube video
- Extracts auto-generated or manually created captions
- Works in the background without user intervention
- Fastest and most reliable method

**Supported URL formats**:
- `https://www.youtube.com/watch?v=VIDEO_ID`
- `https://youtu.be/VIDEO_ID`
- `https://www.youtube.com/embed/VIDEO_ID`
- Any YouTube URL with a valid video ID

#### Method 2: Built-in Helper Script
**Location**: `~/.claude/skills/transcribe-and-summarize/scripts/youtube_transcript.py`

**Usage**:
```bash
python ~/.claude/skills/transcribe-and-summarize/scripts/youtube_transcript.py "https://www.youtube.com/watch?v=DKrBGOFs0GY"
```

**Features**:
- Standalone Python script
- No external dependencies required initially
- Falls back to helpful error messages if transcript unavailable
- Provides step-by-step troubleshooting guidance

**Saving to file**:
```bash
python ~/.claude/skills/transcribe-and-summarize/scripts/youtube_transcript.py "URL" > transcript.txt
```

#### Method 3: Manual Extraction
If automated methods fail, users can manually extract transcripts:

**Steps**:
1. Go to the YouTube video page
2. Right-click on the video or look for three dots menu (...)
3. Click "Show transcript" or "Open transcript"
4. Click the three dots menu in transcript panel
5. Select "Save transcript" or "Copy transcript"
6. Paste into a text file

**Important notes**:
- Not all videos have available transcripts
- Some videos only have auto-generated captions
- Captions quality depends on video audio quality

### Video ID Extraction

The skill automatically extracts video IDs from any YouTube URL format:

```
https://www.youtube.com/watch?v=DKrBGOFs0GY  → DKrBGOFs0GY
https://youtu.be/DKrBGOFs0GY                  → DKrBGOFs0GY
https://www.youtube.com/embed/DKrBGOFs0GY     → DKrBGOFs0GY
```

### YouTube Summary Output Format

When summarizing YouTube videos, the skill provides:

```markdown
# YouTube Video Summary: [Video Title]

**URL**: [Full YouTube URL]
**Video ID**: [ID]
**Duration**: [Length if available]
**Upload Date**: [Date if available]
**Channel**: [Channel name if available]

## Video Description Summary
[Summary of video description/purpose]

## Full Transcript
[Complete transcript with sections]

### Key Topics Covered
- Topic 1: [Brief description]
- Topic 2: [Brief description]

## Key Takeaways
- Takeaway 1
- Takeaway 2
- Takeaway 3

## Important Quotes
- "[Quote]" - Timestamp or context
- "[Quote]" - Timestamp or context

## Follow-up Topics
- Related video suggestions
- Topics for deeper research

## Resources Mentioned
- [Resource 1]
- [Resource 2]
```

### Troubleshooting YouTube Extraction

#### Error: "Transcript Unavailable"
**Causes**:
- Video has no captions enabled
- Auto-generated captions not available for language
- Video creator disabled transcripts

**Solutions**:
1. Check if video has captions by looking for "CC" button
2. Try different language settings
3. Use manual extraction method
4. Contact video creator to enable captions

#### Error: "Could Not Extract Video ID"
**Causes**:
- Invalid YouTube URL format
- Malformed URL

**Solution**:
Use a valid YouTube URL:
- `https://www.youtube.com/watch?v=VIDEO_ID`
- `https://youtu.be/VIDEO_ID`

#### Transcript is Incomplete or Garbled
**Causes**:
- Poor video audio quality
- Heavy accents affecting auto-generation
- Corrupted transcript data

**Solutions**:
1. Try manual extraction method
2. Use third-party transcription service
3. Request human-generated transcript from creator

### Alternative Transcript Services

If YouTube transcript extraction fails, try these services:

**Free Options**:
- **Descript**: https://www.descript.com/
- **Whisper**: https://openai.com/research/whisper
- **YouTube Transcript Generator**: https://www.rev.com/tools/youtube-transcript-generator

**Paid Options**:
- **Rev.com**: Professional transcription ($1.25/min)
- **Happy Scribe**: Affordable transcription service
- **Otter.ai**: AI-powered transcription

### Python Helper Script Details

**Script location**: `scripts/youtube_transcript.py`

**What it does**:
1. Validates YouTube URL format
2. Extracts video ID
3. Attempts youtube-transcript-api method
4. Provides clear error messages if extraction fails
5. Suggests solutions and alternatives

**Requirements**:
- Python 3.6+
- `youtube-transcript-api` (recommended, but optional)
- Internet connection

**Output**:
- Prints transcript to stdout
- Prints diagnostic messages to stderr
- Exit code 0 for success, 1 for failure

**Example usage**:
```bash
# Extract and display
python youtube_transcript.py "https://youtu.be/VIDEO_ID"

# Extract and save
python youtube_transcript.py "https://youtu.be/VIDEO_ID" > transcript.txt

# Redirect errors to see diagnostics
python youtube_transcript.py "URL" 2>&1 | tee output.txt
```

---

## Local File Processing Guide

### PDF Files (.pdf)

**How to process**:
1. Ask user for file path (example: `/Users/name/Documents/report.pdf`)
2. Use the `Read` tool with the exact file path
3. Claude Code automatically extracts text from PDF
4. For large PDFs, specify line offset and limit if needed

**Example request**:
```
User: "Please summarize /Users/name/Documents/research_paper.pdf"

Steps:
1. Read the PDF file using Read tool
2. Extract text, tables, and structure
3. Summarize by sections
4. Highlight key findings and citations
```

**What gets extracted**:
- All text content (main body, headers, footers)
- Page numbers and structure
- Tables and their content
- Images (descriptions if available)
- Metadata (title, author, creation date)

**Tips**:
- Large PDFs (500+ pages) may need to be read in sections
- Use offset/limit parameters: `offset: 1, limit: 100` for pages 1-100
- Tables are extracted as text - structure is preserved
- Scanned PDFs (image-based) cannot be extracted - they need OCR

---

### Word Documents (.docx)

**How to process**:
1. Ask user for file path: `/Users/name/Documents/report.docx`
2. Use the `Read` tool to extract content
3. Document structure is preserved (headings, sections, lists)
4. Extract text, tables, and formatting info

**Example request**:
```
User: "Summarize this Word document: /Users/name/Documents/Annual_Report.docx"

Steps:
1. Read the DOCX file
2. Identify main sections and headings
3. Extract content from each section
4. Preserve tables and lists
5. Create structured summary maintaining document hierarchy
```

**What gets extracted**:
- Document text and structure
- Headings and section breaks
- Bullet points and numbered lists
- Tables with all content
- Comments and tracked changes
- Metadata (title, author, creation date)

**Limitations**:
- Complex formatting (columns, text boxes) may not extract perfectly
- Images are noted but not extracted
- Some embedded objects may be lost

---

### Excel Files (.xlsx)

**How to process**:
1. Ask user for file path: `/Users/name/Documents/Sales_Data.xlsx`
2. Use the `Read` tool to access the file
3. Identifies all sheets and their content
4. Extracts data and formulas

**Example request**:
```
User: "Analyze this Excel file: /Users/name/Data/Q4_Budget.xlsx"

Steps:
1. Read the XLSX file
2. List all sheet names
3. For each sheet: extract columns, data types, and values
4. Identify key metrics (sums, averages, percentages)
5. Summarize trends and patterns
6. Create summary highlighting key findings
```

**What gets extracted**:
- All sheet names and structure
- Column headers and data
- Cell values (numbers, text, dates)
- Formula results (the calculated values, not formulas)
- Data types and formats
- Named ranges

**Data extraction tips**:
- Summarize large datasets (1000+ rows) by statistical highlights
- Group data by categories when relevant
- Identify outliers or anomalies
- Note relationships between sheets
- Calculate key metrics: totals, averages, counts

**Example output**:
```
# Sales Data Summary

## Sheet: Monthly Sales
- 12 months of data (Jan-Dec 2024)
- Total sales: $1,245,000
- Average monthly: $103,750
- Best month: March ($156,000)
- Worst month: January ($78,000)

## Sheet: Product Categories
- 5 product categories tracked
- Top category: Electronics (40% of sales)
- Trending: Software (20% growth YoY)

## Sheet: Regional Performance
- 4 regions analyzed
- East region leads with $450,000
- West region growing fastest (15% YoY)
```

---

### Text Files (.txt)

**How to process**:
1. Ask for file path: `/Users/name/Documents/notes.txt`
2. Use `Read` tool for immediate access
3. Process entire file or sections as needed

**Example**:
```
User: "Summarize /Users/name/Documents/meeting_notes.txt"

Steps:
1. Read the text file
2. Identify main topics/sections
3. Extract action items, decisions, attendees
4. Create organized summary
```

---

### CSV Files (.csv)

**How to process**:
1. Ask for file path: `/Users/name/Data/customers.csv`
2. Use `Read` tool to access
3. Parse headers and data rows
4. Analyze patterns and statistics

**Example**:
```
User: "What insights can you find in /Users/name/Data/sales_data.csv?"

Steps:
1. Read CSV file
2. Identify columns (headers)
3. Analyze data types and ranges
4. Calculate summaries by category
5. Identify patterns or anomalies
6. Create insights report
```

---

### Video Files (with Subtitles/Captions)

**How to process**:
1. Ask for video file path AND subtitle file
2. Locate subtitle file: `.srt`, `.vtt`, or `.ass` format
3. Use `Read` tool on subtitle file
4. Create summary with timestamps

**Finding subtitles**:
- Check same directory as video file
- Common names: `video.srt`, `video.vtt`, `subtitles.srt`
- Extract using: FFmpeg, HandBrake, or video players

**Example**:
```
User: "Summarize the video /Users/name/Videos/tutorial.mp4"

Steps:
1. Ask: "Do you have subtitle file? (e.g., tutorial.srt)"
2. If yes: Read subtitle file, extract transcript
3. Create summary with:
   - Key topics and timestamps
   - Important quotes
   - Segment-by-segment breakdown
4. If no: Explain transcription requirement, suggest:
   - Extract captions from video player
   - Use service like Whisper, Rev, or Happy Scribe
```

**Subtitle file example**:
```
1
00:00:00,000 --> 00:00:05,000
Welcome to this tutorial

2
00:00:05,000 --> 00:00:15,000
Today we'll learn about Python basics
```

---

### Audio Files (with Transcripts)

**How to process**:
1. Ask for audio file path AND transcript file
2. Accept formats: TXT, SRT, VTT, or plain text
3. Use `Read` tool to access transcript
4. Create structured summary

**Example**:
```
User: "Summarize this podcast: /Users/name/Audio/ep_001.mp3"

Steps:
1. Ask: "Do you have a transcript for this episode?"
2. If yes: Read transcript file
3. Create summary with:
   - Speaker/host info
   - Main topics covered
   - Key quotes and insights
   - Episode duration and date
4. If no: Suggest:
   - Use Whisper (OpenAI's transcription API)
   - Use Rev.com or similar service
   - Use podcast platform's built-in transcription
```

**Providing transcript to Claude**:
- Share as separate file (transcript.txt)
- Or paste transcript content in the request
- Both methods work equally well

---

## Working with File Paths

### Absolute vs Relative Paths

**Always use ABSOLUTE paths** - they work everywhere:
```
Good: /Users/john/Documents/report.pdf
Good: /home/user/files/data.xlsx
Bad:  Documents/report.pdf
Bad:  ~/Documents/report.pdf (may not expand)
```

### Finding Your Files

**Using file search**:
```bash
# Find PDF files
find ~/Documents -name "*.pdf"

# Find Excel files
find ~/Downloads -name "*.xlsx"

# Find all document types
find ~ -type f \( -name "*.pdf" -o -name "*.docx" -o -name "*.xlsx" \)
```

### Organizing Files for Processing

**Best practice structure**:
```
Project/
├── Documents/
│   ├── report.pdf
│   └── summary.pdf
├── Data/
│   ├── sales.xlsx
│   └── inventory.xlsx
├── Audio/
│   ├── podcast.mp3
│   └── transcript.txt
└── Video/
    ├── presentation.mp4
    └── subtitles.srt
```

---

## Summary Format for Different File Types

### PDF Summary Format
```markdown
# Document Summary: [Title]

**Source**: [filename]
**Pages**: [total pages]
**Type**: [Type of document]

## Overview
[Brief overview of document purpose and scope]

## Main Sections
### [Section 1]
- Key point
- Key point

### [Section 2]
- Key point
- Key point

## Key Findings/Conclusions
- Finding 1
- Finding 2

## Tables/Data
[Summary of important tables or data]

## References
- [Citation 1]
- [Citation 2]
```

### Excel Summary Format
```markdown
# Data Summary: [Filename]

## Data Structure
- Total sheets: [number]
- Total rows: [number] (approx)
- Key columns: [list]

## Sheet: [Sheet Name]
| Metric | Value |
|--------|-------|
| Total | [value] |
| Average | [value] |
| Min | [value] |
| Max | [value] |

## Key Insights
- Insight 1: [data point]
- Insight 2: [data point]

## Trends
- [Trend 1]
- [Trend 2]
```

### Video/Audio Transcript Summary Format
```markdown
# Transcript Summary: [Title]

**Duration**: [length]
**Speaker(s)**: [names]
**Date**: [date]

## Overview
[Brief overview of content]

## Segment Breakdown

### Topic 1 (00:00 - 05:30)
- Key point
- Key quote: "[quote]"

### Topic 2 (05:30 - 12:00)
- Key point
- Key insight

## Key Takeaways
1. Takeaway 1
2. Takeaway 2

## Resources Mentioned
- [Resource 1]
- [Resource 2]
```

---

## Troubleshooting Local Files

### File Not Found
**Solutions**:
- Verify absolute file path is correct
- Check file extension (case-sensitive on Linux/Mac)
- Ensure file is not open in exclusive mode
- Try copying exact path from file manager

### File Encoding Issues
**Solutions**:
- Most text files work automatically
- If special characters appear: file may need encoding conversion
- UTF-8 is standard; others may need conversion

### Large File Performance
**Solutions**:
- For PDFs 500+ pages: specify line range to read
- For Excel with 10000+ rows: request summaries of specific sheets
- For large transcripts: break into sections

### Missing Data in Summary
**Possible causes**:
- File contains images (text not extracted from images)
- Complex formatting not fully preserved
- Scanned PDFs need OCR to extract text
- Embedded objects not extracted

---

## File Permissions and Security

- **Always ask permission** before processing files
- **No automatic file uploads** - work with local paths only
- **Privacy preserved** - files stay on user's machine
- **No copies made** - only reads content as needed

---

## Quick Reference: File Types Supported

| File Type | Support | Method | Notes |
|-----------|---------|--------|-------|
| PDF | ✅ Full | Read tool | Direct text extraction |
| DOCX | ✅ Full | Read tool | Preserves structure |
| XLSX | ✅ Full | Read tool | All sheets and data |
| CSV | ✅ Full | Read tool | Text-based |
| TXT | ✅ Full | Read tool | Plain text |
| MP4/MOV | ⚠️ Partial | Via subtitles | Need subtitle file |
| MP3/WAV | ⚠️ Partial | Via transcript | Need transcript file |
| SRT/VTT | ✅ Full | Read tool | Subtitle format |
| Images | ❌ Limited | Description only | Need OCR for text |
| HTML | ✅ Full | WebFetch | Web content |