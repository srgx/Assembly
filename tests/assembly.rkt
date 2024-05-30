#lang typed/racket

(: to-x (-> Char (-> Integer Integer Integer) Integer Char))
(define (to-x l f v)
  (integer->char (f (char->integer l) v)))

(: to-lower (-> Char Char))
(define (to-lower l)
  (to-x l bitwise-ior #x20))

(: to-upper (-> Char Char))
(define (to-upper l)
  (to-x l bitwise-and #xdf))

(: string-to-int (-> String Integer))
(define (string-to-int s)
  (chars-to-int (string->list s) 0))

(: chars-to-int (-> (Listof Char) Integer Integer))
(define (chars-to-int l acc)
  (if (empty? l)
      acc
      (chars-to-int
        (rest l)
        (+ (* acc 10)
           (bitwise-and (char->integer (first l)) #xf)))))

(: to-date (-> Integer Integer Integer Integer))
(define (to-date m d y)
  (bitwise-ior
    (arithmetic-shift m 12)
    (arithmetic-shift d 7)
    (- y 1900)))

(: extract-month (-> Integer Integer))
(define (extract-month d)
  (arithmetic-shift d -12))

(: extract-year (-> Integer Integer))
(define (extract-year d)
  (+ 1900 (bitwise-and d #x7f)))

(: extract-day (-> Integer Integer))
(define (extract-day d)
  (bitwise-and
    (arithmetic-shift d -7)
     #x1f))

(: cnt-bits (-> Integer Integer))
(define (cnt-bits n)
  (local
    ((: h (-> Integer Integer Integer))
     (define (h n m)
       (if (zero? m)
           0
           (+ (if (= m (bitwise-and n m)) 1 0)
              (h n (arithmetic-shift m -1))))))
  (h n #x8000)))

(: test-bit (-> Integer Integer Boolean))
(define (test-bit n s)
  (and (= s (bitwise-and s #xf))
       (let ((m (arithmetic-shift 1 s)))
         (= m (bitwise-and m n)))))

(: rol (-> Integer Integer))
(define (rol n)
  (bitwise-ior
    (bitwise-and (arithmetic-shift n 1) #xff)
    (if (= #x80 (bitwise-and #x80 n)) 1 0)))

(: ror (-> Integer Integer))
(define (ror n)
  (bitwise-ior
    (arithmetic-shift n -1)
    (if (= 1 (bitwise-and 1 n)) #x80 0)))

(and (equal? '(0 1 2 10 16) (map cnt-bits '(0 1 5 #xcdcd #xffff)))
     (equal? (list (to-lower #\a) (to-lower #\A)
                   (to-upper #\a) (to-upper #\A))
             '(#\a #\a #\A #\A))
     (equal? (list (string-to-int "123") (string-to-int "512"))
             '(123 512))
     (let* ((m 2) (d 14) (y 1980) (date (to-date m d y)))
       (equal? (list (extract-month date)
                     (extract-day date)
                     (extract-year date))
               (list m d y)))
     (equal? (let* ((n #xabcd) (bits 16) (mindex (sub1 bits)))
               (for/list : (Listof Integer) ([i bits])
                 (if (test-bit n (- mindex i)) 1 0)))
             '(1 0 1 0 1 0 1 1 1 1 0 0 1 1 0 1))
     (equal? (list (rol 0) (rol 2) (rol 128) (rol 148) (rol 255)
                   (ror 0) (ror 4) (ror 1) (ror 41) (ror 255))
             '(0 4 1 41 255 0 2 128 148 255)))

