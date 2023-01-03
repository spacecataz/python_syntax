# python_syntax
A set of Jupyter notebooks that introduce the basics of Python- from "Hello World" to object oriented coding.

These simple notebooks walk through the basics of Python syntax to help new
users learn the language.

| # | Topic & Files |
|---|---------------|
| 1 | Basics: Python variables and simple data types. |
| 2 | Suites: Code blocks and suites |
| 3 | Basic File I/O: Loading and parsing basic ASCII and pickles. |
| 4 | Modules: Creating reusable Python code. |
| 5 | OOP: Embracing object-oriented programming in Python  |
| 6 | Strings: The gory details of strings and formatting. |

## Requirements
Reading the notebooks just takes Github- click on any `*.ipynb` file and
peruse away!

For advanced features or editing, more will be required.
PDFLaTeX is needed for building LaTeX source files.
GNU Make is needed for building PDFs and HTML files.
To build marked-up HTML for code, ensure you have Pygments installed and
`pygmentize` is in the search path.
To convert HTML to PDFs, Wkhtml2pdf is required.
[Information on obtaining this software on different platforms can
be found here.](https://wkhtmltopdf.org/downloads.html)
Jupyter-notebook and Jupyter-nbconvert (version 6 or above) are required for
editing Jupyter notebooks and converting them to PDFs.  If using pip to
install nbconvert, use this syntax to enable webpdf formats:

`pip install nbconvert[webpdf]`
To be able to run the same commands and scripts as contained within this tutorial, you will need Spacepy (which includes Pybats) and all of its dependencies.
The tutorials are Jupyter Notebooks.  If you want to be able to run them interactively, you'll need to obtain Jupyter on your machine.

Finally, the Jupytext plugin is used to synchronize the markdown and `*.ipynb`
files.  You'll want to install this plugin if you are contributing to this
repository.
[Information on installing and using Jupytext can be found here.](https://jupytext.readthedocs.io/en/latest/index.html)

## Creating Shareable Handouts
For shareable files, use the included Makefile.

`make` will create PDFs of all `.ipynb` files.
`make html` will create `.html` files of all `.ipynb` files.

Both are easy to print out or share electronically without worrying about the
end user knowing how to manage Jupyter or navigate Github.