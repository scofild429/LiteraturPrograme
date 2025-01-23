root
====

S-express can be atmo or list car : get the first S-express cdr : get
the rest list cons : need a S-express and a list : put the first
S-express into the second list (null? l) if l is null? (atom? l) if l is
atmo? (member? ele list) (rember ele list)

command
=======

execute
-------

  ---------- ---------------------------
  command    explain
  C-c C-e    result in minibuffer
  C-j        result under the cursor
  M-x ielm   in elisp interactive mode
             
  ---------- ---------------------------

List
====

``` {.elisp}
(concat "abd" "def")
(+ 34 9)

(substring "0123456789" 2 8)

(setq Emacs 'My-favour)

(message "Am today %s I start to learn emacs %d " "niaho" 09)
;"Am today niaho I start to learn emacs 9 "
(message "He saw %d %s"
(- fill-column 32)
(concat "red "
(substring
"The quick brown foxes jumped." 16 21)
" leaping."))
;"He saw 38 red foxes leaping."
(setq trees '(pine fir oak maple)
           herbivores '(gazelle antelope zebra))

```

Evaluation
==========

``` {.elisp}
(buffer-file-name)
(setq a 300)
(* 34 67 45
```

)

Buffer
======

``` {.elisp}
(buffer-name)

(current-buffer)

(other-buffer)

(switch-to-buffer (other-buffer))

(buffer-size)

(point)

(point-min)

(point-max)

(defun multipy-by-seven (number)
"Multipy NUMBER by seven"
(* 7 number))

(multipy-by-seven 4)

(defun multipy-by-seven (number))

(interactive "p")

(message "the result is %d" (* 7 number))
```

let and let \*
==============

let define the local variable

``` {.commonlisp org-language="emacs-lisp"}
(defun circle-area (radix)
  (let ((pi 3.1415926)
        area)
    (setq area (* pi radix radix))
    (message "直径为 %.2f 的圆面积是 %.2f" radix area)
    ))
(circle-area 5)

```

let\* define local variable, which can be immediately used

``` {.commonlisp org-language="emacs-lisp"}
(defun circle-eara (radix)
  (let* ((pi 3.1415926)
         (area (pi*radix*radix))))
    (message "直径为 %.2f 的圆面积是 %.2f" radix area))
(circle-area 6)
```

Special Form
============

### defun

(defun name-of-function (argument-list) \"documentation...\" body...)

### let

(let ((zebra \"stripes\") (tiger \"fierce\")) (message \"One kind of
animal has %s and another is %s.\" zebra tiger))

### if

``` {.commonlisp org-language="emacs-lisp"}
(defun my-max (a b)
  (if ( > a b)
    (message "aaaaa")
    (message "bbbbb")
    ))
(my-max 3 0)  
```

(if true-or-false-test action-to-carry-out-if-the-test-returns-true)

### if-then

(if true-or-false-test action-to-carry-out-if-the-test-returns-true
action-to-carry-out-if-the-test-returns-false)

(if 4 \'true \'false)

(if nil \'true \'false)

### save-excursion

(message \"We are %d characters into this buffer.\" (save-excursion (-
(point) (goto-char (point-min)) (point))))

2-36 arbitrary base
===================

``` {.commonlisp org-language="emacs-lisp"}
#36re
#36r1
#36ra
#36ru
#36rk
```

code
====

char count

``` {.commonlisp org-language="emacs-lisp"}
(defun cheap-count-words()
  (interactive)
  (let ((words 0))
    (goto-char (point-min))
    (while (forward-word)
      (setq words (1+ words)))
    (message (format "Words is Buffer : %s" words))
    words)
  )

```

Emacs lisp programm
===================

file management
---------------

read file :: insert-file-contents and copy file :: write-region

``` {.commonlisp org-language="emacs-lisp"}
;;read file and print out
(defun read-file-as-lines (file-path)
  (with-temp-buffer
    (insert-file-contents file-path)
    (split-string (buffer-string) "\n" t)))

(read-file-as-lines "~/Desktop/110.py")

;;read file and copy to another
(defun copy-file-to-file (fromfile tofile)
  (with-temp-buffer
    (insert-file-contents fromfile)
    (setq copy-test-path tofile)
    (write-region (point-min) (point-max) copy-test-path)
    (write-region "new  content" nil copy-test-path t)))

(copy-file-to-file "~/Desktop/110.py" "~/Desktop/112.py")




```

Function in orgmode
===================

``` {.commonlisp org-language="emacs-lisp"}
(+ 45 65)
```

``` {.commonlisp org-language="emacs-lisp"}
(defun do-some-math(x y)
  (* (+ x 20)
     (- y 10) ) )
```

``` {.commonlisp org-language="emacs-lisp"}
(defun multipy-many  (x &rest operands)
  (dolist (operand operands) 
    (when operand 
      (setq x (* x operand)))) x)
```

interactive function als commands

``` {.commonlisp org-language="emacs-lisp"}
(defun my-first-command()
(interactive)
(message "Hey , it works") )

```
