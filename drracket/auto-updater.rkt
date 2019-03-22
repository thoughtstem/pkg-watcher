#lang racket/gui

(require drracket/tool pkg-watcher)
 
(provide tool@)
 
(define tool@
  (unit
    (import drracket:tool^)
    (export drracket:tool-exports^)
    (define (phase1) (void))
    (define (phase2) (void))


    (thread (thunk (update-watched-packages!)))))



