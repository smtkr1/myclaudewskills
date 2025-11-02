#!/usr/bin/env python3
"""
YouTube Transcript Extractor
Extracts transcripts from YouTube videos using multiple methods
"""

import sys
import re
import json
import urllib.request
import urllib.parse
from typing import Optional, Dict, List

def extract_video_id(url: str) -> Optional[str]:
    """Extract video ID from various YouTube URL formats."""
    patterns = [
        r'(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([^&\n?#]+)',
        r'youtube\.com\/watch\?.*v=([^&]+)',
    ]

    for pattern in patterns:
        match = re.search(pattern, url)
        if match:
            return match.group(1)
    return None

def get_youtube_transcript(video_id: str) -> Optional[str]:
    """
    Attempt to extract transcript from YouTube using multiple methods.

    Methods tried (in order):
    1. YouTube Transcript API (youtube-transcript-api) via CLI
    2. YouTube Transcript API (python package if available)
    3. Direct captions extraction
    4. Manual fallback instructions
    """

    # Method 1a: Try using youtube-transcript-api CLI tool (if installed via pipx)
    try:
        import subprocess
        import os

        # Try different possible locations for the CLI tool
        cli_paths = [
            "youtube_transcript_api",  # In PATH
            os.path.expanduser("~/.local/pipx/venvs/youtube-transcript-api/bin/youtube_transcript_api"),
            os.path.expanduser("~/.local/bin/youtube_transcript_api"),
        ]

        for cli_path in cli_paths:
            try:
                result = subprocess.run(
                    [cli_path, video_id],
                    capture_output=True,
                    text=True,
                    timeout=10
                )
                if result.returncode == 0:
                    return result.stdout
            except FileNotFoundError:
                continue
            except subprocess.TimeoutExpired:
                print(f"Note: {cli_path} timed out", file=sys.stderr)
            except Exception as e:
                print(f"Note: {cli_path} failed: {e}", file=sys.stderr)

    except Exception as e:
        print(f"Note: youtube-transcript-api CLI not available: {e}", file=sys.stderr)

    # Method 1b: Try using youtube-transcript-api if available as Python package
    try:
        from youtube_transcript_api import YouTubeTranscriptApi

        try:
            transcript_list = YouTubeTranscriptApi.get_transcript(video_id)
            transcript = "\n".join([item['text'] for item in transcript_list])
            return transcript
        except Exception as e:
            print(f"Note: youtube-transcript-api method failed: {e}", file=sys.stderr)
    except ImportError:
        print("Note: youtube-transcript-api not installed as Python package. Trying alternative methods...",
              file=sys.stderr)

    # Method 2: Try to extract from video page HTML
    try:
        url = f"https://www.youtube.com/watch?v={video_id}"
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
        }

        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=10) as response:
            html = response.read().decode('utf-8')

            # Look for captions in initial data
            match = re.search(r'"captions":\s*({.*?})\s*[,}]', html)
            if match:
                captions_data = json.loads(match.group(1))
                if 'playerCaptionsTracklistRenderer' in captions_data:
                    return "Captions found but extraction requires additional processing"
    except Exception as e:
        print(f"Note: HTML extraction method failed: {e}", file=sys.stderr)

    return None

def format_transcript(transcript: str) -> str:
    """Format transcript for better readability."""
    lines = transcript.strip().split('\n')
    return '\n'.join(lines)

def main():
    """Main entry point for command-line usage."""
    if len(sys.argv) < 2:
        print("Usage: python youtube_transcript.py <YouTube_URL>")
        print("Example: python youtube_transcript.py https://www.youtube.com/watch?v=DKrBGOFs0GY")
        sys.exit(1)

    youtube_url = sys.argv[1]

    # Extract video ID
    video_id = extract_video_id(youtube_url)
    if not video_id:
        print(f"Error: Could not extract video ID from URL: {youtube_url}", file=sys.stderr)
        sys.exit(1)

    print(f"Video ID: {video_id}", file=sys.stderr)
    print("Attempting to extract transcript...", file=sys.stderr)

    # Get transcript
    transcript = get_youtube_transcript(video_id)

    if transcript:
        print(format_transcript(transcript))
    else:
        print("\n=== TRANSCRIPT EXTRACTION FAILED ===\n", file=sys.stderr)
        print("TROUBLESHOOTING OPTIONS:\n", file=sys.stderr)
        print("1. INSTALL youtube-transcript-api:", file=sys.stderr)
        print("   pip install youtube-transcript-api\n", file=sys.stderr)
        print("2. MANUALLY GET TRANSCRIPT:", file=sys.stderr)
        print("   - Go to the YouTube video page", file=sys.stderr)
        print("   - Click the three dots menu (...)", file=sys.stderr)
        print("   - Select 'Show transcript'", file=sys.stderr)
        print("   - Copy and paste the transcript\n", file=sys.stderr)
        print("3. USE ONLINE TOOLS:", file=sys.stderr)
        print("   - https://www.rev.com/tools/youtube-transcript-generator", file=sys.stderr)
        print("   - https://www.happyscribe.com/", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
