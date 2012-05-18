#lang planet dyoo/scribble-bootstrap

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



Here is a fill-in-the-blank: @fill-in-the-blank[#:id "first-example"].

And another: @fill-in-the-blank[#:id "second-example"
                                #:label "First name"
                                #:width 90].
