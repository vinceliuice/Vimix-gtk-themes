#! /bin/bash

show_question() {
  echo -e "\033[1;34m$@\033[0m"
}

show_dir() {
  echo -e "\033[1;32m$@\033[0m"
}

show_error() {
  echo -e "\033[1;31m$@\033[0m"
}

end() {
  echo -e "\nExiting...\n"
  exit 0
}

continue() {
  show_question "\nDo you want to continue? (Y)es, (N)o : \n"
  read INPUT
  case $INPUT in
    [Yy]* ) ;;
    [Nn]* ) end;;
    * ) show_error "\nSorry, try again."; continue;;
  esac
}

replace() {
  show_question "\nFound an existing installation. Replace it? (Y)es, (N)o :\n" 
  read INPUT
  case $INPUT in
    [Yy]* ) rm -rf "$@/VimixDark*" 2>/dev/null;;
    [Nn]* ) ;;
    * ) show_error "\nSorry, try again."; replace $@;;
  esac
}

setup() {
  show_question "\nDo you want to set the theme now? (Y)es, (N)o : \n"
  read INPUT
  case $INPUT in
    [Yy]* ) themes;;
    [Nn]* ) end;;
    * ) show_error "\nSorry, try again."; setup;;
  esac
}

themes() {
  show_question "\n+------------------------------------------------------------------+

      Select a number to set the theme you want:

              (1)  VimixDark
              (2)  VimixDark-Doder
              (3)  VimixDark-Ruby
              (4)  VimixDark-Laptop
              (5)  VimixDark-Laptop-Doder
              (6)  VimixDark-Laptop-Ruby

+------------------------------------------------------------------+\n"
  read INPUT
  case $INPUT in
    [1]* ) VimixDark;;
    [2]* ) VimixDark-Doder;;
    [3]* ) VimixDark-Ruby;;
    [4]* ) VimixDark-Laptop;;
    [5]* ) VimixDark-Laptop-Doder;;
    [6]* ) VimixDark-Laptop-Ruby;;
    * ) show_error "\nSorry, try again."; themes;;
  esac
}

VimixDark() {

# Set VimixDark Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark
  echo "Done!"

}

VimixDark-Doder() {

# Set VimixDark-Doder Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Doder
  echo "Done!"

}

VimixDark-Ruby() {

# Set VimixDark-Ruby Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Ruby
  echo "Done!"

}

VimixDark-Laptop() {

# Set VimixDark-Laptop Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Laptop
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Laptop
  echo "Done!"

}

VimixDark-Laptop-Doder() {

# Set VimixDark-Laptop-Doder Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Laptop-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Laptop-Doder
  echo "Done!"

}

VimixDark-Laptop-Ruby() {

# Set VimixDark-Laptop-Ruby Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Laptop-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Laptop-Ruby
  echo "Done!"

}

install() {

  # PREVIEW

  # Show destination directory
  echo -e "\nVimixDark Gtk Theme will be installed in:\n"
  show_dir "\t$DEST_DIR"
  if [ "$UID" -eq "$ROOT_UID" ]; then
    echo -e "\nIt will be available to all users."
  else
    echo -e "\nIf you want to make them available to all users, run this script as root."
  fi

  continue

  # INSTALL

  # Check destination directory
  if [ ! -d $DEST_DIR ]; then
    mkdir -p $DEST_DIR
  elif [[ -d $DEST_DIR/VimixDark && -d $DEST_DIR/VimixDark-Doder && -d $DEST_DIR/VimixDark-Ruby && -d $DEST_DIR/VimixDark-Laptop && -d $DEST_DIR/VimixDark-Laptop-Doder && -d $DEST_DIR/VimixDark-Laptop-Ruby ]]; then
    replace $DEST_DIR
  fi

  echo -e "\nInstalling VimixDark..."
  
  # Copying files
  cp -a VimixDark VimixDark-Doder VimixDark-Ruby VimixDark-Laptop VimixDark-Laptop-Doder VimixDark-Laptop-Ruby $DEST_DIR
#  chmod -R 755 $DEST_DIR/VimixDark $DEST_DIR/VimixDark-Doder $DEST_DIR/VimixDark-Ruby $DEST_DIR/VimixDark-Laptop $DEST_DIR/VimixDark-Laptop-Doder $DEST_DIR/VimixDark-Laptop-Ruby

  echo -e "\nInstallation complete!"

  setup

}

remove() {

  # PREVIEW

  # Show installation directory
  if [[ -d $DEST_DIR/VimixDark && -d $DEST_DIR/VimixDark-Doder && -d $DEST_DIR/VimixDark-Ruby && -d $DEST_DIR/VimixDark-Laptop && -d $DEST_DIR/VimixDark-Laptop-Doder && -d $DEST_DIR/VimixDark-Laptop-Ruby ]]; then
    echo -e "\VimixDark Gtk Themes installed in:\n"
    show_dir "\t$DEST_DIR"
    if [ "$UID" -eq "$ROOT_UID" ]; then
      echo -e "\nIt will remove for all users."
    else
      echo -e "\nIt will remove only for current user."
    fi

    continue
  
  else
    show_error "\nVimixDark Gtk Themes is not installed in:\n"
    show_dir "\t$DEST_DIR\n"
    end
  fi

  # REMOVE

  echo -e "\nRemoving VimixDark ..."

  # Removing files
  rm -rf $DEST_DIR/VimixDark*

  echo "Removing complete!"
  echo "I hope to see you soon."
}

main() {
  show_question "What you want to do: (I)nstall, (R)emove : \n"
  read INPUT
  case $INPUT in
    [Ii]* ) install;;
    [Rr]* ) remove;;
    * ) show_error "\nSorry, try again."; main;;
  esac
}

ROOT_UID=0
DEST_DIR=

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/themes"
else
  DEST_DIR="$HOME/.themes"
fi

echo -e "\e[1m\n+----------------------------------------------+"
echo -e "|    VimixDark Gtk Themes Installer Script     |"
echo -e "+----------------------------------------------+\n\e[0m"

main
