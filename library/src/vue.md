数据绑定
========

1.  计算属性 在computed属性对象中定义计算属性的方法
    在页面中使用{{方法名}}来显示计算的结果

2.  监视属性: 通过通过vm对象的\$watch()或watch配置来监视指定的属性
    当属性变化时, 回调函数自动调用, 在函数内部进行计算

3.  计算属性高级: 通过getter/setter实现对属性数据的显示和监视
    计算属性存在缓存, 多次读取只执行一次getter计算

    ``` {.javascript org-language="js" results="output" exports="both"}
    const app = Vue.createApp({
        data() {
            return { count: 4 }
        }
    })

    const vm = app.mount('#app')

    console.log(vm.$data.count) // => 4
    console.log(vm.count)       // => 4

    // 修改 vm.count 的值也会更新 $data.count
    vm.count = 5
    console.log(vm.$data.count) // => 5

    // 反之亦然
    vm.$data.count = 6
    console.log(vm.count) // => 6

    ```

npm
===

npm install 将会执行package.json 的设定， 在IDAE里可以选中package.json
里的 build:prod字段，run

操作
====

vd 是vue里的data属性

vm 是vue里的mothods方法

ht 是html里的标签

  ---------------------------------- ----------------------------- -------------------------------------
  {{vd}}                             占位                          
  v-text=\"vd\"                      替换                          
  v-html=\"vd\"                      替换并渲染                    
  v-bind:ht=\"vd\"                   :ht=\"vd\" 设置属性           可用3元表达式或者数据的元素对象指定
  v-on:ht=\"vm\"                     @ht=\"vm\"                    on methode(可自定义)
  v-mode=\"vd\"                      只在表单中暴露vd,并操作       
  v-for=\"(item,index) in \"vd\"\"   vd时vue中可迭代元素或在对象   
  v-for=\"i in 10\"                  1,,,,,9                       
  push                               后加                          
  unshift                            前加                          
  v-if                               删除不显示的元素              
  v-show                             display 不显示的元素          
                                                                   
                                                                   
  ---------------------------------- ----------------------------- -------------------------------------

生命周期
========

  --------------- ----------------------------------------
  beforeCreate    加载vue系统构造，但是可以接触到Dom元素
  created         加载自定义的data,mothods, filter.....
  beforeMounte    创建特性在内存
  mounted         加载特性，渲染页面
  beforeupdate    更改特性
  updated         渲染更改的特性
  beforedestroy   准备清除特性
  destroy         
                  
  --------------- ----------------------------------------

component
=========

1, 用extends编写template 2, 在component中编写template 3, 在vue
外部，script模块中编写template 4,
在vue的组件中使用变量和方法，必须在组件中用函数定义，

Mustache
========

{{item }} item von el can be here

v-bind
======

v-bind: kann verbunden werden mit id, href, key, für characters von DOM
elements

multi class 动态绑定v-band
--------------------------

1.  三目运算指定class
2.  集合，可删除class，不可增加,不会被拦截
3.  数组，可加可减

multi style 动态绑定v-band
--------------------------

1.  三目运算指定style
2.  集合，可删除style，不可增加， 不会被拦截
3.  数组，可加可减

v-show
======

if v-show is false, the DOM element is already included, but will not be
presented.

v-if
====

if v-if is false, the DOM element will be deleted

watch multiple value
====================

``` {.javascript org-language="js"}
watch(
  () => [PlasData.Amount_Package_Plasmid_1, PlasData.Concentration_Package_Plasmid_1],
  ([Amount_Package_Plasmid_1, Concentration_Package_Plasmid_1]) => {
    PlasData.Volume_Package_Plasmid_1 =  +((1/Concentration_Package_Plasmid_1)*Amount_Package_Plasmid_1).toFixed(2)
  })

```

reactive multiple value
=======================

``` {.javascript org-language="js"}
const platedata :PlatedataType[]  = reactive([])
platedata.push({id:1, name:"6 Well", highlight: false, editable: true, show: false})
```
