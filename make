#!/usr/bin/env racket
#lang racket/base

(require
  racket/system
  racket/string
  racket/function
  command-tree)

(define dependencies
  (list "anaphoric"))

(define (call command . args)
  (system (apply format (cons command args)) #:set-pwd? #t))

(command-tree
  `([install ,(thunk (call "raco pkg install --auto --skip-installed ~a" (string-join dependencies)))]
    [dev     ,(thunk (call "/usr/bin/env DEBUG=true racket ./server.rkt"))]
    [run     ,(thunk (call "racket ./server.rkt"))]
    [test    ,(thunk (call "raco test ./tests/test-all.rkt"))])
  (current-command-line-arguments))