#lang scribble/base

@(require "roles.rkt")


@defroles[teacher student]


This is text that everyone can see.
@role[student]{hello world, this is text that only students can see.}
@role[teacher]{goodbye world, this is text that only teachers can see.}


@role[student]