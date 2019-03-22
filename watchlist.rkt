#lang racket

(require (for-syntax syntax/parse))

(define-syntax (persistent-list stx)
  (syntax-parse stx
    [(persistent-list list-name add! remove! storage-path) 
     (quasisyntax 
       (begin
         (provide list-name
                  add!
                  remove!)

         (define (get-file) 
           storage-path)

         (define (save-list l)
           (with-output-to-file #:exists 'replace
                                (get-file)
                                (thunk (displayln (~s l)))))

         (if (not (file-exists? (get-file)))
           (save-list '())
           (void))

         (define list-name (read (open-input-file (get-file)))) 


         (define/contract (add! thing)
                          (-> symbol? void?)

                          (set! list-name 
                            (remove-duplicates (append list-name (list thing))))

                          (save-list list-name))


         (define/contract (remove! thing)
                          (-> symbol? void?)

                          (set! list-name (filter-not (curry eq? thing) list-name ))
                          (save-list list-name))

         ))]))


(persistent-list
  watch-list
  watch!
  unwatch!
  (build-path (find-system-path 'home-dir) 
              ".racket-pkg-sync"))

(persistent-list
  callback-list
  add-callback!
  remove-callback!
  (build-path (find-system-path 'home-dir) 
              ".racket-pkg-sync-callbacks"))


(persistent-list
  priority-watch-list
  priority-watch!
  priority-unwatch!
  (build-path (find-system-path 'home-dir) 
              ".priority-racket-pkg-sync"))
