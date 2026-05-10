(defpackage #:lextils
(:use #:cl)
(:export 
#:clear-screen  
#:set-ansi-background 
#:set-ansi-foreground
#:bold
#:underline
#:italic
#:clean-from-cursor
#:clean-line))
(in-package #:lextils)
;; This is lextils, a Common Lisp program that allows for certain text utils
;; lextils is compatible with SBCL in compiler terms
;; You cannot utilise certain colours in legacy terminals such as cmd.exe

(defun clear-screen ()
(format t "~c[2J~c[H" #\Escape #\Escape)
(finish-output))
(defun set-ansi-background (colour)
(cond
((eq colour :black) (format t "~c[48;5;0m" #\Escape))
((eq colour :red) (format t "~c[48;5;1m" #\Escape))
((eq colour :green) (format t "~c[48;5;2m" #\Escape))
((eq colour :yellow) (format t "~c[48;5;3m" #\Escape))
((eq colour :blue) (format t "~c[48;5;4m" #\Escape))
((eq colour :magenta) (format t "~c[48;5;5m" #\Escape))
((eq colour :cyan) (format t "~c[48;5;6m" #\Escape))
((eq colour :white) (format t "~c[48;5;7m" #\Escape))
((eq colour :light-black) (format t "~c[48;5;8m" #\Escape))
((eq colour :light-red) (format t "~c[48;5;9m" #\Escape))
((eq colour :light-green) (format t "~c[48;5;10m" #\Escape))
((eq colour :light-yellow) (format t "~c[48;5;11m" #\Escape))
((eq colour :light-blue) (format t "~c[48;5;12m" #\Escape))
((eq colour :light-magenta) (format t "~c[48;5;13m" #\Escape))
((eq colour :light-cyan) (format t "~c[48;5;14m" #\Escape))
((eq colour :light-white) (format t "~c[48;5;15m" #\Escape))
((eq colour :very-dark-blue) (format t "~c[48;5;17m" #\Escape))
(t
(format t "Invalid or Nonpresent Colour.~%"))))
(defun set-ansi-foreground (colour)
(cond
((eq colour :black) (format t "~c[38;5;0m" #\Escape))
((eq colour :red) (format t "~c[38;5;1m" #\Escape))
((eq colour :green) (format t "~c[38;5;2m" #\Escape))
((eq colour :yellow) (format t "~c[38;5;3m" #\Escape))
((eq colour :blue) (format t "~c[38;5;4m" #\Escape))
((eq colour :magenta) (format t "~c[38;5;5m" #\Escape))
((eq colour :cyan) (format t "~c[38;5;6m" #\Escape))
((eq colour :white) (format t "~c[38;5;7m" #\Escape))
((eq colour :light-black) (format t "~c[38;5;8m" #\Escape))
((eq colour :light-red) (format t "~c[38;5;9m" #\Escape))
((eq colour :light-green) (format t "~c[38;5;10m" #\Escape))
((eq colour :light-yellow) (format t "~c[38;5;11m" #\Escape))
((eq colour :light-blue) (format t "~c[38;5;12m" #\Escape))
((eq colour :light-magenta) (format t "~c[38;5;13m" #\Escape))
((eq colour :light-cyan) (format t "~c[38;5;14m" #\Escape))
((eq colour :light-white) (format t "~c[38;5;15m" #\Escape))
((eq colour :very-dark-blue) (format t "~c[38;5;17m" #\Escape))
(t
(format t "Invalid or Nonpresent Colour.~%"))))
(defun bold (state)
(cond
((eq state :on) (format t "~c[1m" #\Escape))
((eq state :off) (format t "~c[0m" #\Escape))
(t
(format t "Invalid Operation.~%"))))
(defun italic (state)
(cond
((eq state :on) (format t "~c[3m" #\Escape))
((eq state :off) (format t "~c[0m" #\Escape))
(t
(format t "Invalid Operation.~%"))))
(defun underline (state)
(cond
((eq state :on) (format t "~c[2m" #\Escape))
((eq state :off) (format t "~c[0m" #\Escape))
(t
(format t "Invalid Operation.~%"))))
(defun clean-from-cursor ()
(format t "~c[K" #\Escape))
(defun clean-line ()
(format t "~c[2K~c[G" #\Escape #\Escape))