# Log

# 2026-01-01: Installing Ubuntu
- I had Ubuntu 22 on my older NVME drive, which meant that drive was weirdly partitioned
- When I most recently upgraded my PC, I got a new NVME drive, which had windows on it.
- On that Windows drive, I had WSL, with Ubuntu in it. ChatGPT helped me shrink that file down from 500GB -> 40GB by exporting and re-importing it... weird.
- After doing that, I tried to shrink the NTFS partition, but Windows fully refused, despite disabling disk cache files, hibernation, etc.
- In the end, I moved everything off of the partitioned old NVME drive, then wiped it and put Ubuntu on it - it gets the whole thing
- I guess this drive is a bit slower, but it keeps the OS completely separate.
- When installing, I used the UEFI partition on the newer SSD, which remains the primary disk in the boot order.
- Grub then defaults to booting Ubuntu from the second drive, or I can still get to Windows 11 if I want to play some games.

*Inside ubuntu*
- Once in Ubuntu, I had to install nvidia drivers / get them working - my resolution was a lovely 1024x768, with only smaller options available.
- I eventually determined this was because I had the "-open" variant of the nvidia drivers + wayland enabled. If this doesn't work, why is it the default?
- So instead, I changed the nvidia package to be the not-open one, which then required that I enroll a "MOK", in order to not disable secure boot. 
- In the past I probably just disabled secure boot, but it's been like a decade, surely this should work by now?
- I then tried to install ghostty because I use it on my mac, but that was a huge mess of trying to set up vulkan for it?
- Installed oh-my-zsh, kphoen theme
- Also the recommendation was to use snap, which then didn't work at all because it had other versions of the libraries that it wanted? Good to know snap still is a mess that doesn't really work.
- I wrapped up the Ubuntu setup for the day by installing Chrome (one day I'll come back Firefox, I promise).

# 2026-01-02: Customizations
- Adjusted the font, it was too small (gnome-tweaks?)
- Adjusted the keyboard shortcuts and key repeat frequency.
- Changed color schemes on terminals
- Installed Cursor, started this repo and log
- Installed Dropbox (manually deb file) to use with KeepassXC (with apt, not snap) for my password manager to work
- Generated SSH keys, added them to Github
- Setup a vimrc, made a script to symlink it from homedir properly
- Setup a mise config for node, python, uv

# 2026-01-03
- Moved .zshrc into the repo, and setup the same symlink thing for it
- I also had to install a few things manually: sqlite3 dev headers, imagemagick, and pillow (PIL)