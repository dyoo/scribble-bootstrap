#lang racket/base

(require "sxml.rkt"
         racket/runtime-path
         racket/stxparam
         scribble/base
         scribble/core
         scribble/decode
         scribble/html-properties
         (for-syntax racket/base))


;; FIXME: must add contracts!
(provide row
         fill-in-the-blank
         free-response

         ;; Sections
         worksheet
         lesson
         drill

         ;; Itemizations
         materials)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This provides form loops and indices



(define-syntax (row stx)
  (syntax-case stx ()
    [(row #:count n body ...)
     ;; FIXME: set up the parameterizations so we can repeat the content
     #'(build-list n (lambda (i)
                       (paragraph (make-style "BootstrapRow" (list (make-alt-tag "div")))
                                  (list body ...))))]))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The following provides sectioning for bootstrap.  They provide
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; TODO: Add a materials
(define (materials . items)
  (list "Materials:"
        (apply itemlist items #:style "BootstrapMaterialsList")))