
# Environment

## machine one x64 (x86_64) or ARM architecture ?
```console
# output: x86_64 or arm / aarch64
uname -m

# provides detailed information about your CPU architecture
lscpu
```
## profile bash_profile

`~/.profile` 在 Linux 發行版中比 `~/.bash_profile` 更常用，因為它被所有 shell 讀取和執行。相反，`~/.bash_profile` 只能由 Bash 讀取和執行。

當 shell 作為互動式非登入 shell 啟動時，它會從 `~/.bashrc` 檔案中讀取並執行命令。

`~/.bash_profile` 和 `~/.bashrc` 作為點檔案位於使用者的主目錄中。使用者主目錄中的檔案用於進行僅適用於該特定使用者的配置。

這些配置通常會覆蓋系統配置。 `~/.bash_profile` 包含啟動程式配置和使用者特定的環境配置，而 `~/.bashrc` 檔案儲存特定使用者的函式和別名。

位於 `/etc/` 目錄中的檔案用於進行適用於系統上所有使用者的系統範圍配置。這些檔案包括 `/etc/profiles` 和 `/etc/bashrc`。

**export PATH= $PATH :/place/with/the/file;$PATH :/place/with/the/file**


## ? kernel version ...



# Common command

## reveal
```console
pwd

ls

top

ps -ef | grep

# 不管大小寫 non-sensitive
grep -i

往下
grep -A 5
往上
grep -B 5
網上下
grep -C 5
```

### history
```console
最近4個
`history | tail -4`

忽略重複的
export HISTCONTROL=ignoredups

# [Linux 指令歷史紀錄（History）的操作教學與範例 – G. T. Wang (gtwang.org)](https://blog.gtwang.org/linux/mastering-linux-command-line-history/)

```

### tree
```console
tree -L <depth> <directory>
```

### find
```console
# 查找当前目录下名为 file.txt 的文件：
find . -name file.txt
将当前目录及其子目录下所有文件后缀为 **.c** 的文件列出来:
find . -name "*.c"
# 尋找/home 目录下
find /home -name file.txt

# maxdepth
find -maxdepth 1

# modified within 1 day
find . -mtime -1
# modified before 1 day ago
find . -mtime +1

# 将当前目录及其子目录中的所有文件列出：
find . -type f

# 查找 /home 目录下大于 1MB 的文件：
find /home -size +1M
```

### du dh
```console
# to list diectory size
du -h <dir>
# to summary
du -sh <dir>

What this means:
- `s` to give only the total for each command line argument.
- `h` for human-readable suffixes like `M` for megabytes and `G` for gigabytes (optional).
- `/*` simply expands to all directories (and files) in `/`.

# to sum whole machine storage
dh -f
```

### file type checker 用於分析檔案的內容和結構。
```console
file /usr/bin/ipmitool
```

### ldd, List Dynamic Dependencies，它是一個用於列出一個執行檔的動態連結庫依賴關係的工具:
```console
ldd /usr/bin/ipmitool
```

## navigate
```console
cd

mv

cp -r

mkdir

rm -rf *

# exclude
rm -rf !(one|two|three)
```

## transmission

### scp
```console
scp <-r> <account>@<ip | name>:<source> <destination>
```

### wget (handles FTP downloads)
```console
# -r for recursive download, a default maximum recursion depth of 5
wget -r --user="user@login" --password="..." ftp://server.com/
```
## authencation
```console
sudo

su

# 可以透過設定 sudoers 檔案：
# 編輯 /etc/sudoers 檔案，新增一筆允許一般使用者執行 ipmitool 的規則，而不需要密碼驗證。
$ sudo vim /etc/sudoers
username ALL=(ALL) NOPASSWD:/usr/bin/ipmitool

# 修改裝置檔案的權限。
chmod 666 /dev/ipmi0
      777
chmod u=rwx <file>

# change the ownership
chown <linuxize>:<users> <file1>
```

## compress

1. **Creating the Archive**:
    `tar -cvpf archive.tar /path/to/directory`
    - **`c`**: Create a new archive.
    - **`v`**: Verbose mode, shows the progress in the terminal.
    - **`p`**: Preserve permissions.
    - **`f`**: Specify the filename of the archive.
    - z: 存取 .tar.gz 格式的套件為「gzip」，此格式會進行打包並且壓縮。
    - 
2. **Extracting the Archive**:
    `tar -xvpf archive.tar`    
    - **`x`**: Extract the archive.
    - **`v`**: Verbose mode.
    - **`p`**: Preserve permissions.
    - **`f`**: Specify the filename of the archive.
    - z: 存取 .tar.gz 格式的套件為「gzip」，此格式會進行打包並且壓縮。

3. To view the contents of a tar file in Linux without extracting it,
tar -tf filename.tar.gz


## others

### soft link
```console
# relative path is acceptable
# but sometimes have to use absolute path
ln -s <source_directory> <link_name>
```

### vim
```console
# vim
vim <file>

# search /\< >\>
/\< word to search >\>
# "*" forward
# "#" backward
# "enter" to search next

# insert
i
"esc"

# quit
:q
:wq
:q!
```


### BMC console related
```console
# ssh
ssh <yujen.lan@192.168.11.1>
"crtl + D"

# minicom
minicom -wD /dev/ast2600evb.1021
"ctrl a + x"
```


# Special

## Virtual USB Drive
- **Create**: `dd if=/dev/zero of=virtual_usb.img bs=1M count=100`
- **Format**: `mkfs.ext4 virtual_usb.img`
- **Mount**: `sudo mount -o loop virtual_usb.img /mnt/virtual_usb`
- **Use**: Copy files to/from `/mnt/virtual_usb`
- **Unmount**: `sudo umount /mnt/virtual_usb`
- **Delete**: `rm virtual_usb.img`
