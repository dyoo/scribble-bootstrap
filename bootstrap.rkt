#lang racket/base

;; Collects all the utility libraries into a single "bootstrap.rkt" for Scribble
;; users to include.

(require "tags.rkt")
(provide (all-from-out "tags.rkt"))