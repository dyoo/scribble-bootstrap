#lang racket/base

(require (for-syntax racket/base))


;; A constraint is:
(struct every (preds))
(struct any (preds))
(struct no (pred))
;; or just a plain pred.


;; where pred can be:
(struct nonempty? (val))
(struct numeric? (val))
;; ... truly, we want a more generic, match-like language for
;; describing the shapes of expressions, or allow for arbitrary
;; predicates that we can evaluate through WeScheme or Whalesong.  We
;; will need to revisit this.



;; The arguments to preds---vals---are:
(struct field (id))
(struct ith-field (id))
