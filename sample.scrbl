#lang scribble/base

@(require "scribble-tagged.rkt"
          scribble/manual)


@declare-tags[student teacher robot]

@title{This is a test!}


This is an example of a document that uses the @tt{scribble-tagged}
library.


@tagged-for[student]{
@section{For students}
This is a message that a student should be able to see.
}

@tagged-for[teacher]{
@section{For teachers}
This is a message that a teacher should be able to see.
}

@tagged-for[(student teacher)]{
@section{For both students and teachers}
This is a message that either a student or teacher can see.
A robot would not see this message, however.
}



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
