; vi:ai:lisp:sm

(define (filter pred lst)
  (cond
    ((null? lst) lst)
    ((pred (car lst)) (cons (car lst) (filter pred (cdr lst))))
    (else (filter pred (cdr lst)))))

(define (quicksort lst)
  (if (null? lst) lst
    (let*
      ((x (car lst))
       (xs (cdr lst))
       (above (lambda (y) (>= y x)))
       (below (lambda (y) (< y x)))
       )
      (append (quicksort (filter below xs))
	      (cons x (quicksort (filter above xs))))))) 

(define (quicksort cmp lst)
  (if (null? lst)
      '()
      (let* ((pivot (car lst))
             (rest (cdr lst))
             (less (filter (lambda (x) (< (cmp x pivot) 0)) rest))
             (equal (filter (lambda (x) (= (cmp x pivot) 0)) rest))
             (greater (filter (lambda (x) (> (cmp x pivot) 0)) rest)))
        (append (quicksort cmp less)
                (list pivot)
                equal
                (quicksort cmp greater)))))