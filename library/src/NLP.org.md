---
title: NLP
---

```{=org}
#+STARTUP: overview
```
# Data process

all input should numerical, categorized character shoud be one-hot
coded, starting with 1

## Tokenizationn

-   **Breaking** text to words (There are many steps to consider )
-   **CountWordFrequencies** (counted key-value dictionary)
    -   list all sorted dictionary
    -   if the list is too big, removing infrequent words(because of
        incorrection, or neame...) good for one-hot coding
-   **encode** to sequences
    -   with counted dictionary index
    -   index length is one-hot coding vector length
-   **one-hot** coding all sequences
    -   if one-hot code vector is not so lang, word embedding is not
        needed

```{=html}
<!-- -->
```
    tests[5] = "this is a cat and a"
    tests_dict = {"this": {1:1}, "is": {2:1}, "a":{3:2}, "cat":{4:1}, "and":{5:1}}
    tests_sequences = [1,2,3,4,3]

## Word Embedding

compose high dimension one-hot vector to low dimension
$$ X_{i}    = P^{T} \cdot e^{i}$$ $e^{i}$ is high dimensional vector
after one-hot coding(v,1) of collected data $P^{T}$ is the parameter
matrix trained by data(d,v), $X_{i}$ is low dimensional vector(d,1), for
further training $d$ : The dimension parameter d is important, can be
vertified with corss validation. Each row of $P$ is called (words
vector词向量), can be interpreted with classification

**Embedding** layer need the number of vocabulary(v), embedding~dim~(d),
and word~num~(cuted words number) v\*d : parameters for this layer

# language model

## skip-gram

## CBOW

continuous bag of words

# text generatation

Encoder: A is RNN layer or LMST layer, all input(x1 to xm) share the
same A, hm is the last result, only give hm to decoder, we can generate
text, but many content of input will be forget

# seq2seq

After one resulte in Decode is generated, With Corss Enteopy to update
the Network, using all the resulte we get, to predict the next resulte
until all is finished consuming the previously generated symbols as
additional input when generating the next.

# Transformer

## simple RNN + attention

Encoder Input E$X = x_{1}, x_{2},,,,x_{m}$ Decoder Input
$X^{'} = x_{1}^{'}, x_{2}^{'},,,,x_m^{'}$ after RNN or LSTM we get
$H = h_{0}, h_{1},,,,,h_{m}$ Now unlike before only pass the last
element $h_{m}$ to Decoder, we use attention skill to mix all input
information

1.  Notion:
    -   Encoder, lower index $i$ stands for the index of input order in
        Encoder
    -   Decoder, high index $j$ stands for the index of generated items
        in Decoder

    $a^{j}_{i}$ stands for the parameter for generate the j-th item
    ($s_j$)in Decoder with respect of the i-th input($x_{i}$) in X.
2.  Variables
    -   Encoder input, $X = x_{1}, x_{2},,,x_{m}$ ,
    -   Encoder shared parameter, A: RNN or LSMT shared parameter
    -   Encoder output , $H: = h_{1}, h_{2},,,h_{m}$ output at each step
        of RNN or LSMT
    -   Decoder initial input $h_{m}$ , denote also as $s^{0}$
    -   key, $q_{i}^{j} = W_{q}^{j} s^{i}$
    -   query $k_{i}^{j} = W_{k}^{j} h_{i}$
    -   Query Martix, $K^{j} = [k_{i}^{j}, k_{2}^{j},,,k_{m}^{j}]$
    -   Encoder Weight $a^{j}_{i}$, $a^{j}_{i} = Softmax(K^{jT} q_{i})$
    -   Eecoder Context Vector,
        $c^{j} = a_{1}^{j}h_{1} + a_{2}^{j}h_{2}+,,,,+a_{m}^{j}h_{m}$
    -   Decoder initial input $h_{m}$ , denote also as $s^{0}$
    -   Decoder output,
        $s^{j} = \tanh(A^{'}\cdot [x^{'j}, s_{j-1}, c_{j-1}]^{T})$
3.  update Network with softmax(c) get the prediciton, and corss enteopy
    update network back($W^{j} -> W^{j+1}$)

## simple RNN + self attention

only Encoder, e$X = x_{1}, x_{2},,,,x_{m}$ Without Decoder and Decoder
input, after RNN or LSTM we get $H = h_{0}, h_{1},,,,,h_{m}$ Now unlike
before only pass the last element $h_{m}$ to Decoder, we use attention
skill to mix all input information

1.  Notion:
    -   Encoder, lower index $i$ stands for the index of input order in
        Encoder
    -   Generation, high index $j$ stands for the index of generated
        items

    $a^{j}_{i}$ stands for the parameter for generate the j-th item
    ($s_j$)in Encoder with respect of the i-th input($x_{i}$) in X.
2.  Variables
    -   Encoder input, $X = x_{1}, x_{2},,,x_{m}$ ,
    -   Encoder shared parameter, A: RNN or LSMT shared parameter
    -   Encoder output , $H: = h_{1}, h_{2},,,h_{m}$ output at each step
        of RNN or LSMT
    -   key, $q_{i}^{j} = W_{q}^{j} h_{i}$
    -   query $k_{i}^{j} = W_{k}^{j} h_{i}$
    -   Query Martix, $K^{j} = [k_{i}^{j}, k_{2}^{j},,,k_{m}^{j}]$
    -   Encoder Weight $a^{j}_{i}$, $a^{j}_{i} = Softmax(K^{jT} q_{i})$
    -   Eecoder Context Vector,
        $c^{j} = a_{1}^{j}h_{1} + a_{2}^{j}h_{2}+,,,,+a_{m}^{j}h_{m}$
3.  update Network
    -   with softmax(c) get the prediciton, and corss enteopy update
        network back($W^{j} -> W^{j+1}$)
4.  Note
    -   attention: key, $q_{i}^{j} = W_{q}^{j} s^{i}$ with
        $s^{j} = \tanh(A^{'}\cdot [x^{'j}, s_{j-1}, c_{j-1}]^{T})$
    -   self attention: key, $q_{i}^{j} = W_{q}^{j} h_{i}$

## attention layer

An attention function can be described as mapping a query and a set of
key-value pairs to an output Encoder Input E$X = x_{1}, x_{2},,,,x_{m}$
Decoder Input $X^{'} = x_{1}^{'}, x_{2}^{'},,,,x_m^{'}$ Removing RNN or
LSMT, only constructing attention layer

1.  Notion:
    -   Encoder, lower index $i$ stands for the index of input order in
        Encoder
    -   Decoder, high index $j$ stands for the index of generated items
        in Decoder

    $a^{j}_{i}$ stands for the parameter for generate the j-th item
    ($s_j$)in Decoder with respect of the i-th input($x_{i}$) in X.
2.  Variables
    -   value, $v_{i}^{j} = W_{v}^{j} x_{i}$
    -   query $k_{i}^{j} = W_{k}^{j} x_{i}$
    -   key, $q_{i}^{j} = W_{q}^{j} x_{'i}$
    -   Query Martix, $K^{j} = [k_{i}^{j}, k_{2}^{j},,,k_{m}^{j}]$
    -   Encoder Weight $a^{j}_{i}$, $a^{j}_{i} = Softmax(K^{jT} q_{i})$
    -   Eecoder Context Vector,
        $c^{j} = a_{1}^{j}v_{1}^{j} + a_{2}^{j}v_{2}^{j}+,,,,+a_{m}^{j}v_{m}^{j}$
3.  update Network
    -   with softmax(c) get the prediciton, and corss enteopy update
        network back($W^{j} -> W^{j+1}$)
4.  Note
    -   X replace H, but still seq2seq model(with X\')

## self attention layer

only Encoder, e$X = x_{1}, x_{2},,,,x_{m}$ Without Decoder and Decoder
input,

1.  Notion:
    -   Encoder, lower index $i$ stands for the index of input order in
        Encoder
    -   Generation, high index $j$ stands for the index of generated
        items

    $a^{j}_{i}$ stands for the parameter for generate the j-th item
    ($s_j$)in Encoder with respect of the i-th input($x_{i}$) in X.
2.  Variables
    -   Encoder input, $X = x_{1}, x_{2},,,x_{m}$ ,
    -   value, $v_{i}^{j} = W_{v}^{j} x_{i}$
    -   key, $q_{i}^{j} = W_{q}^{j} x_{i}$
    -   query $k_{i}^{j} = W_{k}^{j} x_{i}$
    -   Query Martix, $K^{j} = [k_{i}^{j}, k_{2}^{j},,,k_{m}^{j}]$
    -   Encoder Weight $a^{j}_{i}$, $a^{j}_{i} = Softmax(K^{jT} q_{i})$
    -   Eecoder Context Vector,
        $c^{j} = a_{1}^{j}v_{1}^{j} + a_{2}^{j}v_{2}^{j}+,,,,+a_{m}^{j}v_{m}^{j}$
3.  update Network with softmax(c) get the prediciton, and corss enteopy
    update network back($W^{j} -> W^{j+1}$)
4.  Note
    -   in query $k_{i}^{j} = W_{k}^{j} x_{i}$, it\'s X , not X\'

## transformer model

``` {.ditaa file="foto/RNN_attention.png"}
  /--+--\    /-----\    /-----\    /-----\   
  |a_1  |    |a_2  |    |a_3  |    |a_m  |  
  |     |    |     |    |     |    |     |
  \-----/    \-----/    \-----/    \-----/

+-------------------------------------------+
|cBLU                                       |
|Encoder                                    |
|    h1         h2         h3        hm     |
| +------+   +-----+    +-----+   +-----+   |
| |      |   |     |    |     |   |     |   |>------\
| | A    |   | A   |    | A   |   | A   |   |       |
| +--+---+   +--+--+    +--+--+   +---+-+   |       |
|    ^          ^          ^          ^     |       |
+----+----------+----------+----------+-----+       |
     |          |          |          |             |
  /--+--\    /-----\    /-----\    /-----\          |
  |X_1  |    |X_2  |    |X_3  |    |X_m  |          |
  |     |    |     |    |     |    |     |          |
  \-----/    \-----/    \-----/    \-----/          |
                                                    |        /--+--\    /-----\    /-----\    /-----\       
                                                    |        |c_1  |    |c_2  |    |c_3  |    |c_m  |  
                                                    |        |s_1  |    |s_2  |    |s_3  |    |s_m  |
                                                    |        \-----/    \-----/    \-----/    \-----/
                                                    |
                                                    |        +-------------------------------------------+
                                                    |        | c1AB                                      |
                                                    \------->| Decoder                                   |
                                                             | +------+   +-----+    +-----+   +-----+   |
                                                             | |      |   |     |    |     |   |     |   |
                                                             | | A'   |   | A'  |    | A'  |   | A'  |   |
                                                             | +--+---+   +--+--+    +--+--+   +---+-+   |
                                                             |    ^          ^          ^          ^     |
                                                             +----+----------+----------+----------+-----+
                                                                  |          |          |          |  
                                                               /--+--\    /-----\    /-----\    /-----\ 
                                                               |X'1  |    |X'2  |    |X'3  |    |X'm  |  
                                                               |     |    |     |    |     |    |     |
                                                               \-----/    \-----/    \-----/    \-----/

```

# Bert

# ViT
