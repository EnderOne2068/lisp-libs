(require :asdf)
(defpackage :fluff
(:use :cl :uiop)
(:export 
#:enable-raw-mode-windows 
#:disable-raw-mode-windows
#:syscall
#:api-call
#:enable-raw-mode-linux
#:disable-raw-mode-linux))
(in-package :fluff)

;; fluff is an FFI for Common Lisp using only :cl
;; usage: 
;; fluff:enable-raw-mode-linux 
;; fluff:disable-raw-mode-linux
;; fluff:enable-raw-mode-windows
;; fluff:disable-raw-mode-windows
;; fluff:syscall :number

(defvar *header-pe* '(77 90 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 128 0 0 0 14 31 186 14 0 180 9 205 33 184 1 76 205 33 89 111 117 32 99 97 110 110 111 116 32 99 97 108 108 32 87 105 110 51 50 32 107 101 114 110 101 108 51 50 46 100 108 108 32 105 110 32 77 83 45 68 79 83 46 13 10 36 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 32 80 69 0 0 100 134 2 0 0 0 0 0 0 0 0 0 0 0 0 0 240 0 34 0 11 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 16 0 0 0 16 0 0 0 0 0 0 64 0 0 0 0 16 0 0 0 2 0 0 6 0 0 0 0 0 0 0 6 0 0 0 0 0 0 0 0 48 0 0 0 4 0 0 0 4 0 0 0 0 0 0 3 0 0 0 0 0 16 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 32 0 0 100 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(defvar *text-raw-mode* '(72 131 236 40 72 199 193 246 255 255 255 255 21 54 16 0 0 72 137 193 72 199 194 0 0 0 0 255 31 40 16 0 0 72 137 193 72 141 84 24 48 65 184 1 0 0 0 76 141 76 24 56 72 199 68 24 32 0 0 0 0 255 21 17 16 0 0 15 182 68 72 131 196 40 195))
(defvar *text-cooked-mode* '(72 131 236 40 72 199 193 246 255 255 255 255 21 54 16 0 0 72 137 193 72 199 194 0 0 0 0 255 31 40 16 0 0 72 137 193 72 141 84 24 48 65 184 3 0 0 0 76 141 76 24 56 72 199 68 24 32 0 0 0 0 255 21 17 16 0 0 15 182 68 72 131 196 40 195))
(defvar *idata-pe* '(48 32 0 0 0 0 0 0 0 0 0 0 120 32 0 0 64 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 80 32 0 0 0 0 0 0 89 32 0 0 0 0 0 0 105 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 80 32 0 0 0 0 0 0 89 32 0 0 0 0 0 0 105 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 71 101 116 83 116 100 72 97 110 100 108 101 65 0 0 0 83 101 116 67 111 110 115 111 108 101 77 111 100 101 0 0 0 82 101 97 100 67 111 110 115 111 101 77 111 100 101 0 0 0 82 101 97 100 67 111 110 115 111 108 101 65 0 0 0 71 101 116 67 111 110 115 111 108 101 77 111 100 101 0 0 0 87 114 105 116 101 67 111 110 115 111 108 101 65 0 0 0 83 108 101 101 112 0 0 0 69 120 105 116 80 114 111 99 101 115 115 0 107 101 114 110 101 108 51 50 46 100 108 108 0))
(defun enable-raw-mode-windows ()
(with-open-file (stream "raw-mode.exe")
:direction :output
:if-exists :supersede
:if-does-not-exist :create
:element-type '(unsigned-byte 8)
(write-sequence *header-pe* stream)
(dotimes (i 552)
(write-byte 0 stream))
(write-sequence *text-raw-mode* stream)
(dotimes (i 444)
(write-byte 0 stream))
(write-sequence *idata-pe* stream)
(finish-output stream))
(let ((path (uiop:native-namestring (merge-pathnames "raw-mode.exe"))))
(uiop:run-program path))
(defun disable-raw-mode-windows ()
(with-open-file (stream "cooked-mode.exe")
:direction :output
:if-exists :supersede
:if-does-not-exist :create
:element-type '(unsigned-byte 8)
(write-sequence *header-pe* stream)
(dotimes (i 552)
(write-byte 0 stream))
(write-sequence *text-cooked-mode* stream)
(dotimes (i 444)
(write-byte 0 stream))
(write-sequence *idata-pe* stream))
(let ((other-path (uiop:native-namestring (merge-pathnames "cooked-mode.exe"))))
(uiop:run-program other-path)
(uiop:delete-file-if-exists path)
(uiop:terminate-process other-path)
(uiop:delete-file-if-exists other-path))))