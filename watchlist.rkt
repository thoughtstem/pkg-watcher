#lang racket

(provide watch-list
         watch!
         unwatch!)

(define (watch-list-file) 
  (build-path (find-system-path 'home-dir) 
              ".racket-pkg-sync"))

(define (save-watch-list l)
  (with-output-to-file #:exists 'replace
                       (watch-list-file)
                       (thunk (displayln (~s l)))))

(if (not (file-exists? (watch-list-file)))
    (save-watch-list '())
    (void))

(define watch-list (read (open-input-file (watch-list-file)))) 


(define/contract (watch! pkg)
  (-> symbol? void?)

  (set! watch-list 
    (remove-duplicates (append watch-list (list pkg))))
  
  (save-watch-list watch-list))


(define/contract (unwatch! pkg)
  (-> symbol? void?)

  (set! watch-list 
    (filter-not (curry eq? pkg) watch-list ))
  
  (save-watch-list watch-list))


