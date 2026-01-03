# Davidw's Ubuntu configs in 2026

I started the year off by abandoning WSL on Windows 11 and dual booting my PC instead to have a real Linux distro.
The configuration pain I've felt over the years with Linux I no longer fear thanks to ChatGPT and Cursor.

I'm clearly not the only one who felt that way, since today, Jan 2nd, [this post](https://xeiaso.net/notes/2026/year-linux-desktop/) was at the top of HN basically all day.


## Devtool setup

Rough steps so far:
- Installed python from apt
- Installed python3-is-python
- git tool chain is also whatever I started with
(TODO: Clean this up and move to mise?)

## Configs
- I'm going to put configs in this repo, and then use scripts to help initialize them, which Cursor can just one shot for me.


## Toolchains

For node, trying to use mise:

curl https://mise.run | sh


# TODO
- Known bug: Windows 11 doesn't like the system clock setting Ubuntu puts it in


# Appendix

## Initial log

### Jan 1st: Installing Ubuntu
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
- Also the recommendation was to use snap, which then didn't work at all because it had other versions of the libraries that it wanted? Good to know snap still is a mess that doesn't really work.
- I wrapped up the Ubuntu setup for the day by installing Chrome (one day I'll come back Firefox, I promise).

### Jan 2nd: Customizations
- Adjusted the font, it was too small (gnome-tweaks?)
- Adjusted the keyboard shortcuts and key repeat frequency.
- Changed color schemes on terminals
- Installed Cursor, started this repo and log
- Installed Dropbox (manually deb file) to use with KeepassXC (with apt, not snap) for my password manager to work
- Generated SSH keys, added them to Github
