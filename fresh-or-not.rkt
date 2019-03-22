#lang racket

(provide package-needs-update?
         filter-needs-update
         update-if-needed!
         update-watched-packages!)

(require pkg pkg/path setup/setup
         (only-in pkg/private/stage remote-package-checksum) 
         pkg/lib
         "./watchlist.rkt")

(define (local-version-for name)
  (define db (read-pkgs-db 'user))

  (define info (hash-ref db (~a name) #f))
 
  (if info 
    (pkg-info-checksum info)
    #f))

(define (package-name->source name)
  (define db (read-pkgs-db 'user))

  (define info (hash-ref db (~a name) #f))
 
  (if info 
    (pkg-info-orig-pkg info)
    #f))

(define (remote-version-for package-source)
  (define src (package-name->source package-source))
  
  (if (and src (not (eq? 'link (first src))))
    (remote-package-checksum src printf (~a package-source))
    #f))

(define (package-needs-update? pkg-name)
  (define l (local-version-for pkg-name))
  (define r (remote-version-for pkg-name))

  ;There must be a local and remote version,
  ; and they must not be equal
  (and l r
       (not
        (equal? l r))))

(define (filter-needs-update pkgs)
  (filter package-needs-update? pkgs))

(define (update-watched-packages!)
  (update-if-needed priority-watch-list) 
  (update-if-needed watch-list))

(define (update-if-needed! pkgs)
  (define to-update 
    (map ~a (filter package-needs-update? pkgs)))
  
  (unless (empty? to-update) 
    (with-pkg-lock 
      (pkg-update to-update #:dep-behavior 'search-auto))
    (setup #:collections (list (map list to-update))))

  (unless (empty? callback-list) 
    (for ([p callback-list])
      (call p))))


(define (call p)
  (define callback (dynamic-require p 'callback)) 

  (callback))



