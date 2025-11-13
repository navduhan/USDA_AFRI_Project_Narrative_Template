# USDA AFRI Project Narrative Template

**Author:** Naveen Duhan and contributors  
**Version:** 1.1  
**Date:** November 2025

## Overview

This LaTeX template provides a complete formatting solution for USDA AFRI (Agriculture and Food Research Initiative) project narrative submissions. It ensures compliance with USDA formatting requirements including font, margins, spacing, and section numbering.

## Quick Start

### Requirements
- LaTeX distribution (TeX Live, MiKTeX, or MacTeX)
- For best results: **LuaLaTeX** (for true Times New Roman font)
- Alternative: **XeLaTeX** or **pdfLaTeX** (uses newtxtext as fallback)

### Files Included

| File | Purpose |
|------|---------|
| `usda-afri-narrative.cls` | LaTeX document class (formatting) |
| `ProjectNarrative.tex` | Main narrative template (max 18 pages) |
| `Bibliography.tex` | Separate bibliography document |
| `references.bib` | BibTeX database for references |
| `compile.sh` / `compile.bat` | Automated compilation scripts |
| `README.md` | This file |
| `LICENSE` | MIT License |

## USDA AFRI Requirements

### Page Limits
- **Project Narrative:** Maximum **18 pages**
- **Bibliography:** Submitted as **SEPARATE PDF** (no page limit)
- The bibliography does NOT count toward the 18-page narrative limit

### Formatting
- ? 12pt Times New Roman font (enforced by class)
- ? 1-inch margins on all sides (enforced by class)
- ? Single-spaced text (default, customizable)
- ? Section numbering with capital letters (A, B, C, ...)
- ? Centered page numbers in footer

## How to Compile

### Quick Compilation (Automated)

**Mac/Linux:**
```bash
./compile.sh
```

**Windows:**
```
Double-click compile.bat
```

The script will automatically:
- Use LuaLaTeX (or best available compiler)
- Compile both ProjectNarrative.pdf and Bibliography.pdf
- Run BibTeX for references
- Clean up auxiliary files
- Report page count and any warnings

### Manual Compilation

### Step 1: Compile the Project Narrative

**Recommended (LuaLaTeX):**
```bash
lualatex ProjectNarrative.tex
lualatex ProjectNarrative.tex
```

**Alternative (XeLaTeX or pdfLaTeX):**
```bash
xelatex ProjectNarrative.tex
# or
pdflatex ProjectNarrative.tex
```

**Result:** `ProjectNarrative.pdf` (upload as "Project Narrative")

### Step 2: Compile the Bibliography

**Recommended (LuaLaTeX):**
```bash
lualatex Bibliography.tex
bibtex Bibliography
lualatex Bibliography.tex
lualatex Bibliography.tex
```

**Alternative (XeLaTeX or pdfLaTeX):**
```bash
xelatex Bibliography.tex
bibtex Bibliography
xelatex Bibliography.tex
xelatex Bibliography.tex
```

**Result:** `Bibliography.pdf` (upload as "Literature Cited")

### Why Multiple Compilations?

LaTeX requires multiple passes to:
1. First pass: Process citations and generate auxiliary files
2. BibTeX pass: Process bibliography
3. Second pass: Incorporate references
4. Third pass: Finalize cross-references and citations

### Cleaning Auxiliary Files

The compilation scripts automatically clean up auxiliary files (.aux, .log, .bbl, etc.) after successful compilation.

**For manual cleanup** (if needed after failed compilation or manual LaTeX runs):

**Mac/Linux:**
```bash
rm -f *.aux *.log *.out *.bbl *.blg *.toc *.fls *.fdb_latexmk *.synctex.gz
```

**Windows (Command Prompt):**
```cmd
del /Q *.aux *.log *.out *.bbl *.blg *.toc *.fls *.fdb_latexmk *.synctex.gz
```

**Windows (PowerShell):**
```powershell
Remove-Item *.aux,*.log,*.out,*.bbl,*.blg,*.toc,*.fls,*.fdb_latexmk,*.synctex.gz -ErrorAction SilentlyContinue
```

## Document Structure

The project narrative follows standard USDA AFRI sections:

### Section A: Introduction
- Background
- Preliminary Work and Team Expertise

### Section B: Rationale and Significance
- Rationale
- Significance

### Section C: Approach
- Objectives and Hypothesis
- Methods
- Stakeholder Involvement

### Section D: Expected Outcomes and Impacts

### Section E: Extension, Education, and Communication Plan

### Section F: Potential Limitations and Pitfalls

### Section G: Sustainability Plan

### Section H: Timeline

## Using Citations

### Adding References

Add your references to `references.bib` in standard BibTeX format:

```bibtex
@article{smith2023,
  author  = {Smith, John A. and Johnson, Mary B.},
  title   = {Your Article Title},
  journal = {Journal Name},
  year    = {2023},
  volume  = {45},
  pages   = {234--256},
  doi     = {10.1234/example.doi}
}
```

### Citing in Your Text

Use the `\cite{}` command:

```latex
Recent studies have shown \cite{smith2023} that...
Multiple citations \cite{jones2022,chen2024} demonstrate...
```

## Useful Commands

The `usda-afri-narrative` class provides several utility commands:

### Bold Line with Following Paragraph
```latex
\boldline{Hypothesis 1}
Your hypothesis text starts here without indentation.
```

### Bold Line with Inline Paragraph
```latex
\boldpara{Objective 1}{Determine the effect of...}
```

### Text Formatting
```latex
\ul{underlined text}
\ital{italicized text}
\ui{underlined and italicized}
```

### Adjusting Line Spacing
```latex
\begin{document}
\onehalfspacing  % 1.5 spacing
% or
\doublespacing   % double spacing
```

## Customization

### List Spacing
Adjust in your document or modify class defaults:
```latex
\setlength{\USDAlisttopsep}{0.2em}    % space before/after list
\setlength{\USDAlistitemsep}{0.15em}  % space between items
```

### Paragraph Spacing
```latex
\setlength{\USDAparskip}{0.3em}  % space between paragraphs
```

## Tips for Success

### Staying Within Page Limits
1. Write concisely and avoid redundancy
2. Use tables and figures efficiently
3. Check your page count before final submission
4. Remember: bibliography is separate and doesn't count!

### Best Practices
- ? Cite primary literature (not just review articles)
- ? Include recent publications (last 5 years when possible)
- ? Make objectives SMART (Specific, Measurable, Achievable, Relevant, Time-bound)
- ? Provide sufficient methodological detail
- ? Address potential limitations proactively
- ? Demonstrate stakeholder engagement

### Before Submitting
- [ ] Compiled both ProjectNarrative.pdf and Bibliography.pdf
- [ ] Project narrative is ? 18 pages
- [ ] All citations in narrative appear in bibliography
- [ ] Removed all instructional comments
- [ ] Checked for typos and formatting consistency
- [ ] Verified all figures and tables are clear
- [ ] Reviewed USDA AFRI program announcement for specific requirements

## Submission Checklist

Upload to grants.gov:

1. **Project Narrative** ? `ProjectNarrative.pdf` (max 18 pages)
2. **Literature Cited** ? `Bibliography.pdf` (separate file)
3. Other required documents as specified in the program announcement

## Support and Customization

### Modifying the Template
- The template files are commented extensively
- The `.cls` file can be modified for different formatting needs
- Contact your institution's grant support office for assistance

### Common Issues

**Problem:** Bibliography not appearing  
**Solution:** Run BibTeX after first LaTeX compilation

**Problem:** Citations show as [?]  
**Solution:** Compile multiple times (LaTeX ? BibTeX ? LaTeX ? LaTeX)

**Problem:** Font not Times New Roman  
**Solution:** Use LuaLaTeX (recommended) or XeLaTeX instead of pdfLaTeX

**Problem:** Over 18 pages  
**Solution:** Reduce content, use tables/figures efficiently, or check spacing settings

## License

This template is released under the **MIT License**. See the [LICENSE](LICENSE) file for details.

You are free to:
- ? Use this template for any purpose (commercial or non-commercial)
- ? Modify and adapt the template
- ? Distribute copies
- ? Include in other projects

The only requirement is to include the original copyright notice.

## Acknowledgments

This template was developed to assist researchers in preparing high-quality USDA AFRI proposals with proper formatting and organization.

---

**Questions or Issues?** Review the extensive comments in `ProjectNarrative.tex` and `usda-afri-narrative.cls` for detailed guidance.
