#!/bin/bash

# ContextFort Dashboard Installation Script
# This script installs dependencies and starts the frontend development server

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "================================================"
echo "ContextFort Dashboard - Installation & Startup"
echo "================================================"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo -e "${RED}Error: Node.js is not installed${NC}"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo -e "${RED}Error: npm is not installed${NC}"
    echo "Please install npm (usually comes with Node.js)"
    exit 1
fi

echo -e "${GREEN}✓ Node.js version: $(node --version)${NC}"
echo -e "${GREEN}✓ npm version: $(npm --version)${NC}"
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo -e "${RED}Error: package.json not found${NC}"
    echo "Please run this script from the contextfort-dashboard directory"
    exit 1
fi

# Install dependencies
echo -e "${YELLOW}Installing dependencies...${NC}"
npm install

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Dependencies installed successfully${NC}"
else
    echo -e "${RED}✗ Failed to install dependencies${NC}"
    exit 1
fi
echo ""

# Check if .env.local exists, if not copy from .env.example
if [ ! -f ".env.local" ]; then
    if [ -f ".env.example" ]; then
        echo -e "${YELLOW}Creating .env.local from .env.example...${NC}"
        cp .env.example .env.local
        echo -e "${GREEN}✓ .env.local created${NC}"
        echo -e "${YELLOW}⚠ Please update .env.local with your backend URL if needed${NC}"
    else
        echo -e "${YELLOW}⚠ No .env.example found, skipping environment setup${NC}"
    fi
else
    echo -e "${GREEN}✓ .env.local already exists${NC}"
fi
echo ""

# Start the development server
echo -e "${GREEN}Starting development server...${NC}"
echo -e "${YELLOW}The dashboard will be available at http://localhost:3000${NC}"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

npm run dev
