<!-- -*- mode: gfm; coding: utf-8; fill-column: 72; -*- -->
# UMD Thesis Class

Copyright 2022 by [Adam Liter][adamliter].

This is a class file for producing dissertations and theses in
accordance with The University of Maryland Electronic Thesis and
Dissertation (ETD) Style Guide.

I wrote it while writing my dissertation as an alternative to the LaTeX
template that is distributed by the Graduate School, which can be found
on their website about [thesis and dissertation
filing][gradschool-diss-filing]. I found this template to be pretty
cumbersome, so I decided to write my own.

The class is based on the [`memoir`][memoir] document class, so it
inherits all of the functionality of that class. Moreover, the class is
heavily modeled off of [Alan Munn][alanmunn]'s
[`msu-thesis`][msu-thesis] class.

## installation

To install `umd-thesis` locally, you can put `umd-thesis.cls` into a
directory called:

```
<local texmf>/tex/latex/umd-thesis
```

Alternatively, if you don't have a local TEXMF tree set up, you can just
put `umd-thesis.cls` in the same directory as the `.tex` file for your
dissertation or thesis.

This package may be distributed and/or modified under the conditions of
the LaTeX Project Public License, either version 1.3 of this license or
any later version. The latest version of this license is in
http://www.latex-project.org/lppl.txt and version 1.3 or later is part
of all distributions of LaTeX version 2005/12/01 or later.

This package has the LPPL maintenance status "unmaintained".

I'm not sure that I'll actively maintain this class after graduating.
Perhaps this will change if it doesn't require too much time. However,
this means you should use this template at your own risk.

<!-- Links -->
[adamliter]: https://adamliter.org
[gradschool-diss-filing]: https://gradschool.umd.edu/students/academic-progress/thesis-and-dissertation-filing
[memoir]: https://ctan.org/pkg/memoir
[alanmunn]: https://amunn.github.io/
[msu-thesis]: https://github.com/amunn/msu-thesis
