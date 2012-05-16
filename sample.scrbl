#lang scribble/base

@(require "scribble-tagged.rkt")


@title{This is a test}

@declare-tags[student teacher robot]


@tagged-for[student]{
This is a message that a student should be able to see.
}

@tagged-for[teacher]{
This is a message that a teacher should be able to see.
}

@tagged-for[(student teacher)]{

This is a message that either a student or teacher can see.
A robot would not see this message, however.

}

Anything that is not tagged explicitly should be seen by all people.

The resulting Scribble document can be rendered for particular tags.


We plan to use parameters to make this happen.  See
@filepath["sample-student.scrbl"] or @filepath["sample-teacher.scrbl"], for
example.


