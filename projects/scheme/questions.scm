(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.
(define (map proc items)
  (cond
    ((null? items) nil)
    (else
      (cons (proc (car items)) (map proc (cdr items)))
    )
  )
)


(define (cons-all first rests)
  (cond
    ((null? rests) rests)
    (else
      (cons (append (list first) (car rests)) (cons-all first (cdr rests)))
    )
  )
)

(define (zip pairs)
  (list(map car pairs) (map cadr pairs))
)

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  (define (helper x result s)
    (cond
      ((null? s) result)
      (else (helper (+ x 1) (append result (cons (cons (+ x 1) (cons (car s) nil)) nil)) (cdr s)))
      )
    )
    (if (null? s) nil
      (helper 0 (cons (cons 0 (cons (car s) nil)) nil) (cdr s)))
  )
  ; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  (cond
    ((equal? total 0) (list nil))
    ((null? denoms) nil)
    ((> (car denoms) total) (list-change total (cdr denoms)))
    (else 
      (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms))
      (list-change total (cdr denoms)))
    )
  )
)
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (cons form (cons params (map let-to-lambda body)))
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (define params (car (zip values)))
           (define expressions (map let-to-lambda (cadr (zip values))))
           (define lam (cons 'lambda (cons params (map let-to-lambda body))))
           (cons lam expressions)
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (map let-to-lambda expr)
         ; END PROBLEM 19
         )))
