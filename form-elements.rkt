#lang racket/base

(require "sxml.rkt"
         racket/runtime-path
         scribble/base
         scribble/core
         scribble/decode
         scribble/html-properties)


;; FIXME: must add contracts!
(provide fill-in-the-blank
         free-response


         worksheet
         lesson
         drill

         materials)





;; One-line input
(define (fill-in-the-blank #:id id
                           #:columns (width 50)
                           #:label (label #f))
  (sxml->element `(input (@ (type "text")
                            (id ,id)
                            (width ,(number->string width))
                            ,@(if label
                                  `((placeholder ,label))
                                  '()))
                         "")))



;; Free form text
(define (free-response #:id id
                       #:columns (width 50)
                       #:rows (height 20)
                       #:label (label #f))
  (sxml->element `(textarea (@ (id ,id)
                               (cols ,(number->string width))
                               (rows ,(number->string height))
                               ,@(if label
                                     `((placeholder ,label))
                                     '()))
                            "")))


(define-runtime-path bootstrap.css "bootstrap.css")
(define (bootstrap-sectioning-style name)
  (make-style name (list (make-css-addition bootstrap.css)
                         ;; Use <div/> rather than <p/>
                         (make-alt-tag "div"))))


;; The following provide sectioning for bootstrap.  They provide
;; worksheets, lessons, and drills.
(define (worksheet . body)
  (compound-paragraph (bootstrap-sectioning-style "BootstrapWorksheet")
                      (decode-flow body)))


(define (lesson . body)
  (compound-paragraph (bootstrap-sectioning-style "BootstrapLesson")
                      (decode-flow body)))


(define (drill . body)
  (compound-paragraph (bootstrap-sectioning-style "BootstrapLesson")
                      (decode-flow body)))




;; TODO: Add a materials
(define (materials . items)
  (list "Materials:"
        (apply itemlist items #:style "BootstrapMaterialsList")))