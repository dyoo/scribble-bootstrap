#lang racket

(provide defroles role)


(define-syntax (defroles stx)
  (printf "~s\n"  (syntax-local-context))
  (cond
    [#t #;(eq? (syntax-local-context) 'module)
     
     
     (syntax-case stx ()
       [(_ role-structure ...)
        #'(void)])]
    
    [else
     (raise-syntax-error #f "Roles should only be declared at module toplevel" stx)]))



(define-syntax (role stx)
  #'fill-me-in)
                     
     