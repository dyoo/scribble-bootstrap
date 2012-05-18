#lang scribble/base

@(require "bootstrap.rkt"
          scribble/manual
          (for-label "bootstrap.rkt"))

@defmodule["bootstrap.rkt"]


@title{A guide to the @racketmodname["bootstrap.rkt"] Scribble library}


@section{Quick and dirty example}
Let's say that we have the following document:

@filebox["example.scrbl"]{
@codeblock|{
#lang scribble/base
@(require "bootstrap.rkt")

;; Let us declare the following tags.
@declare-tags[reading instruction pedagogy exercise skit]

@tag[reading]{This is text for reading.}

@tag[instruction]{
  This is text for instruction.
  @tag[pedagogy]{This is text for pedagogy.}}
}|}


We can then generate different renderings of this document based on the
audience, by using a @tt{SCRIBBLE_TAGS} environmental variable to provide the
necessary context.

For example, at the Unix command line:
@nested[#:style 'inset]{
@verbatim|{
$ SCRIBBLE_TAGS=reading scribble example.scrbl
}|}
should generate example.html with reading-specific content, and:
@nested[#:style 'inset]{@verbatim|{
$ SCRIBBLE_TAGS=instruction scribble example.scrbl
}|}
should do the same for the instructional context.

To generate content that shows for both instruction and pedagogy, use quotes
(@litchar{"}) so the Unix shell allows you to assign multiple tags into
@tt{SCRIBBLE_TAGS}:

@nested[#:style 'inset]{
@verbatim|{
$ SCRIBBLE_TAGS="instruction pedagogy" scribble \
    example.scrbl
}|}
will show the content for both instruction and pedagogy.



@section{Getting started with scribble and the @racketmodname["bootstrap.rkt"] library}


... fill me in ...




@section{API}

@defform[(declare-tags)]{

Declares the set of tags to be used in this document.  Uses of
@racket[tag] will check that they've been declared in a
@racket[declare-tags].

}


@defform[(tag)]{

This form acts as an ifdef, and blocks off a section of the scribble document
with a tag.  Its content shows only in a context that includes the given tag.

@verbatim|{
@tag[student]{Can be seen by student.}
@tag[teacher]{Can be seen by teacher.}
}|




A section can be tagged with multiple tags at a time by providing a parenthesized
list of tags.

@verbatim|{
@tag[(student teacher)]{Can be seen by both students and teachers.}
}|

This acts as as a union: if the document is generated in a context including
any of the tags, then it will be rendered.



Nested tags act as intersection.  For example:
@codeblock|{
  @tag[teacher]{
    @tag[student]{
        Hello world.
    }
  }
}|
should generate no content unless both the @racket[teacher] and
@racket[student] tags are in play.


Using @racket[tag] with a tag that hasn't been previously declared with
@racket[declare-tags] is a compile-time error.

}




@section{Caveats}

At the moment, the conditional tag logic is performed at compile-time rather
than run-time.  This means that if you compile a @filepath{.scrbl} file with
@litchar{raco make}, that decision has been committed to the bytecode, so that
if you re-render the document, @litchar{scribble} does not revisit the choice.
