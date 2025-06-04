#!/bin/bash

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="$SCRIPT_DIR"

echo -e "${YELLOW}Downloading Lua dependencies for ryba...${NC}\n"

# Create lib/types directory if it doesn't exist
mkdir -p "$LIB_DIR/types"

# Function to download a single file
download_file() {
    local url=$1
    local output_path=$2
    local description=$3

    echo -e "${YELLOW}Downloading $description...${NC}"
    curl -L -o "$output_path" "$url"
    echo -e "${GREEN}✓ Downloaded $description${NC}\n"
}

# Function to download and extract ZIP
download_and_extract() {
    local url=$1
    local temp_file=$2
    local extract_path=$3
    local target_folder=$4
    local description=$5

    echo -e "${YELLOW}Downloading $description...${NC}"
    curl -L -o "$temp_file" "$url"

    echo -e "${YELLOW}Extracting $description...${NC}"
    unzip -q "$temp_file" -d "/tmp/extract_$$"

    # Find the extracted folder and copy the target
    if [ -d "/tmp/extract_$$"/*/"$target_folder" ]; then
        cp -r "/tmp/extract_$$"/*/"$target_folder" "$extract_path/"
    elif [ -d "/tmp/extract_$$/$target_folder" ]; then
        cp -r "/tmp/extract_$$/$target_folder" "$extract_path/"
    else
        echo -e "${RED}Error: Could not find $target_folder in extracted files${NC}"
        return 1
    fi

    # Cleanup
    rm -f "$temp_file"
    rm -rf "/tmp/extract_$$"

    echo -e "${GREEN}✓ Downloaded and extracted $description${NC}\n"
}

# Download single file dependencies
download_file \
    "https://raw.githubusercontent.com/kikito/anim8/bd38defa844ab2dfa3bf416a10c45ce376ba4c50/anim8.lua" \
    "$LIB_DIR/anim8.lua" \
    "anim8.lua (sprite animation)"

download_file \
    "https://raw.githubusercontent.com/kikito/gamera/e594504397ce2bcb3a7bc73b84aa5ad1b508a39f/gamera.lua" \
    "$LIB_DIR/gamera.lua" \
    "gamera.lua (camera management)"

download_file \
    "https://raw.githubusercontent.com/rxi/lume/98847e7812cf28d3d64b289b03fad71dc704547d/lume.lua" \
    "$LIB_DIR/lume.lua" \
    "lume.lua (Lua utilities)"

download_file \
    "https://raw.githubusercontent.com/rxi/lurker/03d1373911f586c1c6d5d557527b5d510190fd94/lurker.lua" \
    "$LIB_DIR/lurker.lua" \
    "lurker.lua (live reload)"

download_file \
    "https://raw.githubusercontent.com/rxi/classic/e5610756c98ac2f8facd7ab90c94e1a097ecd2c6/classic.lua" \
    "$LIB_DIR/classic.lua" \
    "classic.lua (OOP library)"

# Download ZIP-based dependencies
download_and_extract \
    "https://github.com/karai17/Simple-Tiled-Implementation/archive/a83eb64db2db55e85205f15013eb6e7327be605d.zip" \
    "/tmp/sti.zip" \
    "$LIB_DIR" \
    "sti" \
    "Simple-Tiled-Implementation (tilemap loader)"

download_and_extract \
    "https://github.com/a327ex/windfield/archive/830c6f9c357f31f5c0e53d5721e6dc0d0ccebae1.zip" \
    "/tmp/windfield.zip" \
    "$LIB_DIR" \
    "windfield" \
    "windfield (physics wrapper)"

# Apply windfield patch
WINDFIELD_INIT="$LIB_DIR/windfield/init.lua"
if [ -f "$WINDFIELD_INIT" ]; then
    echo -e "${YELLOW}Applying windfield patch...${NC}"
    sed -i.bak 's/^World = {}/local World = {}/' "$WINDFIELD_INIT"
    rm -f "$WINDFIELD_INIT.bak"
    echo -e "${GREEN}✓ Applied windfield patch${NC}\n"
fi

# Download Love2D LLS Addon
download_and_extract \
    "https://github.com/LuaCATS/love2d/archive/97fa46cd694e09f953157a5c71e7e9adeb99d0c8.zip" \
    "/tmp/love2d.zip" \
    "$LIB_DIR" \
    "love2d-97fa46cd694e09f953157a5c71e7e9adeb99d0c8" \
    "Love2D LLS Addon (type definitions)"

# Remove existing types/love2d in case it already exists so the 'mv' command won't fail
rm -rf "$LIB_DIR/types/love2d"
# Rename and move the love2d types
mv $LIB_DIR/love2d-* "$LIB_DIR/types/love2d"
echo -e "${GREEN}✓ Installed Love2D LLS Addon to lib/types/love2d${NC}\n"

echo -e "${GREEN}All dependencies downloaded successfully!${NC}"
echo -e "${YELLOW}Note: Make sure to restart your Lua Language Server to pick up the new type definitions.${NC}"
