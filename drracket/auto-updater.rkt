#lang racket/gui

(require drracket/tool pkg-watcher "./updater-frame.rkt")
 
(provide tool@)
 
(define tool@
  (unit
    (import drracket:tool^)
    (export drracket:tool-exports^)
    (define (phase1) (void))
    (define (phase2) (void))

    
    (define to-update (filter-needs-update watch-list))

    (if (not (empty? to-update))
      (with-handlers ([exn? (lambda (e)
                                (void))])
        (updater to-update))
      (void))))


