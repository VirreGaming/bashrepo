#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Get the current working directory
CURRENT_DIR=$(pwd)

# Redirect all output to time.txt
exec > "$CURRENT_DIR/time.txt" 2>&1

# Navigate to /bin
cd /bin

echo "Running normal ls"
time ls > /dev/null
echo -e "${RED} ^^^Time for normal ls^^^${NC}"

# Compress and test ls
sudo gzexe /bin/ls
echo "Running compressed ls"
time /bin/ls > /dev/null
echo -e "${GREEN}^^^Time for compressed ls^^^${NC}"
du -k /bin/ls
echo -e "${RED}^^^Size of compressed ls in Kilobytes^^^${NC}"
du -k /bin/ls~
echo -e "${GREEN}^^^Size of normal ls in kilobytes^^^${NC}"

# Create and process textfile
TEXTFILE="$CURRENT_DIR/textfile.txt"
echo "Creating textfile with sample content"
touch $TEXTFILE
echo "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit  in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat  non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." > $TEXTFILE
echo "Running normal grep"
time /bin/grep in $TEXTFILE > /dev/null
echo -e "${RED}^^^Time for normal grep^^^${NC}"

# Compress and test grep
sudo gzexe /bin/grep
echo "Running compressed grep"
time /bin/grep in $TEXTFILE > /dev/null
echo -e "${GREEN}^^^Time for compressed grep^^^${NC}"
du -k /bin/grep
echo -e "${GREEN}^^^Size of compressed grep^^^${NC}"
du -k /bin/grep~
echo -e "${RED}^^^Size of normal grep^^^${NC}"

# Test whoami
echo "Running normal whoami"
time /bin/whoami
echo -e "${RED}^^^Time for normal whoami^^^${NC}"

# Compress and test whoami
sudo gzexe /bin/whoami
time /bin/whoami
echo -e "${GREEN}^^^Time for compressed whoami^^^${NC}"
du -k /bin/whoami
echo -e "${GREEN}^^^Size of compressed whoami^^^${NC}"
du -k /bin/whoami~
echo -e "${RED}^^^Size of normal whoami^^^${NC}"

# Test Python script execution
PYTHON_BIN="/usr/bin/python3.12"
echo "Running normal Python"
time $PYTHON_BIN -c "print('Hello world')"
echo -e "${RED}^^^Time for normal python^^^${NC}"

# Compress and test Python
sudo gzexe $PYTHON_BIN
time $PYTHON_BIN -c "print('Hello world')"
echo -e "${GREEN}^^^Time for Compressed python^^^${NC}"
du -k $PYTHON_BIN
echo -e "${GREEN}^^^Size of compressed python^^^${NC}"
du -k ${PYTHON_BIN}~
echo -e "${RED}^^^Size of normal python^^^${NC}"

# Test and compress rmdir
NEWDIR="$CURRENT_DIR/newdir"
mkdir $NEWDIR
echo "Running normal rmdir"
time /bin/rmdir $NEWDIR
echo -e "${RED}^^^Time for normal rmdir^^^${NC}"

sudo gzexe /bin/rmdir
mkdir $NEWDIR
time /bin/rmdir $NEWDIR
echo -e "${GREEN}^^^Time for compressed rmdir^^^${NC}"
du -k /bin/rmdir
echo -e "${GREEN}^^^Size of compressed rmdir^^^${NC}"
du -k /bin/rmdir~
echo -e "${RED}^^^Size of normal rmdir^^^${NC}"

# Decompress and clean up files
echo -e "${RED}Decompressing grep${NC}"
sudo gzexe -d /bin/grep
echo -e "${GREEN}Successfully decompressed grep${NC}"
echo -e "${RED}Removing compressed grep~${NC}"
sudo rm -f /bin/grep~

echo -e "${RED}Decompressing whoami${NC}"
sudo gzexe -d /bin/whoami
echo -e "${GREEN}Successfully decompressed whoami${NC}"
echo -e "${RED}Removing compressed whoami~${NC}"
sudo rm -f /bin/whoami~

echo -e "${RED}Decompressing $PYTHON_BIN${NC}"
sudo gzexe -d $PYTHON_BIN
echo -e "${GREEN}Successfully decompressed $PYTHON_BIN${NC}"
echo -e "${RED}Removing compressed $PYTHON_BIN~${NC}"
sudo rm -f ${PYTHON_BIN}~

echo -e "${RED}Decompressing rmdir${NC}"
sudo gzexe -d /bin/rmdir
echo -e "${GREEN}Successfully decompressed rmdir${NC}"
echo -e "${RED}Removing compressed rmdir~${NC}"
sudo rm -f /bin/rmdir~

echo -e "${RED}Decompressing ls${NC}"
sudo gzexe -d /bin/ls
echo -e "${GREEN}Successfully decompressed ls${NC}"
echo -e "${RED}Removing compressed ls~${NC}"
sudo rm -f /bin/ls~

# Remove textfile
rm -f $TEXTFILE
echo -e "${GREEN}Successfully removed $TEXTFILE${NC}"
