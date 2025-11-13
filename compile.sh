#!/bin/bash

################################################################################
# USDA AFRI Compilation Script
# 
# This script compiles both the Project Narrative and Bibliography PDFs
# for USDA AFRI submission.
#
# Usage: ./compile.sh
# Or: bash compile.sh
################################################################################

echo "========================================================================"
echo "USDA AFRI Project Narrative Compilation Script"
echo "========================================================================"
echo ""

# Check if lualatex is available, otherwise fall back to other compilers
if command -v lualatex &> /dev/null; then
    LATEX_CMD="lualatex"
    echo "Using LuaLaTeX for compilation (recommended for best Times New Roman)..."
elif command -v xelatex &> /dev/null; then
    LATEX_CMD="xelatex"
    echo "Using XeLaTeX for compilation..."
elif command -v pdflatex &> /dev/null; then
    LATEX_CMD="pdflatex"
    echo "Using pdfLaTeX for compilation (fallback)..."
else
    echo "ERROR: No LaTeX compiler found (lualatex, xelatex, or pdflatex)."
    echo "Please install a LaTeX distribution (TeX Live, MiKTeX, or MacTeX)."
    exit 1
fi

echo ""
echo "========================================================================"
echo "Step 1: Compiling Project Summary"
echo "========================================================================"
echo ""

# Compile ProjectSummary.tex
$LATEX_CMD -interaction=nonstopmode ProjectSummary.tex
if [ $? -ne 0 ]; then
    echo "ERROR: Compilation of ProjectSummary.tex failed."
    exit 1
fi

echo ""
echo "? ProjectSummary.pdf created successfully!"
echo ""

echo "========================================================================"
echo "Step 2: Compiling Project Narrative"
echo "========================================================================"
echo ""

# Compile ProjectNarrative.tex
$LATEX_CMD -interaction=nonstopmode ProjectNarrative.tex
if [ $? -ne 0 ]; then
    echo "ERROR: First compilation of ProjectNarrative.tex failed."
    exit 1
fi

# Run bibtex on ProjectNarrative (though bibliography is separate, this helps with citations)
bibtex ProjectNarrative
if [ $? -ne 0 ]; then
    echo "WARNING: BibTeX failed for ProjectNarrative. This is expected if no \cite commands are used yet."
fi

# Second compilation
$LATEX_CMD -interaction=nonstopmode ProjectNarrative.tex
if [ $? -ne 0 ]; then
    echo "ERROR: Second compilation of ProjectNarrative.tex failed."
    exit 1
fi

echo ""
echo "? ProjectNarrative.pdf created successfully!"
echo ""

# Check page count
if command -v pdfinfo &> /dev/null; then
    PAGES=$(pdfinfo ProjectNarrative.pdf | grep "Pages:" | awk '{print $2}')
    echo "  Page count: $PAGES pages"
    if [ "$PAGES" -gt 18 ]; then
        echo "  ? WARNING: Your narrative exceeds the 18-page limit!"
    else
        echo "  ? Within the 18-page limit"
    fi
fi

echo ""
echo "========================================================================"
echo "Step 3: Compiling Bibliography (Separate Document)"
echo "========================================================================"
echo ""

# Compile Bibliography.tex
$LATEX_CMD -interaction=nonstopmode Bibliography.tex
if [ $? -ne 0 ]; then
    echo "ERROR: First compilation of Bibliography.tex failed."
    exit 1
fi

# Run bibtex
bibtex Bibliography
if [ $? -ne 0 ]; then
    echo "WARNING: BibTeX failed for Bibliography. This is expected if no citations are used yet."
fi

# Second compilation
$LATEX_CMD -interaction=nonstopmode Bibliography.tex
if [ $? -ne 0 ]; then
    echo "ERROR: Second compilation of Bibliography.tex failed."
    exit 1
fi

# Third compilation to finalize
$LATEX_CMD -interaction=nonstopmode Bibliography.tex
if [ $? -ne 0 ]; then
    echo "ERROR: Third compilation of Bibliography.tex failed."
    exit 1
fi

echo ""
echo "? Bibliography.pdf created successfully!"
echo ""

echo "========================================================================"
echo "Compilation Complete!"
echo "========================================================================"
echo ""
echo "Three PDF files have been created:"
echo "  1. ProjectSummary.pdf - Upload as 'Project Summary' (max 1 page)"
echo "  2. ProjectNarrative.pdf - Upload as 'Project Narrative' (max 18 pages)"
echo "  3. Bibliography.pdf - Upload as 'Literature Cited' (separate file)"
echo ""

echo "Cleaning up auxiliary files..."
rm -f *.aux *.log *.out *.bbl *.blg *.toc *.fls *.fdb_latexmk *.synctex.gz

echo ""
echo "Next steps:"
echo "  - Review all PDFs for formatting and content"
echo "  - Ensure ProjectSummary.pdf is 1 page"
echo "  - Ensure ProjectNarrative.pdf is ? 18 pages"
echo "  - Verify all citations appear in Bibliography.pdf"
echo "  - Submit all three PDFs separately to grants.gov"
echo ""
echo "========================================================================"
