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

Run the following commands in the terminal:

```sh
./install.sh
```

Usage:  `./install.sh`  **[OPTIONS...]**

```
-d, --dest DIR          Specify destination directory (Default: $HOME/.themes)
-n, --name NAME         Specify theme name (Default: Jasper)
-t, --theme VARIANT     Specify theme color variant(s) [default|purple|pink|red|orange|yellow|green|blue|grey|all] (Default: teal)
-c, --color VARIANT     Specify color variant(s) [standard|light|dark] (Default: All variants)
-s, --size VARIANT      Specify size variant [standard|compact] (Default: standard variant)

-l, --libadwaita        Link installed gtk-4.0 theme to config folder for all libadwaita app use this theme

-r, --remove,
-u, --uninstall         Uninstall/Remove installed themes

--tweaks                Specify versions for tweaks [nord|dracula|black|macos] (only nord and dracula can not mix use with!)
                        1. nord:     Nord ColorScheme version
                        2. dracula   Dracula ColorScheme version
                        3. black:    Blackness color version
                        4. macos:    Macos style windows button

-h, --help              Show help
```

## Screenshots

#### GNOME Shell
![1](https://i.imgur.com/xhmv9VZ.png)
![2](https://i.imgur.com/jOTgUQS.png)
![3](https://i.imgur.com/JHxwUSu.png)
![4](https://i.imgur.com/YFRJf9B.png)
![5](https://i.imgur.com/yAGGnQU.png)

## Icon 
Vimix icon theme is based on Paper-Icon-Theme: https://github.com/snwh/paper-icon-theme

#### You can download here: https://github.com/vinceliuice/vimix-icon-theme
