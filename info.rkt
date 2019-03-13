#lang info
(define collection "pkg-watcher")
(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/kata-installer.scrbl" ())))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(thoughtstem))


(define raco-commands
  '(("update-watched-packages" pkg-watcher/raco-tools/update-watched-packages "Updates anything that has been (watch! __)ed by pkg-watcher" 100)
))

(define drracket-tool-names (list "Package Watcher"))
(define drracket-tools (list (list "drracket/auto-updater.rkt")))
