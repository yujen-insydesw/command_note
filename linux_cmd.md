





# profile bash_profile

`~/.profile` 在 Linux 發行版中比 `~/.bash_profile` 更常用，因為它被所有 shell 讀取和執行。相反，`~/.bash_profile` 只能由 Bash 讀取和執行。

當 shell 作為互動式非登入 shell 啟動時，它會從 `~/.bashrc` 檔案中讀取並執行命令。

`~/.bash_profile` 和 `~/.bashrc` 作為點檔案位於使用者的主目錄中。使用者主目錄中的檔案用於進行僅適用於該特定使用者的配置。

這些配置通常會覆蓋系統配置。 `~/.bash_profile` 包含啟動程式配置和使用者特定的環境配置，而 `~/.bashrc` 檔案儲存特定使用者的函式和別名。

位於 `/etc/` 目錄中的檔案用於進行適用於系統上所有使用者的系統範圍配置。這些檔案包括 `/etc/profiles` 和 `/etc/bashrc`。

**export PATH= $PATH :/place/with/the/file;$PATH :/place/with/the/file**






# Virtual USB Drive
- **Create**: `dd if=/dev/zero of=virtual_usb.img bs=1M count=100`
- **Format**: `mkfs.ext4 virtual_usb.img`
- **Mount**: `sudo mount -o loop virtual_usb.img /mnt/virtual_usb`
- **Use**: Copy files to/from `/mnt/virtual_usb`
- **Unmount**: `sudo umount /mnt/virtual_usb`
- **Delete**: `rm virtual_usb.img`
