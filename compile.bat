@echo off
REM ############################################################################
REM USDA AFRI Compilation Script (Windows)
REM 
REM This script compiles both the Project Narrative and Bibliography PDFs
REM for USDA AFRI submission.
REM
REM Usage: Double-click this file or run: compile.bat
REM ############################################################################

echo ========================================================================
echo USDA AFRI Project Narrative Compilation Script (Windows)
echo ========================================================================
echo.

REM Check for lualatex first (best for Times New Roman), then xelatex, then pdflatex
where lualatex >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set LATEX_CMD=lualatex
    echo Using LuaLaTeX for compilation ^(recommended for best Times New Roman^)...
    goto :compiler_found
)

where xelatex >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set LATEX_CMD=xelatex
    echo Using XeLaTeX for compilation...
    goto :compiler_found
)

where pdflatex >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    set LATEX_CMD=pdflatex
    echo Using pdfLaTeX for compilation ^(fallback^)...
    goto :compiler_found
)

echo ERROR: No LaTeX compiler found in PATH.
echo Please install MiKTeX or TeX Live for Windows.
pause
exit /b 1

:compiler_found
echo.

echo ========================================================================
echo Step 1: Compiling Project Narrative
echo ========================================================================
echo.

REM Compile ProjectNarrative.tex
%LATEX_CMD% -interaction=nonstopmode ProjectNarrative.tex
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: First compilation of ProjectNarrative.tex failed.
    pause
    exit /b 1
)

REM Run bibtex on ProjectNarrative
bibtex ProjectNarrative
if %ERRORLEVEL% NEQ 0 (
    echo WARNING: BibTeX failed for ProjectNarrative. This is expected if no citations are used yet.
)

REM Second compilation
%LATEX_CMD% -interaction=nonstopmode ProjectNarrative.tex
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Second compilation of ProjectNarrative.tex failed.
    pause
    exit /b 1
)

echo.
echo ProjectNarrative.pdf created successfully!
echo.

echo ========================================================================
echo Step 2: Compiling Bibliography (Separate Document)
echo ========================================================================
echo.

REM Compile Bibliography.tex
%LATEX_CMD% -interaction=nonstopmode Bibliography.tex
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: First compilation of Bibliography.tex failed.
    pause
    exit /b 1
)

REM Run bibtex
bibtex Bibliography
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: BibTeX failed for Bibliography.
    pause
    exit /b 1
)

REM Second compilation
%LATEX_CMD% -interaction=nonstopmode Bibliography.tex
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Second compilation of Bibliography.tex failed.
    pause
    exit /b 1
)

REM Third compilation to finalize
%LATEX_CMD% -interaction=nonstopmode Bibliography.tex
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Third compilation of Bibliography.tex failed.
    pause
    exit /b 1
)

echo.
echo Bibliography.pdf created successfully!
echo.

echo ========================================================================
echo Compilation Complete!
echo ========================================================================
echo.
echo Two PDF files have been created:
echo   1. ProjectNarrative.pdf - Upload as 'Project Narrative' (max 18 pages)
echo   2. Bibliography.pdf - Upload as 'Literature Cited' (separate file)
echo.

echo Cleaning up auxiliary files...
del /Q *.aux *.log *.out *.bbl *.blg *.toc *.fls *.fdb_latexmk *.synctex.gz 2>nul

echo.
echo Next steps:
echo   - Review both PDFs for formatting and content
echo   - Ensure ProjectNarrative.pdf is less than or equal to 18 pages
echo   - Verify all citations appear in Bibliography.pdf
echo   - Submit both PDFs separately to grants.gov
echo.
echo ========================================================================
echo.
pause
