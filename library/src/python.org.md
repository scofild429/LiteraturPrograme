---
title: python
---

```{=org}
#+STARTUP: overview
```
# Install

## prerequirement

    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

## install from source code

go to the offical python3.9 site, down the newest version python
package, extract it ./configure make make test sudo make install

## create virtualenv

### virtualenv

sudo apt install python3-virtualenv virtualenv --python=3.10 venv source
venv/bin/activate deactivate

### python3-venv

sudo apt install python3-venv python3 -m venv django source
venv/bin/activate deactivate

## pip

pip freeze \> requirement.txt pip install -r requirement.txt

### ipython {#ipython id="6d672724-4e1f-4691-b6ce-02d77bfa0003"}

install ipyton comes error

    AttributeError: 'PtkHistoryAdapter' object has no attribute '_loaded'

this is because prompt-toolkit version 2 conflict with ipython, upgrade
it with

    pip install prompt-toolkit --upgrade

### update package

``` {.bash org-language="sh"}
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
```

# GPU Driver for linux

## install with apt {#install-with-apt id="83e059c7-2ffb-4c68-99e5-eea5214dc2bb"}

Am 2022 May 09, monday I install cuda with apt, I don\'t know if this is
ready a offer for all, but I still wirte it down

    sudo apt update
    sudo apt upgrade
    ubuntu-drivers devices
    sudo apt install nvidia-driver-510
    reboot
    watch  -n 0.1 nvidia-smi 

    sudo apt install zlib1g nvidia-cuda-toolkit
    nvcc -V

    pip install virtualenv 
    python -m virtualenv dlforcvenv
    cd dlforcvenv
    source ./bin/activate
    pip install torch torchvision torchaudio

    pip install notebook
    python -m jupyter notebook &
    import torch
    torch.cuda.is_available(), torch.backends.cudnn.is_available(), torch.cuda.device_count()

## install driver 418-server, cuda 10.1, cudnn 7.6.1

    1. nouveau to backlist: add following to /etc/modprobe.d/blacklist.conf
       blacklist nouveau
       options nouveau modeset=0

    2. sudo update-initramfs -u   

    3. sudo apt update
       ubuntu-drivers devices
       sudo apt install nvidia-drivers-418-server
       sudo reboot


       then I will be able to check :   nvidia-smi

    4. CUDA
       go to [[https://developer.nvidia.com/cuda-toolkit-archive]]
       select CUDA Toolkit 10.1 update 2 to install
       unmark the Drivers in  CUDA installation

    5. emacs ~/.bashrc
       export PATH="/usr/local/cuda-10.1/bin:$PATH"
       export LD_LIBRARY_PATH="/usr/lcoal/cuda-10.1/lib64:$LD_LIBRARY_PATH"
       source ~/.bashrc

    6. check CUDA
       cd /usr/local/cuda-10.1/samples/1_Utilities/deviceQuery
       sudo make
       ./deviceQuery

       OK if Result = PASS
       or nvcc -V

    6. cuDNN
       go to [[https://developer.nvidia.com/rdp/cudnn-download]]
       at least select 7.6.1 for CUDA 10.1
       sudo cp cuda/include/cudnn.h /usr/local/cuda/include/
       sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64/
       sudo chmod a+r /usr/local/cuda/include/cudnn.h 

    7. sudo apt remove nvidia-*
       reboot

    8. download the nvidia driver source file  at
       [[https://www.nvidia.com/Download/index.aspx?lang=en-us]]

    9. cd ~/Downloads
       chmod +x ~/Downloads/NVIDIA-Linux-x86_64-450.80.02.run
       sudo ./NVI...

    10. sudo apt install python3-pip
        sudo apt install ipython3
        pip3 install pip
        pip3 install tensorflow-gpu
        ipython3
        import tensorflow as tf
        print(tf.test.is_gpu_available())

1.  fixup sometime it can be in the case: the communication with nvidia
    driver is failed, to fix it, using apt install the driver 418-driver
    from apt again

2.  check

    ``` {.ipython results="output"}
    import tensorflow as tf
    if (tf.test.is_gpu_available(cuda_only=False, min_cuda_compute_capability=None)==True):
      print("using gpu")
    ```

``` {.ipython results="output"}
import sys
print(sys.version)
```

# Error

## \'int\' object is not callable

trying to assign a variable to the system variable

## can\'t open pip installed package

notebook, or ipython, such package, installed, bu can\'t open, if the
package is in the path, we can start it with python -m package

# Python Program collection

## useful expression

conditional express

``` {.python results="output"}
condition = True
x = 1 if condition else 0
print(x)

```

Large Number Formation

``` {.python results="output"}

num1 = 100_000_000_000
num2 = 10_000_000
print(f'{num1 + num2 :,}')

```

open with

``` {.python results="output"}
with open('pycharm_keybounding.org','r') as f:
    file= f.read()
words = file.split(' ')


```

enumerate

``` {.python results="output"}
names = ['one', 'two', 'three', 'four']
for index, name in enumerate(names, start=1):
    print(index,name)

```

zip

``` {.python results="output"}
names = ['one', 'two', 'three', 'four']
hero = ['ni', 'wo', 'ta', 'bu']

for name, h in zip(names, hero):
    print(f'{name} is actually {h}')
```

unpacking tuple

``` {.python results="output"}
a, b, *_ = (1,2,3, 4,5)
a, b, *f = (1,2,3, 4,5)
c, d, _ = (1,2,3)
print(a)
print(b)

```

setattr,

getattr

``` python
from getpass import getpass
password = getpass('Password:')
```

python -m model 直接执行model模块

## map and for

``` {.python results="output" tangle="~/Schreibtisch/test11.py"}
list1 = [ord(x) for x in 'ABC']
print(list1)

list2 = map(ord, 'ABkkC')
print(list2)

```

## multiply

``` {.python results="output"}
print('A'*3)
print(['A']*3)
print([['A']]*3)

```

## generator

use yield stead of return

``` {.python results="output"}
def func (lst):
    lt = []
    for i in lst:
        lt.append( i*i)
    return lt
num = func([ x for x in range(8)])
print(num)
num1 = [ x*x for x in range(8)]
print(num1)


#generator
def funcg (lst):
    for i in lst:
        yield (i*i)

numg = funcg([ x for x in range(8)])
print(numg)
numg1 = ( x*x for x in range(8))
print(numg1)



```

## List

this can not be execute, otherweise it will dead,rekursive of position 0

``` python
words = ['big','cat','dog']
for a in words:
    words.insert(0, 'wo')

```

``` python
words = ['big','cat','dog']
for a in words[:]:
    words.insert(0, 'wo')
```

## list creation

``` {.ipython results="output"}

# two fast way to create list
a0 = [1]*10
print(a0)
a1 = [1 for x in range(10)]
print(a1)

# every subarray is conneted
ak0 = [[]]*10
print(ak0)
ak0[2].append(3)
print(ak0)

# every subarray is disconneted
ak1 = [[] for x in range(10)]
print(ak1)
ak1[2].append(3)
print(ak1)

```

## Break Points

    else sentence after for: after for sentence else can be used

    def fun(argument, *argument, **argument)
    fun(single_value, tuple, dictionary)

lambda with funtion

``` {.python results="output"}
def fun(n):
    return lambda x: x+n
print(fun(3)(4))
```

    nonlocal将变量的赋值,且将此值向外层作用域扩展一个范

    global 将变量的赋值到程序的全局作用域


    _ value: 在交互模式下，上一次打印出来的表达式被赋值给变量 _

    import test.py file as a model
    import test
    so all funtions and parameters can be called as in a test class


    python -i test.py 
    after execute test.py file, terminal will get into python console, 
    and all funtions and parameters can just be called.

## Tkinter Vairlaation

### buttom

``` python
import tkinter as tk

window = tk.Tk()
window.title('my window')
window.geometry('200x200')

var = tk.StringVar()
l = tk.Label(window, bg='yellow', width=20, text='empty')
l.pack()

def print_selection():
    l.config(text='you have selected ' + var.get())

r1 = tk.Radiobutton(window, text='Option A',
                    variable=var, value='A',
                    command=print_selection)
r1.pack()
r2 = tk.Radiobutton(window, text='Option B',
                    variable=var, value='B',
                    command=print_selection)
r2.pack()
r3 = tk.Radiobutton(window, text='Option C',
                    variable=var, value='C',
                    command=print_selection)
r3.pack()


window.mainloop()


```

### checkbutton

``` python
import tkinter as tk

window = tk.Tk()
window.title('my window')
window.geometry('200x200')

l = tk.Label(window, bg='yellow', width=20, text='empty')
l.pack()

def print_selection():
    if (var1.get() == 1) & (var2.get() == 0):
        l.config(text='I love only Python ')
    elif (var1.get() == 0) & (var2.get() == 1):
        l.config(text='I love only C++')
    elif (var1.get() == 0) & (var2.get() == 0):
        l.config(text='I do not love either')
    else:
        l.config(text='I love both')

var1 = tk.IntVar()
var2 = tk.IntVar()
c1 = tk.Checkbutton(window, text='Python', variable=var1, onvalue=1, offvalue=0,
                    command=print_selection)
c2 = tk.Checkbutton(window, text='C++', variable=var2, onvalue=1, offvalue=0,
                    command=print_selection)
c1.pack()
c2.pack()


window.mainloop()


```

### menubar

``` python
import tkinter as tk

window = tk.Tk()
window.title('my window')
window.geometry('200x200')

l = tk.Label(window, text='', bg='yellow')
l.pack()
counter = 0
def do_job():
    global counter
    l.config(text='do '+ str(counter))
    counter+=1

menubar = tk.Menu(window)
filemenu = tk.Menu(menubar, tearoff=0)
menubar.add_cascade(label='File', menu=filemenu)
filemenu.add_command(label='New', command=do_job)
filemenu.add_command(label='Open', command=do_job)
filemenu.add_command(label='Save', command=do_job)
filemenu.add_separator()
filemenu.add_command(label='Exit', command=window.quit)

editmenu = tk.Menu(menubar, tearoff=0)
menubar.add_cascade(label='Edit', menu=editmenu)
editmenu.add_command(label='Cut', command=do_job)
editmenu.add_command(label='Copy', command=do_job)
editmenu.add_command(label='Paste', command=do_job)

submenu = tk.Menu(filemenu)
filemenu.add_cascade(label='Import', menu=submenu, underline=0)
submenu.add_command(label="Submenu1", command=do_job)

window.config(menu=menubar)

window.mainloop()


```

### canvas (cannt load img)

``` python
import tkinter as tk

window = tk.Tk()
window.title('my window')
window.geometry('200x200')

canvas = tk.Canvas(window, bg='blue', height=100, width=200)
image_file = tk.PhotoImage(file='ins.gif')
image = canvas.create_image(10, 10, anchor='nw', image=image_file)
x0, y0, x1, y1= 50, 50, 80, 80
line = canvas.create_line(x0, y0, x1, y1)
oval = canvas.create_oval(x0, y0, x1, y1, fill='red')
arc = canvas.create_arc(x0+30, y0+30, x1+30, y1+30, start=0, extent=180)
rect = canvas.create_rectangle(100, 30, 100+20, 30+20)
canvas.pack()

def moveit():
    canvas.move(rect, 0, 2)

b = tk.Button(window, text='move', command=moveit).pack()


window.mainloop()

```

### frame

``` python

import tkinter as tk

window = tk.Tk()
window.title('my window')
window.geometry('200x200')
tk.Label(window, text='on the window').pack()

frm = tk.Frame(window)
frm.pack()
frm_l = tk.Frame(frm, )
frm_r = tk.Frame(frm)
frm_l.pack(side='left')
frm_r.pack(side='right')

tk.Label(frm_l, text='on the frm_l1').pack()
tk.Label(frm_l, text='on the frm_l2').pack()
tk.Label(frm_r, text='on the frm_r1').pack()
window.mainloop()

```

### list

``` python


import tkinter as tk

window = tk.Tk()
window.title('my window')
window.geometry('200x200')

var1 = tk.StringVar()
l = tk.Label(window, bg='yellow', width=4, textvariable=var1)
l.pack()

def print_selection():
    value = lb.get(lb.curselection())
    var1.set(value)

b1 = tk.Button(window, text='print selection', width=15,
              height=2, command=print_selection)
b1.pack()

var2 = tk.StringVar()
var2.set((11,22,33,44))
lb = tk.Listbox(window, listvariable=var2)
list_items = [1,2,3,4]
for item in list_items:
    lb.insert('end', item)
lb.insert(1, 'first')
lb.insert(2, 'second')
lb.delete(2)
lb.pack()

window.mainloop()


```

### scale

``` python

import tkinter as tk

window = tk.Tk()
window.title('my window')
window.geometry('200x200')

l = tk.Label(window, bg='yellow', width=20, text='empty')
l.pack()

def print_selection(v):
    l.config(text='you have selected ' + v)

s = tk.Scale(window, label='try me', from_=5, to=11, orient=tk.HORIZONTAL,
             length=200, showvalue=0, tickinterval=2, resolution=0.01, command=print_selection)
s.pack()

window.mainloop()


```

## decorator

1, \@后没有参数，则被修饰函数名被传到修饰函数作参数 2,
\@后有参数，在该参数被传到修饰函数作参数，而被修饰函数可在其定义内被接收

``` {.python results="output" exports="both"}
def log(func):
    def wrapper(*args, **kw):
        print('call function %s():' % func.__name__)
        return func(*args, **kw)
    return wrapper

def loog(text):
    def decorator(fun):
        def wrapper(*args, **kw):
            print('kkcall function %s with %s():' % (fun.__name__, text))
            return fun(*args, **kw)
        return wrapper
    return decorator



@loog('exit')
def now():
    print("now to start")

now()
```

## functools

``` {.python results="output"}
import functools
int2 = functools.partial(int, base=3)
print(int2('1211'))

```

## Polymorphism

``` {.python results="output" session="yes"}
class Animal(object):
    def __init__(self):
        self.name ='Animal name'

    def run(self):
        print('Animal is running')

class Dog(Animal):
    def __init__(self):
        self.name ='Dog name'
    def run(self):
        print('Dog is running')

class Cat(Animal):
    def __init__(self):
        self.name ='Cat name'
    def run(self):
        print('Cat is running')

class Tortoise(Animal):
    def __init__(self):
        self.name ='Tortoise name'
    def run(self):
        print('Tortoise is running slowly')

# Polymorphism, all Class or instance will be checked the best passing
# mothode or character
def run_twice(a):
    a.run()

def name(b):
    print(b.name)

dog = Dog()
cat = Cat()


run_twice(Animal())
run_twice(Dog())
run_twice(Cat())
run_twice(dog)

name(Animal())
name(Dog())
name(dog)

```

## generator

``` {.python results="output" session="yes"}
def something():
    result = []
    for _ in range(10):
        result.append(2)
    return result
print(something())


def iter_some():
    x = 0
    for _ in range(10):
        yield x
        x += 1
a = iter_some()
print(next(a))
print(next(a))
print(next(a))

```

``` {.python results="output" session="yes"}

def fib ():
    a = b = 1
    yield a
    yield b
    while True:
        a, b = b, a+b
        yield b


for var in fib():
    if var > 100:
        break
    print(var)



```

## pdb

1.  python -m pdb test.py

step by step with n,

1.  import pdb

pdb.set~trace~() 设置断点

## Copy

copying fundmental vaiable will creat a new id for assigned varible,
copy = \[:\] for object will create also a new id for new object, but
not for nested object deepcopy will also creat id for nested object in
copyed object

## Decorator

decorator just rewrite the function, using call function as argument

``` {.python results="output"}
def decorator_function(original_function):
    def wrapper_function(*arg, **kwargs):
        print("using wrapper, and  the name is {}, and the age".format(original_function.__name__))
        return original_function(*arg, **kwargs)
    return wrapper_function

class decorator_class(object):
    def __init__(self, original_function):
        self.original_function = original_function
    def __call__(self, *arg, **kwargs):
        print("using the decorator class")
        return self.original_function(*arg, **kwargs)

print("////////function decor without augurment//////////////////////")
def display():
    print("display this")
display = decorator_function(display)
display()
print("////////decorator decor without augurment//////////////////////")
@decorator_function
def display1():
    print("display1 this")
display1()
print("////////function decor with augurment//////////////////////")
def display_info(name, age):
    print("display the name is {}, and the age is {}".format(name, age))
display_info = decorator_function(display_info)
display_info("Xiang", 21)
print("////////decorator decor with augurment//////////////////////")
@decorator_function
def display_info1(name, age):
    print("display the name is {}, and the age is {}".format(name, age))
display_info1("Xiang", 21)
print("/////////class decorator decor/////////////////////")
@decorator_class
def display_info_class(name, age):
    print("display the name is {}, and the age is {}".format(name, age))
display_info_class("Xiang", 21)
print("////////class function decor//////////////////////")
def display_info_class(name, age):
    print("display the name is {}, and the age is {}".format(name, age))
display_info_class1 = decorator_class(display_info_class)
display_info_class1("Xiang", 21)



```

## with \* \*\*

``` {.ipython results="output" exports="both"}
def function_with_one_star(*d):
    print(d)

def function_with_two_stars(**d):
    print(d)

function_with_one_star(1,2,3)

function_with_two_stars(a=1, b=2, c=3)


```

``` example
(1, 2, 3)
{'a': 1, 'b': 2, 'c': 3}
```

## Python Numpy with \~

Wenn we want to filter the we wanted from a np.array, we can define the
filter with boolen in a np.array,

``` {.ipython results="output" exports="both"}
import numpy as np
x = np.arange(25).reshape(5,5)
print(x)

```

``` example
[[ 0  1  2  3  4]
 [ 5  6  7  8  9]
 [10 11 12 13 14]
 [15 16 17 18 19]
 [20 21 22 23 24]]
```

Or

``` {.ipython results="output" exports="both"}
import numpy as np
xx = np.linspace(0, 24, 25).reshape(5,5)
print(xx)

```

``` example
[[ 0.  1.  2.  3.  4.]
 [ 5.  6.  7.  8.  9.]
 [10. 11. 12. 13. 14.]
 [15. 16. 17. 18. 19.]
 [20. 21. 22. 23. 24.]]
```

With np.linspace is float number, but arange is int number

``` {.ipython results="output" exports="both"}
import numpy as np
x = np.arange(25).reshape(5,5)
y = np.array([False, False, True, True, False])
print(x[y,2])

```

``` example
[12 17]
```

according to y = np.array(\[False, False, True, True, False\]) to filter
the true position in the third column.

if we want the false position in the third column, with \~ on the filter
array

``` {.ipython results="output" exports="both"}
import numpy as np
x = np.arange(25).reshape(5,5)
y = np.array([False, False, True, True, False])
print(x[~y,2])

```

``` example
[ 2  7 22]
```

## turtle movement

``` python

import turtle
turtle.setup(650, 350, 200, 200)
turtle.penup()
turtle.fd(-250)
turtle.pendown()
turtle.pensize(25)
turtle.pencolor("purple")
turtle.seth(-40)
for i in range(4):
    turtle.circle(40, 80)
    turtle.circle(-40, 80)
turtle.circle(40, 80/2)
turtle.fd(40)
turtle.circle(16, 180)
turtle.fd(40*2/3)
turtle.done()


```

## tempertur converse

``` python
#TempConver.py
TempStr = input('请输入带有符号的温度值:')
if TempStr[-1] in ['F', 'f']:
    C = (eval(TempStr[0:-1]) - 32)/1.8
    print('转换后的温度值为{:.2f}C'.format(C))
elif TempStr[-1] in ['C', 'c']:
    F = 1.8*eval(TempStr[0:-1]) + 32
    print('转换后的温度值为{:.2f}F'.format(F))
else:
    print('输入有误')


```

## print current time

``` {.python results="output"}
import turtle, time
def drawGap():
    turtle.penup()
    turtle.fd(5)
def drawLine(draw):
    drawGap()
    turtle.pendown() if draw else turtle.penup()
    turtle.fd(40)
    drawGap()
    turtle.right(90)
def drawDigit(digit):
    drawLine(True) if digit in [2,3,4,5,6,8,9] else drawLine(False)
    drawLine(True) if digit in [0,1,3,4,5,6,7,8,9] else drawLine(False)
    drawLine(True) if digit in [0,2,3,5,6,8,9] else drawLine(False)
    drawLine(True) if digit in [0,2,6,8] else drawLine(False)
    turtle.left(90)
    drawLine(True) if digit in [0,4,5,6,8,9] else drawLine(False)
    drawLine(True) if digit in [0,2,3,5,6,7,8,9] else drawLine(False)
    drawLine(True) if digit in [0,1,2,3,4,7,8,9] else drawLine(False)
    turtle.left(180)
    turtle.penup()
    turtle.fd(20)
# def drawDate(date):
#     for i in date:
#         drawDigit(eval(i))
# def main():
def drawDate(date):
    turtle.pencolor("red")
    for i in date:
        if i == '-':
            turtle.write('年', font=("Arial", 18, "normal"))
            turtle.pencolor("green")
            turtle.fd(40)
        elif i == '=':
            turtle.write('月', font=("Arial", 18, "normal"))
            turtle.pencolor("blue")
            turtle.fd(40)
        elif i == '+':
            turtle.write('日', font=("Arial", 18, "normal"))
        else:
            drawDigit(eval(i))
def main():
    turtle.setup(800,350,200,200)
    turtle.penup()
    turtle.fd(-300)
    turtle.pensize(5)
    # drawDate('20181010')
    drawDate(time.strftime("%Y-%m=%d+",time.gmtime()))
    turtle.hideturtle()
    turtle.done()
main()

```

## pandas DataFrame merge

merge in pandas DataFrame is very similar like join in SQL.

``` ipython
DataFrame.merge(right,
                how='inner', 
                on=None,
                left_on=None,
                right_on=None, 
                left_index=False,
                right_index=False, 
                sort=False,
                suffixes=('_x', '_y'),
                copy=True,
                indicator=False, 
                validate=None)[source]
```

how = \'inner\', \'outer\', \'left\', \'right\' default is \'inner\'
inner: interaction set output: union set left : all left right : all
right

if right~on~, left~on~, and on is not given, the merge is on the
index(row). we use the frist column from left and right dataframe to
merge, just like the example. left: \'one\' has 0, 1 right: \'one\' has
1, 2, 3 the interaction set is only 1 all columns will be just added
together

``` {.ipython results="output" exports="both"}
import pandas as pd
dd = {'one':[0, 1 ], 'two':[0, 0], 'three':[1, 1]}
a = pd.DataFrame(data= dd)
b = pd.DataFrame({'zero':[0,0,0], 'one':[1,2,3 ], 'two':[0,0,0 ]})
print(a)
print(b)
print(a.merge(b))
```

``` example
   one  two  three
0    0    0      1
1    1    0      1
   zero  one  two
0     0    1    0
1     0    2    0
2     0    3    0
   one  two  three  zero
0    1    0      1     0
```

the can also be merge on columns, for each compare elemenet in column
with out repeated key

``` {.ipython results="output" exports="both"}
dd = {'one':[0, 1 ], 'two':[0, 0], 'three':[1, 1]}
a = pd.DataFrame(data= dd)
b = pd.DataFrame({'zero':[0,0,0], 'one':[1,2,3 ], 'two':[0,0,0 ]})
print(a)
print(b)
print(a.merge(b, on='one', how='inner'))

```

``` example
   one  two  three
0    0    0      1
1    1    0      1
   zero  one  two
0     0    1    0
1     0    2    0
2     0    3    0
   one  two_x  three  zero  two_y
0    1      0      1     0      0
```

if with repeated key, the number will be multipy by its occurrence,

``` {.ipython results="output" exports="both"}
dd = {'one':[0, 1 ], 'two':[0, 0], 'three':[1, 1]}
a = pd.DataFrame(data= dd)
b = pd.DataFrame({'zero':[0,0,0], 'one':[1,2,3 ], 'two':[0,0,0 ]})
print(a)
print(b)
print(a.merge(b, on='two', how='inner'))
```

``` example
   one  two  three
0    0    0      1
1    1    0      1
   zero  one  two
0     0    1    0
1     0    2    0
2     0    3    0
   one_x  two  three  zero  one_y
0      0    0      1     0      1
1      0    0      1     0      2
2      0    0      1     0      3
3      1    0      1     0      1
4      1    0      1     0      2
5      1    0      1     0      3
```

## filp {#filp id="6db7b2dc-ccf8-4feb-9ad0-724f66244ad9"}

see numpy document
[numpy.flip](https://numpy.org/doc/stable/reference/generated/numpy.flip.html)

``` {.python results="output" exports="both"}
import numpy as np
A = np.array([[1,2,3], [4,5,6], [7,8,9]])
print(A)
print(A[::-1])
print(np.all(A[::-1] == np.flip(A, 0)))


```

``` example
[[1 2 3]
 [4 5 6]
 [7 8 9]]
[[7 8 9]
 [4 5 6]
 [1 2 3]]
True
```

## print all attribute of object

``` {.ipython results="output" exports="both"}
from pprint import pprint
import inspect
import time
pprint(inspect.getmembers(time))
```

## \@property

    @property: Declares the method as a property.
    @<property-name>.setter: Specifies the setter method for a property that sets the value to a property.
    @<property-name>.deleter: Specifies the delete method as a property that deletes a property.  

# python automotion

## system manipulation

### os.getcwd()

``` {.ipython results="output" exports="both"}
import os
print(os.getcwd())
```

``` example
/home/silin/Dropbox/LiteraturPrograme/content
```

### os.chdir()

``` {.ipython results="output" exports="both"}
# import os
# os.chdir("../../Schreibtisch")
# print(os.getcwd())
```

### os.listdir()

``` {.ipython results="output" exports="both"}
print(os.listdir())
```

``` example
[]
```

# PyTorch

## Basic

### cpu with cuda.gpu

``` {.ipython results="output"}

import torch
import time
print(torch.__version__)
print(torch.cuda.is_available)

a = torch.randn(10000, 1000)
b = torch.randn(1000, 2000)

t0 = time.time()
c = torch.matmul(a, b)
t1 = time.time()
print(a.device, t1-t0, c.norm(2))

device = torch.device('cuda')
a = a.to(device)
b = b.to(device)

t0 = time.time()
c = torch.matmul(a, b)
t2 = time.time()
print(a.device, t2-t0, c.norm(2))


t0 = time.time()
c = torch.matmul(a, b)
t2 = time.time()
print(a.device, t2-t0, c.norm(2))
```

### auto Derivative

``` {.ipython results="output"}
import torch
from torch import autograd

x = torch.tensor(1.)
a = torch.tensor(1. , requires_grad=True)
b = torch.tensor(2. , requires_grad=True)
c = torch.tensor(3. , requires_grad=True)

y = a**2*x + b*x + c

print('before:', a.grad, b.grad, c.grad)
grad = autograd.grad(y, [a,b,c])
print('after:', grad[0], grad[1], grad[2])

```

### small example

``` {.ipython results="output"}
import torch

x = torch.ones(2,2,requires_grad=True)
y = x +2
z = y*y*3
out = z.mean()
out.backward()
print(x.grad)

```

```{=latex}
\begin{equation}
x = 
  \left(
  \begin{array}{cc}
          1  & 1  \\
          1  & 1 \\
  \end{array}
  \right)
\end{equation}
```
```{=latex}
\begin{equation}
y =    2 + x =
  \left(
  \begin{array}{cc}
          3  & 3  \\
          3  & 3 \\
  \end{array}
  \right)
\end{equation}
```
```{=latex}
\begin{equation}
z =   3*y*y =
  \left(
  \begin{array}{cc}
          27  & 27  \\
          27  & 27 \\
  \end{array}
  \right)
\end{equation}
```
$$ out = \frac{1}{4}\sum_{i=1,j=1}^{i=2, j=2}3y_{ij}y_{ij} =\frac{1}{4}\sum_{i=1,j=1}^{i=2, j=2}3(2+x_{ij})(2+x_{ij}) $$

x.grad is to say : $$ \frac{d(out_{ij})}{d(x_{ij})}  = 3(2+4)/4 = 4.5$$

## Function

### x = x.new~ones~(4,3)

## Iterator DataLoader

here, THE i is the number of iterations, each iteration has 20 iter

``` {.ipython results="output"}
import torch
import numpy as np

i = np.array([a for a in range(100)])
i = torch.from_numpy(i)

test = torch.utils.data.DataLoader(i, batch_size=20,shuffle=False)
testiter = iter(test)

for k, data in enumerate(testiter):
    print(k)


```

## torch.max

the return is a namedtuple dim = 0, 1, maximum of rows or columns

``` {.ipython results="output"}
import torch
i = torch.randn(3,4)
print(torch.max(i, 0))
print(torch.max(i, 1))

```

## exsample 3 ploy

``` {.ipython results="output"}
import torch
import math


class Polynomial3(torch.nn.Module):
    def __init__(self):
        """
        In the constructor we instantiate four parameters and assign them as
        member parameters.
        """
        super().__init__()
        self.a = torch.nn.Parameter(torch.randn(()))
        self.b = torch.nn.Parameter(torch.randn(()))
        self.c = torch.nn.Parameter(torch.randn(()))
        self.d = torch.nn.Parameter(torch.randn(()))

    def forward(self, x):
        """
        In the forward function we accept a Tensor of input data and we must return
        a Tensor of output data. We can use Modules defined in the constructor as
        well as arbitrary operators on Tensors.
        """
        return self.a + self.b * x + self.c * x ** 2 + self.d * x ** 3

    def string(self):
        """
        Just like any class in Python, you can also define custom method on PyTorch modules
        """
        return f'y = {self.a.item()} + {self.b.item()} x + {self.c.item()} x^2 + {self.d.item()} x^3'


# Create Tensors to hold input and outputs.
x = torch.linspace(-math.pi, math.pi, 2000)
y = torch.sin(x)

# Construct our model by instantiating the class defined above
model = Polynomial3()

# Construct our loss function and an Optimizer. The call to model.parameters()
# in the SGD constructor will contain the learnable parameters of the nn.Linear
# module which is members of the model.
criterion = torch.nn.MSELoss(reduction='sum')
optimizer = torch.optim.SGD(model.parameters(), lr=1e-6)
for t in range(2000):
    # Forward pass: Compute predicted y by passing x to the model
    y_pred = model(x)

    # Compute and print loss
    loss = criterion(y_pred, y)
    if t % 100 == 99:
        print(t, loss.item())

    # Zero gradients, perform a backward pass, and update the weights.
    optimizer.zero_grad()
    loss.backward()
    optimizer.step()

print(f'Result: {model.string()}')


```

# packages

## matplotlib.plot

### two linear plot

``` {.ipython results="output"}
import numpy as np
import random
from matplotlib import pyplot as plt

a = np.array([ x for x in range(10)])
b = np.array([[random.randint(0,10) for x in range(10)],[random.randint(0,10) for x in range(10)]])
plt.plot(a,b.T)
plt.show()


```

### simplest linear plot

``` {.ipython results="output"}
import matplotlib.pyplot as plt
plt.plot([1,2,3,4])
plt.ylabel('some numbers')
plt.show()


```

### simplest point plot

``` {.ipython results="output"}
import matplotlib.pyplot as plt
plt.plot([1,2,3,4], [1,4,9,16], 'ro')
plt.axis([0, 6, 0, 20])
plt.show()


```

### simplest function plot

``` {.ipython results="output"}
import numpy as np
import matplotlib.pyplot as plt

# evenly sampled time at 200ms intervals
t = np.arange(0., 5., 0.2)

# red dashes, blue squares and green triangles
plt.plot(t, t, 'r--', t, t**2, 'bs', t, t**3, 'g^')
plt.show()


```

### simplest subplot

``` {.ipython results="output"}
import numpy as np
import matplotlib.pyplot as plt

def f(t):
    return np.exp(-t) * np.cos(2*np.pi*t)

t1 = np.arange(0.0, 5.0, 0.1)
t2 = np.arange(0.0, 5.0, 0.02)

plt.figure(1)
plt.subplot(211)
plt.plot(t1, f(t1), 'bo', t2, f(t2), 'k')

plt.subplot(212)
plt.plot(t2, np.cos(2*np.pi*t2), 'r--')
plt.show()


```

### histogram plot with cusomised legend

``` {.ipython results="output"}
import numpy as np
import matplotlib.pyplot as plt

# Fixing random state for reproducibility
np.random.seed(19680801)

mu, sigma = 100, 15
x = mu + sigma * np.random.randn(10000)

# the histogram of the data
n, bins, patches = plt.hist(x, 50, normed=1, facecolor='g', alpha=0.75)


plt.xlabel('Smarts')
plt.ylabel('Probability')
plt.title('Histogram of IQ')
plt.text(60, .025, r'$\mu=100,\ \sigma=15$')
plt.axis([40, 160, 0, 0.03])
plt.grid(True)
plt.show()


```

### histogram plot

``` {.ipython results="output"}
import numpy as np
import matplotlib.pyplot as plt

# Fixing random state for reproducibility
np.random.seed(19680801)

mu, sigma = 100, 15
x = mu + sigma * np.random.randn(100000)

# the histogram of the data
n, bins, patches = plt.hist(x, 50, facecolor='g')

plt.xlabel('Smarts')
plt.ylabel('Probability')
plt.title('Histogram of IQ')
#plt.text(60, .025, r'$\mu=100,\ \sigma=15$')
#plt.axis([40, 160, 0, 0.03])
#plt.grid(True)
plt.show()



```

### histogram y axis with log index

``` {.ipython results="output"}

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import NullFormatter  # useful for `logit` scale

# Fixing random state for reproducibility
np.random.seed(19680801)

# make up some data in the interval ]0, 1[
y = np.random.normal(loc=0.5, scale=0.4, size=1000)
y = y[(y > 0) & (y < 1)]
y.sort()
x = np.arange(len(y))

# plot with various axes scales
plt.figure(1)

# linear
plt.subplot(221)
plt.plot(x, y)
plt.yscale('linear')
plt.title('linear')
plt.grid(True)


# log
plt.subplot(222)
plt.plot(x, y)
plt.yscale('log')
plt.title('log')
plt.grid(True)


# symmetric log
plt.subplot(223)
plt.plot(x, y - y.mean())
plt.yscale('symlog', linthreshy=0.01)
plt.title('symlog')
plt.grid(True)

# logit
plt.subplot(224)
plt.plot(x, y)
plt.yscale('logit')
plt.title('logit')
plt.grid(True)
# Format the minor tick labels of the y-axis into empty strings with
# `NullFormatter`, to avoid cumbering the axis with too many labels.
plt.gca().yaxis.set_minor_formatter(NullFormatter())
# Adjust the subplot layout, because the logit one may take more space
# than usual, due to y-tick labels like "1 - 10^{-3}"
plt.subplots_adjust(top=0.92, bottom=0.08, left=0.10, right=0.95, hspace=0.25, wspace=0.35)

plt.show()


```

### a example of mean standrad deviation plotting

``` {.ipython results="output"}
import matplotlib.pyplot as plt;
import numpy as np
import scipy.stats
import scipy as sp
from scipy import integrate
from scipy.optimize import curve_fit

data = np.genfromtxt('Highz_SN_data.txt');

redshift = np.array([data[:,2]])
mu = np.array([data[:,3]])
velocity = np.array([data[:,4]])
redshift_mean = np.mean(redshift)
mu_mean = np.mean(mu)
velocity_mean = np.mean(velocity)
redshift_std = np.std(redshift)
mu_std = np.std(mu)
velocity_std = np.std(velocity)
para = ["redshift", "mu", "velocity"]
x_pos = np.arange(len(para))
ctes = [redshift_mean, mu_mean, velocity_mean]
error = [redshift_std, mu_std, velocity_std]


fig, ax = plt.subplots()
ax.bar(x_pos, ctes, yerr=error, align='center', alpha=0.5, ecolor='black', capsize=10)
ax.set_ylabel('Coefficient of Thermal Expansion ($\degree C^{-1}$)')
ax.set_xticks(x_pos)
ax.set_xticklabels(para)
ax.set_title('Coefficent of Thermal Expansion (CTE) of Three Metals')
ax.yaxis.grid(True)

# Save the figure and show
plt.tight_layout()
plt.savefig('bar_plot_with_error_bars.png')
plt.show()

```

## pandas

### plot.scatter()

``` {.python results="output"}
import pandas as pd
import numpy as np
a = pd.DataFrame(np.random.rand(3,2))
print(a)
a.plot.scatter(x=0, y = 1)


```

# Tensorflow 1

## Constand additional und multiply

### addition

``` {.python results="output" session="yes"}
import tensorflow as tf
a = tf.constant([1.0, 2.0])
b = tf.constant([3.0, 4.0])

a_m = tf.constant([[1.0, 2.0]])
b_m = tf.constant([[3.0], [4.0]])

result_add = a + b
result_multpl = tf.matmul(a_m, b_m)

with tf.Session() as sess:
    print (sess.run(result_add))
    print (sess.run(result_multpl))

print (result_add)
print (result_multpl)
```

### mpppultiply

``` {.python results="output" session="yes"}

import tensorflow as tf
#创建常量
m1= tf.constant([[3,3]])
m2=tf.constant([[1],[2]])
#相乘
product = tf.matmul(m1,m2)
print(product)

#定义一个会话，启动默认图
sess = tf.Session()
#调用sess，执行乘法运算
result = sess.run(product)
print(result)
#不要忘了关闭sess
sess.close()

with tf.Session() as sess:
    result = sess.run(product)
    print(result)
#使用with不需要专门关闭sess


```

## Variable

### the first using of variable & subtract add

``` {.python results="output"}
  import tensorflow as tf
  x = tf.Variable([1,2])
  a = tf.constant([3,3])
  sub = tf.subtract(x,a)
  add = tf.add(x,sub)
# 对于变量，要初始化init
  init = tf.global_variables_initializer()
  with tf.Session() as sess:
      sess.run(init)
      print(sess.run(sub))
      print(sess.run(add))


```

### assign a value for variable and update & assign

``` {.python results="output"}
#............................．．．．．．变量计算
#变量可以被起名，初始化为０
import tensorflow as tf
state = tf.Variable(0, name = 'counter')
new_value = tf.add(state,1)
#赋值功能assign
update = tf.assign(state,new_value)
init = tf.global_variables_initializer()
with tf.Session() as sess:
    sess.run(init)
    print(state)
    for _ in range(5):
        sess.run(update)
        print(sess.run(state))
        print(sess.run(update))


```

### fetch and Feed &placeholder

``` {.python results="output"}
import tensorflow as tf
# Fetch 在一个会话里执行多个op
input1 = tf.constant(3.0)
input2 = tf.constant(2.0)
input3 = tf.constant(5.0)

add = tf.add(input2,input3)
mul = tf.multiply(input1,add)

with tf.Session() as sess:
    result = sess.run([add,mul])  #有[]
    print(result)

#------------------Feed
#创建占位符
input4= tf.placeholder(tf.float32)
input5 = tf.placeholder(tf.float32)
output = tf.multiply(input4, input5)
with tf.Session() as sess:
    print(sess.run(output,feed_dict = {input4:[7.0],input5:[2.0]}))  #随后赋值是用字典的方式进行的feed_dict = {input4:[7.0],input5:[2.0]}, 数字还加了方括号．


```

## Tuning

### change learing rate

``` python
#coding:utf-8

import tensorflow as tf
LEARING_RATE_BASE = 0.1
LEARING_RATE_DECAY = 0.99
LEARING_RATE_STEP= 1

global_step = tf.Variable(0,trainable = False)
learning_rate = tf.train.exponential_decay(LEARING_RATE_BASE, global_step,
LEARING_RATE_STEP, LEARING_RATE_DECAY, staircase = True)

w = tf.Variable(tf.constant(5, dtype = tf.float32))
loss = tf.square(w+1)

train_step = tf.train.GradientDescentOptimizer(learning_rate).minimize(loss,global_step = global_step)

with tf.Session() as sess:
    init_op = tf.global_variables_initializer()
    sess.run(init_op)
    for i in range(40):
        sess.run(train_step)
        learnin_rate_val = sess.run(learning_rate)
        global_step_val = sess.run(global_step)
        w_val = sess.run(w)
        loss_val = sess.run(loss)
        print(" After {} steps: global_step is {}, w is {}, learnin_rate is {}, loss is {}"
.format(i, global_step_val, w_val, learnin_rate_val, loss_val))


```

### learing rate for loss

``` {.python results="output"}
import tensorflow as tf
w = tf.Variable(tf.constant(5,dtype=tf.float32))
loss = tf.square(w+1)
train_step = tf.train.GradientDescentOptimizer(0.2).minimize(loss)

with tf.Session() as sess:
    init_op=tf.global_variables_initializer()
    sess.run(init_op)
    for i in range(50):
        sess.run(train_step)
        w_var = sess.run(w)
        loss_val = sess.run(loss)
        print("After {} steps: w is {}, loss is {}".format(i,w_var,loss_val))
        #print("After %s steps: w is %f, loss is %f." %(i,w_var, loss_val))


```

## train examples

### the first train case

``` {.python results="output"}
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
#生成随机数据
x_date = np.random.rand(100)
y_date = x_date*0.4 + 2

#构造线性模型
b = tf.Variable(0.)
k = tf.Variable(0.)
y = k*x_date + b

#构造二次代价函数
loss = tf.reduce_mean(tf.square(y_date-y))
#定义梯度下降的优化器
optimizer = tf.train.GradientDescentOptimizer(0.2)
#定义一个最小化代价函数
train = optimizer.minimize(loss)
init = tf.global_variables_initializer()
with tf.Session() as sess:
    sess.run(init)
    for steps in range(201):
        sess.run(train)
        if steps%20 == 0:
            print(steps, sess.run([k,b]))
    prediction_value = sess.run(y)
    plt.figure()
    plt.scatter(x_date, y_date)
    plt.plot(x_date,prediction_value,'r-',lw=5)
    plt.show()



```

### non linear regression case

``` python
#----------------------------非线性回归
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt

#构造数据
x_date = np.linspace (-0.5,0.5,100)[:,np.newaxis] #np.newaxis 功能同None，将行变列
noise = np.random.normal(0,0.02,x_date.shape)
y_date = np.square(x_date)+noise

x = tf.placeholder(tf.float32,[None,1])
y = tf.placeholder(tf.float32,[None,1])

#构建神经网络
Weight_L1 = tf.Variable(tf.random_normal([1,10]))
Biase_L1 = tf.Variable(tf.zeros([1,10]))
Wx_plus_b_L1 = tf.matmul(x,Weight_L1)+Biase_L1
L1 = tf.nn.tanh(Wx_plus_b_L1)

#定义输出层
Weight_L2 = tf.Variable(tf.random_normal([10,1]))
Biase_L2 = tf.Variable(tf.zeros([1,1]))
Wx_plus_b_L2 = tf.matmul(L1,Weight_L2)+ Biase_L2
prediction = tf.nn.tanh(Wx_plus_b_L2)

#二次代价函数
loss = tf.reduce_mean(tf.square(y-prediction))
train_step = tf.train.GradientDescentOptimizer(0.1).minimize(loss)
with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    for _ in range(2000):
        sess.run(train_step,feed_dict={x:x_date,y:y_date})

    #训练好后，用来做预测
    prediction_value = sess.run(prediction,feed_dict={x:x_date})
    plt.figure()
    plt.scatter(x_date, y_date)
    plt.plot(x_date,prediction_value,'r-',lw=5)
    plt.show()


```

### the first train with data for accuary

``` python
import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data
#载入数据集
mnist= input_data.read_data_sets('MNIST_data', one_hot = True)

#设定每个批次的大小
batch_size = 100
#计算总共的批次
n_batch = mnist.train.num_examples // batch_size

#参数统计
def variable_summries(var):
    with tf.name_scope('summaries'):
        mean = tf.reduce_mean(var)
        tf.summary.scalar('mean',mean)
        with tf.name_scope('stddev'):
            stddev = tf.sqrt(tf.reduce_mean(tf.square(var-mean)))
        tf.summary.scalar('stddev',stddev)
        tf.summary.scalar('max',tf.reduce_max(var))
        tf.summary.scalar('min',tf.reduce_min(var))
        tf.summary.histogram('histogram',var)

#命名空间
with tf.name_scope('input'):
    x = tf.placeholder(tf.float32,[None,784])
    y = tf.placeholder(tf.float32,[None,10])

with tf.name_scope('layers'):
    with tf.name_scope('wight'):
        W = tf.Variable(tf.truncated_normal([784,10]))
        variable_summries(W)
    with tf.name_scope('biases'):
        B = tf.Variable(tf.zeros([10])+0.1)
        variable_summries(B)
    with tf.name_scope('wx_plus_b'):
        wx_plus_b=tf.matmul(x,W)+B
    with tf.name_scope('softmax'):    
        prediction = tf.nn.tanh(wx_plus_b)

#定义二次代价函数
#loss = tf.reduce_mean(tf.square(y-prediction))
#重新定义对数(交叉熵)
with tf.name_scope('loss'):
    loss =tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels=y,logits=prediction))
    tf.summary.scalar('loss',loss)
#使用梯度下降法

with tf.name_scope('train'):
    train_step = tf.train.GradientDescentOptimizer(0.2).minimize(loss)
#    train_step = tf.train.AdamOptimizer(0.05).minimize(loss)
#初始化
init = tf.global_variables_initializer()

#测试准确率
with tf.name_scope('accuracy'):
    with tf.name_scope('correct_prediction'):
        correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(prediction,1))
    with tf.name_scope('accuracy'):
        accuracy = tf.reduce_mean(tf.cast(correct_prediction,tf.float32))
        tf.summary.scalar('accuracy',accuracy)

#合并summary
merged = tf.summary.merge_all()
        #训练开始
with tf.Session() as sess:
    writer = tf.summary.FileWriter('pics/',sess.graph)
    sess.run(init)
    for epoch in range(51):
        for batch in range(n_batch):
            batch_xs, batch_ys = mnist.train.next_batch(batch_size)
            summary,_ = sess.run([merged,train_step], feed_dict={x:batch_xs, y:batch_ys})
#            writer.add_summary(summary,batch)
        writer.add_summary(summary,epoch)
        acc = sess.run(accuracy,feed_dict={x:mnist.test.images, y:mnist.test.labels})
        print("准确率为:　在"+str(epoch)+"回,"+str(acc))



```

### a simple CNN case

``` {.python results="output"}
import tensorflow as tf
import numpy as np
BATCH_SIZE = 8
seed = 23455

rng = np.random.RandomState(seed)
X = rng.rand(32, 2)
Y = [[int(X0+X1 < 1)] for (X0, X1) in X]
# print ("X is :", X)
# print ("Y is :", Y)

x = tf.placeholder(tf.float32, shape = (None, 2))
y_ = tf.placeholder(tf.float32, shape = (None, 1))

w1 = tf.Variable(tf.random_normal([2,3], stddev=1, seed=1))
w = tf.Variable(tf.random_normal([3,3], stddev=1, seed=1))
w2 = tf.Variable(tf.random_normal([3,1], stddev=1, seed=1))

a = tf.matmul(x,w1)
b = tf.matmul(a,w)
y = tf.matmul(b,w2)

loss = tf.reduce_mean(tf.square(y-y_))
train_step = tf.train.GradientDescentOptimizer(0.001).minimize(loss)

with tf.Session() as sess:
    init_op = tf.global_variables_initializer()
    sess.run(init_op)
    print("w1 is :", sess.run(w1))
    print("w is :", sess.run(w))
    print("w2 is :", sess.run(w2))

    steps= 30000
    for i in range(steps):
        start = (i*BATCH_SIZE) % 32
        end = start + BATCH_SIZE
        sess.run(train_step, feed_dict={x:X[start:end], y_:Y[start:end]})
        if i % 5000 == 0:
            total_loss = sess.run(loss, feed_dict={x:X, y_:Y})
            print("After %d training steps, loss on all data is %g" %(i,total_loss))
    print("\n")
    print("w1 is :", sess.run(w1))
    print("w is :", sess.run(w))
    print("w2 is :", sess.run(w2))

```

### CNN train

``` python
import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data

mnist=input_data.read_data_sets("MNIST_data",one_hot = True)

batch_size = 100
n_batch = mnist.train.num_examples // batch_size

#初始化权值
def weight_variable(shape):
    return tf.Variable(tf.truncated_normal(shape,stddev =0.01))

#初始化偏置
def bias_variable(shape):
    return tf.Variable(tf.constant(0.1,shape= shape))

#定义卷积层
def conv2d(x,W):
    return tf.nn.conv2d(x,W,strides=[1,1,1,1],padding="SAME") 

#池化层定义
def max_pool_2x2(x):
    return tf.nn.max_pool(x,ksize =[1,2,2,1],strides=[1,2,2,1], padding = "SAME")

x = tf.placeholder(tf.float32,[None, 784])
y = tf.placeholder(tf.float32,[None,10])

x_image = tf.reshape(x,[-1,28,28,1])

#初始化第一个卷积层的权值和偏置，输入其要求的形状
W_convl = weight_variable([5,5,1,32]) #5x5的采样窗口大小，１通道对黑白，３通道对彩色
b_convl = bias_variable([32])

#现在卷积
h_conv1 = tf.nn.relu(conv2d(x_image,W_convl) +b_convl)
#现在池化
h_pool1 = max_pool_2x2(h_conv1) 


W_convl2 = weight_variable([5,5,32,64]) #5x5的采样窗口大小，１通道对黑白，３通道对彩色
b_convl2 = bias_variable([64])

#现在卷积
h_conv2 = tf.nn.relu(conv2d(h_pool1 ,W_convl2) +b_convl2)
#现在池化
h_pool2 = max_pool_2x2(h_conv2)

#池化后将结果扁平化处理，以便输入网络
h_pool2_flat = tf.reshape(h_pool2, [-1,7*7*64])

#建立第一个神经网络的全连接层，初始化其权重和偏置
W_fcl = weight_variable([7*7*64, 100])
b_fcl = bias_variable([100])

#第一层的计算
h_fcl = tf.nn.relu(tf.matmul(h_pool2_flat, W_fcl) + b_fcl)

#dropout
keep_prob = tf.placeholder(tf.float32)
h_fcl_drop = tf.nn.dropout(h_fcl, keep_prob)

#建立第二个神经层
W_fc2 = weight_variable([100,10])
b_fc2 = bias_variable([10])
prediction = tf.nn.softmax(tf.matmul(h_fcl_drop, W_fc2)+b_fc2)

#交叉熵
cross_entropy = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels = y, logits=prediction))
#优化
train_step = tf.train.AdamOptimizer(1e-4).minimize(cross_entropy)

#结果
correct_prediction = tf.equal(tf.argmax(prediction,1),tf.argmax(y,1))
#准确率
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    for epoch in range(21):
        for batch in range(n_batch):
            batch_xs, batch_ys = mnist.train.next_batch(batch_size)
            sess.run(train_step, feed_dict={x:batch_xs, y:batch_ys, keep_prob:0.7})
        acc= sess.run(accuracy, feed_dict={x:mnist.test.images,y:mnist.test.labels, keep_prob:1.0})
        print("在第"+str(epoch)+"轮，准确率为"+str(acc))

```

### classification

``` python

# Youku video tutorial: http://i.youku.com/pythontutorial

"""
Please note, this code is only for python 3+. If you are using python 2+, please modify the code accordingly.
"""
from __future__ import print_function
import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data
# number 1 to 10 data
mnist = input_data.read_data_sets('MNIST_data', one_hot=True)

def add_layer(inputs, in_size, out_size, activation_function=None,):
    # add one more layer and return the output of this layer
    Weights = tf.Variable(tf.random_normal([in_size, out_size]))
    biases = tf.Variable(tf.zeros([1, out_size]) + 0.1,)
    Wx_plus_b = tf.matmul(inputs, Weights) + biases
    if activation_function is None:
        outputs = Wx_plus_b
    else:
        outputs = activation_function(Wx_plus_b,)
    return outputs

def compute_accuracy(v_xs, v_ys):
    global prediction
    y_pre = sess.run(prediction, feed_dict={xs: v_xs})
    correct_prediction = tf.equal(tf.argmax(y_pre,1), tf.argmax(v_ys,1))
    accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
    result = sess.run(accuracy, feed_dict={xs: v_xs, ys: v_ys})
    return result

# define placeholder for inputs to network
xs = tf.placeholder(tf.float32, [None, 784]) # 28x28
ys = tf.placeholder(tf.float32, [None, 10])

# add output layer
prediction = add_layer(xs, 784, 10,  activation_function=tf.nn.softmax)

# the error between prediction and real data
cross_entropy = tf.reduce_mean(-tf.reduce_sum(ys * tf.log(prediction),
                                              reduction_indices=[1]))       # loss
train_step = tf.train.GradientDescentOptimizer(0.5).minimize(cross_entropy)

sess = tf.Session()
# important step
# tf.initialize_all_variables() no long valid from
# 2017-03-02 if using tensorflow >= 0.12
if int((tf.__version__).split('.')[1]) < 12 and int((tf.__version__).split('.')[0]) < 1:
    init = tf.initialize_all_variables()
else:
    init = tf.global_variables_initializer()
sess.run(init)

for i in range(1000):
    batch_xs, batch_ys = mnist.train.next_batch(100)
    sess.run(train_step, feed_dict={xs: batch_xs, ys: batch_ys})
    if i % 50 == 0:
        print(compute_accuracy(
            mnist.test.images, mnist.test.labels))


```

### optimizer varialbe (with error)

``` python
# View more python learning tutorial on my Youtube and Youku channel!!!

# Youtube video tutorial: https://www.youtube.com/channel/UCdyjiB5H8Pu7aDTNVXTTpcg
# Youku video tutorial: http://i.youku.com/pythontutorial

"""
Please note, this code is only for python 3+. If you are using python 2+, please modify the code accordingly.
"""
from __future__ import print_function
import tensorflow as tf
import numpy as np


def add_layer(inputs, in_size, out_size, n_layer, activation_function=None):
    # add one more layer and return the output of this layer
    layer_name = 'layer%s' % n_layer
    with tf.name_scope(layer_name):
        with tf.name_scope('weights'):
            Weights = tf.Variable(tf.random_normal([in_size, out_size]), name='W')
            tf.summary.histogram(layer_name + '/weights', Weights)
        with tf.name_scope('biases'):
            biases = tf.Variable(tf.zeros([1, out_size]) + 0.1, name='b')
            tf.summary.histogram(layer_name + '/biases', biases)
        with tf.name_scope('Wx_plus_b'):
            Wx_plus_b = tf.add(tf.matmul(inputs, Weights), biases)
        if activation_function is None:
            outputs = Wx_plus_b
        else:
            outputs = activation_function(Wx_plus_b, )
        tf.summary.histogram(layer_name + '/outputs', outputs)
    return outputs


# Make up some real data
x_data = np.linspace(-1, 1, 300)[:, np.newaxis]
noise = np.random.normal(0, 0.05, x_data.shape)
y_data = np.square(x_data) - 0.5 + noise

# define placeholder for inputs to network
with tf.name_scope('inputs'):
    xs = tf.placeholder(tf.float32, [None, 1], name='x_input')
    ys = tf.placeholder(tf.float32, [None, 1], name='y_input')

# add hidden layer
l1 = add_layer(xs, 1, 10, n_layer=1, activation_function=tf.nn.relu)
# add output layer
prediction = add_layer(l1, 10, 1, n_layer=2, activation_function=None)

# the error between prediciton and real data
with tf.name_scope('loss'):
    loss = tf.reduce_mean(tf.reduce_sum(tf.square(ys - prediction),
                                        reduction_indices=[1]))
    tf.summary.scalar('loss', loss)

with tf.name_scope('train'):
    train_step = tf.train.GradientDescentOptimizer(0.1).minimize(loss)

sess = tf.Session()
merged = tf.summary.merge_all()

writer = tf.summary.FileWriter("logs/", sess.graph)

init = tf.global_variables_initializer()
sess.run(init)

for i in range(1000):
    sess.run(train_step, feed_dict={xs: x_data, ys: y_data})
    if i % 50 == 0:
        result = sess.run(merged,
                          feed_dict={xs: x_data, ys: y_data})
        writer.add_summary(result, i)

# direct to the local dir and run this in terminal:
# $ tensorboard --logdir logs


```

### dropout

``` python
import tensorflow as tf
import numpy as np
from tensorflow.examples.tutorials.mnist import input_data
#载入数据集
mnist= input_data.read_data_sets('MNIST_data', one_hot = True)

#设定每个批次的大小
batch_size = 100
#计算总共的批次
n_batch = mnist.train.num_examples//batch_size

x = tf.placeholder(tf.float32,[None,784])
y = tf.placeholder(tf.float32,[None,10])
keep_prob = tf.placeholder(tf.float32)
#构建神经网络
W = tf.Variable(tf.truncated_normal([784,2000], stddev = 0.1))
B = tf.Variable(tf.zeros([2000])+0.1)
p1 = tf.nn.softmax(tf.matmul(x,W)+B)
p1_dropout = tf.nn.dropout(p1,keep_prob)

W1 = tf.Variable(tf.truncated_normal([2000,2000]))
B1 = tf.Variable(tf.zeros([2000])+0.1)
p2 = tf.nn.softmax(tf.matmul(p1_dropout,W1)+B1)
p2_dropout = tf.nn.dropout(p2,keep_prob)

W2 = tf.Variable(tf.truncated_normal([2000,10]))
B2 = tf.Variable(tf.zeros([10])+0.1)
prediction = tf.nn.softmax(tf.matmul(p2_dropout,W2)+B2)

#定义二次代价函数
#loss = tf.reduce_mean(tf.square(y-prediction))
#重新定义对数(交叉熵)
loss =tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels=y, logits=prediction))
#使用梯度下降法
train_step = tf.train.GradientDescentOptimizer(0.2).minimize(loss)

#初始化
init = tf.global_variables_initializer()

#测试准确率
correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(prediction,1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction,tf.float32))

#训练开始
with tf.Session() as sess:
    sess.run(init)
    for epoch in range(21):
        for batch in range(n_batch):
            batch_xs, batch_ys = mnist.train.next_batch(batch_size)
            sess.run(train_step, feed_dict={x:batch_xs, y:batch_ys,keep_prob:1.0})

        test_acc = sess.run(accuracy,feed_dict={x:mnist.test.images, y:mnist.test.labels, keep_prob:1.0})
        train_acc = sess.run(accuracy,feed_dict={x:mnist.train.images, y:mnist.train.labels, keep_prob:1.0})
        print("准确率为:　在"+str(epoch)+"回,"+str(test_acc)+", 但是在训练集中为"+str(train_acc))


```

### number identification

``` python
import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data
#载入数据集
mnist= input_data.read_data_sets('MNIST_data', one_hot = True)

#设定每个批次的大小
batch_size = 100
#计算总共的批次
n_batch = mnist.train.num_examples // batch_size

x = tf.placeholder(tf.float32,[None,784])
y = tf.placeholder(tf.float32,[None,10])
keep_prob = tf.placeholder(tf.float32)
lr= tf.Variable(0.001,dtype=tf.float32)
#构建神经网络

# W = tf.Variable(tf.truncated_normal([784,10]))
# B = tf.Variable(tf.zeros([10])+0.1)
# prediction = tf.nn.softmax(tf.matmul(x,W)+B)

# W = tf.Variable(tf.zeros([784,10]))
# B = tf.Variable(tf.zeros([10]))
# prediction = tf.nn.softmax(tf.matmul(x,W)+B)

#构建神经网络
W = tf.Variable(tf.truncated_normal([784,500],stddev =0.1))
B = tf.Variable(tf.zeros([500])+0.1)
p1 = tf.nn.tanh(tf.matmul(x,W)+B)
p1_dropout = tf.nn.dropout(p1,keep_prob)

W1 = tf.Variable(tf.truncated_normal([500,200],stddev=0.1))
B1 = tf.Variable(tf.zeros([200])+0.1)
p2 = tf.nn.tanh(tf.matmul(p1_dropout,W1)+B1)
p2_dropout = tf.nn.dropout(p2,keep_prob)

W2 = tf.Variable(tf.truncated_normal([200,10],stddev = 0.1))
B2 = tf.Variable(tf.zeros([10])+0.1)
prediction = tf.nn.softmax(tf.matmul(p2_dropout,W2)+B2)



#定义二次代价函数
#loss = tf.reduce_mean(tf.square(y-prediction))
#重新定义对数(交叉熵)
loss =tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(labels=y,logits=prediction))
#使用梯度下降法
#train_step = tf.train.GradientDescentOptimizer(0.2).minimize(loss)
train_step = tf.train.AdamOptimizer(lr).minimize(loss)
#初始化
init = tf.global_variables_initializer()

#测试准确率
correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(prediction,1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction,tf.float32))

# #训练开始
# with tf.Session() as sess:
#     sess.run(init)
#     for epoch in range(20):
#         for batch in range(n_batch):
#             batch_xs, batch_ys = mnist.train.next_batch(batch_size)
#             sess.run(train_step, feed_dict={x:batch_xs, y:batch_ys})
#         acc = sess.run(accuracy,feed_dict={x:mnist.test.images, y:mnist.test.labels})
#         print("准确率为:　在"+str(epoch)+"回,"+str(acc))


#训练开始
with tf.Session() as sess:
    sess.run(init)
    for epoch in range(41):
        sess.run(tf.assign(lr,0.001*(0.95**epoch)))
        for batch in range(n_batch):
            batch_xs, batch_ys = mnist.train.next_batch(batch_size)
            sess.run(train_step, feed_dict={x:batch_xs, y:batch_ys,keep_prob:1.0})
        learing_rate = sess.run(lr)
        test_acc = sess.run(accuracy,feed_dict={x:mnist.test.images,
y:mnist.test.labels, keep_prob:1.0})
        train_acc = sess.run(accuracy,feed_dict={x:mnist.train.images,
y:mnist.train.labels, keep_prob:1.0})
        print("准确率为:　在"+str(epoch)+"回,"+str(test_acc)+",但是在训练集中为"+str(train_acc)+"同时学习率为"+str(learing_rate))


```

### with L regularizer

``` python

import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
BATCH_SIZE = 30
seed = 2
rdm = np.random.RandomState(seed)
X = rdm.randn(300,2)
Y_ = [int(x0*x0 + x1*x1 < 2) for (x0,x1) in X]
Y_c = [['red' if y else 'blue'] for y in Y_]
X = np.vstack(X).reshape(-1,2)
Y_ = np.vstack(Y_).reshape(-1,1)
print(X)
print(Y_)
print(Y_c)
plt.scatter(X[:,0],X[:,1], c = np.squeeze(Y_c))
plt.show()

def get_weight(shape, regularizer):
    w = tf.Variable(tf.random_normal(shape), dtype = tf.float32)
    tf.add_to_collection('losses', tf.contrib.layers.l2_regularizer(regularizer)(w))
    return w
def get_bias(shape):
    b = tf.Variable(tf.constant(0.01, shape=shape))
    return b
x = tf.placeholder(tf.float32, shape=(None, 2))
y_ = tf.placeholder(tf.float32, shape = (None , 1))
w1 = get_weight([2,11], 0.01)
b1 = get_bias([11])
y1 = tf.nn.relu(tf.matmul(x,w1)+b1)
w2 = get_weight([11,1],0.01)
b2 = get_bias([1])
y = tf.matmul(y1,w2)+b2

loss_mse = tf.reduce_mean(tf.square(y-y_))
loss_total = loss_mse + tf.add_n(tf.get_collection('losses'))


train_step_l = tf.train.AdamOptimizer(0.0001).minimize(loss_total)
with tf.Session() as sess:
    init_op = tf.global_variables_initializer()
    sess.run(init_op)
    STEPS = 40000
    for i in range(STEPS):
        start = (i*BATCH_SIZE) % 300
        end = start + BATCH_SIZE
        sess.run(train_step_l, feed_dict = {x:X[start:end], y_:Y_[start:end]})
        if i % 2000 == 0:
            loss_total_v = sess.run(loss_total, feed_dict={x:X,y_:Y_})
            print('After %d steps, loss is: %f' %(i, loss_total_v))
    xx, yy = np.mgrid[-3:3:0.01, -3:3:0.01]
    grid = np.c_[xx.ravel(), yy.ravel()]
    probs = sess.run(y, feed_dict={x:grid})
    probs = probs.reshape(xx.shape)
    print ('w1 is \n:', sess.run(w1))
    print ('b1 is \n:', sess.run(b1))
    print ('w2 is \n:', sess.run(w2))
    print ('b2 is \n:', sess.run(b2))
plt.scatter(X[:,0], X[:,1], c = np.squeeze(Y_c))
plt.contour(xx, yy, probs, levels = [.5])
plt.show()


print('loss_mse_v * loss_total_v is :', loss_mse_v*loss_total_v)


```

### without L regularizer

``` python
import tensorflow as tf
import numpy as np
import matplotlib.pyplot as plt
BATCH_SIZE = 30
seed = 2
rdm = np.random.RandomState(seed)
X = rdm.randn(300,2)
Y_ = [int(x0*x0 + x1*x1 < 2) for (x0,x1) in X]
Y_c = [['red' if y else 'blue'] for y in Y_]
X = np.vstack(X).reshape(-1,2)
Y_ = np.vstack(Y_).reshape(-1,1)
print(X)
print(Y_)
print(Y_c)
plt.scatter(X[:,0],X[:,1], c = np.squeeze(Y_c))
plt.show()

def get_weight(shape, regularizer):
    w = tf.Variable(tf.random_normal(shape), dtype = tf.float32)
    tf.add_to_collection('losses', tf.contrib.layers.l2_regularizer(regularizer)(w))
    return w
def get_bias(shape):
    b = tf.Variable(tf.constant(0.01, shape=shape))
    return b
x = tf.placeholder(tf.float32, shape=(None, 2))
y_ = tf.placeholder(tf.float32, shape = (None , 1))
w1 = get_weight([2,11], 0.01)
b1 = get_bias([11])
y1 = tf.nn.relu(tf.matmul(x,w1)+b1)
w2 = get_weight([11,1],0.01)
b2 = get_bias([1])
y = tf.matmul(y1,w2)+b2

loss_mse = tf.reduce_mean(tf.square(y-y_))
loss_total = loss_mse + tf.add_n(tf.get_collection('losses'))

train_step = tf.train.AdamOptimizer(0.0001).minimize(loss_mse)
with tf.Session() as sess:
    init_op = tf.global_variables_initializer()
    sess.run(init_op)
    STEPS = 40000
    for i in range(STEPS):
        start = (i*BATCH_SIZE) % 300
        end = start + BATCH_SIZE
        sess.run(train_step, feed_dict = {x:X[start:end], y_:Y_[start:end]})
        if i % 2000 == 0:
            loss_mse_v = sess.run(loss_mse, feed_dict={x:X,y_:Y_})
            print('After %d steps, loss is: %f' %(i, loss_mse_v))
    xx, yy = np.mgrid[-3:3:0.01, -3:3:0.01]
    grid = np.c_[xx.ravel(), yy.ravel()]
    probs = sess.run(y, feed_dict={x:grid})
    probs = probs.reshape(xx.shape)
    print ('w1 is \n:', sess.run(w1))
    print ('b1 is \n:', sess.run(b1))
    print ('w2 is \n:', sess.run(w2))
    print ('b2 is \n:', sess.run(b2))
plt.scatter(X[:,0], X[:,1], c = np.squeeze(Y_c))
plt.contour(xx, yy, probs, levels = [.5])
plt.show()


```

### exponen decay with L regularizer(this has error)

``` python
import numpy as np
import matplotlib.pyplot as plt


try:
    import opt4_8_generateds
    import opt4_8_forward
except:
    import pip 
    pip.main(['install','opt4_8_forward'])
    pip.main(['install','opt4_8_generateds'])
    import opt4_8_generateds
    import opt4_8_forward



STEPS = 40000
BATCH_SIZE = 30
LEARNING_RATE_BASE = 0.001
LEARNING_RATE_DECAY = 0.999
REGULARIZER = 0.01

def backward():
    x = tf.placeholder(tf.float32, shape = (None,2))
    y_ = tf.placeholder(tf.float32, shape = (None,1))

    x , Y_, Y_c = opt4_8_generateds.generateds()
    y = opt4_8_forward.forward(x,REGULARIZER)

    global_steps = tf.Variable(0, trainable= False)
    learning_rate = tf.train.exponential_decay(
        LEARNING_RATE_BASE,
        global_steps,
        300/BATCH_SIZE,
        LEARNING_RATE_DECAY,
        staircase = True)
    loss_mse = tf.reduce_mean(tf.square(y-y_))
    loss_total = loss_mse + tf.add_n(tf.get_collection('losses'))

    train_step = tf.train.AdamOptimizer(learning_rate).minimizer(loss_total)

    with tf.Session() as sess:
        init_op = tf.global_variables_initializer()
        sess.run(init_op)
        for i in range(STEPS):
            start = (i*BATCH_SIZE) % 300
            end = start + BATCH_SIZE
            sess.run(train_step, feed_dict = {x:X[start:end], y_:Y_[start:end]})
            if i % 2000 == 0:
                loss_v = sess.run(loss_total, feed_dict={x:X,y_:Y_})
                print('After %d steps, loss is: %f' %(i, loss_v))
        xx, yy = np.mgrid[-3:3:0.01, -3:3:0.01]
        grid = np.c_[xx.ravel(), yy.ravel()]
        probs = sess.run(y, feed_dict={x:grid})
        probs = probs.reshape(xx.shape)

    plt.scatter(X[:,0], X[:,1], c = np.squeeze(Y_c))
    plt.contour(xx, yy, probs, levels = [.5])
    plt.show()

if __name__ == '__main__':
    backward()


```

### read date for variables

``` {.python results="output"}
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets('./data', one_hot = True)

# print(mnist.train.labels[0])
# print(mnist.train.images[0])

BATCH_SIZE = 200
xs, ys = mnist.train.next_batch(BATCH_SIZE)
print("xs shape :", xs.shape)
print("ys shape :", ys.shape)


```

```{=org}
#+startup: content
```
## keras

### classification

``` python


# please note, all tutorial code are running under python3.5.
# If you use the version like python2.7, please modify the code accordingly

# 5 - Classifier example

import numpy as np
np.random.seed(1337)  # for reproducibility
from keras.datasets import mnist
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import Dense, Activation
from keras.optimizers import RMSprop

# download the mnist to the path '~/.keras/datasets/' if it is the first time to be called
# X shape (60,000 28x28), y shape (10,000, )
(X_train, y_train), (X_test, y_test) = mnist.load_data()

# data pre-processing
X_train = X_train.reshape(X_train.shape[0], -1) / 255.   # normalize
X_test = X_test.reshape(X_test.shape[0], -1) / 255.      # normalize
y_train = np_utils.to_categorical(y_train, num_classes=10)
y_test = np_utils.to_categorical(y_test, num_classes=10)

# Another way to build your neural net
model = Sequential([
    Dense(32, input_dim=784),
    Activation('relu'),
    Dense(10),
    Activation('softmax'),
])

# Another way to define your optimizer
rmsprop = RMSprop(lr=0.001, rho=0.9, epsilon=1e-08, decay=0.0)

# We add metrics to get more results you want to see
model.compile(optimizer=rmsprop,
              loss='categorical_crossentropy',
              metrics=['accuracy'])

print('Training ------------')
# Another way to train the model
model.fit(X_train, y_train, epochs=2, batch_size=32)

print('\nTesting ------------')
# Evaluate the model with the metrics we defined earlier
loss, accuracy = model.evaluate(X_test, y_test)

print('test loss: ', loss)
print('test accuracy: ', accuracy)

```

### regression

``` python
# # please note, all tutorial code are running under python3.5.
# # If you use the version like python2.7, please modify the code accordingly

# # 4 - Regressor example

import numpy as np
np.random.seed(1337)  # for reproducibility
from keras.models import Sequential
from keras.layers import Dense
import matplotlib.pyplot as plt

# create some data
X = np.linspace(-1, 1, 200)
np.random.shuffle(X)    # randomize the data
Y = 0.5 * X + 2 + np.random.normal(0, 0.05, (200 ))
# plot data
plt.scatter(X, Y)
plt.show()

X_train, Y_train = X[:160], Y[:160]     # first 160 data points
X_test, Y_test = X[160:], Y[160:]       # last 40 data points

# build a neural network from the 1st layer to the last layer
model = Sequential()

model.add(Dense(units=1, input_dim=1)) 

# choose loss function and optimizing method
model.compile(loss='mse', optimizer='sgd')

# training
print('Training -----------')
for step in range(301):
    cost = model.train_on_batch(X_train, Y_train)
    if step % 100 == 0:
        print('train cost: ', cost)

# test
print('\nTesting ------------')
cost = model.evaluate(X_test, Y_test, batch_size=40)
print('test cost:', cost)
W, b = model.layers[0].get_weights()
print('Weights=', W, '\nbiases=', b)

# plotting the prediction
Y_pred = model.predict(X_test)
plt.scatter(X_test, Y_test)
plt.plot(X_test, Y_pred)
plt.show()
```

## sklearn

### decisiontree

``` python
from sklearn.feature_extraction import DictVectorizer
import csv
from sklearn import preprocessing
from sklearn import tree
from sklearn.externals.six import StringIO
import numpy as np
import pandas as pd
from pylab import *

allElectronicsData = open("computer.csv")
reader = csv.reader(allElectronicsData)
headers = next(reader)
print(headers)
print(reader)

featureList = []
labelList = []
for row in reader:
    labelList.append(row[len(row)-1])
    rowDict = {}
    for i in range(1,len(row)-1):
        rowDict[headers[i]] = row[i]
    featureList.append(rowDict)
print(featureList)

vec = DictVectorizer()
dummyX = vec.fit_transform(featureList).toarray()
print("dummyX: " + str(dummyX))
print(vec.get_feature_names())

print("labeList" + str(labelList))
lb = preprocessing.LabelBinarizer()
dummyY = lb.fit_transform(labelList)
print("dummyY:" + str(dummyY))

clf = tree.DecisionTreeClassifier(criterion= 'entropy')
clf = clf.fit(dummyX,dummyY)
print("clf :" + str(clf))

# save as dot
with open("output.dot","w") as f:
    f = tree.export_graphviz(clf, feature_names= vec.get_feature_names(), out_file = f)

#in terminnal gives the flowwing comands

#    dot -Tpdf -O output.dot
#    xdg-open output.pdf

```

### cross validation 1

``` python
# View more python learning tutorial on my Youtube and Youku channel!!!

# Youtube video tutorial: https://www.youtube.com/channel/UCdyjiB5H8Pu7aDTNVXTTpcg
# Youku video tutorial: http://i.youku.com/pythontutorial

"""
Please note, this code is only for python 3+. If you are using python 2+, please modify the code accordingly.
"""
from __future__ import print_function
from sklearn.datasets import load_iris
from sklearn.cross_validation import train_test_split
from sklearn.neighbors import KNeighborsClassifier

iris = load_iris()
X = iris.data
y = iris.target

# test train split #
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=4)
knn = KNeighborsClassifier(n_neighbors=5)
knn.fit(X_train, y_train)
y_pred = knn.predict(X_test)
print(knn.score(X_test, y_test))

# this is cross_val_score #
from sklearn.cross_validation import cross_val_score
knn = KNeighborsClassifier(n_neighbors=5)
scores = cross_val_score(knn, X, y, cv=5, scoring='accuracy')
print(scores)

# this is how to use cross_val_score to choose model and configs #
from sklearn.cross_validation import cross_val_score
import matplotlib.pyplot as plt
k_range = range(1, 31)
k_scores = []
for k in k_range:
    knn = KNeighborsClassifier(n_neighbors=k)
    loss = -cross_val_score(knn, X, y, cv=10, scoring='mean_squared_error') # for regression
    k_scores.append(loss.mean())

plt.plot(k_range, k_scores)
plt.xlabel('Value of K for KNN')
plt.ylabel('Cross-Validated Accuracy')
plt.show()


```

### cross validation 2

``` python
# View more python learning tutorial on my Youtube and Youku channel!!!

# Youtube video tutorial: https://www.youtube.com/channel/UCdyjiB5H8Pu7aDTNVXTTpcg
# Youku video tutorial: http://i.youku.com/pythontutorial

"""
Please note, this code is only for python 3+. If you are using python 2+, please modify the code accordingly.
"""
from __future__ import print_function
from sklearn.learning_curve import  learning_curve
from sklearn.datasets import load_digits
from sklearn.svm import SVC
import matplotlib.pyplot as plt
import numpy as np

digits = load_digits()
X = digits.data
y = digits.target
train_sizes, train_loss, test_loss= learning_curve(
        SVC(gamma=0.01), X, y, cv=10, scoring='mean_squared_error',
        train_sizes=[0.1, 0.25, 0.5, 0.75, 1])
train_loss_mean = -np.mean(train_loss, axis=1)
test_loss_mean = -np.mean(test_loss, axis=1)

plt.plot(train_sizes, train_loss_mean, 'o-', color="r",
             label="Training")
plt.plot(train_sizes, test_loss_mean, 'o-', color="g",
             label="Cross-validation")

plt.xlabel("Training examples")
plt.ylabel("Loss")
plt.legend(loc="best")
plt.show()


```

### corss validation 3

``` python
# View more python learning tutorial on my Youtube and Youku channel!!!

# Youtube video tutorial: https://www.youtube.com/channel/UCdyjiB5H8Pu7aDTNVXTTpcg
# Youku video tutorial: http://i.youku.com/pythontutorial

"""
Please note, this code is only for python 3+. If you are using python 2+, please modify the code accordingly.
"""
from __future__ import print_function
from sklearn.learning_curve import  validation_curve
from sklearn.datasets import load_digits
from sklearn.svm import SVC
import matplotlib.pyplot as plt
import numpy as np

digits = load_digits()
X = digits.data
y = digits.target
param_range = np.logspace(-6, -2.3, 5)
train_loss, test_loss = validation_curve(
        SVC(), X, y, param_name='gamma', param_range=param_range, cv=10,
        scoring='mean_squared_error')
train_loss_mean = -np.mean(train_loss, axis=1)
test_loss_mean = -np.mean(test_loss, axis=1)

plt.plot(param_range, train_loss_mean, 'o-', color="r",
             label="Training")
plt.plot(param_range, test_loss_mean, 'o-', color="g",
             label="Cross-validation")

plt.xlabel("gamma")
plt.ylabel("Loss")
plt.legend(loc="best")
plt.show()


```

### data application

``` python
# View more python learning tutorial on my Youtube and Youku channel!!!

# Youtube video tutorial: https://www.youtube.com/channel/UCdyjiB5H8Pu7aDTNVXTTpcg
# Youku video tutorial: http://i.youku.com/pythontutorial

"""
Please note, this code is only for python 3+. If you are using python 2+, please modify the code accordingly.
"""
from __future__ import print_function
from sklearn import datasets
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

loaded_data = datasets.load_boston()
data_X = loaded_data.data
data_y = loaded_data.target

model = LinearRegression()
model.fit(data_X, data_y)

print(model.predict(data_X[:4, :]))
print(data_y[:4])

X, y = datasets.make_regression(n_samples=100, n_features=1, n_targets=1, noise=1)
plt.scatter(X, y)
plt.show()


```

### eigenschaft function

``` python
# View more python learning tutorial on my Youtube and Youku channel!!!

# Youtube video tutorial: https://www.youtube.com/channel/UCdyjiB5H8Pu7aDTNVXTTpcg
# Youku video tutorial: http://i.youku.com/pythontutorial

"""
Please note, this code is only for python 3+. If you are using python 2+, please modify the code accordingly.
"""
from __future__ import print_function
from sklearn import datasets
from sklearn.linear_model import LinearRegression

loaded_data = datasets.load_boston()
data_X = loaded_data.data
data_y = loaded_data.target

model = LinearRegression()
model.fit(data_X, data_y)

print(model.predict(data_X[:4, :]))
print(model.coef_)
print(model.intercept_)
print(model.get_params())
print(model.score(data_X, data_y)) # R^2 coefficient of determination


```

### iris

View more python learning tutorial on my Youtube and Youku channel!!!

Youtube video tutorial:
<https://www.youtube.com/channel/UCdyjiB5H8Pu7aDTNVXTTpcg> Youku video
tutorial: <http://i.youku.com/pythontutorial>

``` python

"""
Please note, this code is only for python 3+. If you are using python 2+, please modify the code accordingly.
"""
from __future__ import print_function
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier

iris = datasets.load_iris()
iris_X = iris.data
iris_y = iris.target


X_train, X_test, y_train, y_test = train_test_split(
    iris_X, iris_y, test_size=0.3)


knn = KNeighborsClassifier()
knn.fit(X_train, y_train)
print(knn.predict(X_test))
print(y_test)


```

### normnalization

``` python
# View more python learning tutorial on my Youtube and Youku channel!!!

# Youtube video tutorial: https://www.youtube.com/channel/UCdyjiB5H8Pu7aDTNVXTTpcg
# Youku video tutorial: http://i.youku.com/pythontutorial

"""
Please note, this code is only for python 3+. If you are using python 2+, please modify the code accordingly.
"""
from __future__ import print_function
from sklearn import preprocessing
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.datasets.samples_generator import make_classification
from sklearn.svm import SVC
import matplotlib.pyplot as plt

a = np.array([[10, 2.7, 3.6],
                     [-100, 5, -2],
                     [120, 20, 40]], dtype=np.float64)
print(a)
print(preprocessing.scale(a))

X, y = make_classification(n_samples=300, n_features=2 , n_redundant=0, n_informative=2, random_state=22, n_clusters_per_class=1, scale=100)
plt.scatter(X[:, 0], X[:, 1], c=y)
plt.show()
X = preprocessing.scale(X)    # normalization step
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=.3)
clf = SVC()
clf.fit(X_train, y_train)
print(clf.score(X_test, y_test))


```

### save load

``` python
# View more python tutorials on my Youtube and Youku channel!!!

# Youtube video tutorial: https://www.youtube.com/channel/UCdyjiB5H8Pu7aDTNVXTTpcg
# Youku video tutorial: http://i.youku.com/pythontutorial

"""
Please note, this code is only for python 3+. If you are using python 2+, please modify the code accordingly.
"""
from __future__ import print_function
from sklearn import svm
from sklearn import datasets

clf = svm.SVC()
iris = datasets.load_iris()
X, y = iris.data, iris.target
clf.fit(X, y)

# # method 1: pickle
# import pickle
# # save
# with open('save/clf.pickle', 'wb') as f:
#     pickle.dump(clf, f)
# # restore
# with open('save/clf.pickle', 'rb') as f:
#    clf2 = pickle.load(f)
#    print(clf2.predict(X[0:1]))

# method 2: joblib
from sklearn.externals import joblib
# Save
joblib.dump(clf, 'save/clf.pkl')
# restore
clf3 = joblib.load('save/clf.pkl')
print(clf3.predict(X[0:1]))


```

## theano

### basic

``` {.python results="output"}
# View more python tutorials on my Youtube and Youku channel!!!

# Youtube video tutorial: https://www.youtube.com/channel/UCdyjiB5H8Pu7aDTNVXTTpcg
# Youku video tutorial: http://i.youku.com/pythontutorial

# 4 - basic usage
#   from __future__ import print_function
import numpy as np
import theano.tensor as T
from theano import function

# basic
x = T.dscalar('x')
y = T.dscalar('y')
z = x+y     # define the actual function in here
f = function([x, y], z)  # the inputs are in [], and the output in the "z"

print(f(2,3))  # only give the inputs "x and y" for this function, then it will calculate the output "z"

# # to pretty-print the function
from theano import pp
print(pp(z))

# # how about matrix
x = T.dmatrix('x')
y = T.dmatrix('y')
z = x + y
f = function([x, y], z)
print(f(np.arange(12).reshape((3,4)), 10*np.ones((3,4))))


```

# Tensorflow 2

## Tensorflow foundation

### 数值类型

  -------- ------ ----------- ------------------------
  type     diam   shape       function
  Scalar   0      \[\]        acc
  Vector   1      \[n,\]      bias (b)
  Matrix   2      \[n, m\]    weight (W)
  Tensor   lg 3   \[n,m,p\]   input ( \[n, h, w, 3\]
  -------- ------ ----------- ------------------------

``` python

a = tf.constant(example)
tf.constant()  # 功能类似于tf.convert_to_tensor()
b = tf.constant('Hello Deep learning')
c = tf.constant(True)
dtype=tf.int16, int32, int64,tf.float16, tf.float32, tf.float64
tf.cast(a, tf.float64)
tf.Variable(a)    #可以添加a的可训练属性
tf.zeros([n,m])  tf.zeros_like(a)  == tf.zeros(a.shape)
tf.ones([n,m])   tf.ones_like(a)   == tf.ones(a.shape)
tf.fill([2,2],10)
tf.random.normal([2,2]) == tf.random.normal([2,2], mean=0, stddev=1)
tf.random.uniform(shape, minval=0,maxval=10,dtype=tf.float32)
tf.range(10) == tf.range(0,10, delta = 2)

```

### Reference(,) and Segment(:)

``` python
x = tf.random.normal([4,32,32,3])
x[2][1][0][1]  == x[2,1,0,1]

[start:end:step] for each dimension.
x[1:3:2, 1:4:2, 2:4:2, 1:3:2]

```

### 改变视图

x = tf.random.normal(\[4,32,32,3\]) 的数据是整体贮存的，可以合法的
reshape. 从后往前合并，拆分。

1.  增加维度

    增加前置维度 tf.expand~dims~(x, axis=0) 增加后置维度
    tf.expand~dims~(x, axis=-1)
    也可以是其他值，表示在相应的位置增加一个维度

2.  删除维度

    删除前置 tf.squeeze(x, axis=0) 后置和其他位置一样，删除dia=1的维度

### 交换维度

这会改变数据的贮存顺序 x = tf.random.normal(\[2,32,32,3\]) x =
tf.transpose(x, perm=\[0,3,1,2\]) 以前的维度下表变换为perm

### Broadcasting

### tile

x = tf.random.normal(\[4,32,32,3\]) y = tf.tile(x,\[2,3,3,1\])
对应维度各复制成原来的2，3，3，1倍。

### Concatenate & Stack & Split & unstack

tf.concat(\[a,b\],axis=0) 除了axis=0外的所有维度都应该一样
tf.stack(\[a,b\],axis=0) a,b的所有维度应该都一样，插入的位置和
expand~dims~() 遵守相同规则 tf.split(x, num~orsizesplits~=10, axis=0)
拆分的维度不消失 tf.unstack(x, axis=0) 拆为步长为1 拆分的维度消失

### Statistik

L1 Norm $||x_{1}|| = \sum_{i}|x_{i}|$ tf.norm(x, ord=1) L2 Norm
$||x_{2}|| = \sqrt{\sum_{i}|x_{i}|^2 }$ tf.norm(x,ord=2)

tf.reduce~max~(x, axis=0) tf.reduce~min~() tf.reduce~mean~()
tf.reduce~sum~() 不指明axis则是对全局求解 tf.argmax(x, axis)
tf.argmin(x,axis) axis 轴的极值坐标

``` python

out = tf.random.normal([100,10])
out = tf.nn.softmax(out, axis=1)
pred = tf.argmax(out, axis=1)
y = tf.random.uniform([100],dtype=tf.int64,maxval=10)
out = tf.equal(pred, y)
out = tf.cast(out, dtype=tf.float32)
cor = tf.reduce_sum(out)
```

### Padding

    x = tf.pad(x,[[0,2]]) []内是padding 填充的方案，每个[]表示一个维度

### advance manipulation

### tf.minimum

tf.minimum(x, a) 最小a tf.maximum(x, b) 最大b
tf.minimum(tf.maximum(x,2),7) == tf.clip~byvalue~(x,2,7)

### tf.gather

tf.gather(x, \[0,2,4,5,7\],axis =1)
抽取在axis=1上的\[0,2,4,5,7\]坐标的组
成数据，并可以重新定义组成数据的顺序

### tf.gather~nd~

后面根的\[\]说明了所有成员要操作的维度，
第一成员的第一维坐标为1，第二维坐标为1.. 所有成员组成List

### tf.boolean~mask~

tf.boolean~mask~(x, mask=\[True, False, True, False\],axis =0)
在axis=0的轴上，只有mask成员是True才会被选中，mask 长度等于axis=0 轴的
长度。

### tf.where

``` python
a = tf.ones([3,3])
b = tf.zeros([3,3])
cond = tf.constant([True,False,False],[False, True, True],[False, False, False])
c = tf.where(cond, a,b)
```

tf.where(cond) 返回所有值为True元素的下标

``` python
x = tf.random.normal([3.3])
mask = x>0
ind = tf.where(mask)
a = tf.gather_nd(x,ind)
```

### tf.scatter~nd~

在一个长度为8的空白向量（全为0）里，将updates按照indices的位置写入

``` python
indices = tf.constant([[4],[3],[2],[1]])
updates = tf.constant([3,1,0,2])
tf.scatter_nd(indices, updates, [8])

```

### tf.meshgrid

``` python
x = tf.linspace(-8., 8, 100)   #-8后面的. 不能省略
y = tf.linspace(-8., 8, 100)
x.shape = 100
x, y = tf.meshgrid(x,y)
x.shape = [100,100]
ax.contour3D(x.numpy(), y.numpy(), z.numpy(), 50)

```

## chapter 01 code

一个很简单的例子，用tf来求某个函数的导数

``` {.python results="output"}
import tensorflow as tf
a = tf.constant(1.)
b = tf.constant(2.)
c = tf.constant(3.)
w = tf.constant(4.)

with tf.GradientTape() as tape:
    tape.watch([w])
    y = a*w**2 + b*w + c
[dy_dw] = tape.gradient(y, [w])
print(dy_dw)

```

检测cpu和gpu运行时的时间对比

``` {.python results="output"}
import tensorflow as tf
import timeit

n = 10000000
with tf.device('/cpu:0'):
    cpu_a = tf.random.normal([1, n])
    cpu_b = tf.random.normal([n, 1])

with tf.device('/gpu:0'):
    gpu_a = tf.random.normal([1, n])
    gpu_b = tf.random.normal([n, 1])

def cpu_run():
    with tf.device('/cpu:0'):
        c = tf.matmul(cpu_a, cpu_b)
    return c

def gpu_run():
    with tf.device('/gpu:0'):
        c = tf.matmul(gpu_a, cpu_b)
    return c

cpu_time = timeit.timeit(cpu_run, number=10)
gpu_time = timeit.timeit(cpu_run, number=10)
print('run time: ', cpu_time, gpu_time)



```

不用tensorflow的API，使用纯函数来实现神经网络训练的例子

``` {.python results="output"}
import numpy as np
data = []
for i in range(100):
    x = np.random.uniform(-10., 10)
    y = 1.477*x + 0.089 + np.random.normal(0., 0.01)
    data.append([x, y])
data = np.array(data)


def mse(b, w, points):
    totalError = 0
    for i in range(0, len(points)):
        x = points[i, 0]
        y = points[i, 1]
        totalError += (y-(w*x+b))**2
    return totalError/float(len(points))


def step_gradient(b_current, w_current, points, lr):
    b_gradient = 0
    w_gradient = 0
    M = float(len(points))
    for i in range(0, len(points)):
        x = points[i, 0]
        y = points[i, 1]
        b_gradient += (2/M)*((w_current*x+b_current)-y)
        w_gradient += (2/M)*x*((w_current*x + b_current)-y)
    new_b = b_current - (lr*b_gradient)
    new_w = w_current - (lr*w_gradient)
    return [new_b, new_w]


def gradient_descent(points, staring_b, staring_w, lr, num_iterations):
    b = staring_b
    w = staring_w
    for step in range(num_iterations):
        b, w = step_gradient(b, w, np.array(points), lr)
        loss = mse(b, w, points)
        if step % 5000  == 0:
            print(f"iterations:{step}, loss :{loss}, w:{w}, b:{b}")
    return [b, w]


def main():
    lr = 0.001
    initial_b = 0
    initial_w = 0
    num_iterations = 100000
    [b, w] = gradient_descent(data, initial_b, initial_w, lr, num_iterations)
    loss = mse(b, w, data)
    print(f"Final loss :{loss}, w:{w}, b:{b}")


# if __name__ ==' __main__':
main()


```

## MNIST dataset

``` {.python results="output" session="MNIST_image"}
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers, optimizers, datasets
w1 = tf.Variable(tf.random.truncated_normal([784, 256], stddev=0.1))
b1 = tf.Variable(tf.zeros([256]))
w2 = tf.Variable(tf.random.truncated_normal([256, 128], stddev=0.1))
b2 = tf.Variable(tf.zeros([128]))
w3 = tf.Variable(tf.random.truncated_normal([128, 10], stddev=0.1))
b3 = tf.Variable(tf.zeros([10]))
(x,y),(x_val, y_val)=datasets.mnist.load_data()
print('x:',x.shape, 'y:', y.shape,'x test:', x_val.shape, 'y test:', y_val)
def preprocess(x, y):
    x = tf.cast(x, dtype = tf.float32)/255.
    x = tf.reshape(x, [-1,28*28])
    y = tf.cast(y,dtype=tf.int32)
    y = tf.one_hot(y, depth=10)
    return x,y
train_db = tf.data.Dataset.from_tensor_slices((x,y))  #构建Dataset 对象
train_db = train_db.shuffle(10000)                    # 打散样本顺序
train_db = train_db.batch(128)                        #批训练
train_db = train_db.map(preprocess)
test_db = tf.data.Dataset.from_tensor_slices((x_val, y_val))
test_db = test_db.shuffle(1000)
test_db = test_db.batch(128)
test_db = test_db.map(preprocess)
lr = 0.001
for epoch in range(8):
    for step, (x,y) in enumerate(train_db):
        with tf.GradientTape() as tape:
            h1 = x@w1 + tf.broadcast_to(b1, [x.shape[0], 256])
            h1 = tf.nn.relu(h1)
            h2 = h1@w2 + b2
            h2 = tf.nn.relu(h2)
            out = h2@w3 + b3
            loss = tf.square(y - out)
            loss = tf.reduce_mean(loss)
            grads = tape.gradient(loss, [w1,b1,w2,b2,w3,b3])
            w1.assign_sub(lr *grads[0])
            b1.assign_sub(lr * grads[1])
            w2.assign_sub(lr *grads[2])
            b2.assign_sub(lr * grads[3])
            w3.assign_sub(lr *grads[4])
            b3.assign_sub(lr * grads[5])
for x, y in test_db:
    h1 = x@w1 + b1
    h1 = tf.nn.relu(h1)
    h2 = h1@w2 + b2
    h2 = tf.nn.relu(h2)
    out = h2@w3 + b3
    pred = tf.argmax(out,axis=1)
    y = tf.argmax(y, axis=1)
    correct = tf.equal(pred, y)
    total_correct +=tf.reduce_sum(tf.cast(correct,dty=tf.int32)).numpy()



```

## Make~moons~

all import

``` {.python session="make_moons"}
import seaborn as sns
import matplotlib.pyplot as plt
```

generate the data

``` {.python results="output" session="make_moons"}
from sklearn.datasets import make_moons
from sklearn.model_selection import train_test_split
N_samples = 2000
Test_size = 0.3
X, y = make_moons(n_samples = N_samples, noise = 0.2, random_state=100)
X_train, X_test, y_train, y_test = train_test_split(X, y,test_size = Test_size, random_state = 42)
print(X.shape, y.shape)
def make_plot(X, y, plot_name, file_name=None, XX=None, YY=None, preds=None,dark=False):
    if(dark):
        plt.style.use('dark_background')
    else:
        sns.set_style("whitegrid")
    plt.figure(figsize=(16,12))
    axes = plt.gca()
    axes.set(xlabel="$x_1$", ylabel="$x_2$")
    plt.title(plot_name,fontsize=30)
    plt.subplots_adjust(left=0.20)
    plt.subplots_adjust(right=0.8)
    if(XX is not None and YY is not None and preds is not None):
        plt.contourf(XX,YY,preds.reshape(XX.shape), 25, alpha=1,cmap = cm.Spectral)
        plt.contour(XX,YY, preds.reshape(XX.shape), levels=[.5],cmap="Greys", vmin=0,vmax=0.6)
        plt.scatter(X[:,0],X[:,1],c=y.ravel(), s=40, cmap=plt.cm.Spectral,edgecolors='none')
        plt.savefig('data.svg')
        plt.close()
make_plot(X,y,None,"Classification Dataset Visualization")
```

generate the signal Layer class

``` {.python session="make_moons"}
class Layer:
    def __init__(self, n_input, n_neurons,activation=None, weight=None,bias=None):
        self.weight = weight if weight is not None else np.random.randn(n_input,n_neurons)*np.sqrt(1/n_neurons)
        self.bias = bias if bias is not None else np.random.rand(n_neurons)*0.1
        self.activation = activation
        self.last_activation = None
        self.error = None
        self.delta = None
    def activate(self,x):
        r = np.dot(x, self.weight)+self.bias
        self.last_activation = self._apply_activation(r)
        return self.last_activation
    def _apply_activation(self, r):
        if self.activation is None:
            return r
        elif self.activation == 'relu':
            return np.maximum(r,0)
        elif self.activation == 'tanh':
            return np.tanh(r)
        elif self.activation == 'sigmoid':
            return 1/(1+np.exp(-r))
        return r
    def apply_activation_derivative(self, r):
        if self.activation is None:
            return np.ones_like(r)
        elif self.activation == 'relu':
            grad = np.array(r, copy=True)
            grad[r>0] = 1.
            grad[r<=0] =0.
            return grad
        elif self.activation == 'tanh':
            return 1-r**2
        elif self.activation == 'sigmoid':
            return r*(1-r)
        return r

```

generate the multi Layers Class NeuralNetwork

``` {.python session="make_moons"}
class NeuralNetwork:
    def __init__(self):
        self._layers = []
    def add_layer(self, layer):
        self._layers.append(layer)
    def feed_forward(self, X):
        for layer in self._layers:
            X = layer.activate(X)
        return X

    def backpropagation(self, X, y,learning_rate):
        output = self.feed_forward(X)
        for i in reversed(range(len(self._layers))):
            layer = self._layers[i]
            if layer == self._layers[-1]:
                layer.error = y-output
                layer.delta = layer.error*layer.apply_activation_derivative(output)
            else:
                next_layer = self._layers[i+1]
                layer.error = np.dot(next_layer.weights, next_layer.delta)
                layer.delta = layer.error*layer.apply_activation_derivative(layer.last_activation)

        for i in range(len(self._layers)):
            layer = self._layers[i]
            o_i = np.atleast_2d(X if i == 0 else  self._layers[i-1].last_activation)
            layer.weights += layer.delta*o_i.T*learning_rate


    def train(self, X_train, X_test, y_train, y_test, learning_rate, max_epochs):
        y_onehot = np.zeros((y_train.shape[0],2))
        y_onehot[np.arange(y_train.shape[0]),y_train] =1
        mses = []
        for i in range(max_epochs):
            for j in range(len(X_train)):
                self.backpropagation(X_train[j], y_onehot[j], learning_rate)
            if i%10 == 0:
                mse = np.mean(np.square(y_onehot - self.feed_forward(X_train)))
                mses.apply(mse)
                print('Epoch : #%s, MSE: %f' %(i, float(mse)))
                print('Accuracy: %.2f%%' %(self.accuracy(self.predict(X_test),y_test.flatten())*100))
        return mses


```

``` {.python session="make_moons"}
nn = Neuralnetwork()
nn.add_layer(Layer (2, 25, 'sigmoid'))
nn.add_layer(Layer(25, 50, 'sigmoid'))
nn.add_layer(Layer(50, 25, 'sigmoid'))
nn.add_layer(Layer(25, 2, 'sigmoid'))
nn.backpropagation(X_train,y_train,0.001)
nn.train(X_train, X_test, y_train, y_test, 0.001,20)


```

different Layers

``` {.python session="make_moons"}
for n in range(5):
    model = Sequential()
    model.add(Dense(8,input_dim=2,activation='relu'))
    for _ in range(n):
        model.add(Dense(32,activation='relu'))
    model.add(Dense(1,activation='sigmoid'))
    model.compile(loss='binary_crossentropy',optimizer='adam',metrics=['accuracy'])
    history = model.fit(X_train,y_train,epochs = 20, verbose=1)
    preds = model.predict_classes(np.c_[XX.ravel(), YY_ravel()])
    title = "网络层数({})".format(n)
    file = "网络容量 %f.png" %(2+n*1)
    make_plot(X_train,y_train, title,file,XX,YY,preds)


```

## Keras

### tf.keras

``` {.python results="output"}
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers

x = tf.constant([2., 1., 0.1])
print(tf.keras.layers.Softmax(axis=-1)(x))
print(tf.nn.softmax(x))

```

tf.keras.Model 是tf.keras.Sequential的父类(网络类）
Sequential类还有方法： Sequential.compile() Sequential.fit()
Sequential.predict()

tf.keras.layers.Layer 是网络层类的父类（网络层类）

### 模型的保存和加载

1.  保存数值

    Sequential.save~weights~(\'weights.ckpt\')
    重建了一样的网络后，重新加载
    Sequential.load~weights~(\'weights.ckpt\')

2.  保存框架

    tf.keras.Sequential.save(\'model.h5\')
    不需要重构模型，可以直接生成保存的模型 network =
    tf.keras.models.load~model~(\'model.h5\')

3.  跨系统平台保存恢复

    tf.saved~model~.save(network, \'model-savedmodel\')
    复制，分发该文件后，在跨平台上复现 network =
    tf.saved~model~.load(\'model-savedmodel\')

### self-def

自定义网络层类，继承Layer 自定义网络类，继承Model

## Dropout

tf.nn.dropout(x, rate = 0.5) model.add(layers.Dropout(rate=0.5))

## Data Augmentation

### resize

tf.image.resize(x,\[244,244\])

### rote

tf.image.rot90(x,1) k为1时，代表一个90度的g逆时针旋转

### flip

tf.image.random~flipleftright~(x) tf.image.random~flipupdown~(x)

### crop

先放大，再剪裁 tf.image.resize(x,\[244,244\])
tf.image.random~crop~(x,\[224,224,3\])

# IDE

## emacs

## Pycharm

  ---------- -----------------------------------
  M-1        open projects
  C-M-c      collapse 折叠代码
  C-M-e      expand 打开代码
  C-M-s      open Settings
  C-S-+      increasing fonts
  C-S+-      decreasing fonts
  C-S-0      reset fonts
  S-Esc      close
  S-tab      open in Emacs
  S-Enter    execute/run
  C-S-i      go to define file
  C-M-l      show line
  C-F12      close main bar
  C-M-x      exit
  C-A-\[\]   change in between opened projects
  C-ins      in project add a new file
  C-c C-p    execute python file
  C-c C-o    close (python) tab
  f11        Full screen
  A-.        open the relate source file
  ---------- -----------------------------------

## jupyter

``` {.bash org-language="sh"}
sudo apt install jupyter
sudo apt install jupyter lab
pip install jupyterthemes
jt -t monokai -f fira -fs 13 -nf ptsans -nfs 11 -N -kl -cursw 5 -cursc r -cellw 95% -T

```

Helf -\> edit shortcut

  ------------ ------------------------------
  j            next cell
  k            previous cell
  f            pull the cell to the top
  i            intercept cell
  c            clear results
  space        next site
  ctrl space   previous site
  ctrl enter   execute and to the next cell
  C-M-m        close mainbar
  C-M-n        close toolbar
  ------------ ------------------------------

# Flask

open development and debug mode

    export FLASK_APP=app
    export FLASK_DEBUG=1
    export FLASK_ENV=development
    flask run

# Django

## deployment

-   null=True if allow this to be empty in the input interface
-   blank=True if it\'s empty from the interface, if set it to be
    NULL(not good for strings filed)

# Golab notebook with Vim

1.  Cell model

      ------------- ---------------------------------
      j/k C-n/C-p   Cell之间上下移动
      Enter         to normal model or insert model
      ------------- ---------------------------------

2.  Normal Model

      ---------- ------------------------------------
      M-n/M-p    Cell 之间上下移动
      Markdown   双击右边的视图回到Cell model
      Code       点击左边执行框内阴影回到Cell model
      i          to insert model
      ---------- ------------------------------------

3.  Insert model

      ---------------- ------------------------------------
      Up/Down          行之间上下移动
      C-Left/C-right   词语之间左右移动
      M-Up/M-Down      行的上下互换
      Markdown         双击右边的视图回到Cell model
      Code             点击左边执行框内阴影回到Cell model
      ---------------- ------------------------------------

  ---- ---------------------
  w    next word front
  b    previous word front
  e    end of word
  i    insert front word
  I    insert front line
  a    insert end word
  A    insert end line
  o    insert line up
  O    insert line down
  u    redo
  x    delete char
  y    copy
  yy   copy line
  d    delete
  dd   delete line
  p    pasta
  gg   document begin
  G    document end
  ---- ---------------------

# test

``` {.python results="output"}
import os
os.system("ls -l")
```

# Exception

``` python
def example1():
    print("example 01")
    try:
        a = 10 / 0
    except ZeroDivisionError as e:
        print("catched")
        raise RuntimeError("Runtime error") from e
    except Exception as e:
        print(e.__class__.__name__)

def call():
    try:
        example1()
    except RuntimeError as e:
        print(e.__class__.__name__)
        print(e.args)
        print("Runtime Error")
    except Exception as e:
        print(e.__class__.__name__)
        print(e.args)

call()

```

.env not be share