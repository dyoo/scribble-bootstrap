#lang racket/base

(require "sxml.rkt")


;; FIXME: must add contracts!
(provide fill-in-the-blank
         free-response)



(define (fill-in-the-blank #:id id
                           #:width (width 50)
                           #:label (label #f)
                           ;;#:default (default #f)
                           )
  (sxml->element `(input (@ (type "text")
                            (id ,id)
                            (width ,(number->string width))
                            ,@(if label
                                  `((placeholder ,label))
                                  '()))
                         "")))




(define (free-response #:id id
                        #:width (width 50)
                        #:height (height 20)
                        #:label (label #f)
                        ;;#:default (default #f)
                        )
  (sxml->element `(textarea (@ (id ,id)
                               (cols ,(number->string width))
                               (rows ,(number->string height))
                               ,@(if label
                                     `((placeholder ,label))
                                     '()))
                            "")))



;; free form text

;; wescheme instance