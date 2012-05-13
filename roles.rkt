#lang racket/base
(require (for-syntax racket/base
                     racket/block
                     "compile-time.rkt")
         (prefix-in scribble: scribble/decode))

(provide defroles role)


(define-syntax (defroles stx)
  (syntax-case stx ()
    [(_ role-structure ...)
     #'(begin
         (begin-for-syntax
           (for ([r (role-applicable (parse-role #'role-structure))])
             (install-role! r))
           ...))]))


(define-syntax (role stx)
  (syntax-case stx ()
    [(_ id body ...)
     (identifier? #'id)
     (block
      (define a-role (role-lookup #'id))
      (cond
       [(eq? a-role #f)
        (raise-syntax-error #f 
                            (format "Could not find defined role ~a in document.  Known roles are: ~a" 
                                    (syntax-e #'id)
                                    (known-role-names))
                            #'id)]
       [else
        ;; Fixme: we want to do something conditional here.
        #'(scribble:splice (list body ...))]))]))
