#lang racket/base

(require syntax/id-table)

(provide (all-defined-out))


;; We keep a hierarchy of roles.
(struct role (binding-stx
              parent
              children)
  #:mutable
  #:transparent)


(define known-roles (make-free-id-table))

(define (install-role! r)
  (free-id-table-set! known-roles (role-binding-stx r) r))


;; known-role-names: -> (listof symbol)
;; Returns a list of all the known roles names.
(define (known-role-names)
  (free-id-table-map known-roles (lambda (id r)
                                   (syntax-e id))))
   

;; role-lookup: identifier-stx -> (U role #f)
(define (role-lookup stx)
  (free-id-table-ref known-roles stx #f))


;; new-role: syntax -> role
(define (new-role binding-stx)
  (role binding-stx #f '()))


;; role-add-child!: role role -> void
;; Attach a role to the hierarchy.
(define (role-add-child! a-role r)
  (set-role-children! a-role
                      (cons r (role-children a-role)))
  (set-role-parent! r a-role))


;; role-applicable a-role: role -> (listof role)
;; Given a role, produce a list of all of the roles
;; rooted with us.
(define (role-applicable a-role)
  (reverse
   (let loop ([a-role a-role]
              [acc '()])
     (foldl loop
            (cons a-role acc)
            (reverse (role-children a-role))))))


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
          (check-equal? (length (role-applicable r)) 3)
          (check-equal? (syntax-e (role-binding-stx r))
                        'all)

          (check-equal? (for/list ([r (role-applicable r)])
                          (syntax-e (role-binding-stx r)))
                        '(all teacher student))
          
          (check-equal? (for/list ([r (reverse (role-children r))])
                          (syntax-e (role-binding-stx r)))
                        '(teacher student))
          
          (for ([c (role-children r)])
            (check-eq? (role-parent c)
                       r))))
