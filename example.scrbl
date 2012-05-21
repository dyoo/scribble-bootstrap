#lang planet dyoo/scribble-bootstrap
@title{Example}

@; Note: this document can be generated in different contexts.
@;
@; E.g.:    $ SCRIBBLE_TAGS=student scribble example.scrbl
@;      vs  $ SCRIBBLE_TAGS=teacher scribble example.scrbl
@;      vs  $ SCRIBBLE_TAGS="student teacher" scribble example.scrbl


@declare-tags[student teacher robot]

@declare-data-repository["bootstrap-data-repository.hashcollision.org"]



@image["bootstrap.gif"]


@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@section{For everyone}
Untagged content shows for everyone.
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@tag[student]{
@section{For students}
This is a message that a student should be able to see.
}
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@tag[teacher]{
@section{For teachers}
This is a message that a teacher should be able to see.
}
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@tag[(student teacher)]{
@section{For either students or teachers}
This is a message that either a student or teacher can see.
A robot would not see this message, however.
}
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
@tag[teacher]{
    @tag[student]{
        @section{Only when both teacher and student tags are enabled}
        Hello world.
    }
}
@;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


@section{Fill in the blank}

Here is a fill-in-the-blank: @fill-in-the-blank[#:id "first-example"].

And another: @fill-in-the-blank[#:id "first-name"
                                #:label "First name"
                                #:width 90]
@fill-in-the-blank[#:id "last-name"
                                #:label "Last name"
                                #:width 90].






@section{Free form text}
This is a free-response: @free-response[#:id "mytext"].