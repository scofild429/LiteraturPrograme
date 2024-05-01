---
title: RUST
---

```{=org}
#+startup: content
```
# 所有权

``` {.rust results="output"}
fn main() {
    let s1 = String::from("hello");
    let s2 = s1;

    println!("{}, world!", s2);
    // println!("{}, world!", s1);  

}

```

``` {.rust results="output"}
fn main() {
    let s = String::from("hello world");

    let word = first_word(s);

    //      s.clear(); // error!

    println!("the first word is: {}", word);
}
fn first_word(s: String) -> String {
    s
}


```

``` {.rust results="output"}
fn main() {
    #[derive(Debug)]
    struct User {
        active: bool,
        username: String,
        email: String,
        sign_in_count: u64,
    }

    let user1 = User {
        email: String::from("someone@example.com"),
        username: String::from("someusername123"),
        active: true,
        sign_in_count: 1,
    };
    // let user2 = User {
    //     email: String::from("another@example.com"),
    //     ..user1
    // };

    let user2 = User {
        active: user1.active,
        username: String::from("uset2"),
        email: String::from("another@example.com"),
        sign_in_count: user1.sign_in_count,
    };

    println!("{}", user1.email);
    // 下面这行会报错
    println!("{:?}", user2)

}



```

-   HITS: no matter with ..user1 or xxx: user1.xxx to create new user
    with old user, if only fundemantal elements have been copy, the old
    user can still be available, and the other non-fundemantal
    attributes also . Otherwise the old user instance and also the
    non-fundemantal attributes are both not available.

# test

``` {.rust results="output"}
fn main() {
    let greetings = ["Hello", "Hola", "Bonjour",
                     "Ciao", "こんにちは", "안녕하세요",
                     "Cześć", "Olá", "Здравствуйте",
                     "chào bạn", "您好"];

    for (num, greeting) in greetings.iter().enumerate() {
        print!("{} : ", greeting);
        match num {
            0 =>  println!("This code is editable and runnable!"),
            1 =>  println!("Este código es editable y ejecutable!"),
            2 =>  println!("Ce code est modifiable et exécutable!"),
            3 =>  println!("Questo codice è modificabile ed eseguibile!"),
            4 =>  println!("このコードは編集して実行出来ます！"),
            5 =>  println!("여기에서 코드를 수정하고 실행할 수 있습니다!"),
            6 =>  println!("Ten kod można edytować oraz uruchomić!"),
            7 =>  println!("Esse código é editável e executável!"),
            8 =>  println!("Этот код можно отредактировать и запустить!"),
            9 =>  println!("Bạn có thể edit và run code trực tiếp!"),
            10 =>  println!("这段代码是可以编辑并且能够运行的！"),
            _ =>  {},
        }
    }
}
```

# item collections

``` rust
impl Summary for Post    

```

``` rust
pub fn notify<T: Summary>(item: &T) {
    println!("Breaking news! {}", item.summarize());
}
// is like
pub fn notify(item: &impl Summary) {
    println!("Breaking news! {}", item.summarize());
}

```

``` {.rust results="output"}
#[derive(Debug)]
enum UiObject {
    Button,
    SelectBox,
}

fn main() {
    let objects = [
        UiObject::Button,
        UiObject::SelectBox
    ];

    for o in objects {
        draw(o)
    }
}

fn draw(o: UiObject) {
    println!("{:?}",o);
}
```

# 特征对象

``` {.rust results="output"}
pub trait Draw {
    fn draw(&self);
}

pub struct Button {
    pub width: u32,
    pub height: u32,
    pub label: String,
}

impl Draw for Button {
    fn draw(&self) {
        // 绘制按钮的代码
        println!("draw for Button, {}, {}, {}", &self.width, &self.height, &self.label);
    }
}

struct SelectBox {
    width: u32,
    height: u32,
    options: Vec<String>,
}

impl Draw for SelectBox {
    fn draw(&self) {
        // 绘制SelectBox的代码
        println!("draw for Selectbox {}, {}, {:?}", &self.width, &self.height, &self.options);
    }
}


// pub struct Screen {
//     pub components: Vec<Box<dyn Draw>>,
// }
// impl Screen {
//     pub fn run(&self) {
//         for component in self.components.iter() {
//             component.draw();
//         }
//     }
// }

pub struct Screen<T: Draw> {
    pub components: Vec<T>,
}

impl<T> Screen <T>
where T: Draw {
    pub fn run(&self) {
        for component in self.components.iter() {
            component.draw();
        }
    }
}




fn main() {
    let screen = Screen {
        components: vec![
            Box::new(SelectBox {
                width: 75,
                height: 10,
                options: vec![
                    String::from("Yes"),
                    String::from("Maybe"),
                    String::from("No")
                ],
            }),
            Box::new(Button {
                width: 50,
                height: 10,
                label: String::from("OK"),
            }),
        ],
    };

    screen.run();
}

```

# mut

## mut example

``` {.rust results="output"}
fnmain() {
    let x :i32 = 48;
    let X :i32 = 480;
    let mut y :&i32        = &x;    // y can be redirected from x to X, but y can not change x
    let      z: &mut &i32 = &mut y  // z can not be redirected, but z can change y
}

```

## different lifetime

``` {.rust results="output"}
fn main() {
    struct MutStr<'a, 'b> {
        s: &'a mut &'b str,
    }

    let mut r: &str = "hello";
    Mutstr{s: &mut r}.s = "world";
    println!("{}", r);
}

```