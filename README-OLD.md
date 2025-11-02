# Transcribe and Summarize Skill

A comprehensive Claude Code skill for transcribing, extracting, and summarizing content from various file formats including PDFs, Word documents, Excel spreadsheets, and media files with transcripts.

## 📁 What's Included

This skill package contains:

### Core Documentation
- **SKILL.md** - Main skill definition with instructions and examples
- **QUICKSTART.md** - Quick start guide for immediate use
- **reference.md** - Comprehensive reference guide for all file types
- **examples.md** - Real-world practical examples with sample outputs
- **README.md** - This file

## 🚀 Quick Usage

### Summarize a PDF
```
"Summarize /Users/yourname/Documents/report.pdf"
```

### Analyze Excel Data
```
"Summarize /Users/yourname/Data/sales.xlsx"
```

### Summarize Word Document
```
"Create a summary of /Users/yourname/Documents/report.docx"
```

### Transcribe Video/Audio (with transcript file)
```
"Summarize this video: /Users/yourname/Videos/presentation.mp4
(subtitles: /Users/yourname/Videos/presentation.srt)"
```

## 📋 Supported File Types

| Format | Support | Notes |
|--------|---------|-------|
| **PDF** | ✅ Full | Direct text extraction |
| **DOCX** | ✅ Full | Word documents, preserves structure |
| **XLSX** | ✅ Full | Excel spreadsheets, data analysis |
| **CSV** | ✅ Full | Comma-separated values |
| **TXT** | ✅ Full | Plain text files |
| **SRT/VTT** | ✅ Full | Video/audio subtitles |
| **MP4/MOV** | ⚠️ Partial | Requires subtitle file |
| **MP3/WAV** | ⚠️ Partial | Requires transcript file |
| **Web URLs** | ✅ Full | Articles, blog posts, websites |

## ✨ Key Features

- **Multi-format support**: Handle PDFs, documents, spreadsheets, and media
- **Intelligent extraction**: Automatically identify structure and key points
- **Data analysis**: Extract statistics, trends, and patterns from data files
- **Comparative analysis**: Compare multiple documents side-by-side
- **Flexible output**: Summaries, key points, detailed analysis, or data exports
- **Context preservation**: Maintain important quotes, data, and relationships

## 📖 Documentation Guide

### For Quick Start
→ Read **QUICKSTART.md**
- 5-minute introduction
- Common request patterns
- File path instructions
- Basic examples

### For Specific File Types
→ Read **reference.md**
- PDF file handling
- Word document extraction
- Excel data analysis
- Video/audio transcription
- Audio file processing
- File path best practices

### For Real-World Examples
→ Read **examples.md**
- Complete example workflows
- Sample inputs and outputs
- Different use cases
- Tips for best results

### For Complete Skill Details
→ Read **SKILL.md**
- Full skill instructions
- All supported features
- When to use (and not use)
- Implementation details

## 🎯 Common Use Cases

1. **Research & Analysis**: Summarize research papers, articles, and reports
2. **Business Intelligence**: Extract insights from data files and documents
3. **Meeting Notes**: Transcribe and summarize meeting recordings
4. **Document Review**: Compare multiple documents and find key differences
5. **Data Analysis**: Generate insights from Excel spreadsheets
6. **Knowledge Management**: Extract and organize information from various sources

## 💡 Tips for Best Results

1. **Always use absolute file paths** (e.g., `/Users/name/Documents/file.pdf`)
2. **Be specific about what you need** (key points vs. detailed analysis)
3. **Provide context** if it helps narrow the focus
4. **Request specific format** (bullets, tables, markdown, etc.)
5. **Ask follow-up questions** for deeper analysis

## 🔧 How It Works

The skill leverages Claude Code's built-in tools:
- **Read tool**: Extracts content from local files (PDF, DOCX, XLSX, TXT, etc.)
- **WebFetch**: Retrieves and processes web content
- **Bash**: Handles file detection and metadata extraction
- **Intelligent processing**: Analyzes content and creates structured summaries

## 📝 Examples of What You Can Do

### Extract Action Items from Meeting Notes
```
"Extract all action items, owners, and deadlines from /path/to/meeting.docx"
```

### Compare Financial Reports
```
"Compare Q3 and Q4 financial reports and highlight the differences"
```

### Create Data Summary from Excel
```
"Summarize /path/to/sales_data.xlsx focusing on regional performance"
```

### Analyze Research Papers
```
"Compare these three research papers and identify common themes"
```

### Transcribe Podcast Episode
```
"Summarize this podcast episode with timestamps: /path/to/transcript.txt"
```

## ⚙️ Installation

This skill is already installed in your Claude Code environment at:
```
~/.claude/skills/transcribe-and-summarize/
```

The skill is automatically recognized and will activate when you:
- Ask to summarize a URL or file
- Request transcription of audio/video content
- Ask to extract key points from a document
- Request comparison of multiple documents

## 🔄 Workflow Examples

### Single Document Summary
1. Provide file path
2. Specify output format (if desired)
3. Receive structured summary
4. Ask follow-up questions for deeper analysis

### Multi-Document Analysis
1. Provide multiple file paths
2. Request comparison or combined summary
3. Get individual + comparative analysis
4. Identify patterns across documents

### Data Extraction and Transformation
1. Provide spreadsheet path
2. Specify analysis focus
3. Get insights and statistics
4. Request export in specific format

## ⚠️ Limitations

- **Video/Audio**: Requires pre-existing transcript or subtitle file
- **Scanned PDFs**: Text extraction requires OCR (image-based PDFs not supported)
- **Paywalled Content**: Cannot access restricted web content
- **Complex Layouts**: Some PDF formatting may not transfer perfectly
- **Large Files**: Very large files (1000+ pages) benefit from section-by-section processing

## 🛠️ Troubleshooting

### File Not Found
- Verify absolute file path is correct
- Check file exists and isn't corrupted
- Ensure you have read permission for the file

### Incomplete Summary
- Large files may need section-by-section processing
- Scanned PDFs need OCR conversion first
- Ask for summary of specific sections

### Can't Transcribe Video/Audio
- Provide subtitle file (.srt, .vtt) or transcript (.txt)
- Use Whisper, Rev.com, or similar service to generate transcript first
- Extract captions from video player

## 📚 Additional Resources

- **Claude Code Documentation**: https://docs.claude.com/
- **File Format Specifications**: Check specific format documentation
- **Video Transcription Services**: Whisper, Rev, Happy Scribe, Descript

## 🤝 Contributing

If you'd like to suggest improvements or add features to this skill:
1. Test the current functionality
2. Identify gaps or improvements
3. Document your findings clearly
4. Share feedback with your team

## 📄 License

This skill is part of Claude Code and follows the same terms as the main application.

---

**Version**: 1.0  
**Created**: November 2024  
**Status**: Ready for use

For detailed information about any aspect, refer to the specific documentation files listed above.
