#lang racket

(provide (all-from-out "./watchlist.rkt")
         (all-from-out "./fresh-or-not.rkt")
         all-watched-are-updated?)

(require "./watchlist.rkt")
(require "./fresh-or-not.rkt")

;TODO: Docs (watch! ___) (unwatch! ___)
;      Release
;      DrRacket tool -- working, but needs to have better output to show what's being updated...

(define (all-watched-are-updated?)
  (empty? (filter-needs-update watch-list)))
