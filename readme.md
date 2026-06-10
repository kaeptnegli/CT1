# CT1 - Computer engineering

This repository contains the lectures, exercises and laboratories for
computer engineering 1.

A few files of note are:

* `git-introduction/readme.(md|pdf)` is a quick introduction and
  nonexhaustive reference to git.
* `laboratories/readme.(md|pdf)` contains instructions to setup the
  tools required for the laboratories.


## File structure

Below is the file tree of the students repository for CT1.
It only shows files which are mentioned in this document.

Entries ending with '/' are directories.

```
ct1-students
+-- common/
|   +-- .gdbinit
|   +-- ct.code-profile
|   +-- pdf.mk
|   +-- root.mk
|   +-- template.tex
|   `-- trailing-whitespace.sh
+-- exercises/
+-- git-introduction/
|   +-- Makefile
|   +-- readme.md
|   `-- readme.pdf
+-- laboratories/
|   +-- Makefile
|   +-- readme.md
|   `-- readme.pdf
+-- libctboard/
+-- theory/
+-- Makefile
+-- readme.md
`-- readme.pdf
```

Every Markdown file should have a `Makefile` with rules to convert
from Markdown to PDF (requires `pandoc` and `texlive`).
The students releases should contain a PDF version of every Markdown
file.

`common/.gdbinit` contains commands to be run by the GNU debugger at
startup.
For example if you want to modify the `ines` layout you could change
this file.

`common/ct.code-profile` is a profile for VS Code users, which comes
with the required extensions and settings.

`common/pdf.mk` is a make include file with rules to convert Markdown
to PDF.

`common/root.mk` is a make include file with rules to build and link
binaries from C and assembly sources.

`common/template.tex` is a LaTeX template for pandoc to customise the
PDF output of pandoc.

`trailing-whitespace` is a bash script to detect and remove trailing
whitespace and optionally convert line endings to unix style
(just line feed).

`git-introduction/readme.(md|pdf)` is a short introduction to Git.
It is mostly intended for beginners, but also discusses some more
advanced topics.

`laboratories/readme.(md|pdf)` contains instructions on how to setup
the required tools for the laboratories, how to work with the
makefiles, VS Code or Keil and a short introduction to the GNU
debuger.

`./readme.(md|pdf)` is the file you are reading.
It contains a file tree and instructions on "forking" without forking.


## "Forking" the repository

It is sensible to fork this repository and continue working with
`git`.

> However if you fork it on Github, students after you will have
> trouble finding the right repository searching for `ct`.
> Also they will have your solutions, though experience shows, they
> will have access to solutions anyways.
> (It is usually rather easy to spot.)
>
> Thus you shall not use Githubs `fork` function.
> Instead follow the steps below.

**First** clone the CT1 repository locally.
Read `git-introduction.(md|pdf)` if you do not know how to use Git.

**Second** create an empty and **private** repository with your user
as owner.

![Creating a new repository](./resources/create-new-repository.png)

![Settings for new repository](./resources/repository-settings.png)

Make sure to select your **user as owner**.
Choose a recognisable name for you new repository.
The description is optional.

> As mentioned before: Set the visibility to **Private**.

**Third** change the URL of your local copy of the CT1 repository.

![Newly created empty repository](./resources/empty-repository.png)

Copy the URL in the 'Quick setup' box.
In your local copy of the CT1 repository set the remote URL to your
empty repository.

```sh
cd <path/to/ct1/repository>
git remote set-url origin <url-to-private-repository>
```

**Optionally** if you work on the labs with a fellow student, you can
open the settings of your private repository and add them as
collaborator in order to give them access.
