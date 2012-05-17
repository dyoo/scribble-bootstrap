#lang racket/base
(require racket/splicing
         (prefix-in scribble: scribble/decode)
         (prefix-in scribble: scribble/core)
         (for-syntax racket/base
                     racket/block))


(provide declare-tags tagged-for)


(begin-for-syntax

 ;; We'll use this as our environment variable.
 (define SCRIBBLE-TAGS-ENV-VAR "SCRIBBLE_TAGS")

 (define known-tags (make-hash))

 (define (check-known-tag! tag-stx)
   (void))
 

 (define (generate-tagged-for-code tags bodies)
   (with-syntax ([(body ...) bodies])
     (for-each check-known-tag! tags)
     ;; I would really like to push this compile-time check to
     ;; runtime, but I'm having a difficult type getting traverse
     ;; elements to cooperate with splice, which I need so that we
     ;; can wrap sections with this.  I suspect I need to cooperate
     ;; with decode in some funky way.
     (define enabled-tags (map string->symbol (regexp-split #px"\\s+" (getenv SCRIBBLE-TAGS-ENV-VAR))))
     (cond
      [(for/or ([tag tags]) (member (syntax-e tag) enabled-tags))
       #'(scribble:splice (list body ...))]
      [else
       #'(scribble:splice (list))]))))
 


(define-syntax (declare-tags stx)
  (syntax-case stx ()
    [(_ tag-name ...)
     #'(begin-for-syntax
        (for ([tag (list '(tag-name ...))])
             (hash-set! known-tags tag #t)))]))



(define-syntax (tagged-for stx)
  (syntax-case stx ()
    [(_ tag body ...)
     (identifier? #'tag)
     (generate-tagged-for-code (list #'tag) #'(body ...))]

    [(_ (tag ...) body ...)
     (andmap identifier? (syntax->list #'(tag ...)))
     (generate-tagged-for-code (syntax->list #'(tag ...)) #'(body ...))]))