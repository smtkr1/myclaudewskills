#!/bin/bash
################################################################################
# Transcribe and Summarize Skill - Setup Script
#
# This script sets up the YouTube transcription dependencies for the skill
# It installs youtube-transcript-api and other optional dependencies
################################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SKILL_DIR="$( dirname "$SCRIPT_DIR" )"

echo -e "${BLUE}╔════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║     Transcribe-and-Summarize Skill - Setup Script                 ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check if Python is installed
echo -e "${YELLOW}Checking Python installation...${NC}"
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
    echo -e "${GREEN}✓ Python3 found${NC}"
elif command -v python &> /dev/null; then
    PYTHON_CMD="python"
    echo -e "${GREEN}✓ Python found${NC}"
else
    echo -e "${RED}✗ Python is not installed${NC}"
    echo -e "${YELLOW}Please install Python 3.6+ first:${NC}"
    echo "  macOS: brew install python3"
    echo "  Ubuntu/Debian: sudo apt-get install python3"
    echo "  Windows: https://www.python.org/downloads/"
    exit 1
fi

PYTHON_VERSION=$($PYTHON_CMD --version 2>&1)
echo -e "${GREEN}✓ Using: $PYTHON_VERSION${NC}"
echo ""

# Check if pip is installed
echo -e "${YELLOW}Checking pip installation...${NC}"
if $PYTHON_CMD -m pip --version &> /dev/null; then
    echo -e "${GREEN}✓ pip is available${NC}"
else
    echo -e "${RED}✗ pip is not available${NC}"
    echo -e "${YELLOW}Installing pip...${NC}"
    $PYTHON_CMD -m ensurepip --default-pip
fi
echo ""

# Try different installation methods
INSTALL_SUCCESS=false

# Method 1: Try pipx (recommended, isolated installation)
if command -v pipx &> /dev/null; then
    echo -e "${YELLOW}Method 1: Installing via pipx (recommended)...${NC}"
    if pipx install youtube-transcript-api 2>/dev/null; then
        echo -e "${GREEN}✓ Successfully installed youtube-transcript-api via pipx${NC}"
        INSTALL_SUCCESS=true
    else
        echo -e "${YELLOW}pipx installation had issues, trying next method...${NC}"
    fi
fi

# Method 2: Try pip with --user flag
if [ "$INSTALL_SUCCESS" = false ]; then
    echo -e "${YELLOW}Method 2: Installing via pip --user...${NC}"
    if $PYTHON_CMD -m pip install --user youtube-transcript-api 2>/dev/null; then
        echo -e "${GREEN}✓ Successfully installed youtube-transcript-api${NC}"
        INSTALL_SUCCESS=true
    else
        echo -e "${YELLOW}pip --user installation had issues, trying next method...${NC}"
    fi
fi

# Method 3: Use virtual environment approach
if [ "$INSTALL_SUCCESS" = false ]; then
    echo -e "${YELLOW}Method 3: Creating isolated virtual environment...${NC}"
    VENV_PATH="$HOME/.local/share/transcribe-and-summarize-venv"
    if $PYTHON_CMD -m venv "$VENV_PATH" 2>/dev/null && \
       source "$VENV_PATH/bin/activate" && \
       pip install youtube-transcript-api 2>/dev/null; then
        echo -e "${GREEN}✓ Successfully installed youtube-transcript-api in virtual environment${NC}"
        echo -e "${YELLOW}Note: Virtual environment at: $VENV_PATH${NC}"
        INSTALL_SUCCESS=true
        deactivate
    else
        echo -e "${YELLOW}Virtual environment installation failed${NC}"
    fi
fi

# If all methods fail
if [ "$INSTALL_SUCCESS" = false ]; then
    echo -e "${RED}✗ Failed to install youtube-transcript-api${NC}"
    echo -e "${YELLOW}Please try one of these manual installation methods:${NC}"
    echo ""
    echo "Option A (using pipx - recommended):"
    echo "  brew install pipx"
    echo "  pipx install youtube-transcript-api"
    echo ""
    echo "Option B (using pip with --user):"
    echo "  python3 -m pip install --user youtube-transcript-api"
    echo ""
    echo "Option C (using virtual environment):"
    echo "  python3 -m venv ~/.local/share/transcribe-and-summarize-venv"
    echo "  source ~/.local/share/transcribe-and-summarize-venv/bin/activate"
    echo "  pip install youtube-transcript-api"
    echo ""
    echo "After installation, the skill will work automatically!"
    exit 1
fi
echo ""

# Optional: Install additional helpful packages
echo -e "${YELLOW}Optional: Install additional helpful packages?${NC}"
echo "These are not required but recommended:"
echo "  - requests: Better HTTP handling"
echo "  - beautifulsoup4: HTML parsing for web articles"
echo ""
read -p "Install optional packages? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Installing optional packages...${NC}"
    if command -v pipx &> /dev/null; then
        pipx inject youtube-transcript-api requests beautifulsoup4 --quiet 2>/dev/null || true
    else
        $PYTHON_CMD -m pip install --user requests beautifulsoup4 --quiet 2>/dev/null || true
    fi
    echo -e "${GREEN}✓ Optional packages installation attempted${NC}"
else
    echo -e "${YELLOW}Skipped optional packages${NC}"
fi
echo ""

# Verify installation
echo -e "${YELLOW}Verifying installation...${NC}"
if $PYTHON_CMD -c "from youtube_transcript_api import YouTubeTranscriptApi; print('✓ youtube_transcript_api is ready')" 2>&1; then
    echo -e "${GREEN}✓ All required packages are installed and working${NC}"
else
    echo -e "${RED}✗ Verification failed${NC}"
    exit 1
fi
echo ""

# Test the helper script
echo -e "${YELLOW}Testing YouTube transcript helper script...${NC}"
if [ -f "$SCRIPT_DIR/youtube_transcript.py" ]; then
    echo -e "${GREEN}✓ Helper script found at: $SCRIPT_DIR/youtube_transcript.py${NC}"
    echo ""
    echo -e "${YELLOW}The script can now extract YouTube transcripts!${NC}"
    echo ""
    echo -e "${BLUE}Usage Examples:${NC}"
    echo "  python3 $SCRIPT_DIR/youtube_transcript.py \"https://www.youtube.com/watch?v=VIDEO_ID\""
    echo "  python3 $SCRIPT_DIR/youtube_transcript.py \"https://youtu.be/VIDEO_ID\" > transcript.txt"
else
    echo -e "${RED}✗ Helper script not found${NC}"
    exit 1
fi
echo ""

# Final summary
echo -e "${BLUE}╔════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}✓ Setup Complete!${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}You can now use the skill to:${NC}"
echo "  • Transcribe YouTube videos automatically"
echo "  • Summarize the transcripts"
echo "  • Extract key points and timestamps"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo "  1. Try extracting a YouTube transcript:"
echo "     python3 $SCRIPT_DIR/youtube_transcript.py \"https://youtu.be/VIDEO_ID\""
echo ""
echo "  2. Or ask Claude Code to summarize any YouTube video:"
echo "     \"Summarize this YouTube video: https://www.youtube.com/watch?v=VIDEO_ID\""
echo ""
echo -e "${YELLOW}For more information, read:${NC}"
echo "  $SKILL_DIR/YOUTUBE_GUIDE.md"
echo ""
