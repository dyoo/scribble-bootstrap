#lang racket/base

(require "sxml.rkt")

(provide fill-in-the-blank)


;; Add in a fill-in-the-blank
(define (fill-in-the-blank #:id id
                           #:width (width 50)
                           ;;#:default (default #f)
                           )
  (sxml->element `(input (@ (type "text")
                            (id ,id)
                            (width (number->string width))))))