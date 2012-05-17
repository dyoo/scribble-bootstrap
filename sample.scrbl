#lang scribble/base

@(require "scribble-tagged.rkt"
          scribble/manual
          (for-label "scribble-tagged.rkt"))

@defmodule["scribble-tagged.rkt"]


@declare-tags[student teacher robot]

@title{scribble-tagged example document}


This is an example of a document that demonstrates the use of the
@tt{scribble-tagged} library.




@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@tagged-for[student]{
@section{For students}
This is a message that a student should be able to see.
}
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@tagged-for[teacher]{
@section{For teachers}
This is a message that a teacher should be able to see.
}
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@tagged-for[(student teacher)]{
@section{For either students or teachers}
This is a message that either a student or teacher can see.
A robot would not see this message, however.
}
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  @tagged-for[teacher]{
    @tagged-for[student]{
        @section{Only when both teacher and student tags are enabled}
        Hello world.
    }
  }
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




Anything that is not tagged explicitly should be seen by all people.

The resulting Scribble document can be rendered for particular tags.


We plan to use the @tt{SCRIBBLE_TAGS} environmental variable to generate the conditional
documentation.

For example:
@verbatim|{
SCRIBBLE_TAGS=student scribble sample.scrbl
}|
should generate sample.html with student-specific content, and:
@verbatim|{
SCRIBBLE_TAGS=teacher scribble sample.scrbl
}|
should do the same for teachers.


To generate content that shows for both students and teachers:
@verbatim|{
SCRIBBLE_TAGS="student teacher" scribble sample.scrbl
}|



@section{API}

@defform[(declare-tags)]{

Declares the set of tags to be used in this document.  Uses of
@racket[tagged-for] will check that they've been declared in a
@racket[declare-tags].

}


@defform[(tagged-for)]{

Blocks off a section of the scribble document with a tag.  Acts to exclude all
but the people who have the named tag.
@verbatim|{
@tagged-for[student]{Can be seen by student.}
@tagged-for[teacher]{Can be seen by teacher.}
}|



A section can be tagged with multiple tags at a time, which acts as union.
@verbatim|{
@tagged-for[(student teacher)]{Can be seen by both students and teachers.}
}|


Nested tags act as intersection.  For example:
@codeblock|{
  @tagged-for[teacher]{
    @tagged-for[student]{
        Hello world.
    }
  }
}|
should generate no content unless both the @racket[teacher] and
@racket[student] tags are in play.



}




@section{Caveats}

The conditional test is performed at compile-time rather than
run-time.  This means that if you compile a @filepath{.scrbl} file
with @litchar{raco make}, that decision has been committed to the
bytecode, so that if you re-render the document, @litchar{scribble}
does not revisit the choice.
