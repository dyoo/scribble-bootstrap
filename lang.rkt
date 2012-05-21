#lang racket/base

(require scribble/doclang
         scribble/base
         scribble/core
         scribble/html-properties
         "bootstrap.rkt"
         racket/runtime-path
         (for-syntax racket/base))

(provide (except-out (all-from-out scribble/doclang) #%module-begin)
         (all-from-out "bootstrap.rkt")
         (all-from-out scribble/base)
         (rename-out [module-begin #%module-begin]))

(define-syntax (module-begin stx)
  (syntax-case stx ()
    [(_ id . body)
     #`(#%module-begin id change-defaults ()
                       (inject-embedding-libraries)
                       . body)]))



(define-runtime-path-list js-paths
  (list (build-path "easyXDM.min.js")
        (build-path "json2.min.js")
        (build-path "wescheme-embedded.js")))

;; TODO: we need to change the style of the document here to fit
;; the CSS styles we want for bootstrap.
;; We also need to include the js files, the dependencies necessary
;; to render us.
(define (change-defaults doc)
  (define my-extra-files (html-defaults #"" #"" js-paths))
  (struct-copy part doc
               [style (make-style (style-name (part-style doc))
                                  (cons my-extra-files
                                        (style-properties (part-style doc))))]))
