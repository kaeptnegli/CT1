> ARM themselves call their own assembly syntax legacy
> ([ARM statement][arm-asm]).
> Therefore this repository contains laboratories from CT1 modified to use the
> more modern GNU assembly syntax.
>
> *This project is based on the work of Prosper Leibundgut (leiu) who provided
> a Makefile and a precompiled library (for startup and hal) to kickstart the
> project.*

**Setup for Maintainer**

1) Clone this repository *locally*.
1) Download the tarball from the latest [release][libct-releases], or clone
the [repository][libctboard] and compile it yourself.
Place the tarball in the directory `./lib/` and extract it there.
1) Ensure, that all required software is installed
(see [Installation](#installing-the-required-tools)).

**Adding resources and creating releases for students**

When adding a lab or single resources, make sure to tag solutions which
should are not meant for students with the correct flags:
`solution:start`/`solution:end` in Markdown and Make files **replace ':' with '=',
`STUDENTS: To be programmed`/`END: To be programmed` in source code files.

To create a **release** for the students repository, use the prepared bash
script.
It will clone the students repository and copy the required, adjusted
resources into said repository.
This ensures, that no (properly tagged) solutions are pushed, and improves
release consistency.
Note that committing and tagging has to be done manually.
