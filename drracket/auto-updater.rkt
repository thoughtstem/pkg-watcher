#lang racket/gui

(require drracket/tool pkg-watcher racket/gui)
 
(provide tool@)
 
(define tool@
  (unit
    (import drracket:tool^)
    (export drracket:tool-exports^)
    (define (phase1) (void))
    (define (phase2) (void))

    ;Note, will not complete if they close DrRacket before the update is finished.
    (thread 
      (thunk (update-if-needed! priority-watch-list)
             (message-box "Finished" "Updates complete!")))))



