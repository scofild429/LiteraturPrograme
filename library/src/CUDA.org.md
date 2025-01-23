---
title: CUDA
---

```{=org}
#+STARTUP: overview
```
# install cuda toolkit for U24 with dependence libinfo5

U24 install toolkit for U22, libinfo5 is missing. Then follow the
instruction, set password

``` {.bash org-language="sh"}
weg http://archive.ubuntu.com/ubuntu/pool/universe/n/ncurses/libtinfo5_6.2-0ubuntu2_amd64.deb
sudo dpkg -i  libtinfo5_6.2-0ubuntu2_amd64.deb
```
