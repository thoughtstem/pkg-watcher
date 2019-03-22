#lang racket

(require pkg-watcher)

(let loop ()
  (update-watched-packages!)
  (sleep 1)
  (loop))
