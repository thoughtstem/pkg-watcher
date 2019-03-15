#lang racket

(provide package-needs-update?
         filter-needs-update
         update-if-needed!)

(require pkg pkg/path 
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

(define (update-if-needed! pkgs)
  (define to-update (filter package-needs-update? pkgs))
  
  (unless (empty? to-update) 
    (with-pkg-lock 
      (pkg-update (map ~a to-update) #:dep-behavior 'search-auto)))
  

  (unless (empty? callback-list) 
    (for ([p callback-list])
      (call p))))


(define (call p)
  (define callback (dynamic-require p 'callback)) 

  (callback))



