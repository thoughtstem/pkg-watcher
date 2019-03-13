#lang racket

(provide (all-from-out "./watchlist.rkt")
         (all-from-out "./fresh-or-not.rkt"))

(require "./watchlist.rkt")
(require "./fresh-or-not.rkt")

;TODO: Docs (watch! ___) (unwatch! ___)
;      Release
;      DrRacket tool -- working, but needs to have better output to show what's being updated...

;P.S. Eventually, we need to write back to the backend whenever we update a package -- send over the current versions of everything.  Does that happen in the DrRacket tool, a different DrRacket tool (maybe it just starts logging when you open drracket and the first thing it does is logs the currently installed versions of any watched packages) ?

