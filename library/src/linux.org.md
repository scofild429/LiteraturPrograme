---
title: Linux
---

```{=org}
#+startup: content
```
# Install

## ISO installation

  ------- ---------------------
  lsblk   list all partiation
  mkfs    format partiation
  fdisk   manage partiation
  ------- ---------------------

    lsblk
    sudo umount....
    format the partation: 
    sudo mkfs -t ext4 /dev/sda1
    sudo mkfs -t ext4 /dev/sda2
    sudo mkfs -t ext4 /dev/sda
    sudo dd if=.../ubuntu-20.04.3-desktop-amd64.iso of=/dev/sda bs=4M status=progress && sync
    resize the host
    ....
    sudo mkfs -t ext4 /dev/sda
    sudo fdisk -l
    sudo fdisk  /dev/sda -> m, g, n, 1, Enter, w

    sudo dd if=/dev/nvm..p1 of=/dev/sda1
    sudo dd if=/dev/nvm..p3 of=/dev/sda2


    from windows: Rufus
    Disk can delete all partation in linux 
    lsblk -f
    sudo mkfs -t ext4 /dev/sda
    from Linux:
    sudo dd if=~/Downloads/ubuntu-20.04.3-desktop-amd64.iso of=/dev/sda bs=4M status=progress && sync

## backup system

one step to backup in USB

    sudo dd if=/dev/nvmxx2 of=/dev/sda2 bs=4M status=progress && sync  

old setting insert SSD usb \$ lsblk

``` example
check the partition of whole disk
```

\$ sudo fdisk -l

``` example
check the detail partation
```

\$ sudo mkfs -t ext4 /dev/sda

``` example
format sda  disk (can also for partition )
```

\$ sudo fdisk /dev/sda

``` example
make new partiation distribation for backup
```

\$ sudo dd if=/dev/nvmxx2 of=/dev/sda2 bs=4M status=progress && sync

``` example
backup the whole system disk into sda2 backup partition
```

\$ disk resize the restore partation

``` example
this step can open the Disks in APP, and resize the system disk,
better if the system disk is 10GB bigger than the backup partition.
Later for backup again, don't forget resize it back to backup again
```

\$ sudo mkfs -t ext4 /dev/nvmxxx2

``` example
clean the system partition
```

\$ sudo dd if=/dev/sda2 of=/dev/nvmxx2 bs=4M status=progress && sync

``` example
should be just fine
```

## grub repair

for error : Minimal BASH-like line editing is supported......

    grub > ls 
    grub > ls (hd0,gptXX)/boot/grub

if XX partation returns many file, one is with grub.cfg, this is the one
we want

    grub > set root=(hd0,gptXX)
    grub > set prefix=(hd0,gptXX)/boot/grub
    grub > normal

enter the system

    sudo add-apt-repository ppa:yannubuntu/boot-repair
    sudo apt-get update
    sudo apt-get install boot-repair
    sudo grub-install /dev/where EFI partation is

## Recover the fastplatte in windows

    1. WIN+R diskpart
    2. select disk (Disk)
    3. clean
    4. new add 

## write images in USB

1.  下载ubuntu
2.  下载USBwriter并安装
3.  写入系

## reboot

    my computer : F12

## Update nvidia drivers for linux

    sudo add-apt-repository ppa:graphics-drivers/ppa
    sudo apt update 
    ubuntu-drivers devices
    sudo apt-get --reinstall install nvidia-430
        1.  will be asked for password
        2.  reboot
        3.  select Enroll MOK -> continue -> Yes -> Roboot
    nvidia-sim
    watch -n 1 nvidia-smi

## chinese

export LC~CTYPE~=zh~CN~.UTF-8 sudo apt-get -y install
language-pack-zh-hans 此应用压制中英文的同步变化, 尽量避免使用中文

## Time Screensaver

NowSat Nov 5 12:29:50 2022, I just configured my computer for a time
screensaver.

-   [link](https://github.com/alexanderk23/gluqlo)

-   go the the link, for me only work with building from source, don\'t
    forget the dependence.

-   after install it add following into \~/.xscreensaver under section
    of programs:

        gluqlo -root \n\

-   install Xscreensaver if not with following, but before that, delete
    gnome-screensaver if exist.

        sudo apt-get install xscreensaver xscreensaver-data-extra xscreensaver-gl-extra

-   start Screensaver application, find the Gluqlo, and set it to be the
    only one, more setting is option

-   start startup application, add one as following, name and comment is
    as well(liberty)command is this: xscreensaver -nosplash

-   lauch keyshort, add keyshort as following, key combination is as
    personal wish

        xscreensaver-command -lock

-   change Wayland to xorg

    -   sudo apt install xorg
    -   sudo nano /etc/gdm3/custom.conf
    -   WaylandEnable=false

-   now test the keyshort

# System configuration collection

## check port of application

``` {.bash org-language="sh" dir="/sudo::" results="output"}
ps -aux |grep mongo
netstat -nap |grep 80
```

## open fire wall for port

sudo apt install firewalld add port : sudo firewall-cmd
--add-port=80/tcp --permanent sudo firewall-cmd --remove-port=80/tcp
--permanent restart firewall: sudo firewall-cmd --reload check port:
sudo firewall-cmd --list-all

## firewall

systemctl status firewalld systemctl stop firewalld systemctl disable
firewalld systemctl enable firewalld

## Shutdown Keyboard default


    1. $ xinput list 
       Find the Touchpad and its NAME and ID
    2. $ xinput set-prop 'NAME' 'Device Enabled' 0
       to close the Touchpad
    3. but with following can be named as tpOn and tpOff in ./bashrc
    alias tpOff="xinput set-prop 'SYNA1D31:00 06CB:CD48 Touchpad' 'Device Enabled' 0"
    alias tpOn="xinput set-prop 'SYNA1D31:00 06CB:CD48 Touchpad' 'Device Enabled' 1"
    4. Close Touchpad default in boost system
       the following in ~/.config/autostart/xinput.desktop

    [Desktop Entry]
    Type=Application
    Exec=xinput set-prop 'SYNA1D31:00 06CB:CD48 Touchpad' 'Device Enabled' 0
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
    Name[zh_CN]=touchpad enable
    Name=touchpad enable

## autostart

Thunderbird

    [Desktop Entry]
    Type=Application
    Exec=/usr/bin/thunderbird
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
    Name[en_US]=thunderbird
    Name=thunderbird
    Comment[en_US]=thunderbird
    Comment=thunderbird

## exchange Control Key and Caps Key

在/etc/default/keyboard文件中添加:

    XKBOPTIONS="ctrl:nocaps

or

``` shell
setxkbmap -option ctrl:nocaps
```

setting for 右键没反应 \$ sudo add-apt-repository universe \$ sudo apt
install gnome-tweak-tool

## right key no response

    gsettings set org.gnome.desktop.peripherals.touchpad click-method areas

## hotkey

  -------- ----------------------
  C-M- t   terminal
  C-M- p   thunderbird
  C-M- e   emacs
  C-M- f   firefox
  C-M- j   emacs windows switch
  C-M- t   terminal
  C-M- w   emacs worterbuch
  C-M- t   terminal
  C-M- t   terminal
           
  -------- ----------------------

  --------------------------------- -----------
  Switch application                Alt + Tab
  Switch window of an application   Alt + Spc
                                    
  --------------------------------- -----------

  -------------- ----------
  Alt Ctrl Del   退出用户
  -------------- ----------

in Einstellung, the executable command can be used in command for
customized hotkey

## clear caches

this command has been added to the .bashrc of the /root. only root user
can call this command

``` {.bash org-language="sh"}
alias freemem="sync; echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared' "
```

## create customized dock to favorites

-   find the executable files and icon

-   create the desktop setting file:
    /usr/share/applications/myapp.desktop

-   change the settings and make it executable +x

-   new works as normal

    ``` shell
    #!/usr/bin/env xdg-open
    [Desktop Entry]
    Version=1.0
    Type=Application
    Terminal=false
    Exec=/path/to/yourapp
    Name=YourApp
    Comment=Description of YourApp
    Icon=/path/to/yourapp.png
    ```

## hstr

    add-apt-repository ppa:ultradvorka/ppa
    apt-get update
    apt-get install hstr

the hh

# commands

## hits

-   assigne permition for delete

``` {.bash org-language="sh"}
chmod -R u+rwx /usr/users/szhao/go-workspace/pkg/mod
```

-   /ect/ssh/sshd~config~
    -   AllowedUsers cloud silin, allow such user login remotely

## terminal

S-C-c : can copy out from terminal S-C-v : can paste into terminal C-h :
backwards to delete C-j : enter C-k : cut after C-u : cut before

## sammary

    fdisk -l

    fdisk /dev/nvme0n1p4 (m, p, n, ...)
    mkfs.ext4 /dev/nvme0n1p4
    sudo emacs /etc/fstab
    /dev/nvme0n1p4 /home/silin/4GB ext4 defaults 0 0

in /etc/fstab, the command must be correct, otherwise the system can\'t
booted.

``` {.bash org-language="sh" results="output"}
cat < source1.c >> source2.c (add source1.c to the end of source2.c)
```

echo \$PATH \| tr \\: \\`\n`{=latex}

## file management

在\~内找filename的文件 find \~ -name filename

找到.bash~history内带有~\"install\"的内容 grep -n \"install\"
.bash~history~

copy 110.txt to 111.txt echo \| cat 110.txt \> 111.txt

\> 擦除再写 \>\> 追加写入

读取.sdsv~history的不重复内容~，再写入到.sdsv echo \| sort -n
.sdsv~history~ \|uniq \> .sdsv

## directory operation

    tree -L 2
    alias open='nautilus'
    open .

## find uninstall and remove software

    sudo apt list --installed | grep software
    whereis software
    sudo apt-get --purge remove software
    sudo apt-get autoremove

## su password config

sudo passwd :to configure the password of root user

## get IP address

curl ifconfig.me

## grep sort

grep -n \"xxx\" ./test.txt sort (--reverse -t \" \" -k 3 ) test.csv

## link

softlink

    ln -s filename linkname // 快捷方式
    ln -s sourcefile softlinkname
    filename加上绝对路径，linkname被移动后，仍能访问访问文件

hard link

    ln filename linkname   //硬链接
    不占用磁盘空间，重复连接到文件的inode点。
    可以在不同地方通过硬连接对文件进行操作

## cd to program with which

cd \$(dirname \$(which cling))

## awk

delete the repeat : awk \'!a\[\$0\]++\' file.txt

## less

  ------- ---------------
  J       down
  K       up
  Space   next page
  b       previous page
  /       search
  n       next mark
  N       previous mark
  q       quit
  ------- ---------------

## link

### 静态库的制作

1.  库方

    include/head.h lib/ src/ 将在src/中编写要实现的文件 并编译这些文件
    \$ gcc \*.c -c -I ../include/ -I :链接头文件 再将这些编译后的打包 \$
    ar rcs libtest.a \*.o ar : -archive 打包 检测 : nm libtest.a 前缀lib
    和后缀.a 不能更改，实际名字是test

    最后将生成的libtest.a放到上级目录lib中，
    可以将lib和include目录发送给甲方

2.  甲方

    根据include/head.h 的头文件编写自己的应用文件main.c
    编译main.c并链接头文件和库 \$ gcc main.c -I ./include/ -L ./lib/
    -ltest -o app -I : 连接头文件 -L : 链接库 -ltest :
    链接库文件，去头lib 去尾.a -o: 指点生成的应用名

3.  特点

    优点： 加载块，移植方便 缺点
    ：部署更新麻烦，引用的重复文件重复储存，浪费空间

### 动态库的制作

编译 \$ gcc \*.c -c -fpic -I ../include -fpic 或者 fPIC : 特殊命令 打包
\$ gcc -shared \*.o -o libxxx.so 头lib 尾.so

使用和静态库相似， 根据头文件编写应用文件main.c \$ gcc main.c -I
./inculde/ -L ./lib/ -lxxx -o app

对于linux生成的文件都是elf格式，并由ld-libc.so动态加载,需要让app能别找
到可以用环境变量或者配置文件

1.  环境变量

    临时设置 \$ export LD~LIBRARYPATH~=./lib 或者新增 \$ export
    LD~LIBRARYPATH~=./lib:LD~LIBRARYPATH~

    临时设置可以使用相对路径，

    永久设置 用户 \$ cat \" LD~LIBRARYPATH~=./lib:LD~LIBRARYPATH~\" \>\>
    \~/.bashrc \$ source \~./bashrc

    永久设置 系统 \$ sudo cat \"LD~LIBRARYPATH~=./lib:LD~LIBRARYPATH~\"
    \>\> /etc/profile \$ source /etc/profile

2.  修改配置文件

    配置文件/etc/ld.so.conf \$ sudo cat \"绝对路径/lib\" \>\>
    /etc/ld.so.conf \$ sudo ldconfig -v 激活配置

3.  通过函数加载

    dlopen dlclose dlsym

## sshpass login

ssh user@ip sshpass -p password ssh user@ip

## Login without password

ssh-keygen -r rsa and drei mal enter ssh-copy-id cloud@ip ssh-copy-id
localhost(warming:username should not be hostname)

## ssh root login

emacs /etc/ssh/sshd~config~

1.  PermitRootLogin yes
2.  AllowUsers root OtherUser

## output redirect

comands xxx \>\> output file comands xxx &\>\> str error file

## recursive string replace

``` {.bash org-language="sh"}
find . -type f -name "*.md" -exec sed -i 's/foo/bar/g' {} +
find . -type f -name "*.vue" -exec sed -i 's/store.state.Timer/store.state.Session01/g' {} +
```

# Useful Software

## tar

-x : extract -c: compose -v: show the process -z: with zip -f : such
file

``` {.bash org-language="sh"}
tar -zvcf xxx.tar.gz xxx
tar -zvxf xxx.tar.gz
```

## fcitx for sougou

    1. sudo apt install fcitx
    download sougou
    2. sudo apt  --fix-broken install(after download)
    3. export LC_CTYPE=zh_CN.UTF-8 (for Emacs)

## eog

    eog xxx.png to view png with bluit in software eog

## Okular

    sudo apt-get install okular
    F2 to constimizer
    F7 mode view
    C-gg to the page
    C-n page down
    C-p page up
    M-n scroll down
    M-p scroll up
    C-b C-b add Annoation, 1 to note
    SPC-b add bookmark
    SPC-SPC rename bookmark
    SPC-n bookmark down
    SPC-p bookmark up

## xournal

    sudo apt install xournal

## evince

    evince xxx.pdf to view pdf file

## stardict

download dictionaries from, <http://download.huzheng.org/> and
<http://download.huzheng.org/zh_TW/> extract, and put them in
*usr/share/stardict/dic* , if without this folder, create it with root

``` shell
sudo apt install stardict
sudo apt install sdcv 
cd ~/Dropbox/cs/Tools
bzip2 -dk *.bz2
for i in *.tar.bz2; do sudo tar -xjvf "$i" -C /usr/share/stardict/dic ; done

```

## kmplayer

sudo apt install kmplayer

## simplescreenrecorder


    sudo apt install simplescreenrecorder
    alias ssr='simplescreenrecorder'
    $ ssr
    Ctrl + Shift + Alt + V start or pause 

## Cvim

    C-j moive to left 
    C-k moive to right

## hotopea

登陆photopea网站后，新建并上传图片 设置白色背景：图像 -\> 调整 -\> 色阶
点击下面的白色 后点击要处理的图片区域 去背景 ： 魔术棒 ， 点击去连续，
再直接delete

## manual png create png

after edit a file.dot

dot -Tpng -O file.dot

## gpg for secret

    gpg --list-secret-keys
    gpg -r user -e xxx.file
    gpg -d xxx.file.gpg
    after change xxx.file :gpg --verify xxx.file.gpg

## ranger

apt install

## pdftk

[official web link](http://www.pdflabs.com/docs/install-pdftk/)

  ------------------ -------------------------------------------------------------
  合并               pdftk 1.pdf 2.pdf 3.pdf output 123.pdf
  多个不同页面合并   pdftk A=1.pdf B=2.pdf C=pdf cat A1-2 B2-3 C3 output abc.pdf
  旋转第一页         pdftk in.pdf cat 1E 2-end output out.pdf
  加密（128位）      pdftk a.pdf output b.pdf owner~pw~ pass
  加访问密码         pdftk a.pdf output b.pdf user~pw~ pass
  解密               pdftk a.pdf input~pw~ pass output b.pdf
  解压               pdftk a.pdf output b.pdf uncompress
  压缩               pdftk a.pdf output b.pdf compress
  修复               pdftk a.pdf output b.pdf
  切割               pdftk a.pdf cat 1-end output b.pdf
  分解成单页         pdftk a.pdf burst
  ------------------ -------------------------------------------------------------

## Linux connect to Android

    kedconnect on linux
    kedconnect on android
    with  the same internet connection can be found each other, and communication

    The file can be found in Download folder of each devices

## gs

### remove active content from pdf

gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=CV.pdf -dBATCH CV.pdf

### compress

gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/prepress
-dNOPAUSE -dQUIET -dBATCH -sOutputFile=compressed~PDFfile~.pdf
input~PDFfile~.pdf

## mpv player

sudo apt install mpv

mpv.conf

    no-osd-bar # 去掉白色进度条
    save-position-on-quit # 关闭时记住文件播放位置
    no-border # 去掉边框

    # 解码-字幕
    vo=opengl:gamma-auto:icc-profile-auto
    hwdec=auto
    autofit-larger=92%
    playcache=8192
    lang=zh,chi
    video-sync=display-resample

    sub-codepage=enca:zh:utf8
    sub-auto=fuzzy
    sub-text-font-size=40
    sub-text-shadow-offset=0
    sub-text-color="#ffffffff"
    sub-text-font="STZhongsong"
    sub-codepage=utf8:gb18030

    screenshot-template=mpv-screenshot-%f-%p
    screenshot-format=png

    osd-font="STZhongsong"
    osd-font-size=36

    --script=/Users/yourname/.config/mpv/autoload.lua

autoload.lua

    -- This script automatically loads playlist entries before and after the
    -- the currently played file. It does so by scanning the directory a file is
    -- located in when starting playback. It sorts the directory entries
    -- alphabetically, and adds entries before and after the current file to
    -- the internal playlist. (It stops if the it would add an already existing
    -- playlist entry at the same position - this makes it "stable".)
    -- Add at most 5000 * 2 files when starting a file (before + after).
    MAXENTRIES = 5000

    function Set (t)
        local set = {}
        for _, v in pairs(t) do set[v] = true end
        return set
    end

    EXTENSIONS = Set {
        'mkv', 'avi', 'mp4', 'ogv', 'webm', 'rmvb', 'flv', 'wmv', 'mpeg', 'mpg', 'm4v', '3gp',
        'mp3', 'wav', 'ogv', 'flac', 'm4a', 'wma',
    }

    mputils = require 'mp.utils'

    function add_files_at(index, files)
        index = index - 1
        local oldcount = mp.get_property_number("playlist-count", 1)
        for i = 1, #files do
            mp.commandv("loadfile", files[i], "append")
            mp.commandv("playlist-move", oldcount + i - 1, index + i - 1)
        end
    end

    function get_extension(path)
        match = string.match(path, "%.([^%.]+)$" )
        if match == nil then
            return "nomatch"
        else
            return match
        end
    end

    table.filter = function(t, iter)
        for i = #t, 1, -1 do
            if not iter(t[i]) then
                table.remove(t, i)
            end
        end
    end

    function find_and_add_entries()
        local path = mp.get_property("path", "")
        local dir, filename = mputils.split_path(path)
        if #dir == 0 then
            return
        end
        local pl_count = mp.get_property_number("playlist-count", 1)
        if (pl_count > 1 and autoload == nil) or
           (pl_count == 1 and EXTENSIONS[string.lower(get_extension(filename))] == nil) then
            return
        else
            autoload = true
        end

        local files = mputils.readdir(dir, "files")
        if files == nil then
            return
        end
        table.filter(files, function (v, k)
            local ext = get_extension(v)
            if ext == nil then
                return false
            end
            return EXTENSIONS[string.lower(ext)]
        end)
        table.sort(files, function (a, b)
            local len = string.len(a) - string.len(b)
            if len ~= 0 then -- case for ordering filename ending with such as X.Y.Z
                local ext = string.len(get_extension(a)) + 1
                return string.sub(a, 1, -ext) < string.sub(b, 1, -ext)
            end
            return string.lower(a) < string.lower(b)
        end)

        if dir == "." then
            dir = ""
        end

        local pl = mp.get_property_native("playlist", {})
        local pl_current = mp.get_property_number("playlist-pos", 0) + 1
        -- Find the current pl entry (dir+"/"+filename) in the sorted dir list
        local current
        for i = 1, #files do
            if files[i] == filename then
                current = i
                break
            end
        end
        if current == nil then
            return
        end

        local append = {[-1] = {}, [1] = {}}
        for direction = -1, 1, 2 do -- 2 iterations, with direction = -1 and +1
            for i = 1, MAXENTRIES do
                local file = files[current + i * direction]
                local pl_e = pl[pl_current + i * direction]
                if file == nil or file[1] == "." then
                    break
                end

                local filepath = dir .. file
                if pl_e then
                    -- If there's a playlist entry, and it's the same file, stop.
                    if pl_e.filename == filepath then
                        break
                    end
                end

                if direction == -1 then
                    if pl_current == 1 then -- never add additional entries in the middle
                        mp.msg.info("Prepending " .. file)
                        table.insert(append[-1], 1, filepath)
                    end
                else
                    mp.msg.info("Adding " .. file)
                    table.insert(append[1], filepath)
                end
            end
        end

        add_files_at(pl_current + 1, append[1])
        add_files_at(pl_current, append[-1])
    end

    mp.register_event("start-file", find_and_add_entries)

## mellplayer

sudo apt-get install libmpv-dev mpv

## thunderbird

    Alt to open the menubar,
    Ansicht Anpassen to setting ungelesen

    For Filter:
    cd ~/.thunderbird/4r373mm9.default-release/ImapMail/imap.gmail.com
    import msgFilterRules.dat to Gmail

## EverSync

Eversync sync all bookmarks between chrome and firefox with G Konten

## IPFS


    download go-ipfs and untar
    cp ipfs /usr/local/bin and sudo ./install.sh

    sudo apt install ipfs

    ipfs init
    export EDITOR=/usr/bin/emacs
    ipfs config edit
    ipfs id
    ipfs  help


    mkdir IPFS
    echo "balabalu" > hallo.org
    ipfs add hallo.org  :get file_hash
    ipfs cat file_hash
    ipfs.io/ipfs/file_hash

push


    ipfs add -r . (we get all file_hash(s), and a folder_hash(IPFS))
    ipfs name publish folder_hash  (: to IDHASH)

    in Webborser: ipfs.io/ipns/IDHASH


    ipfs name resolve IDHASH : to HASH_file

    特殊加密，暂时不用
    ipfs key gen --type=rsa --size=2048 IPFS
    ipfs name publish --key=IPFS folder_hash

    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT", "GET", "POST","OPTIONS"]'

    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'

    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'

    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers '["Authorization"]'

    ipfs config --json API.HTTPHeaders.Access-Control-Expose-Headers '["Location"]'


    http://localhost:5001/webui


    ipfs files mkdir /Docu

    ipfs files ls /Docu

    ipfs file cp /ipfs/HASH

## GPG

  ------------------ ---------------------------------------------------------
  terminal encrypt   gpg --recipient ID --output en.org --encrypt source.org
  terminal decrypt   gpg en.org
  emacs encrypt      epa-encrypt-file
  emacs decrypt      epa-decrypt-file
  ------------------ ---------------------------------------------------------

encrypt by terminal, once decrypt by emacs, just as normal file, can be
edited anytime encrypt by emacs with password, passwd will be ask every
time by after edit if epa-file-select-key is t

## Zulip Rocket Chat

# System control

## system backup

mount rsync

查看系统的磁盘 :lsblk 再将磁盘(也可以是某个分区)挂载到某个点 :

该磁盘可以是正在使用的磁盘或者分区

     mount /dev/disk /media/Linux
    sudo mount /dev/sda1 /media/Backup

    rsync -aAXv --delete --exclude=media target backup/LinuxBackUp20200316
    my opera 

    rsync -aAXv /home/sx/ /media/sx/A672BA1B72B9EFE3/linuxbackup/home/

如果要恢复，重复上面的过程，再将target backup 交换

## system performance

1.  systemlastanzeigen sudo apt install indicator-multiload

2.  dependence

sudo apt-get install gir1.2-gtop-2.0 gir1.2-networkmanager-1.0
gir1.2-clutter-1.0

1.  Ubuntu Software

search for : system moniter extension

1.  install and configure performance

## hostname

hostnamectl hostnamectl set-hostname cat /etc/hostname cat /etc/hosts

# chinese config

## emacs chinese input

sudo apt install fcitx download sougou for linux sudo dpkg -i
sougou...... fcitx set global restart configuration to add sougou
chinese

\$ local -a \|grep zh sudo apt-get -y install language-pack-zh-hans \$
local -a \|grep zh to see zh is installed

export LC~CTYPE~=zh~CN~.UTF-8 to language configuration and auto install
drivers to zh~CN~.UTF-8 so in emacs can input sougou, here we go

## chinese output pdf

for a orgmode file with 汉字 pandoc xxxx.org -o xxxx.pdf pandoc xxxx.org
-o xxxx.pdf --pdf-engine=xelatex 如果没有汉字支持

    fc-list -f "%{family}\n"  :lang=zh
    pandoc test.org -o test.pdf --pdf-engine=xelatex -V mainfont="AR PL KaitiM GB"

找到支持的格式，再指明

# sed

  --- ---------------------------------------------------------
  a   add new line(s) after match with context behind a
  c   replace the current line in match with context behind c
  i   add context behind i before match
  s   repace
  d   delete
  --- ---------------------------------------------------------

sed -rn \'/2\\/1/s/00/\*\*/pg\' test2.csv

-   sed:
-   -rn : no default output and allow \\
-   \' \' : aufrufen
-   /2\\/1: reg pattern
-   s: search
-   00: all 00

\-**\*\***: will be replaced by\*\*

-   p: print
-   g: global replace
-   test2.csv: input file

sed \'s/ //pg\' test2.csv

# Makefile

gcc 调用 make 来构造

## 格式

目标 ： 依赖 Tab 命令

## 1example

实列文件：add.c head.h main.c maul.c sub.c 直接在terminal 用gcc ：\$ gcc
add.c main.c sub.c -o app

Makefile : \$ touch Makefile

``` txt
app: main.c add.c sub.c mul.c
    gcc main.c add.c sub.c mul.c 
```

\$ make

## 2修改后只编译改动后的文件

Makefile : \$ touch Makefile

``` txt
app: main.o add.o sub.o mul.o
    gcc main.o add.o sub.o mul.o -o app

main.o: main.c
    gcc -c main.c -o main.o

add.o: add.c
    gcc -c add.c -o add.o

sub.o: sub.c
    gcc -c sub.c -o sub.o

mul.o: mul.c
    gcc -c mul.c -o mul.o

```

\$ make 所有源文件的修改过，即时间戳晚于生成的目标文件，则重新编译

## 3使用自动变量

\$@ :目标 \$\< :第一个依赖 \$\^ :所有依赖 Makefile : \$ touch Makefile

``` txt
obj =   main.o add.o sub.o mul.o
target = app

$(target):$(obj)
    gcc $(obj) -o $(target)  // gcc $^ -o $@

%.o:%.c
    gcc -c $< -o $@

```

\$ make

## 4增加可移植性

wildcard :查找指定目录下的指定类型文件 src = \$(wildcard ./\*.c)
将当前目录下所有的.c 找到，并赋给src

patsubst :匹配替换 obj = \$(patsubst %.c, %.o, \$(src))
将src中的所有.c替换为.o

Makefile : \$ touch Makefile

``` txt
src = $(wildcard ./*.c)
obj = $(patsubst %.c, %.o $(src))
target = app

$(target):$(obj)
    gcc $^ -o $@

%.o:%.c
    gcc -c $< -o $@

```

\$ make 此文件在别的目录下也能使用

## 5清洁中间的生成的不必要保存文件

make 一般直接执行终结目标，但是可以直接指定make的函数 clean :
删除不必要的文件，-f : 强制删除，不管有没有该文件，- :
前置-后，遇到错误执行，直接跳过

``` txt
src = $(wildcard ./*.c)
obj = $(patsubst %.c, %.o $(src))
target = app

$(target):$(obj)
    gcc $^ -o $@

%.o:%.c
    gcc -c $< -o $@

clean:
    rm $(obj) $(target)
    rm $(obj) $(target) -f
    -rm $(obj) $(target) -f

```

\$ make \$ make clean

# BetreibenSystem

## Program execution level

Multi Process : Parallel single Process has more thread : Concurrency
single thread can work in Synchronous or Asynchronous

## Multi Process

### queue communication

1.  one way communication server to client

    Server.c

    ``` {.c org-language="C"}
    #include <stdio.h>
    #include "unistd.h"
    #include "sys/types.h"
    #include "stdlib.h"
    #include "signal.h"
    #include "sys/msg.h"
    #include "string.h"

    #define messagelen 124


    struct messqueue
    {
      long type;
      char message[messagelen];
      char ID[4];
    };


    int main(int argc, char *argv[])
    {
      int msgid;
      int key;
      int receivelen;
      int conut = 0;
      struct messqueue sendbuffer;
      sendbuffer.type = 100;

      key = ftok("./a.c", 'a');
      if (key < 0) {
        printf("create key for server failed \n");
        return -1;
      }

      //create the massage queue
      msgid= msgget(key, IPC_CREAT | 0777);
      if (msgid < 0) {
        printf("creat massage queue failed .\n");
        return -1;
      }
      printf("create massage queue success  with msgid %d.\n",  msgid);


      do {
        memset(sendbuffer.message, 0, messagelen);
        //input your massage
        printf("please input your massage you want to send to massage queue \n");
        scanf("%s", sendbuffer.message);

        //wirte the massage(which is now in your struct messqueue) into massage queue msgid
        msgsnd(msgid, (void *)&sendbuffer, strlen(sendbuffer.message), 0);
        conut++;
      }while (conut < 3);

      msgctl(msgid, IPC_RMID, NULL);

      system("ipcs -q");
      return 0;
    }

    ```

    Client.C

    ``` {.c org-language="C"}
    #include <stdio.h>
    #include "unistd.h"
    #include "sys/types.h"
    #include "stdlib.h"
    #include "signal.h"
    #include "sys/msg.h"
    #include "string.h"

    #define messagelen 124


    struct messqueue
    {
      long type;
      char message[messagelen];
      char ID[4];
    };


    int main(int argc, char *argv[])
    {
      int msgid;
      int key;
      int receivelen;
      int conut = 0;
      struct messqueue sendbuffer;
      sendbuffer.type = 100;

      key = ftok("./a.c", 'a');
      if (key < 0) {
        printf("create key for server failed \n");
        return -1;
      }

      //create the massage queue
      msgid= msgget(key, IPC_CREAT | 0777);
      if (msgid < 0) {
        printf("creat massage queue failed .\n");
        return -1;
      }
      printf("create massage queue success  with msgid %d.\n",  msgid);


      do {
        memset(sendbuffer.message, 0, messagelen);
        //input your massage
        printf("please input your massage you want to send to massage queue \n");
        scanf("%s", sendbuffer.message);

        //wirte the massage(which is now in your struct messqueue) into massage queue msgid
        msgsnd(msgid, (void *)&sendbuffer, strlen(sendbuffer.message), 0);
        conut++;
      }while (conut < 3);

      msgctl(msgid, IPC_RMID, NULL);

      system("ipcs -q");
      return 0;
    }

    ```

2.  two ways communication server vs client

    Server.c

    ``` {.c org-language="C"}
    #include <stdio.h>
    #include "unistd.h"
    #include "sys/types.h"
    #include "stdlib.h"
    #include "signal.h"
    #include "sys/msg.h"
    #include "string.h"

    #define messagelen 124


    struct messqueue
    {
      long type;
      char message[messagelen];
      char ID[4];
    };


    int main(int argc, char *argv[])
    {
      int msgid;
      int key;
      int receivelen;
      int conut = 0;
      pid_t pid;
      struct messqueue sendbuffer, receiverbuffer;


      key = ftok("./b.c", 'a');
      if (key < 0) {
        printf("create key for server failed \n");
        return -1;
      }

      //create the massage queue
      msgid= msgget(key, IPC_CREAT | 0777);
      if (msgid < 0) {
        printf("creat massage queue failed .\n");
        return -1;
      }
      printf("create massage queue success  with msgid %d.\n",  msgid);

      pid = fork();

      if (pid > 0) {   //server father process write tpye 100
        sendbuffer.type = 100;

        while(1) {
          memset(sendbuffer.message, 0, messagelen);
          //input your massage
          printf("please input your massage you want to send to massage queue \n");
          scanf("%s", sendbuffer.message);

          //wirte the massage(which is now in your struct messqueue) into massage queue msgid
          msgsnd(msgid, (void *)&sendbuffer, strlen(sendbuffer.message), 0);
          conut++;
        }
      }

      if (pid == 0) {    //server child process read tpye 200
        while (1) {
          memset(receiverbuffer.message, 0, messagelen);
          msgrcv(msgid, (void *)&receiverbuffer, messagelen, 200, 0);
          printf("the receive massage of massage queue in server is %s \n", receiverbuffer.message);
        }

      }

      msgctl(msgid, IPC_RMID, NULL);

      system("ipcs -q");
      return 0;
    }

    ```

    Client.c

    ``` {.c org-language="C"}
    #include <stdio.h>
    #include "unistd.h"
    #include "sys/types.h"
    #include "stdlib.h"
    #include "signal.h"
    #include "sys/msg.h"
    #include "string.h"

    #define messagelen 124


    struct messqueue
    {
      long type;
      char message[messagelen];
      char ID[4];
    };


    int main(int argc, char *argv[])
    {
      int msgid;
      int key;
      int receivelen;
      int conut = 0;
      pid_t pid;
      struct messqueue sendbuffer, receiverbuffer;


      key = ftok("./b.c", 'a');
      if (key < 0) {
        printf("create key for server failed \n");
        return -1;
      }

      //create the massage queue
      msgid= msgget(key, IPC_CREAT | 0777);
      if (msgid < 0) {
        printf("creat massage queue failed .\n");
        return -1;
      }
      printf("create massage queue success  with msgid %d.\n",  msgid);

      pid = fork();

      if (pid == 0) { // client child process for write tpye 200
        sendbuffer.type = 200;

        while(1) {
          memset(sendbuffer.message, 0, messagelen);
          //input your massage
          printf("please input your massage you want to send to massage queue \n");
          scanf("%s", sendbuffer.message);

          //wirte the massage(which is now in your struct messqueue) into massage queue msgid
          msgsnd(msgid, (void *)&sendbuffer, strlen(sendbuffer.message), 0);
          conut++;
        }
      }

      if (pid > 0) {  // client child process read type 100
        while(1){
          memset(receiverbuffer.message, 0, messagelen);
          msgrcv(msgid, (void *)&receiverbuffer, messagelen, 100, 0);
          printf("the receive massage of massage queue in server is %s \n", receiverbuffer.message);
        }
      }

      msgctl(msgid, IPC_RMID, NULL);

      system("ipcs -q");
      return 0;
    }


    ```

### pipe communication

1.  named

    1.  In current directory: mkfifo(\"./myfifo\", 0777);

    with mkfifo creat a file, so that other unrelated process can commu

    1.  In one process : fd = open(\"./myfifo\", O~WRONGLY~);

    open the file, and : write(fd, &process~inter~,1); change the pipe
    variable.

    1.  In other process : fd = open(\"./myfifo\",O~RDONLY~);

    open the file, and : while(process~inter~ == 0); can be controled by
    pipe variable

2.  unnamed

    1.  In one process diff threads creat place for pipe : int fd\[2\];
        one for main thread, one for new thread creat pipe : int ret =
        pipe(fd);

        in new thread : read(fd\[0\], &process~inter~ 1); if nothing to
        read, sleep in main thread do its stuff, after finish :
        write(fd\[1\], &process~inter~, 1); let new pthread run

        remeber: wirte at frist in fd\[1\], and then read at fd\[0\]

### signal communication

1.  alarm

    alarm(10); wait for 10 seconds and kill itself send signal as 14 to
    itself

2.  kill

    kill(pid, 9); send signal 9 to pid process

3.  raise

    raise(9); == kill(getpid(), 9);

4.  pause

    pause(); stoped for ever

5.  signal

    signal(signal~ID~, self~function~); self function or SIG~ING~ or
    SIG~DFL~

6.  exit

    exit(0) will also send signal 17 (SIGCHID) to its father thread;

### semaphore communication

1.  key

    key can be 2 differ

    1.  For father and son process : IPC~PRIVATE~ :
    2.  For unrelated process : self~def~ key

    ``` {.c org-language="C" results="output" exports="both"}

    int key;
    key = ftok("./a.c", 'a');
    if (key < 0) {
      printf("create key for server failed \n");
      return -1;
    }
    printf("create key for server success \n");
    ```

2.  memcpy

    memcpy(p, \"niao\",4);

3.  shmget

    shmid = shmget(IPC~PRIVATE~, 128, 0777); shmid = shmget(key, 128,
    IPC~CREAT~ \| 0777);

4.  shmat

    char \*p = (char \*) shmat(shmid, NULL, 0); after mapping to p : can
    be manipulated scanf(\"%s\", p); printf(\"%s\", p);

5.  shmdt

    delete the mapping of p to shared memory shmdt(p); after that, the
    manipulation of p is not allowed, and well be segmention fault

6.  shmctl

    delete the created shared memory shmctl(shmid, IPC~RMID~, NULL); ==
    iprcm -m shmid

7.  IPC manipulation

    show : ipcs -m(shared memory) -q(message queue) -s(semaphores)
    delete : ipcrm -m shmid /-q msgid /-s semid

8.  msgget

    msgid= msgget(IPC~PRIVATE~, 0777);

    ``` {.c org-language="C" results="output" exports="both"}
    #include <stdio.h>
    #include "unistd.h"
    #include "sys/types.h"
    #include "stdlib.h"
    #include "signal.h"
    #include "sys/msg.h"

    int main(int argc, char *argv[])
    {
      int msgid;

      msgid= msgget(IPC_PRIVATE, 0777);
      if (msgid < 0) {
        printf("creat massage queue failed .\n");
        return -1;
      }

      printf("create massage queue success  with msgid %d.\n",  msgid);

      system("ipcs -q");
      return 0;
    }

    ```

    ``` example

    ------ Nachrichtenwarteschlangen --------
    Schlüssel msqid      Besitzer   Rechte     Benutzt-Bytes Nachrichten 
    0x61091797 2          silin      777        0            0           
    0x00000000 4          silin      777        0            0           
    0x00000000 5          silin      777        0            0           
    0x00000000 6          silin      777        0            0           
    0x00000000 7          silin      777        0            0           
    0x00000000 8          silin      777        0            0           
    0x00000000 9          silin      777        0            0           
    0x00000000 10         silin      777        0            0           
    0x00000000 11         silin      777        0            0           
    0x00000000 12         silin      777        0            0           

    create massage queue success  with msgid 12.
    ```

9.  msgctl

    msgctl(msgid, IPC~RMID~, NULL); == ipcrm -q msgid

    ``` {.c org-language="C" results="output" exports="both"}
    #include <stdio.h>
    #include "unistd.h"
    #include "sys/types.h"
    #include "stdlib.h"
    #include "signal.h"
    #include "sys/msg.h"

    int main(int argc, char *argv[])
    {
      int msgid;

      msgid= msgget(IPC_PRIVATE, 0777);
      if (msgid < 0) {
        printf("creat massage queue failed .\n");
        return -1;
      }

      printf("create massage queue success  with msgid %d.\n",  msgid);

      system("ipcs -q");
      return 0;
    }

    ```

10. msgsnd & msgrcv

    msgsnd(msgid, (void \*)&sendbuffer, strlen(sendbuffer.message), 0);

    receivelen = msgrcv(msgid, (void \*)&receiverbuffer, messagelen,
    100, 0);

    ``` {.c org-language="C" results="output" exports="both"}
    #include <stdio.h>
    #include "unistd.h"
    #include "sys/types.h"
    #include "stdlib.h"
    #include "signal.h"
    #include "sys/msg.h"
    #include "string.h"

    #define messagelen 124


    struct messqueue
    {
      long type;
      char message[messagelen];
      char ID[4];
    };


    int main(int argc, char *argv[])
    {
      int msgid;
      int receivelen;
      struct messqueue sendbuffer, receiverbuffer;
      sendbuffer.type = 100;
      receiverbuffer.type = 100;

      //create the massage queue
      msgid= msgget(IPC_PRIVATE, 0777);
      if (msgid < 0) {
        printf("creat massage queue failed .\n");
        return -1;
      }
      printf("create massage queue success  with msgid %d.\n",  msgid);

      //input your massage
      printf("please input your massage you want to send to massage queue \n");
      scanf("%s", sendbuffer.message);

      //wirte the massage(which is now in your struct messqueue) into massage queue msgid
      msgsnd(msgid, (void *)&sendbuffer, strlen(sendbuffer.message), 0);

      //clear receiverbuffer.massage
      memset(receiverbuffer.message, 0, messagelen);
      //read massage to receiverbuffer from massage queue msgid
      receivelen = msgrcv(msgid, (void *)&receiverbuffer, messagelen, 100, 0);

      printf("the receiverbuffer massage have %s .\n", receiverbuffer.message);
      printf("the long is %d .\n", receivelen);


      msgctl(msgid, IPC_RMID, NULL);

      system("ipcs -q");
      return 0;
    }

    ```

    ``` example

    ------ Nachrichtenwarteschlangen --------
    Schlüssel msqid      Besitzer   Rechte     Benutzt-Bytes Nachrichten 
    0x61091797 2          silin      777        0            0           
    0x00000000 4          silin      777        0            0           
    0x00000000 5          silin      777        0            0           
    0x00000000 6          silin      777        0            0           
    0x00000000 7          silin      777        0            0           
    0x00000000 8          silin      777        0            0           
    0x00000000 9          silin      777        0            0           
    0x00000000 10         silin      777        0            0           
    0x00000000 11         silin      777        0            0           
    0x00000000 12         silin      777        0            0           

    create massage queue success  with msgid 14.
    please input your massage you want to send to massage queue 
    the receiverbuffer massage have
    the long is 6 .
    ```

11. semget

    semid = semget(IPC~PRIVATE~,3 , 0777);

12. semctl

    semctl(semid, 0, IPC~RMID~, NULL);

## Multi Thread

### 1 pthread~create~.c

using pthread~create~ create new thread(thread~fun~) with
arguements(\"new thread\"). In new thread call function print~id~ with
giving arguements.

This programm can\'t compiled in Babel, please save this as a .c file,
and compile with **-pthread**

``` {.c org-language="C" results="output" exports="both"}
#include "apue.h"

void print_id(char *s)
{
  pid_t pid;
  pthread_t tid;

  pid = getpid();
  tid = pthread_self();

  printf("%s pid is %u, and tid is 0x%x\n", s, pid, (int) tid);
}

void *thread_fun(void *arg)
{
  printf("In son thread, can't get the father tid \n");

  print_id(arg);
  return (void *)0;
}

int main( )
{
  pthread_t ntid;
  int err;
  err = pthread_create(&ntid, NULL, thread_fun, "new thread");

  if (err != 0) {
    printf("create new thread is failed\n");
    return 0;
  }
  printf("In father thread, the new THREAS is 0x%x \n", (int)ntid );

  print_id("main thread");
  sleep(2);

  return 0;
}


```

### 2 pthread~id~.c

using pid = getpid() to get pid of current pthread

``` {.c org-language="C" results="output" exports="both"}
#include <stdio.h>
#include "unistd.h"
#include "sys/types.h"
#include "stdlib.h"
#include "signal.h"
#include "sys/msg.h"
#include "string.h"

int main( )
{
  pid_t pid;
  pthread_t tid;

  pid = getpid();
  tid = pthread_self();

  printf("pid is %d , and tid is %x\n", pid, (int)tid );
  return 0;
}


```

``` example
pid is 3406 , and tid is 960c4c0
```

### 3 pthread~jion~.c

pthread~jion~(tid, &reval) 可以回收主线程发起的副线程tid，并由
副线程指定返回值给reval.但是副线程如自己调用了
pthread~detach~(pthread-self()) 可以阻止主线程的jion

``` {.c org-language="C"}
#include "apue.h"

void *thread_fun1(void *arg){
  printf("New thread out with return\n");
  return (void *)1;
}

void *thread_fun2(void *arg){
  printf("New thread out with pthread_exit\n");
  pthread_detach(pthread_self()); // detach it self
  pthread_exit((void *)2);
}


int main( )
{
  pthread_t tid1, tid2;
  int err1, err2;
  void  *reval1, *reval2;

  err1 = pthread_create(&tid1, NULL, thread_fun1, NULL); 
  err2 = pthread_create(&tid2, NULL, thread_fun2, NULL); 

  if (err1 || err2) {
    printf("The create of new thread is failed\n");
  }

  printf("the thread 1 has return as %d\n", pthread_join(tid1, &reval1) );
  printf("the thread 2 has return as %d\n", pthread_join(tid2, &reval2) );

  printf("the thread 1 has return code %d\n",(int*)reval1 );
  printf("the thread 2 has return code %d\n",(int*)reval2 );

  return 0;
}



```

### 4 pthread~cancel~.c

从主线程来的pthread~cancel~(tid)作用到tid的副线程时，
如果副线程设置为pthread~setcancelstate~(PTHREAD~CANCELDISABLE~, NULL)
则取消请求被忽视

如果副线程设置为pthread~setcancelstate~(PTHREAD~CANCELENABLE~, NULL);
则取消请求在下一个取消点被执行

如果副线程设置为pthread~setcanceltype~(PTHREAD~CANCELASYNCHRONOUS~,
NULL); 则取消请求被立即执行

``` {.c org-language="C"}
#include "apue.h"

void *thread_fun(void * arg){
  int stateval;
  int typeval;

  //  set cancel to be disable
  stateval = pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, NULL);
  if (stateval != 0) {
    printf("set cancel state to disable is failed\n");
  }
  printf("I'm New thread here !\n");
  sleep(4);


  //set cancel to be enable, will be canceled at the first cancel point
  stateval = pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
  if (stateval != 0)
    printf("set cancel state to enable is failed\n");
  else
    printf("about to set cancel enable\n");   // print is a cancel point

  //set cancel to be enable and immediately
  typeval = pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
  if (typeval != 0) {
    printf("set cancel state to immediately failed\n");
  }

  //cancel points
  printf("first place to cancel:\n");
  printf("second place to cancel:\n");
  return (void *)20;
}



int main( )
{
  pthread_t tid;
  int err, cval, jval;
  void * rval;

  err = pthread_create(&tid, NULL, thread_fun, NULL);
  if (err != 0) {
    printf("creat new thread is failed\n");
    return 0;
  }
  sleep(2);

  cval = pthread_cancel(tid);
  if (cval != 0) {
    printf("cancel the new thread is failed\n");
    return 0;
  }

  jval = pthread_join(tid, &rval);
  if (jval != 0) {
    printf("join thread  is failed\n");
    return 0;
  }
  printf("new thread has return code of %d\n", (int) rval );

  return 0;
}

```

### 5 pthread~rwlock~.c

pthread~rwlockt~ rwlock; 声明 pthread~rwlockinit~(&rwlock); 初始化
pthread~rwlockwrlock~(&rwlock); 写锁 pthread~rwlockrdlock~(&rwlock);
读锁 pthread~rwlockunlock~(&rwlock); 解锁
pthread~rwlockdestroy~(&rwlock); 销锁

``` {.c org-language="C"}
#include "apue.h"
int num;
pthread_rwlock_t rwlock;

void * thread_fun1(void *arg){
  int err;
  sleep(1);
  pthread_rwlock_wrlock(&rwlock);  // write mode lock
  // pthread_rwlock_rdlock(&rwlock);   // read mode lock

  printf("thread 1 print num as %d\n",num );
  sleep(5);
  printf("thread 1 is over \n");

  pthread_rwlock_unlock(&rwlock);
  return (void *)0;
}

void * thread_fun2(void *arg){
  int err;
  pthread_rwlock_wrlock(&rwlock);
  //  pthread_rwlock_rdlock(&rwlock);

  printf("thread 2 print num as %d\n",num );
  sleep(5);
  printf("thread 2 is over \n");

  pthread_rwlock_unlock(&rwlock);
  return (void *)0;
}

int main( )
{
  pthread_t tid1, tid2;
  int err;

  err = pthread_rwlock_init(&rwlock, NULL);
  if (err) {
    printf("init failed\n");
    return 0;
  }

  err = pthread_create(&tid1, NULL ,thread_fun1, NULL);
  if (err) {
    printf("create of the first thread fail\n");
    return 0;
  }

  err = pthread_create(&tid2, NULL ,thread_fun2, NULL);
  if (err) {
    printf("create of the second thread failed\n");
    return 0;
  }

  pthread_join(tid1, NULL);
  pthread_join(tid2, NULL);

  pthread_rwlock_destroy(&rwlock);

  return 0;
}




```

### 6 pthread~attr~.c

seeing pthread~attr~.c pthread~attrinit~(&attr) using :
pthread~attrsetdetachstate~(&attr, PTHREAD~CREATEDETACHED~); OR:
pthread~attrsetdetachstate~(&attr, PTHREAD~CREATEJOINABLE~);
决定该线程是否可以被jion.

``` {.c org-language="C"}
#include "apue.h"

void *thread_fun1(void *arg)
{
  printf("I am new thread  1\n");
  return (void *)1;
}


void *thread_fun2(void *arg)
{
  printf("I am new thread  2 \n");
  return (void *)2;
}

int main(int argc, char *argv[])
{
  pthread_t tid1, tid2;
  int err;

  //def attr and init and set to be spreate
  pthread_attr_t attr;
  pthread_attr_init(&attr);
  //  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);  

  err = pthread_create(&tid1, &attr, thread_fun1, NULL);
  if (err) {
    printf("create new thread 1 failed \n");
    return 0;
  }

  err = pthread_create(&tid2, NULL, thread_fun2, NULL);
  if (err) {
    printf("create new thread 2 failed \n");
    return 0;
  }

  err = pthread_join(tid1, NULL);
  if (!err) 
    printf("join thread 1 success \n");
  else 
    printf("jion thread 1 failed \n");


  err = pthread_join(tid2, NULL);
  if (!err) 
    printf("join thread 2 success \n");
  else 
    printf("jion thread 2 failed \n");

  pthread_attr_destroy(&attr);

  return 0;
}



```

### 7 pthread~mutex~.c

pthread~mutexlock~(&mutex) 和 pthread~mutexunlock~(&mutex)
可以锁住之间的的任何变量， 所以不同线程之间的访问和赋值只能错开时间，
这样就不会造成线程之间变量值不受控制的错误

``` {.c org-language="C"}
#include "apue.h"

struct student{
  int age;
  int size;
} stu;

int i;
pthread_mutex_t mutex;

void *thread_fun1(void *arg){
  while(1){
    //    pthread_mutex_lock(&mutex);
    stu.age = i;
    stu.size = i;
    i++;
    if (stu.age != stu.size) {
      printf("thread 1 %d, %d,\n", stu.age, stu.size);
      break;
    }
    //    pthread_mutex_unlock(&mutex);
  }
  return (void *)0;
}


void *thread_fun2(void *arg){
  while (1) {
    //    pthread_mutex_lock(&mutex);
    stu.age = i;
    stu.size = i;
    i++;
    if (stu.age != stu.size) {
      printf("thread 2 %d, %d,\n", stu.age, stu.size);
    }
    //    pthread_mutex_unlock(&mutex);
  }
  return(void *)0;
}

int main( )
{
  pthread_t tid1, tid2;
  int err1, err2;

  err1 = pthread_create(&tid1, NULL, thread_fun1, NULL);
  err2 = pthread_create(&tid2, NULL, thread_fun2, NULL);  
  if (err1 || err2) {
    printf("the create o pthread 1 and pthread 2 failed\n");
  }

  pthread_join(tid1, NULL);
  pthread_join(tid2, NULL);

  return 0;
}


```

### 8 pthread~interpetercontroll~.c

用主线程给一个可交换变量赋值，来控制副进程的执行， only if in main
thread, parameter interpeter be assigned to 1, in side thread can start
to run.

``` {.c org-language="C"}
#include <stdio.h>
#include "stdlib.h"
#include <unistd.h>
#include "pthread.h"

int interpeter = 0;

void *mythread(void *num){
  while(interpeter == 0);
  int i = 0;
  for (i = 0; i < 10; ++i) {
    printf("In my thread there is %d\n", i);
    usleep(100);
  }
  return (void *)0;
}

int main(int argc, char *argv[])
{
  pthread_t tid;
  int err;
  err = pthread_create(&tid, NULL, mythread, NULL);
  if (err < 0) {
    printf("create my thread failed\n");
    return -1;
  }
  int i = 0;
  for (i = 0; i < 10; ++i) {
    printf("In main thread there is %d\n", i);
    usleep(100);
  }
  interpeter = 1;
  sleep(10);
  return 0;
}



```

### 9 pthread~passstruct~.c

将一个结构体通过pthread~create~()的参数传给副进程，注意在副进程中的
结构体转化

``` {.c org-language="C"}
#include "apue.h"

struct student {
  int age;
  char name[10];
  char subject[10];
};

void *thread_fun(void *stu)
{
  printf("In the constuction we have age : %d, name : %s, and subject %s.\n", ((struct  student *)stu)->age,((struct student *)stu)->name, ((struct student *)stu)->subject);
  return (void *)0;
}

int main( )
{
  pthread_t tid;
  int err;
  void * val;

  struct student stu;
  stu.age = 20;
  memcpy(stu.name, "xiang", 10);
  memcpy(stu.subject, "phyics", 10);

  err = pthread_create(&tid, NULL, thread_fun, (void *)&stu);
  if (err != 0) {
    printf("the new thread is failed to create\n");
    return  0;
  }
  pthread_exit(val);
  return 0;
}





```

### 10 pthread~stackattr~.c

在系统支持的条件下，获取栈的大小，并作出调整

``` {.c org-language="C"}
#include "apue.h"

pthread_attr_t attr;

void *thread_fun(void *arg){

  size_t stacksize;

#ifdef _POSIX_THREAD_ATTR_STACKSIZE
  pthread_attr_getstacksize(&attr, &stacksize);
  printf("new thread stack size is %d \n", (int)stacksize );  //获取默认栈大小
  //更改 has to be greater than 16384, otherwise will be default
  pthread_attr_setstacksize(&attr, 100000);
  pthread_attr_getstacksize(&attr, &stacksize);
  printf("new thread stack size is %d \n", (int)stacksize );  //获取设置栈大小
#endif // _POSIX_THREAD_ATTR_STACKSIZE


  return (void *)1;
}


int main(int argc, char *argv[])
{
  pthread_t tid;
  int err;

  pthread_attr_init(&attr);

  //设置为可连接的分离属性
  pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);

  //check if system support this
#ifdef _POSIX_THREAD_ATTR_STACKSIZE
  pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);
#endif // _POSIX_THREAD_ATTR_STACKSIZE

  err = pthread_create(&tid, &attr, thread_fun, NULL);
  if (err) {
    printf("create new thread failed \n");
    return 0;
  }
  pthread_join(tid ,NULL);
  return 0;
}


```

## Stoket

# Git

## tips

    Raw 文件
    git rm --cached file, will only delete it in git, but still in my local directory

## Git installation in Linux

1.  sudo apt install git

2.  local configuration

``` {.bash org-language="sh"}
git  config --global user.name "username1"
git  config --global user.email "email1"
```

git config --list

1.  in local terminal

``` {.bash org-language="sh"}
ssh-keygen -t rsa -C "email2"
```

and then just all enter as default warming: email1 == email2

## Webconfig

    1. go to Fold Docu1, and in terminal git init to create local  repository
    2. apply github count with:
       Email: email3
       Username: username3
       Password:xxxx
    3. in setting add ssh key from local document: ./ssh/id_rsa.pub
    4. create web repository with name Docu2
       Warming: Docu1 == Docu2

## Connection


    1. in local computer Docu1, create our files and prepare to push to
       Github
    2. git add && git commit -m ""
    3. git remote add origin HTTPS/SSH(of the created web repository)
       warming: with  HTTPS will be ask the Username:username3 and
       password:xxxx every time for the push, but SSH note
    4. git push -u origin master
    5. username3 and xxxx if necessary
    6. later push it only use git push origin master

## Magit

    C-x g  : open the git buffer
    S or s : to stage
    C      : to commit 
    C-c C-c : to finish commit
    P and p to push

## Git branch

### git branch 创建development分支

    branch 创建 新分支
    创建新的分支： git branch development
    带着全部家当去新的分支： git checkout development
    git add -A 
    git commit -m "development"
    git push -u origin development

### git merge 可以 merge mybranch分支到master分支

    merge 融合分支
    如果此时只有development分支改变，可以直接回到master, 把development分支
    merge 过来   git merge development

    git checkout master
    git pull origin master
    git branch --merged
    git merge development
    git push origin master

### 删除mybranch分支


    git branch --merged
    git branch -d mybrauch
    git branch -a 
    git push origin --delete mybrauch

### git rm

1.  git rm --cached file

        编辑当前文件后，已提交(已 add),想撤出索引 ：    git rm --cached  file
        after that, I can check the delete file with git status or git diff --cached.

2.  recover after git rm

        if I want , I can git add * to call all back again, but nothing to commit

3.  confirm to delete file in local directory

        if I ready want to delete this,
        using rm file  delete the file in local directory, 
        but git status and diff --cached remands this still, 
        only after commit, there's no signal for the deleted file anymore.

4.  recover after delete in local directory

        git reflog
        git reset --hard ID

### git multi commit

commit 添加提交 和上次commit提交融合，不产生新的提交记录： git commit
--amend

### remote branch

    git checkout -t origin/ui-mockup

## commands to recover

### after only save

  ---------------------- -----------------------------------------------------
  git diff               can see the different comparing to last time commit
  git checkout -- file   git diff: NULL, file has been recovered
  ---------------------- -----------------------------------------------------

### after git add file

  ---------------------- ---------------------------------------------------------
  git diff               dit diff :NULL
  git diff --cached      can see the different comparing to the last time commit
  git reset HEAD file    git diff -- cached : NULL
  git checkout -- file   file has been recovered
  ---------------------- ---------------------------------------------------------

### after git commit file


    编辑后，强制回到最近一次添加索引的版本：        git reset --hard HEAD
    编辑后，强制回到最近倒数第二次添加索引的版本：   git reset --hard HEAD~
    编辑后，强制回到最近倒数第n次添加索引的版本：    git reset --hard HEAD~n

    如果将HEAD换成对应的ID， 也可以回到之前相应的版本。 但是如果想再回去，
    又没有记住之前的ID， 可以用，       git reflog 查询.

# GWDG

1.  as student of Göttingen send email to support@gwdg.de with uni
    email, asking for freischaltung of cloud server
2.  got <https://gwdg.de> Dienst-\> GWDG cloud server -\> self service
    create Instance if with my ssh, the connect can be without password,
    but still need to aktiv
3.  where the instance is created, use the VNS to aktiv the konto,
    remember to save the password ssh cloud@ip

# Google cloud

# Certificate

-   First generate the self-singed certificate: Set CN to localhost,

        openssl req -new -x509 -nodes -keyout key.pem -sha256 -days 365 -out cert.pem
        sudo cp cert.pem /etc/pki/ca-trust/source/anchors/
        sudo update-ca-trust

-   First generate a new key, and Then create a CSR from it:

        openssl genrsa -out test.key 2048
        openssl req -new -key test.key -out test.csr

-   creat extenation file test.ext, for domain name or DNS

        1 authorityKeyIdentifier=keyid,issuer
        2 basicConstraints=CA:FALSE
        3 keyUsage =digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
        4 subjectAltName = @alt_names
        5
        6 [alt_names]
        7 DNS.1 = localhost
        8 DNS.2 = test.dev

-   Create a new signed certificate for extended information

        openssl x509 -req -in test.csr -CA cert.pem -CAkey key.pem -CAcreateserial \
        -out test.crt -days 365 -sha256 -extfile test.ext    

-   signed by Let\'s Encrypt

        sudo certbot certonly --standalone

-   DONe

# Problem

## System limit for number of file watchers reached

sudo sysctl -w fs.inotify.max~userwatches~=100000 reboot

``` {.bash org-language="sh"}
ls
```

# Docker

``` {.bash org-language="sh"}
sudo docker rm $(sudo docker ps -aq)
sudo docker rmi $(sudo docker images -aq)
```

# opencv

sudo cmake
-DCMAKE~INSTALLPREFIX~:PATH=/home/si/Dokumente/opencv/libopencv .. make
make install export
LD~LIBRARYPATH~=\$LD~LIBRARYPATH~:/home/si/Dokumente/opencv/libopencv/lib

# Warp

  -------- -----------------------------------------------
  Ctrl f   move cousur to left, accept the auto complete
  Ctrl N   next block
  Ctrl P   provious block
  -------- -----------------------------------------------
