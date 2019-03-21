#lang racket/gui

(provide updater)

(require "../main.rkt")

(define (updater to-update)
  (define frame (new frame% 
                     [label "Updater"]
                     [width 400]
                     [height 400]
                     ))

  (define top-panel (new group-box-panel%
                         (parent frame)
                         (label "Do you want to update?")))

  (define panel (new horizontal-panel% 
                     [parent top-panel]
                     [alignment '(center center)]
                    ; [min-width 400]
                    ; [stretchable-width 400]
                     ))

  (new button% [parent panel]
       [label "Yes"]
       [callback (lambda (button event)
                   (send text insert "This will close after updating.  Wait..." ) 

                   ;TODO: Pipe the output of update-if-needed! into the text frame in real time...
      	           (update-if-needed! to-update)

                   (send frame show #f) )])

  (new button% [parent panel]
       [label "No"]
       [callback (lambda (button event)
		   (send frame show #f))])

  (define editor-canvas (new editor-canvas%
			     (parent frame)
			     (label "Editor Canvas")))

  (define text (new text%))
  (send text insert (string-join (map ~a to-update) "\n"))
  (send editor-canvas set-editor text)

  (send frame show #t))

