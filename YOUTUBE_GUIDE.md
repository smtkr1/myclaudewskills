# YouTube Transcription Guide for Transcribe-and-Summarize Skill

## What's New

The transcribe-and-summarize skill now includes full YouTube video transcription and summarization capabilities!

## Quick Start

### For Users (Direct Summarization)

Simply ask the skill to summarize any YouTube video:

```
"Summarize this YouTube video: https://www.youtube.com/watch?v=DKrBGOFs0GY"
```

The skill will:
1. Extract the video ID automatically
2. Retrieve the full transcript from YouTube
3. Create a comprehensive summary with:
   - Video metadata (title, duration, channel)
   - Full transcript organized by topics
   - Key takeaways
   - Important quotes with timestamps
   - Related topics and resources

### Supported YouTube URL Formats

All of these formats are automatically supported:

- `https://www.youtube.com/watch?v=VIDEO_ID`
- `https://youtu.be/VIDEO_ID`
- `https://www.youtube.com/embed/VIDEO_ID`
- `https://m.youtube.com/watch?v=VIDEO_ID` (mobile)

## Installation & Setup

### Method 1: Automatic (Recommended)

The skill includes a Python helper script that handles everything:

**Location**: `~/.claude/skills/transcribe-and-summarize/scripts/youtube_transcript.py`

This script will automatically try to use the youtube-transcript-api if available, or provide helpful fallback instructions.

### Method 2: Manual Installation

For best results, install the youtube-transcript-api package:

```bash
pip install youtube-transcript-api
```

This enables:
- Faster transcript extraction
- Better error handling
- Support for all video languages
- Automatic fallback to manual extraction if needed

## How It Works

### Step 1: Video ID Extraction
The skill automatically extracts the video ID from any YouTube URL format.

### Step 2: Transcript Retrieval
The skill attempts to get the transcript using (in order):
1. **youtube-transcript-api** - If installed (fastest method)
2. **Helper script** - Built-in Python script with fallback logic
3. **Manual instructions** - If automated methods unavailable

### Step 3: Processing
If transcript is available:
- Organizes content by topics/sections
- Extracts key quotes and timestamps
- Identifies main themes and takeaways
- Prepares comprehensive summary

If transcript unavailable:
- Provides clear instructions for manual extraction
- Suggests alternative services
- Offers guidance for using the helper script

## Using the Helper Script Directly

If you prefer to extract transcripts using the command line:

### Basic Usage

```bash
python ~/.claude/skills/transcribe-and-summarize/scripts/youtube_transcript.py "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Save to File

```bash
python ~/.claude/skills/transcribe-and-summarize/scripts/youtube_transcript.py "https://youtu.be/VIDEO_ID" > transcript.txt
```

### Get Help

```bash
python ~/.claude/skills/transcribe-and-summarize/scripts/youtube_transcript.py
```

## Troubleshooting

### "Transcript not available"

**Causes**:
- Video has captions disabled
- No auto-generated captions available
- Age-restricted or private video

**Solutions**:
1. Try manual extraction from YouTube
2. Use an alternative transcription service
3. Check if video has captions (look for CC button)

### "Could not extract video ID"

**Cause**: Invalid or malformed URL

**Solution**: Use a valid YouTube URL:
- ✅ `https://www.youtube.com/watch?v=DKrBGOFs0GY`
- ✅ `https://youtu.be/DKrBGOFs0GY`
- ❌ `youtube.com/watch?v=...` (missing https://)
- ❌ Non-YouTube URLs

### Script not found

**Solution**: Verify the script location:
```bash
ls -la ~/.claude/skills/transcribe-and-summarize/scripts/youtube_transcript.py
```

If missing, the skill needs to be reinstalled.

## Manual YouTube Transcript Extraction

If automated methods fail, you can manually extract transcripts:

### Steps

1. Go to the YouTube video page
2. Look for the three dots menu (⋯) below the video
3. Click **"Show transcript"**
4. A transcript panel appears on the right
5. Copy all the text
6. Save to a text file
7. Use the skill to summarize the saved file:
   ```
   "Summarize this transcript: /path/to/transcript.txt"
   ```

### Tips

- Not all videos have transcripts available
- Some videos only have auto-generated captions (quality varies)
- Captions in different languages may also be available

## Alternative Transcript Services

If YouTube's transcription isn't available, try these alternatives:

### Free Options

- **Rev.com Transcript Generator**: https://www.rev.com/tools/youtube-transcript-generator
- **Happy Scribe**: https://www.happyscribe.com/
- **OpenAI Whisper**: https://openai.com/research/whisper

### Paid Options

- **Rev.com**: Professional transcription ($1.25/min)
- **Otter.ai**: AI-powered transcription with speaker identification
- **Descript**: Full video editing and transcription suite

## Examples

### Example 1: Quick Summary

```
User: "Summarize this: https://youtu.be/DKrBGOFs0GY"

Skill output:
# YouTube Video Summary: [Title]

**Duration**: [Length]
**Channel**: [Channel Name]

## Overview
[Brief overview of video content]

## Key Takeaways
- Takeaway 1
- Takeaway 2
- Takeaway 3

## Full Transcript
[Complete organized transcript]
```

### Example 2: Save and Summarize

```bash
# Extract transcript
python ~/.claude/skills/transcribe-and-summarize/scripts/youtube_transcript.py \
  "https://www.youtube.com/watch?v=DKrBGOFs0GY" > my_transcript.txt

# Then ask the skill:
"Summarize this YouTube transcript: /Users/name/my_transcript.txt"
```

### Example 3: Compare Multiple Videos

```
User: "Compare these three YouTube videos:
- https://youtu.be/VIDEO_ID_1
- https://youtu.be/VIDEO_ID_2
- https://youtu.be/VIDEO_ID_3"

Skill output:
# Video Comparison Summary

## Video 1: [Title]
- Key point 1
- Key point 2

## Video 2: [Title]
- Key point 1
- Key point 2

## Video 3: [Title]
- Key point 1
- Key point 2

## Comparison
[Analysis of similarities and differences]
```

## What's Included in Skill Package

### Files Added/Updated

1. **scripts/youtube_transcript.py** ✨ NEW
   - Python helper script for YouTube transcript extraction
   - Handles multiple extraction methods
   - Built-in error handling and suggestions

2. **SKILL.md** - Updated
   - YouTube-specific instructions
   - Examples for YouTube videos
   - Updated feature list

3. **reference.md** - Updated
   - Comprehensive YouTube transcription guide
   - Troubleshooting section
   - Multiple extraction methods explained

4. **examples.md** - Updated
   - Real-world YouTube examples
   - Sample outputs and workflows

5. **QUICKSTART.md** - Updated
   - YouTube as primary quick start example
   - Updated supported types table

6. **YOUTUBE_GUIDE.md** ✨ NEW
   - This guide
   - Setup instructions
   - Usage examples

## Feature Summary

| Feature | Status |
|---------|--------|
| Extract YouTube video ID | ✅ Automatic |
| Get video transcript | ✅ Multiple methods |
| Summarize transcript | ✅ Full featured |
| Timestamp support | ✅ Yes |
| Multi-language support | ✅ Yes (if available) |
| Manual fallback | ✅ Included |
| Error handling | ✅ Comprehensive |
| Helper script | ✅ Included |

## Next Steps

1. **Try it out**: Ask the skill to summarize any YouTube video
2. **Install youtube-transcript-api** (optional but recommended):
   ```bash
   pip install youtube-transcript-api
   ```
3. **Explore features**: Compare videos, extract specific topics, save transcripts
4. **Share feedback**: Let us know how it works for you!

## Support & Resources

- **Skill documentation**: See other .md files in this directory
- **Python script help**: Run script with no arguments for usage info
- **Issues**: Check troubleshooting section above
- **Feature requests**: Document your use case for future enhancements

## Version Info

- **Skill Version**: 2.0 (with YouTube support)
- **Last Updated**: November 2024
- **YouTube Support**: Full
- **Status**: Production Ready
