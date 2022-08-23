# LaPreprint

<p align="center">
  <img width="300" height="420" src="https://user-images.githubusercontent.com/25629697/186152620-72626796-53c0-4f29-a44a-399454deceb8.jpg">
</p>
<p align="center">
An easy way to create pretty, nicely formatted preprints in LaTeX.
</p>

## Quick start
1. Click `Use this template`.
2. In `main.tex`, edit `Article setup` to have the correct information.
3. Start writing! The sections are found in the `main` folder.

If you want different sections you can easily rename them - just make sure also to edit the names in `main.tex`.

## Features
This package provides the document class `preprint`.  
The document class is called with:
```latex
\documentclass[9pt,biorxiv,lineno,endfloat]{preprint}
```
The document class provides the following options:
- Choose between `biorxiv`, `medrxiv`, `arxiv` and `chemrxiv`. Otherwise defaults to `preprint`.  
- Use the `onehalfspacing` or `doublespacing` option for 1.5/2.0 line spacing.  
- Use the `lineno` option for line numbers.  
- Use the `endfloat` option to place floats after the bibliography.  

## Other features
There are certain editorial problems authors will likely often run into when writing papers. I've tried to find the best solutions to common features, and these should be fairly well supported:

### Figures
- `fullwidth`: For avoiding the margins (e.g. for large figures), use the \begin{fullwidth} environment.
- `subfigure`: For figures with multiple panels, use the `\subfigure` command within the \begin{figure} environment.

### Sidenotes
- `sidenote`: For notes, I really like sidenotes - and I've opted to use `\sidenote{}` for this purpose.

## Acknowledgements
LaPreprint is inspired by the style of eLife and PLoS, and is based on the eLife template. Additionally, the fancy footer is modified from the [the Henriques Lab template](https://www.overleaf.com/latex/templates/henriqueslab-biorxiv-template/nyprsybwffws). Without those all their work, this template wouldn't exist!

# Working environment
For most people, using [Overleaf](https://www.overleaf.com/) is great for collaborative writing. They are however also [owned by Holtzbrinck](http://bjoern.brembs.net/2021/09/algorithmic-employment-decisions-in-academia/), one of the big wigs in publishing, and a major [surveillance publishing](https://osf.io/preprints/socarxiv/j6ung/) actor that make money from selling our data. So I'll also propose an alternative solution using Visual Studio Code (or even better the non-tracking alternative VSCodium):

## Overleaf
Import into Overleaf is incredibly simple:  
1. On the `Projects` page, click `New Project`
2. `Import from Github`
<img width="208" alt="Screenshot 2022-08-23 at 10 10 10" src="https://user-images.githubusercontent.com/25629697/186129407-f0937a57-fda3-4d06-af5e-d5b54ac25937.png">

## VSCode
1. Install [VSCode](https://code.visualstudio.com/) or [VSCodium](https://vscodium.com/).
2. Install [Tex](https://www.tug.org/texlive/)
3. Open `VSCode`
4. Install extension `LaTeX Workshop` by James Yu
5. Open `User Settings (JSON)`: `Cmd+Shift+P`, `Preferences: Open User Settings (JSON)`
6. Add the following:
```json
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.latex.autoClean.run": "onFailed",
    "latex-workshop.latex.outDir": "build",
    "latex-workshop.view.pdf.internal.synctex.keybinding": "double-click",
    "[latex]": {
        "editor.wordWrap": "on"
    }
```
7. Clone your new repository to your device
8. `File`, `Open Folder` and select your newly cloned repository.
