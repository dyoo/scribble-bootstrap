#lang racket/base

(require (for-syntax racket/base))


;; A set of constraints we can impose on form elements.

(define-syntax (define-constraint stx)
  (syntax-case stx ()
    [(_ id c)
     #'(define id c)]))



;; For the moment, support the nonempty constraint and the "and" constraint.
(struct constraint:nonempty ())

(struct constraint:and (c1 c2))
