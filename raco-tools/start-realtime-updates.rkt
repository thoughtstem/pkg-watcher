#lang racket

(require pkg-watcher)

(let loop ()
  (update-watched-packages!)
  (sleep 10)
  (loop))
