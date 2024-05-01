---
title: DeepLearning
---

```{=org}
#+STARTUP: overview
```
# Batch Size Problem

## Batch Gradient descent

-   all data as input once
-   loss graph is quite smooth
-   need great calculation power

## Stochastic gradient descent

-   input each time only one data sample
-   cost will fluctuate over the training
-   fast update the weights

## mini-batch gradient descent

-   only a subset of all data points in each

### big batch size

Advantages: the descension of weights has a more accuary direction, less
oscillation. Disadvantages: memery explotion, and fall into locally
minimum

### small batch size

Advantages: more times weights update, more chance to overcome locally
minimum, Disadvantages: difficult to convergence

# Learning rate

  ----------- ---------------------------------------
  too small   converge slowly or find local minimum
  too large   oscillation or divergence
  ----------- ---------------------------------------

## Second order optimizer

## SGD with momentum

## learning rate decay

# Pytorch

automatic differentiation

# Regularization

# Multi-layer perceptrons

## Perceptron

**Universal Approximation Theorem** Perceptrons solves linearly
separable problem One hidden layer is enough to approximate any
continuons funtion, to an arbitrary degree of accuracy

**Perceptron Learning Algorithm(PLA)**: $\omega \gets 0$ Iterate over
training examples until convergence $\hat{y}^{i} \gets \omega^{T} x^i$
$e \gets y^{i}-\hat{y}^{i}$ $\omega \gets \omega + e \cdot x^i$

## Gradient Descent

## Advance gradient descent

Gradient-based optimization does neither always find the absolute
minimum, nor does it find the optimal direction

### Second-order optimizers

Theorical besser performance, but generally too expensive and not work
with minibatches

### SGD with momentum

$$ w \gets w - v$$ $$ v \gets \beta v + \eta\nabla_{w}L$$
$$ \beta \in [0, 1]$$

  ----------- ---------------------------------------------
  too small   get stuck in local minimum or saddle points
  too large   overshoot optimum or spiral around it
  ----------- ---------------------------------------------

### AdaGrad

adaptive gradient algorithm(DL~03MLP~.pdf/12 )

### RMSProp

root mean square propagation(DL~03MLP~.pdf/13 )

### Adam

## Regularization of MLP

## Dropout

## Early stop

## Active funtion

Sigmoids vanish for large postive and negative inputs Rectified Linear
Unit(ReLu) LeakyReLU Exponential linear unit Absolute value activation

# Babysitting training neural network

-   check initial loss make sense
-   overfit training model to 100% accuracy of small samples, such as
    few minibatches
    -   adjust the initialization and learning rate
-   find the learning rate, which reduce loss significantly
-   rough train few epochs with learning rate nearby from previous step
-   use the best options from previous step, training longer
-   watch out the loss curves
    -   if learning rate decay needed
    -   accuracy of train vs validation, overfit, underfit, go back to
        step 5
-   Early strop Idea: Stop training when generalization error increases

# Hyperparameter search

-   grid search and random search
-   Multipy learning rate by N where you increase the batchsize by
    factor of N

# Data Augmentation

-   data artifacts
    -   flips
    -   crops and scales
    -   randomize color
    -   rotate
-   advance data augmentation
    -   Mixup: take linear combination of input and target of two
        training samples
    -   CutMit: mix patches of the two input, Target is linear
        combination with weight according to patch ratio

# CNN

Modern CNN architectures tend to use strided convolutions instead of max
pooling.

## Output size

valid: $M=\lfloor  \frac{N - k}{s} \rfloor +1$ padding:
$M=\lfloor \frac{N  - k +2p}{s} \rfloor+1$ N: input size M: output size
p: padding k: kernel size s: stride size

## Receptive field

$$RF = 1 + \sum^{L}_{l=1}(k_{l}-1)*s $$
$$ RF_{i} = (RF_{i+1} -1)*s + k $$

From where I want to calcalete to the input layer. and set the current
calcalete layer\'s RF as 1

## Zero Padding

  ------- ----------------- ---------------------
  valid   without padding   shape reduce k-1
  same    with padding      shape stay the same
  ------- ----------------- ---------------------

## pooling

  ----------------- -------------------------------------
  max pooling       only chose the maximum one of block
  average pooling   use the average of block
  ----------------- -------------------------------------

## Feather abstact

The layer can extract image features, and finally determine the
convolution kernel parameters through backpropagation to obtain the
final features

## Normalization

For Vanishing/exploding gradients: each example in layer all data are
normalized $$ \mu = \frac{1}{N} \sum_{i=1} ^{N} x_{i, j}$$

$$ \sigma_{j}^{2} = \frac{1}{N} \sum_{i=1}^{n} (x_{i, j} - \mu_{j})^{2}$$

$$\hat{x}_{i,j} = \frac{x_{i, j} - \mu_{j}}{\sqrt{\sigma_{j}^{2} + \epsilon}} $$

$$ y_{i, j} = \gamma_{j}\hat{x}_{i, j} + \beta_{j}$$

-   Batch Normalization norm each channel
-   Layer Normalization norm each sample
-   Instance Normalization norm each sample and each channel
-   Group Normalization norm multi channel and sample

## regular convolution

## Depthwise separable convolution

-   Depthwise Convolution: channel-wise
-   Pointwise Convolution: 1\*1 convolution

## learning rate decay

dacay schudle

## Linear Warmup

small learing rate increase very fast, and decay slowly can deal with
bad initialization

## Modul ensembling

-   training N model, and take the averate
-   take N snapshots of training

# ResNet

Vanishing gradient and exploding gradient

# GAN (Generative Adersarial models)

**Implicit density**

## step 1 Generater stay, Discriminater update

-   randomly initialization of G and D
-   inputs (Distribution: ${z_{1}, z_{2}, z_{3}, z_{4}... } : Z$) from
    known distribution to G get rough outputs (Distribution:
    ${z^{'}_{1}, z^{'}_{2}, z^{'}_{3}, z^{'}_{4}... } : Z^{'}$)
-   rough outputs and real image (Examples:
    ${x_{1}, x_{2}, x_{3}, x_{4}.....  } : X$) feed to D
-   training D to classify them with mark, and update D Max
    $V = \frac{1}{m} \sum^{m}_{i=1} log D(X)$ to 1 Min
    $V = \frac{1}{m} \sum^{m}_{i=1} log D(G(Z))$ to 0, so
    $$max_{d}[E_{x\backsim data} \log D_{d}(x) + E_{z \backsim p(z)} \log (1-D_{d}(G_{g}(z)))]$$

## step 2 Discriminater stay, Generater update

-   fix D, feed new inputs from known distribution to G

-   get rough outputs again, and pass them to D, and evaluated with mark

-   training G, for getting better mark

    max
    $V = \frac{1}{m} \sum^{m}_{i=1} log D(G(Z)) = \frac{1}{m} \sum^{m}_{i=1} log D(Z')$
    to 1, so $$min_{g}[E_{z \backsim p(z)} \log (1-D_{d}(G_{g}(z)))]$$

    Just like training normal neural network with minimum cross enteopy

## summary

$$min_{g}max_{d}[E_{x\backsim data} \log D_{d}(x) + E_{z \backsim p(z)} \log (1-D_{d}(G_{g}(z)))]$$

# Autoencoder

input data $\to$ Feathers $\to$ predicted labels predicted labels +
Classifier $\to$ loss function

# VAE (Variational Autoencoders)

**optimizes variational lower bound on likelihood** **Approximate
density search the latent implimentation, reduce the dimensionality to
capture meaningful factors in data** x: examples z: latent parameters
$$p_{\theta}(x)  = \int p_{\theta}(z)p_{\theta}(x|z)dz$$, simple
gaussian prior, encoder neural network
$\log p(x) = \log \frac{p(x|z)p(z)}{p(z|x)}$
$\log p(x) = E_{x\backsim p(x|z)} logp(z|x) - KL[q(z|x)||p(z)] + KL[q(z|x)||p(z|x)]$

-   decoder network
-   KL term between gaussian encoder and z latent. make approximate
    posterior distribution close to prior.
-   mostly similarity between q and p, KL\[q(z\|x)\|\|p(z\|x)\], bigger
    than 0, so maxmized data likelihood $\log p(x)$ can only have a
    lower bound value

Intractability of p(x), because We want $p(z|x)$, but it\'s too
difficult, so we use $q(z|x)$ as approximation:

$$KL[q(z|x)||p(z|x)]$$
$$= \int q(z|x) \cdot \log\frac{q(z|x)}{p(z|x)} dz$$
$$ = \int q(z|x) \cdot \log\frac{q(z|x) p(x)}{p(x|z)p(z)}dz$$
$$ = \int q(z|x) \cdot \log q(z|x)dz  + \int q(z|x)\cdot \log p(x)dz - \int q(z|x) \cdot \log p(x|z) dz -\int q(z|x) \cdot \log p(x)dz$$
$$= log p(x) + KL[q(z|x)||p(z)] - E_{x\backsim p(x|z)} logp(z|x)$$

We randomly example the z from the normal Gaussian for VAE

# PixelCNN (Autoregressive models)

**Explicit density, optimizes exact likelihood** exact likelihood(chain
rule), and training slowly maxmize likelihood
$$p(x) = \prod_{i=1}^{n} p(x_{i}|x_{1}, x_{2}, x_{3},...x_{i-1})$$ Mask
converlutions: kernel filter pixel in the future are set to be 0

# Diffusion Model

image to noise : forward process noise to image : backward process

# RNN

this is many to one, $$h(t) = \tanh(A * [h(t-1), x(t)]^{T})$$
A\[shape(h), shap(h)+shap(x)\] is shared by all step there is no big
difference for prediction with only h(t) or conta(h(1), h(t))

# LSTM

many gate, output elementweise product Stacked, Bedirection

-   Forget Gate:
    $f_t = \sigma(W_f \cdot \begin{bmatrix} h_{t-1} \\ x_t \end{bmatrix} )$

-   Input Gate:
    $i_t = \sigma(W_i \cdot \begin{bmatrix} h_{t-1} \\ x_t \end{bmatrix} )$

-   New Value:
    $n_t = \tanh(W_n \cdot \begin{bmatrix} h_{t-1} \\ x_t \end{bmatrix} )$

-   Output Gate:
    $o_t = \sigma(W_o \cdot \begin{bmatrix} h_{t-1} \\ x_t \end{bmatrix} )$

-   input of C : $C_t = f_t \otimes C_{t-1} + i_t \otimes n_t$

-   output of C : $h_t = o_t \otimes \tanh(C_t)$

# Semi-supervised learning

train model jointly on labeled and unlabled data
$$L = L_{S} + \mu(t)L_{\mu}$$ supervised loss, time dependent
weight\*unsupervised loss($L_{\mu}$)

## consistentcy loss SSL

consider the consistency loss on all examples between Student model and
Teacher model.

1.  training the student model with labeled data as usual,
2.  difference augmented view methodes(scala, rotate...) applying on
    each unlabled data.
3.  passing augmented views(x\', x\'\') of the same data(x) to student
    and teacher model
4.  minimizing the consistency loss of both output
    $L_{\mu} = ||f(x') -g(x'')||^{2}$.
5.  updating weight of teacher model,
    $\Theta'_{t} = \alpha \Theta''_{t-1} + (1-\alpha)\Theta_{t}$

## Pseudo-label based SSL

1.  training Teacher model with labeled data as usual
2.  using well trianed teacher model to predict unlabled data
3.  taking over the confident prediciton(threshold) lable as new labeled
    data
4.  training student model with original and new label data
5.  passing the student model weights to teacher model, and predict all
    data again

# Weakly-supervised learing

use simple and cheaper labels for training

-   Classification: hashtags
-   Object detection: images tags
-   Semantic Segmentation: scribble annotations

# Self-supervised learing

pre-training unsupervised model with large unlabled data, then fineturn
it with small label dataset

## Colorization

Reference Frame $f_{i}$, color $c_{i}$, Target Frame $f_{j}$, predect
color $y_{j}$.
$$A_{ij} = \frac{exp(f_{i}^{T}f_{j})}{\sum_{k}exp(f_{k}^{T}f_{j})}, y_{j}=\sum_{i}A_{ij}c_{i}$$

## Context Prediciton

picture divied into patches, predict the relative position of patches.

-   Gap between batches, jitter location of patches
-   Chromatic abberation, predict the absolute position of patches

# Contrastive Learning

## Contrastive Predictive Coding (CPC)

Idea: Learn to predict future embeddings linearly.
$Z_{t+k} = W_{k}C_{t}$ Loss: mean squared error not helpful, because
encoding = 0 will give perfect loss, positive example are close, and
negative example are distant

## SimCLR

Maxmize agreement between representations of two views, good contrastive
learning need many negative examples.

-   MoCo: $\theta_{k} <- m\theta_{k} +(1-m)\theta_{q}$, decouples batch
    size of large number of negative exsamples, more complex model
-   BYOL: no need for negative examples

## Cross-model contrastive learning(CLIP)

# Semantic segmentation

## methods

-   in CNN model, replace the last fully connected layer with 1x1
    converlutions layer
-   at last upsampling to original size
-   ouput original weight \* original height \* class number with
    one-hot coding.
-   loss funtion, cross entry of pixel-wise:
    $\frac{1}{N} \sum_{ij}\sum_{k} \log p_{ij}^{k} t_{ij}^{k}$,
    -   imbalanced background not work good for target prediciton, using
        balanced loss function
    -   weight factor r inverse to class frequency
    -   dice loss
    -   Focal loss
-   upsampling: nearest neighbor interpolation, transposed convolutions
-   upsampling combining with the corresponding pooling

## FCN

tranposed convolution can cause artifacts, can avoid by using fixed
upsampling(nearest neighbor)

## U-net

-   Contraction: extract semantic information
-   Expansion: produce detail segmentation
-   Skip connection: copy high-resolution information into decoder

## Deep Lab

combine feathers representations at multiple scale atrous converlution:
dilate filter by implicit zeros in between kenerl elements

# Object Detection

**Predict the Bounding box and predict the class**

## two stage mothode

Faster R-CNN:

-   Loss = $\sum$ classification loss + $\sum$ region proposal loss
-   RoI pooling: all object map to Rol convolutional features(C\*H\*W)
    for region proposal

## single stage mothode

change the mask size, and predect all at once

# Instance Segmentation

**segment individual object from image** **Instance segmentation is
invariant under relabeling**

-   Proposal-based instance segmentation, perform object detection at
    first, the predict each mask instance with bounding box L =
    classification loss + region proposal loss(bounding box) + mask loss
-   proposal-free instance segmentation, predict intermediate
    representations,
    -   foreground prediciton
    -   boundary prediciton

# image to image

-   colorization
-   super resolution
-   Denoising
