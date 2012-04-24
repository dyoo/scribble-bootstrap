#lang racket/base


;; We keep a hierarchy of roles.
(struct role (binding-stx
              parent
              children)
  #:mutable)


;; new-role: syntax -> role
(define (new-role binding-stx)
  (role binding-stx #f '()))


;; role-add-child!: role role -> void
;; Attach a role to the hierarchy.
(define (role-add-child! a-role r)
  (set-role-children! a-role
                     (cons r (role-children a-role)))
  (set-role-parent! r a-role))


;; role-descendents a-role: role -> (listof role)
;; Given a role, produce a list of all of the descendents.
(define (role-descendents a-role)
  (let loop ([a-role a-role]
             [acc '()])
    (foldl loop
           (cons a-role acc)
           (role-children a-role))))


;; parse-role: syntax -> role
;; Given an s-expression of a tree structure, translates
;; all the identifiers to roles.  Builds the acyclic
;; tree in the role structure.
(define (parse-role role-stx)
  (syntax-case role-stx ()
    [(parent children ...)
     (begin
       (define p (parse-role #'parent))
       (define cs (map parse-role (syntax->list #'(children ...))))
       (for ([c cs]) (role-add-child! p c))
       p)]
    [id
     (identifier? #'id)
     (new-role #'id)]))


(module+ test
         (require rackunit
                  racket/block)
         
         (block
          (define r1 (new-role #'parent))
          (define r2 (new-role #'student))
          (check-equal? (role-parent r1) #f)
          (check-equal? (role-parent r2) #f)
          (role-add-child! r1 r2)
          (check-equal? (role-parent r1) #f)
          (check-equal? (role-parent r2) r1))
         
         (block 
          (define r (parse-role #'(all teacher student)))
          (check-equal? (length (role-children r)) 2)
          (check-equal? (length (role-descendents r)) 2)
          (check-equal? (syntax-e (role-binding-stx r))
                        'all)
          (check-equal? (map syntax-e (role-descendents r))
         
         
         )
