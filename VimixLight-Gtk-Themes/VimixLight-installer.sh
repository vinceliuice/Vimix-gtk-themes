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
    [Yy]* ) rm -rf "$@/VimixLight*" 2>/dev/null;;
    [Nn]* ) ;;
    * ) show_error "\tSorry, try again."; replace $@;;
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

              (1)  VimixLight
              (2)  VimixLight-Doder
              (3)  VimixLight-Ruby
              (4)  VimixLight-Laptop
              (5)  VimixLight-Laptop-Doder
              (6)  VimixLight-Laptop-Ruby

+------------------------------------------------------------------+\n"
  read INPUT
  case $INPUT in
    [1]* ) VimixLight;;
    [2]* ) VimixLight-Doder;;
    [3]* ) VimixLight-Ruby;;
    [4]* ) VimixLight-Laptop;;
    [5]* ) VimixLight-Laptop-Doder;;
    [6]* ) VimixLight-Laptop-Ruby;;
    * ) show_error "\nSorry, try again."; themes;;
  esac
}

VimixLight() {

# Set VimixLight Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight
  echo "Done!"

}

VimixLight-Doder() {

# Set VimixLight-Doder Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Doder
  echo "Done!"

}

VimixLight-Ruby() {

# Set VimixLight-Ruby Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Ruby
  echo "Done!"

}

VimixLight-Laptop() {

# Set VimixLight-Laptop Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Laptop
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Laptop
  echo "Done!"

}

VimixLight-Laptop-Doder() {

# Set VimixLight-Laptop-Doder Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Laptop-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Laptop-Doder
  echo "Done!"

}

VimixLight-Laptop-Ruby() {

# Set VimixLight-Laptop-Ruby Gtk Themes
  echo "Setting the theme..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Laptop-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Laptop-Ruby
  echo "Done!"

}

install() {

  # PREVIEW

  # Show destination directory
  echo -e "\nVimixLight Gtk Theme will be installed in:\n"
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
  elif [[ -d $DEST_DIR/VimixLight && -d $DEST_DIR/VimixLight-Doder && -d $DEST_DIR/VimixLight-Ruby && -d $DEST_DIR/VimixLight-Laptop && -d $DEST_DIR/VimixLight-Laptop-Doder && -d $DEST_DIR/VimixLight-Laptop-Ruby ]]; then
    replace $DEST_DIR
  fi

  echo -e "\nInstalling VimixLight..."
  
  # Copying files
  cp -a VimixLight VimixLight-Doder VimixLight-Ruby VimixLight-Laptop VimixLight-Laptop-Doder VimixLight-Laptop-Ruby $DEST_DIR
#  chmod -R 755 $DEST_DIR/VimixLight $DEST_DIR/VimixLight-Doder $DEST_DIR/VimixLight-Ruby $DEST_DIR/VimixLight-Laptop $DEST_DIR/VimixLight-Laptop-Doder $DEST_DIR/VimixLight-Laptop-Ruby

  echo -e "\nInstallation complete!"

  setup

}

remove() {

  # PREVIEW

  # Show installation directory
  if [[ -d $DEST_DIR/VimixLight && -d $DEST_DIR/VimixLight-Doder && -d $DEST_DIR/VimixLight-Ruby && -d $DEST_DIR/VimixLight-Laptop && -d $DEST_DIR/VimixLight-Laptop-Doder && -d $DEST_DIR/VimixLight-Laptop-Ruby ]]; then
    echo -e "\VimixLight Gtk Themes installed in:\n"
    show_dir "\t$DEST_DIR"
    if [ "$UID" -eq "$ROOT_UID" ]; then
      echo -e "\nIt will remove for all users."
    else
      echo -e "\nIt will remove only for current user."
    fi

    continue
  
  else
    show_error "\nVimixLight Gtk Themes is not installed in:\n"
    show_dir "\t$DEST_DIR\n"
    end
  fi

  # REMOVE

  echo -e "\nRemoving VimixLight ..."

  # Removing files
  rm -rf $DEST_DIR/VimixLight*

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
echo -e "|    VimixLight Gtk Themes Installer Script    |"
echo -e "+----------------------------------------------+\n\e[0m"

main
