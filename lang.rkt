#lang racket/base

(require scribble/doclang
         scribble/base
         "bootstrap.rkt"
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



;; TODO: we need to change the style of the document here to fit
;; the CSS styles we want for bootstrap.
(define (change-defaults doc)
  doc)