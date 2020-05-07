<img src="https://github.com/vinceliuice/vimix-gtk-themes/blob/images/vimix-logo.svg" alt="Logo" align="right" /> Vimix-gtk-theme
======

Vimix is a flat Material Design theme for GTK 3, GTK 2 and Gnome-Shell which supports GTK 3 and GTK 2 based desktop environments like Gnome, Unity, Budgie, Pantheon, XFCE, Mate, etc.

This theme is based on materia gtk theme of nana-4. Thanks nana-4 sincerely for his great job!

materia gtk theme: https://github.com/nana-4/materia-theme

## Info

### GTK+ 3.20 or later

### GTK2 engines requirment

- GTK2 engine Murrine 0.98.1.1 or later.
- GTK2 pixbuf engine or the gtk(2)-engines package.

Fedora/RedHat distros:

    yum install gtk-murrine-engine gtk2-engines

Ubuntu/Mint/Debian distros:

    sudo apt-get install gtk2-engines-murrine gtk2-engines-pixbuf

ArchLinux:

    pacman -S gtk-engine-murrine gtk-engines

Other:
Search for the engines in your distributions repository or install the engines from source.

## Install Or Uninstall

Open the terminal at current directory.

Run

    ./install.sh

Usage:  `./install.sh`  **[OPTIONS...]**

|  OPTIONS:      | |
|:---------------|:-------------|
| -d, --dest     | Specify theme destination directory (Default: $HOME/.themes) |
| -n, --name     | Specify theme name (Default: vimix) |
| -a, --all      | install all theme variant(s) |
| -c, --color    | Specify theme color variant(s) **[standard/light/dark]** (Default: All variants) |
| -t, --theme    | Specify hue theme variant(s) **[standard/doder/beryl/ruby/amethyst]** (Default: doder) |
| -s, --size     | Specify theme size variant(s) **[standard/laptop]** (Default: All variants) |
| -f, --flat     | Specify theme with flat and normal titlebutton style |
| -o, --no-color | Use grey titlebuttons in standard variants |
| -h, --help     | Show this help |

if you want to get the last vimix theme version online, you can

Run

    ./update-vimix-online

## Screenshots

#### GNOME Shell
![1](https://cn.pling.com/img/5/b/b/f/f5bc03455d89246214cbf49d53f134ad8048.png?raw=true)
![2](https://cn.pling.com/img/f/1/4/1/72ec62aff6edc8243a12f8a8db57a6468804.png?raw=true)
![3](https://cn.pling.com/img/9/1/d/b/e37013349e0f0bd76b9a0afc8e98222f8504.png?raw=true)
![4](https://cn.pling.com/img/4/b/7/9/6f4bf294ae650b3a70f571e89077014d4007.png?raw=true)
![5](https://cn.pling.com/img/5/9/6/2/a71edf571bd7b8ba46c6a7440ada75b2eced.png?raw=true)

## Icon 
Vimix icon theme is based on Paper-Icon-Theme: https://github.com/snwh/paper-icon-theme

#### You can download here: https://github.com/vinceliuice/vimix-icon-theme
