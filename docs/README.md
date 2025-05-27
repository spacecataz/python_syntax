# Source Code Information

This repository is built using Jupyter Notebooks with the Jupytext plugin.
Makefile commands exist to create PDF handouts quickly.

## Requirements
<!--For advanced features or editing, more will be required.
PDFLaTeX is needed for building LaTeX source files.
GNU Make is needed for building PDFs and HTML files.
To build marked-up HTML for code, ensure you have Pygments installed and
`pygmentize` is in the search path.
To convert HTML to PDFs, Wkhtml2pdf is required.
[Information on obtaining this software on different platforms can
be found here.](https://wkhtmltopdf.org/downloads.html)
-->

A standard Python3 environment is needed to run these tutorials.
This includes Python3, Numpy, and Matplotlib.

When running the notebook files interactively or editing them, you will need
Jupyter installed locally or access to a live Jupyter-notebook server.
Additionally, because the tutorials are saved as markdown files,
you will need to install the Jupytext plugin on your machine.
[Information on installing and using Jupytext can be found here.](https://jupytext.readthedocs.io/en/latest/index.html)

Finally, Jupyter-nbconvert is required for generation of HTML or PDF versions
of the tutorials.

Typical installation on a Debian-like machine will look like this:

```
sudo apt install jupyter-notebook jupyter-nbconvert
pip3 install jupytext

```

Note that if the Jupytext menu is not appearing within a notebook, you may
need to activate the extension within Jupyter (even though Jupytext is
already installed):

```
jupyter nbextension install --py jupytext [--user]
jupyter nbextension enable --py jupytext [--user]
```

For users of Microsoft's Visual Studio Code, these two plugins will allow for
running and editing the Markdown files as Jupyter notebooks within VSCode:

[Jupyter (Microsoft)](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter)
[Jupytext for Notebooks (Fork:Congyiwu)](https://marketplace.visualstudio.com/items?itemName=congyiwu.vscode-jupytext)


## Creating Shareable Handouts
For shareable files, use the included Makefile.

`make` will create PDFs of all `.ipynb` files.
`make html` will create `.html` files of all `.ipynb` files.

Both are easy to print out or share electronically without worrying about the
end user knowing how to manage Jupyter or navigate Github.

