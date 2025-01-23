Array
=====

  push   unshift   pop   shift
  ------ --------- ----- -------

``` {.javascript org-language="js" results="output" exports="both"}
let arrayy = ["Apple", "Banane", "Orange"]
console.log("push Krisch");
arrayy.push("Krisch")
console.log(arrayy);
console.log("unshift Biren");
arrayy.unshift("Biren")
console.log(arrayy);
console.log("pop");
arrayy.pop();  
console.log(arrayy);
console.log("shift");
arrayy.shift();  
console.log(arrayy);  

```

``` {.example}
push Krisch
[ 'Apple', 'Banane', 'Orange', 'Krisch' ]
unshift Biren
[ 'Biren', 'Apple', 'Banane', 'Orange', 'Krisch' ]
pop
[ 'Biren', 'Apple', 'Banane', 'Orange' ]
shift
[ 'Apple', 'Banane', 'Orange' ]
```

methods for Array

  ------------------------------------
  pop()
  push()
  shift()
  unshift()
  splice(0,1,2)
  slice(0,1)
  concat()
  sort(function(a,b)return(a-b))
  reverse()
  map(value, index, array)
  filter(value, index, array)
  reduce(total, value, index, array)
  every(value, index, array)
  some(value, index, array)
  indexOf()
  find(value, index, array)
  ------------------------------------

``` {.javascript org-language="js" results="output"}
function mymap(value, index, array){
  return value*array[index]
}
let arr = [1,2,3,4,5];
console.log(arr.map(mymap));
```

``` {.javascript org-language="js" results="output"}
function myreduce(total, value, index, array){
  return total+value*array[index]
}
let arr = [1,2,3,4,5];
console.log(arr.reduce(myreduce, 10));
```

set array 去重 求交
===================

``` {.javascript results="output"}
let arr = [1,2,3,4,5,6,7,4,5,6];
let arr2 = [2,4,6];
let result = [...new Set(arr)].filter(
  item => new Set(arr2).has(item)
);
console.log(result);
```

Class
=====

ES5
---

class mit generate function

``` {.javascript org-language="js" results="output"}
function Phone(brand, price){
    this.brand = brand;
    this.price = price;
}

Phone.prototype.call = function(){
    console.log("I want to make a phone");
}

let Huawei = new Phone("HuAwei", 5998);

console.log(Huawei)

```

ES6
---

``` {.javascript org-language="js" results="output"}
class Phone{
    constructor(brand, price){
        this.brand = brand;
        this.price = price;
    }

    call(){
        console.log("I will make a call");
    }
}

let onePlus = new  Phone("1+", 2000);
console.log(onePlus);

```

setTimeout
==========

``` {.javascript org-language="js" results="output"}
setTimeout(  function(){console.log("1090kjk0")}    , 2000);
setTimeout(  ()=>{console.log("10900")}             , 2000);

setTimeout(  ()=>{      } , 2000);

```

no name function
================

``` {.javascript org-language="js" results="output"}
(()=>{console.log("testtest") })();
```

``` {.javascript org-language="js" results="output"}
(function(){console.log("testtest")})()
```

构造函数也是类
==============

``` {.javascript org-language="js" results="output" exports="both"}
  function Person(name, age){
      this.name = name;
      this.age = age;
      this.sagenhallo = function(){
          console.log("hallo");
      }
    return {a:this.age};
  }

  let xiaoming =  Person("xiaoming", 20);
  console.log(xiaoming);
  console.log(xiaoming.name);
//  xiaoming.sagenhallo();



```

``` {.example}
{ a: 20 }
undefined
```

let
===

不能重复赋值
------------

``` {.javascript org-language="js" results="output" exports="both"}
let a = 1;
let b = [];
let c = "kdjfie";
console.log(c)
let a = 3;

```

有块级作用域
------------

``` {.javascript org-language="js" results="output" exports="both"}
{
    let girls = "meimei";

    function fnnn(){
        console.log(girls);
    }

    fnnn();
}

console.log(girls);
```

``` {.example}
meimei
```

没有变量提升
------------

``` {.javascript org-language="js" results="output" exports="both"}
console.log(song)
let song = "kaka"

```

const
=====

注意
----

初始一定要赋值 一般使用大写 不能修改 有块级作用域

对象和复合型的可以修改
----------------------

``` {.javascript org-language="js" results="output" exports="both"}
const name = ["wangba", "wuqing", "tiankong"]
name.push("gousi")
console.log(name)

```

``` {.example}
[ 'wangba', 'wuqing', 'tiankong', 'gousi' ]
```

数组和对象可以被解构的赋值
--------------------------

``` {.javascript org-language="js" results="output" exports="both"}
const F4 = ["zhangsan", "lisi", "wangwu", "zhaoliu"];
let [f1, f2, f3, f4] = F4
console.log(f2)

```

``` {.example}
lisi
```

``` {.javascript org-language="js" results="output" exports="both"}
const zhao = {
    name: "benshan",
    age:"unkownen",
    xiaoping :function(){
        console.log("I K y");
    }
};
let {name, age, xiaoping} = zhao;
console.log(age);
console.log(xiaoping);
xiaoping();

```

``` {.example}
unkownen
[Function: xiaoping]
I K y
```

模板字符串可以换行，拼接
========================

´\${}´ 可以拼接变量 可以换行

简化对象
========

``` {.javascript org-language="js" results="output" exports="both"}
let name = "sangguigu";
let change = function(){
    console.log("I can make it");
};

const school = {
    name,
    change,
    improve(){
        console.log("We can help you");
    }
};

console.log(school.name);
console.log(school.change);
school.change()
school.improve()

```

``` {.example}
sangguigu
[Function: change]
I can make it
We can help you
```

箭头函数
========

静态的this, 当前作用域的this，call都不能改变 不能构造对象实例化
不能使用arguments

``` {.javascript org-language="js" results="output" exports="both"}
let qual = n => n*n;
let fn = (a,b) => { return a*b};
console.log(qual(3))
console.log(fn(2,5));
```

``` {.example}
9
10
```

rest
====

ES5
---

``` {.javascript org-language="js" results="output" exports="both"}
function data(){
    console.log(arguments);
}
data("nihao", "niyehao");

```

``` {.example}
[Arguments] { '0': 'nihao', '1': 'niyehao' }
```

ES6
---

``` {.javascript org-language="js" results="output" exports="both"}
function data(...args){
    console.log(args);
}
data(1,2,3,4);

```

``` {.example}
[ 1, 2, 3, 4 ]
```

``` {.javascript org-language="js" results="output" exports="both"}
function data(a, b, ...args){
    console.log(a);
    console.log(b);
    console.log(args);
}
data(1,2,3,4,5,6);

```

``` {.example}
1
2
[ 3, 4, 5, 6 ]
```

扩展运算符...
=============

Beispiel 将内容转化为数组
-------------------------

``` {.javascript org-language="js" results="output" exports="both"}
const name = ["wangyi", "wanger","wangsan"];
let putname = function(){
    console.log(arguments);
};
putname(...name);

```

``` {.example}
[Arguments] { '0': 'wangyi', '1': 'wanger', '2': 'wangsan' }
```

Anwendung
---------

``` {.javascript org-language="js" results="output" exports="both"}
const kuaizi = ["王太利","肖扬"];
const fenghuang = ["冯坤", "来用"];
console.log(kuaizi.concat(fenghuang));
console.log([...kuaizi, ...fenghuang])

```

``` {.example}
[ '王太利', '肖扬', '冯坤', '来用' ]
[ '王太利', '肖扬', '冯坤', '来用' ]
```

Symbol
======

唯一性, 不能运算, 用for表唯一
-----------------------------

``` {.javascript org-language="js" results="output" exports="both"}
let s = Symbol();
let ss = Symbol("shanggui");
let sss = Symbol("shanggui");
console.log(ss === sss);

let ss1 = Symbol.for("shanggui");
let sss1 = Symbol.for("shanggui");
console.log(ss1 === sss1);

```

``` {.example}
false
true
```

给对象添加属性和方法
--------------------

``` {.javascript org-language="js" results="output" exports="both"}
let youxi = {
    name:"狼人杀",
    [Symbol("say")]: function(){
        console.log("发言");
    },
    [Symbol("nosay")]: function(){
        console.log("闭眼");
    }
};

console.log(youxi);

let addmethod = {
    up: Symbol(),
    down:Symbol()
};

youxi[addmethod.up] = function(){
    console.log("up");
};

youxi[addmethod.down] = function(){
    console.log("down");
};

console.log(youxi);
```

``` {.example}
{
  name: '狼人杀',
  [Symbol(say)]: [Function: [say]],
  [Symbol(nosay)]: [Function: [nosay]]
}
{
  name: '狼人杀',
  [Symbol(say)]: [Function: [say]],
  [Symbol(nosay)]: [Function: [nosay]],
  [Symbol()]: [Function (anonymous)],
  [Symbol()]: [Function (anonymous)]
}
```

迭代器
======

``` {.javascript org-language="js" results="output" exports="both"}
const xiyou = ["唐僧", "孙悟空", "猪八戒", "沙僧"]
for (let v in xiyou){
    console.log(v);
}

for (let v of xiyou){
    console.log(v);
}

```

``` {.example}
0
1
2
3
唐僧
孙悟空
猪八戒
沙僧
```

``` {.javascript org-language="js" results="output" exports="both"}
let cluster = {
    name:"tiankong",
    age: [1,2,3,5,7,9],
    [Symbol.iterator]() {
        let index = 0;
        let _that = this;
        return {
            next: function(){
                if (index < _that.age.length) {
                    const result = {value:_that.age[index], done:false };
                    index++;
                    return result;
                }else{
                    return {value:undefined, done:true};
                }
            }
        };
    }
}

for(let v of cluster){
    console.log(v);
}

```

``` {.example}
1
2
3
5
7
9
```

生成器
======

``` {.javascript org-language="js" results="output" exports="both"}
function *gen(){
    console.log("1");
    yield "一";
    console.log("2");
    yield "二";
}

for (let v of gen()){
    console.log(v);
}
let iter = gen();


iter.next();
for (let v of iter){
    console.log(v);
}

```

``` {.example}
1
一
2
二
1
2
二
```

``` {.javascript org-language="js" results="output" exports="both"}
function *gen(args){
    console.log(args);   // can only be passed once at first
    console.log("1");
    let mmm = yield "一"; // each step can be passed
    console.log(mmm);
    console.log("2");
    yield "二";
    console.log("3");
    yield "三";

}

let iter = gen("aaa");

iter.next();
iter.next("MMM")
iter.next();

```

``` {.example}
aaa
1
MMM
2
3
```

type vaildation
===============

basic
-----

tpyeof: the rest `=` : null, undefined 开始： let a = null;
说明a后来要被赋值为object 结束： a = null; 释放b的内存

``` {.javascript org-language="js" results="output" exports="both"}
var a;
console.log()
console.log(typeof(a))
console.log(typeof a)
console.log(typeof a==="undefined" )
console.log(a===undefined )
```

``` {.example}
undefined
undefined
true
true
```

class
-----

instanceof typeof 不能区分数组和函数和对象

``` {.javascript org-language="js" results="output" exports="both"}
  var bb = {
    bb1 : [1, "niaho", console.log],
    bb2 : function(){
      console.log("nidf");
    }
  }

console.log(bb instanceof Object);
console.log(bb.bb1 instanceof Array);
console.log(bb.bb1 instanceof Object);
console.log(bb.bb2 instanceof Function);
console.log(bb.bb2 instanceof Object);
console.log( typeof bb.bb1[2] === "function")
bb.bb1[2](4)

```

``` {.example}
true
true
true
true
true
true
4
```

multi assigment
===============

如果两个变量指向一个引用地址，修改其中一个，修改结果另一个可见
如果一个重新指向（例如某个函数赋值），另一个内容不变

call
====

对于obj没有test()方法， 临时调用 test.call(obj) `=` obj.test()
test.apply(obj) `=` obj.test()

IIFE Immediately Invoked Function Expression
============================================

Beispiel
--------

1: 不影响全局命名空间 2：可以暴露

``` {.javascript org-language="js" results="output" exports="both"}
(function (){
    let a = 34;
    console.log("kk!!!!");
    console.log(a*34);
})();

```

``` {.example}
kk!!!!
1156
```

浏览器端列子
------------

这里不能执行

``` {.javascript org-language="js" results="output" exports="both"}
(
    function(){
        let aa = 1;
        function test(){
            console.log(++aa);
        };
        window.$ = function(){
            return {
                test:test
            };
        };
    }
)();

$().test();



```

服务器端列子
------------

``` {.javascript org-language="js" results="output" exports="both"}
(
    function(window){
        let aa = 1;
        function test(){
            console.log(++aa);
        };
        window.$ = function(){
            return {
                test:test
            };
        };
    }
)(this);

this.$().test();



```

``` {.example}
2
```

this
====

任何函数本质都是通过对象来调用的， 如果没有指定调用者，那么就是window

括号
====

小括弧(IIFE)和中括弧(Beispiel untern)前面的语句后必须加分号，
否则分号全部可以省略

``` {.javascript org-language="js" results="output" exports="both"}
[1,2,3,4].forEach(function(a){console.log(a)})
;[1,2,3,4].forEach(a =>console.log(a))

```

``` {.example}
1
2
3
4
1
2
3
4
```

callback
========

callback named function
-----------------------

``` {.javascript org-language="js" results="output"}
 var test = function(msg, callback){
     setTimeout(function(){ console.log(msg);   }, 2000);
     //console.log(msg);
     callback(); 
 }
function  justcall(){
     console.log("juskjktcallkkjk to i ");
 }
var just = function(){
     console.log("juskjktcallkkjk to i ");
 }
 test("nisho 0p", justcall)
 test("nisho 0p", just)
```

callback no named function
--------------------------

``` {.javascript org-language="js" results="output"}
  var test = function(msg , didi){
//      setTimeout( ()=>{   console.log(msg);   } , 2000);
      console.log(msg);
      didi(msg);
  }

  test("kdjfi", msg => {
      console.log(msg);
  });
```

no named function callback no named function
--------------------------------------------

``` {.javascript org-language="js" results="output"}
(
    (msg , didi) => {
        console.log(msg);
        //          setTimeout(  ()=>{    didi(msg);  } , 2000);  // can only be used in  function body
        didi(msg); 
    }
)
( "kdiikkjkjk",
  msg => {
      console.log(msg);
  }
)
```

promise
=======

resolve and reject
------------------

  ------------------------
  resolve 触发 then 回调
  reject 触发 catch 回调
  ------------------------

``` {.javascript org-language="js" results="output" exports="both"}
let sentSuccess = false;
let p = new Promise(function(resolve, reject) {
  if(sentSuccess){
    resolve("Successed");
  } else {
    reject("Failed");
  }
});

p.then(function(message) {
  console.log(`${message} is coming`);
}).catch(function(message){
  console.log(`${message} is coming`);
})

```

``` {.example}
Failed is coming
```

resolve and reject with recusive
--------------------------------

  -----------------------------------------------------------
  then 执行后正常返回 resolved状态， 出错返回rejected 状态
  catch 执行后正常返回 resolved状态， 出错返回rejected 状态
  -----------------------------------------------------------

``` {.javascript org-language="js" results="output" exports="both"}
Promise.resolve().then( ()=> {
    console.log(1);
}).catch(()=> {
    console.log(2);
}).then(()=> {
    console.log(3);
});

```

``` {.example}
1
3
```

``` {.javascript org-language="js" results="output" exports="both"}
Promise.resolve().then( ()=> {
    console.log(1);
    throw new Error ('Error');
}).catch(()=> {
    console.log(2);
}).then(()=> {
    console.log(3);
});

```

``` {.example}
1
2
3
```

``` {.javascript org-language="js" results="output" exports="both"}
Promise.resolve().then( ()=> {
    console.log(1);
    throw new Error ('Error');
}).catch(()=> {
    console.log(2);
}).catch(()=> {
    console.log(3);
});

```

``` {.example}
1
2
```

``` {.javascript org-language="js" results="output" exports="both"}
let sentSuccess = true;
let p = new Promise(function(resolve, reject) {
  if(sentSuccess){
    resolve("Successed");
  } else {
    reject("Failed");
  }
});

p.then(function(message) {
  console.log(`${message} is coming`);
  console.log(1);
  throw new Error ('Error');
}).catch(()=> {
  console.log(2);
}).catch(()=> {
  console.log(3);
}).catch(function(message){
  console.log(`${message} is coming`);
}).then(() => {
  console.log(4);  
});

```

``` {.example}
Successed is coming
1
2
4
```

resolve and reject with recusive with return
--------------------------------------------

``` {.javascript org-language="js" results="output" exports="both"}
  let sentSuccess = false;
  let p = new Promise(function(resolve, reject) {
    if(sentSuccess){
      resolve("Successed");
    } else {
      reject("Failed");
    }
  });

  p.then(function(message) {
    console.log(`${message} is coming`);
    return "niaho";
  }).then(function(massage) {
    console.log(massage)
  }).catch(function(message){
    console.log(`${message} is coming`);
    return "nibuaho";
  }).then(function(massage) {
    console.log(massage)
  })

* Closure
** conuter将函数作为另一个函数的返回值
#+begin_src js :results output :exports both
  function f1(){
      let a = 0;
      function f2(){
          a++;
          console.log(a);
      }
      return f2;
  }

  var f = f1();
  f()
  f()
  f();

```

``` {.example}
1
2
3
```

将函数作为实参传给另一个函数调用
--------------------------------

实际上，这和回调函数是一样的

``` {.javascript org-language="js" results="output" exports="both"}
function print(fn){
    let a = 200;
    fn();
}

let a = 100;
function fn(){
    console.log(a);
}
print(fn);

```

``` {.example}
100
```

multi return
------------

``` {.javascript org-language="js" results="output" exports="both"}
function myModule(){
    let msg = "My Massage";

    function doSomething(){
        console.log("do Something..."+msg);
    }
    function doOtherthing(){
        console.log("do Otherthing..." + msg);
    }

    return {
        Something:doSomething,
        Otherthing:doOtherthing
    };
}

let F = myModule();
F.Something()
F.Otherthing()

```

``` {.example}
do Something...My Massage
do Otherthing...My Massage
```

Prototype
=========

new note
--------

每一个函数都有一个prototpye属性&，默认是个对象， 即原型对象
该prototype原型对象有constructor属性和\_~proto~\_~属性~
constructor指向函数对象（回去了） fun.prototype = &, &.constructor = fun

**constructor**

``` {.javascript org-language="js" results="output" exports="both"}
function Fun(){  }
var yuanxing = Fun.prototype
var yuanhanshu = yuanxing.constructor
console.log(yuanhanshu == Fun)
console.log(Fun.prototype.constructor == Fun)
```

``` {.example}
true
true
```

**prototype** **显式原型** **函数类** **定义时被生成**
**添加方法给类的原型对象**
还可以对原型对象添加自定义的属性和方法，让原型对象的函数的实列来使用

``` {.javascript org-language="js" results="output" exports="both"}
function Fun(){  }
Fun.prototype.test = function(){console.log("prototype for test")}
var fun = new Fun()
fun.test()
```

``` {.example}
prototype for test
```

**[[proto]{.underline}]{.underline}** **隐式原型** **实列**
**实列化时生成**

类的显式原型等于实列的隐式原型

``` {.javascript org-language="js" results="output" exports="both"}
function Fun(){}
var fun = new Fun()
console.log(Fun.prototype)
console.log(fun.__proto__)
console.log(Fun.prototype == fun.__proto__)
```

``` {.example}
{}
{}
true
```

**[[proto]{.underline}]{.underline}** 原型链\*
如果为被复制，则默认为系统Object空对象

``` {.javascript org-language="js" results="output" exports="both"}
    function Fun(){}
    var fun = new Fun()

    function FFun (){}
    var ffun = new FFun()

  FFun.prototype.__proto__ = fun
//  ffun.__proto__.__proto__ = fun

    console.log(ffun.__proto__.__proto__)
```

``` {.example}
Fun {}
```

alte note
---------

对象的隐式原型([[proto]{.underline}]{.underline})等于对应的构造函数的显式原型(prototype)的值
*photolink* 对象的属性组成： 1：本身的声明
2：\_~proto~\_~隐式原型链属性~ 3：系统Object的原型对象，其\_~proto~\_\_
= null

``` {.javascript org-language="js" results="output" exports="both"}
function Fn (){
}
var fn = new Fn();

Fn.prototype.test = function(){
    console.log("from prototype");
}

fn.test();  // === fn.__proto__.test();
fn.__proto__.test();

```

``` {.example}
from prototype
from prototype
```

``` {.javascript org-language="js" results="output" exports="both"}
console.log(Object.prototype instanceof Object)
console.log(Function.prototype instanceof Object)
console.log(Function.__proto__ === Function.prototype)
```

``` {.example}
false
true
true
```

``` {.javascript org-language="js" results="output" exports="both"}
function A(){};
A.prototype.n = 1;
var b = new A();
A.prototype = {
    n:2,
    m:3
};
var c = new A();
console.log(b.n, b.m, c.n, c.m);
```

``` {.example}
1 undefined 2 3
```

``` {.javascript org-language="js" results="output" exports="both"}
function F(){}

Object.prototype.a = function(){
    console.log("a")
}
Function.prototype.b = function(){
    console.log("b")
}
var f = new F();
f.a()
f.b()
F.a()
F.b()


```

event loop事件循环
==================

-   browser interpreter
-   Call stack
-   Web API
-   Call query
-   event loop

async/await
===========

::: {.center}
用同步语法编写异步代码
:::

执行async函数， 返回的是Promise
-------------------------------

如果没有Promise的调用，也会自动封装为Promise

``` {.javascript org-language="js" results="output" exports="both"}
async function fn1(){
    return 1000;
}
fn1().then(data => {
    console.log("data :", data);
});
```

``` {.example}
data : 1000
```

如果有，则直接返回该Promise

``` {.javascript org-language="js" results="output" exports="both"}
async function fn1(){
    return Promise.resolve(200);
}
const res1 = fn1();
res1.then(data => {
    console.log("data :", data);
});
```

``` {.example}
data : 200
```

await 相当于 Promise + then
---------------------------

### await 后面跟数值也会自动封装

``` {.javascript org-language="js" results="output" exports="both"}
(async function (){
    const data = await 300;
    console.log(data);
})();
```

``` {.example}
300
```

### await 跟Promise

``` {.javascript org-language="js" results="output" exports="both"}
(async function (){
    const p1 = Promise.resolve(200);
    const data = await p1;
    console.log(data);
} )();
```

``` {.example}
200
```

### await跟async函数

``` {.javascript org-language="js" results="output" exports="both"}
async function fn1(){
    return 300;
}

(async function (){
    const data = await fn1();
    console.log(data);  // 此时await后面的命令相当与setTimeout的第二个参数，即新的异步分支
} )();
```

``` {.example}
300
```

try catch 捕获异常,代替Promise+catch
------------------------------------

``` {.javascript org-language="js" results="output" exports="both"}
(async function (){
    const p4 = Promise.reject('Error');
    try {
        const res = await p4;
        console.log(res); // reject for Promise + then, this will not be executed
    } catch (err) {
        console.log(err);
    } finally {
        console.log("It's done");
    }
})();
```

``` {.example}
Error
It's done
```

包装长时耗的异步函数
--------------------

``` {.javascript org-language="js" results="output" exports="both"}
function sendRequest(){
  return new Promise(function(resolve, reject) {
    setTimeout( function(){
      reject("Request reject");
    }, 2000);
  });
}

async function getUsername() {
  try {
    let username =  await sendRequest();
    console.log(username);
  } catch (err) {
    console.log(`Error: ${err}`);
  } finally {
    console.log("Gut");
  }
}

getUsername()

```

``` {.example}
Error: Request reject
Gut
```

js in Dom
=========

``` {.html}
<li><a onclick="emacs()" href="#">Emacs</a></li>
<iframe src="emacs.html" id="emacs" class="hidden" ; style="position:fixed; top:50px; left:0; bottom:0; right:0; width:100%; height:100%; border:none; margin:0; padding:0; overflow:hidden; z-index:999999;" ></iframe>
```

``` {.javascript org-language="js"}
document.querySelectorAll('iframe').forEach( item => item.setAttribute('class','hidden'))
document.getElementById("UniversalHashing").setAttribute('class','showing')
```

...rests
========

使用在一个表达式前，表示整个表达式的值， 例如整个数组或者对象

``` {.javascript org-language="js" results="output" exports="both"}
var test = {a:0, b:1, c:2}
var testall = {...test, d:5}
console.log(testall)

var parts = ['0', '1','2']
var alles = [...parts, '3']
console.log(alles)


```

``` {.example}
{ a: 0, b: 1, c: 2, d: 5 }
[ '0', '1', '2', '3' ]
```

add function to window
======================

with \$ this example is special for now, virtual DOM

``` {.javascript org-language="js" results="output" exports="both"}
( function(window){
    let aa = 9;
    function test(){
        console.log(++aa);
    };
    window.$ = function(){
        return {
            test:test,
            aa:aa
        };
    };
}
)(this);

console.log(this);
console.log(this.$);
console.log(this.$());
console.log(this.$().aa);
this.$().test();
```

``` {.example}
{ '$': [Function (anonymous)] }
[Function (anonymous)]
{ test: [Function: test], aa: 9 }
9
10
```

change this with call apply bind
================================

call function
-------------

改变函数运行的this值，即指向, 并得到运行后的结果,
通过增加方法并事后删除的方式完成 let the **this** attribution of call
function be banded with another instance, and calculate the result.

if the another instance is null or undefined, in ES11, globalThis will
replace this instance with window

``` {.javascript org-language="js" results="output" exports="both"}
  function call(Fn, obj, ...args){
      if (obj == undefined || obj == null) {
          obj = globalThis;
      }
      obj.temp = Fn;
      var resulte = obj.temp(...args);
      delete  obj.temp;
      return resulte;
  }

  function add(a, b){
      console.log(this);
      return a+b+this.c;
  }
  let obj ={
      c:2
  };

  console.log(call(add, obj, 10, 10));
//将add的this值等于obj的this

  //  window.c = 10;
globalThis.c = 2;
console.log(call(add, null, 10, 10));

```

``` {.example}
{ c: 2, temp: [Function: add] }
22
<ref *1> Object [global] {
  global: [Circular *1],
  clearInterval: [Function: clearInterval],
  clearTimeout: [Function: clearTimeout],
  setInterval: [Function: setInterval],
  setTimeout: [Function: setTimeout] {
    [Symbol(nodejs.util.promisify.custom)]: [Function (anonymous)]
  },
  queueMicrotask: [Function: queueMicrotask],
  clearImmediate: [Function: clearImmediate],
  setImmediate: [Function: setImmediate] {
    [Symbol(nodejs.util.promisify.custom)]: [Function (anonymous)]
  },
  a: 3,
  c: 2,
  temp: [Function: add]
}
22
```

apply function
--------------

唯一和call不同是: apply的第三个开始的数据参数是一个整体，比如数组

``` {.javascript org-language="js" results="output" exports="both"}
  function apply(Fn, obj, args){
      if (obj == undefined || obj == null) {
          obj = globalThis;
      }
      obj.temp = Fn;
      var resulte = obj.temp( ...args);
      delete  obj.temp;
      return resulte;
  }
  function add(a, b){
      console.log(this);
      return a+b+this.c;
  }
  let obj ={
      c:2
  };
  global.a = 3;
  console.log(apply(add, obj, [2,4]));
//将add的this值等于obj的this
  //  window.c = 10;
globalThis.c = 2;
console.log(apply(add, null, [2, 4]));
```

``` {.example}
{ c: 2, temp: [Function: add] }
8
<ref *1> Object [global] {
  global: [Circular *1],
  clearInterval: [Function: clearInterval],
  clearTimeout: [Function: clearTimeout],
  setInterval: [Function: setInterval],
  setTimeout: [Function: setTimeout] {
    [Symbol(nodejs.util.promisify.custom)]: [Function (anonymous)]
  },
  queueMicrotask: [Function: queueMicrotask],
  clearImmediate: [Function: clearImmediate],
  setImmediate: [Function: setImmediate] {
    [Symbol(nodejs.util.promisify.custom)]: [Function (anonymous)]
  },
  a: 3,
  c: 2,
  temp: [Function: add]
}
8
```

bind function
-------------

do the same thing as call, but do not execute, return a function which
can be executed. **注意传值**

``` {.javascript org-language="js" results="output" exports="both"}
function call(Fn, obj, ...args){
    if (obj == undefined || obj == null) {
        obj = globalThis;
    }
    obj.temp = Fn;
    var resulte = obj.temp(...args);
    delete obj.temp;
    return resulte;
};

function bind(Fn, obj, ...args){
    return function(...arg){
        return call(Fn, obj, ...args, ...arg);
    };

}

globalThis.c = 2;
let obj = {c:2};

function add(a, b){
    return a+b+this.c;
}
let fff =bind(add, obj, 2);
console.log(fff(1));

```

``` {.example}
5
```

Jest
====

init
----

-   init

npx jest --init npx jest --coverage / npm run coverage

-   autodetect

packages.json-\>\"scripts\": \"test\":\"jest\", ----\>\>\>\>
\"test\":\"jest --watchall\",

-   babel

npm install @bable/core@7.4.5 @bable/preset-env@7.4.5 -D touch .babelrc

-   model

a model o model f model p model

runing node npm js fetch async await
------------------------------------

-   npm init

-   \"type\": \"module\", \>\> package.json

-   npm install node-fetch

    ``` {.javascript org-language="js"}
    import fetch from 'node-fetch';

    fetch("https://pokeapi.co/api/v2/pokemon/")
      .then((res) => res.json())
      .then((data) => console.log(data)); 
    ```

-   node index.js

jest test npm js fetch async await
----------------------------------

-   npm init -y

-   \"type\": \"module\", \>\> package.json

-   npm install node-fetch

    ``` {.javascript org-language="js"}
    import fetch from 'node-fetch';

    const getPokemonList = async() => {
      const listRep = await fetch("https://pokeapi.co/api/v2/pokemon/");
      return await listRep.json();
    };

    const getPokemon = async(url) => {
      const dataResp = await fetch(url);
      return await dataResp.json();
    };



    function sum(a, b) {
      return a + b;
    }
    module.exports = {
      sum,
      getPokemon,
      getPokemonList
    };
    ```

-   Here, because jest are default use CommonJS, so please PLEASE revoke
    your node-fetch to version 2. Because node-fetch after version 3, it
    will be convert to ES6.

-   npm remove node-fetch

-   npm install node-fetch\@2.6.2

    ``` {.javascript org-language="js"}
    const {sum, getPokemon, getPokemonList } = require('./index');

    test("testSum", () => {
      expect( sum(1, 2) ).toBe(3);
    });

    test("testDict", () => {
      const data = {one: 1};
      data["two"] = 2;
      expect( data ).toEqual({one:1, two:2});
    });


    test("testgetPokemonList", async () => {
      const pokemonList = await getPokemonList();
      const firstPokemon = await getPokemon(pokemonList.results[0].url);
      expect(firstPokemon.name).toBe("bulbasaur");
    });


    ```

-   but the index.js is using ES6 to import fetch-node, even use
    module.exports(for CommonJS) and require, but import is still
    complaining.

-   npm i -s @bable/preset-env

-   npm i -s babel-jest

-   touch .babelrc

        {
          "presets": ["@babel/preset-env"]
        }

-   npm run test should now work

yarn ts fetch async await
-------------------------

-   cd asyncts

-   yarn init -y

-   yarn add typescript ts-node @types/node-fetch@2.6.2

-   yarn add node-fetch\@2.6.2

-   npx tsc --init

    ``` {.typescript}
    import fetch from "node-fetch"
    fetch("https://pokeapi.co/api/v2/pokemon/")
      .then((res) => res.json())
      .then((data) => console.log(data)); 

    ```

-   ts-node index.ts

    **node-fetch convert every thing into EMS moduld after version 3.0**
    if you meet some error, please use the last version 2

-   yarn add @supercharge/promise-pool

-   yarn add ts-jest jest @types/jest -D

-   npx ts-jest config:init

-   yarn test

-   seeing the demo \~/Dropbox/cs/asyncTSPromisejest
