<h1 align="center">LaPreprint</h1>
<p align="center">
<a href="#"><img alt="License" src="https://img.shields.io/github/license/roaldarbol/lapreprint?style=flat-square"></a>
<a href="#"><img alt="Stars" src="https://img.shields.io/github/stars/roaldarbol/lapreprint?style=social"></a>
<a href="#"><img alt="Twitter" src="https://img.shields.io/twitter/follow/roaldarbol?style=social"></a>
</p>


<p align="center">
  <img width="300" height="420" src="https://user-images.githubusercontent.com/25629697/186152620-72626796-53c0-4f29-a44a-399454deceb8.jpg">
</p>
<p align="center">
  <b>An easy way to create pretty, nicely formatted preprints in LaTeX.</b>
</p>

## Quick start
1. Click `Use this template`
2. Open the document in your preferred environment ([e.g. Overleaf or VSCode](https://github.com/roaldarbol/LaPreprint/wiki/Working-environment))
3. In `main.tex`, edit `Article setup` to have the correct information
4. Start writing! The sections are found in the `main` folder

If you want different sections you can easily rename them - just make sure also to edit the names in `main.tex`.

# Features
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
