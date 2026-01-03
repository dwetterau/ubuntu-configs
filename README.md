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

```
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
```


# TODO
- Known bug: Windows 11 doesn't like the system clock setting Ubuntu puts it in

