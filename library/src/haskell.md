commands
========

in file.hs
----------

C-c C-l to execute file.hs and go to interactive environment Seeing
./black.hs

C-c C-c call in src
-------------------

``` {.haskell results="value"}
log2 :: Float -> Float
  log2 = logBase 2
  log2 43

```

with :results value :eval (inferior-haskell-start-process)

in src can multi functions be defined. and the last call will be printed

with follow extension, can be easy C-c C-c executed, but not in send to
haskell log file, but only output the last result

Seeing Literatur Programm Grundlage

send to haskell/org-src-block
-----------------------------

``` {.haskell results="value"}
log2 :: Float -> Float
  log2 = logBase 2
  log2 43

```

\#+end~src~

first to load file. \~/.emacs.d/packages/orgmode-babal-haskell.el in one
of src block M-x : send to haskell/org-src-block

in src block without any extension can be load in send buffer(after
~src~ haskell), and the be called function can be many type.

important : in src block the calling syntax is NOT allowed

Seeing Literatur Programm Alternativen

Functional Programm
===================

Grundlage
---------

basic function call

``` {.haskell results="value"}
log2 :: Float -> Float
  log2 = logBase 2
  log2 43

```

implication

``` {.haskell results="value"}
(==>):: Bool -> Bool -> Bool
a ==> b = not a || not b
Flase ==> True
False==> False
True ==> True

```

--euler numbers

``` {.haskell results="value"}
e:: Float
e = exp 1
e 
```

Pattern Matching
----------------

one of the calling must match one case of pattern

``` {.haskell}
(<#>) :: Bool -> Bool -> Bool
  (<#>) False False = False
  (<#>) False True = True
  (<#>) True False = True
  (<#>) True True = True


True <#> True
```

``` {.haskell results="value"}
(<#>) :: Bool -> Bool -> Bool
  (<#>) True True = True
  (<#>) _ _ = False

(<#>) True True
(<#>) False True

```

``` {.haskell}
(<#>) :: Bool -> Bool -> Bool
  (<#>) True True 

```

case : this can only be executed in a .hs file, in orgmode can NOT be
imported, I don\'t know what is going on in Terminal can NOT also

Here I made above mistake, this is no sense. so long the indentation is
correct, so works

``` {.haskell}
(<#>) :: Bool -> Bool -> Bool
(<#>) a b
  | a == b = False
  | otherwise = True


```

Alternativen
------------

if else then

``` {.haskell}
absolute :: Int -> Int
absolute x = if x < 0 then -x else x

```

Recursion
---------

easy fib

``` {.haskell}
heronA ::(Int, Double) -> Double
heronA (n,a)
  | n > 0     = (heronA(n-1,a) + a/heronA(n-1, a))/2
  | otherwise = a

absolute :: Int -> Int
absolute x = if x < 0 then -x else x

heronB :: Int -> Double -> Double
heronB n a
  | n > 0     = (heronB (n-1) a + a/heronB(n-1) a)/2
  | otherwise = a

```

where

``` {.haskell}
heronC :: Int -> Double -> Double
heronC n a
  |n > 0      = (x + a/x)/2
  |otherwise  = a
  where x = heronC (n-1) a
```

fib & where

``` {.haskell}
fibA :: Int -> Int
fibA n
  |n == 0    = 0
  |n == 1    = 1
  |otherwise = x +y
  where
    x = fibA (n-1)
    y = fibA (n-2)

```

fib & where & pattern matching

``` {.haskell}
fibB :: Int -> Int
fibB 0 = 0
fibB 1 = 1
fibB n = fibB (n-1) + fibB (n-2)


fibC :: Int -> Int
fibC 0 = 0
fibC 1 = 1
fibC n
  | n < 0      = error "illegal arguement"
  | otherwise  = fibB (n-1) + fibB (n-2)


(<##>) :: Int -> Double -> Double
0 <##> a   = a
n <##> a  
  | n > 0  = (x + a/x)/2
  | otherwise  = error "illegal arguement"
  where x = (n-1) <##> a
```

Type conversion1
----------------

Guides

``` {.haskell}
vielleichtdreifach :: Bool -> Bool -> Integer -> Integer
vielleichtdreifach verdreifach nochmal n
  | verdreifach && nochmal = maldrei ( maldrei n)
  | verdreifach            = maldrei n
  | otherwise              = n
  where maldrei n = 3*n 

dreifach :: Integer -> Integer
dreifach = vielleichtdreifach True False 

neudreifach :: Integer -> Integer
neudreifach = vielleichtdreifach True True

```

vielleichtdreifach Bool Bool -\> Integer

Factorial
---------

``` {.haskell}
fac :: Integer -> Integer
fac n
  | n == 0  = 1
  | otherwise = fac (n-1) * n
```

Stern Brocot Floge
------------------

$\\s_{0} = 0 \\ s_{1} = 1 \\ s_{2n} = s_{n} \\ s_{2n+1} = s_{n} + s_{n+1}$

``` {.haskell}
(*/*) :: Integer -> Integer -> Integer
(*/*) = div

(*%*) :: Integer -> Integer -> Integer
(*%*) = rem

sternBrocot :: Integer -> Integer
sternBrocot n
  | n == 0      = 0
  | n == 1      = 1
  | n *%* 2 == 0 = sternBrocot half
  | otherwise    = sternBrocot half + sternBrocot (half + 1)
  where half = n */* 2

suche :: Integer -> Integer -> Integer
suche suchziel postionziel
  | sternBrocot postionziel > suchziel = postionziel
  | otherwise                          = suche suchziel (postionziel +1)

```

List
====

字符串就是单一字符的列表

List add
--------

in prelude

``` {.haskell}
[1,2,3] ++ [3,4,5]
2 : [3,4]
```

Symbol
======

需要时刻谨记是用 . 来做函数组合的，\$ 是用来降低函数执行优先级的。

Functional Programm of Haskell
==============================

Grundlage
---------

basic function call

``` {.haskell results="value"}
  log2 :: Float -> Float
  log2 = logBase 2
log2 43

```

implication

``` {.haskell results="value"}
(==>):: Bool -> Bool -> Bool
a ==> b = not a || not b
Flase ==> True
False==> False
True ==> True

```

--euler numbers

``` {.haskell results="value"}
  e:: Float
    e = exp 1
e 
```

Pattern Matching
----------------

one of the calling must match one case of pattern

``` {.haskell}
(<#>) :: Bool -> Bool -> Bool
  (<#>) False False = False
  (<#>) False True = True
  (<#>) True False = True
  (<#>) True True = True


True <#> True
```

``` {.haskell results="value"}
(<#>) :: Bool -> Bool -> Bool
  (<#>) True True = True
  (<#>) _ _ = False

(<#>) True True
(<#>) False True

```

``` {.haskell}
(<#>) :: Bool -> Bool -> Bool
  (<#>) True True = True

```

case : this can only be executed in a .hs file, in orgmode can NOT be
imported, I don\'t know what is going on in Terminal can NOT also

Here I made above mistake, this is no sense. so long the indentation is
correct, so works

``` {.haskell}
(<#>) :: Bool -> Bool -> Bool
(<#>) a b
  | a == b = False
  | otherwise = True


```

Alternativen
------------

if else then

``` {.haskell}
absolute :: Int -> Int
absolute x = if x < 0 then -x else x

```

Recursion
---------

easy fib

``` {.haskell}
heronA ::(Int, Double) -> Double
heronA (n,a)
  | n > 0     = (heronA(n-1,a) + a/heronA(n-1, a))/2
  | otherwise = a

absolute :: Int -> Int
absolute x = if x < 0 then -x else x

heronB :: Int -> Double -> Double
heronB n a
  | n > 0     = (heronB (n-1) a + a/heronB(n-1) a)/2
  | otherwise = a

```

where

``` {.haskell}
heronC :: Int -> Double -> Double
heronC n a
  |n > 0      = (x + a/x)/2
  |otherwise  = a
  where x = heronC (n-1) a
```

fib & where

``` {.haskell}
fibA :: Int -> Int
fibA n
  |n == 0    = 0
  |n == 1    = 1
  |otherwise = x +y
  where
    x = fibA (n-1)
    y = fibA (n-2)

```

fib & where & pattern matching

``` {.haskell}
fibB :: Int -> Int
fibB 0 = 0
fibB 1 = 1
fibB n = fibB (n-1) + fibB (n-2)


fibC :: Int -> Int
fibC 0 = 0
fibC 1 = 1
fibC n
  | n < 0      = error "illegal arguement"
  | otherwise  = fibB (n-1) + fibB (n-2)


(<##>) :: Int -> Double -> Double
0 <##> a   = a
n <##> a  
  | n > 0  = (x + a/x)/2
  | otherwise  = error "illegal arguement"
  where x = (n-1) <##> a
```

type conversion
---------------

Guides

``` {.haskell}
vielleichtdreifach :: Bool -> Bool -> Integer -> Integer
vielleichtdreifach verdreifach nochmal n
  | verdreifach && nochmal = maldrei ( maldrei n)
  | verdreifach            = maldrei n
  | otherwise              = n
  where maldrei n = 3*n 

dreifach :: Integer -> Integer
dreifach = vielleichtdreifach True False 

neudreifach :: Integer -> Integer
neudreifach = vielleichtdreifach True True

```

vielleichtdreifach Bool Bool -\> Integer

Factorial
---------

``` {.haskell}
fac :: Integer -> Integer
fac n
  | n == 0  = 1
  | otherwise = fac (n-1) * n
```

Stern Brocot Floge
------------------

$\\s_{0} = 0 \\ s_{1} = 1 \\ s_{2n} = s_{n} \\ s_{2n+1} = s_{n} + s_{n+1}$

``` {.haskell}
(*/*) :: Integer -> Integer -> Integer
(*/*) = div

(*%*) :: Integer -> Integer -> Integer
(*%*) = rem

sternBrocot :: Integer -> Integer
sternBrocot n
  | n == 0      = 0
  | n == 1      = 1
  | n *%* 2 == 0 = sternBrocot half
  | otherwise    = sternBrocot half + sternBrocot (half + 1)
  where half = n */* 2

suche :: Integer -> Integer -> Integer
suche suchziel postionziel
  | sternBrocot postionziel > suchziel = postionziel
  | otherwise                          = suche suchziel (postionziel +1)

```
