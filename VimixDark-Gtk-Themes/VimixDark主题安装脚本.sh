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
  echo -e "\n     正在退出...\n"
  exit 0
}

continue() {
  show_question "\n     继续安装？  是的：（ Y ）， 不用：（ N ）： \n"
  read INPUT
  case $INPUT in
    [Yy]* ) ;;
    [Nn]* ) end;;
    * ) show_error "\n     不好意思，再试一次吧！"; continue;;
  esac
}

replace() {
  show_question "\n     发现你以前安装过这个主题，需要替换掉吗? 替换：（ Y ）， 不用：（ N ） :\n" 
  read INPUT
  case $INPUT in
    [Yy]* ) rm -rf "$@/VimixDark*" 2>/dev/null;;
    [Nn]* ) ;;
    * ) show_error "\n     不好意思，再试一次吧！"; replace $@;;
  esac
}

setup() {
  show_question "\n     现在要设置主题吗？  是的：（ Y ）， 不用：（ N ） \n"
  read INPUT
  case $INPUT in
    [Yy]* ) themes;;
    [Nn]* ) end;;
    * ) show_error "\n     不好意思，再试一次吧！"; setup;;
  esac
}

themes() {
  show_question "\n+------------------------------------------------------------------+
  请输入数字选择主题：（提示：笔记本用户推荐Laptop版，版式更紧凑。）
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
    * ) show_error "\n     不好意思，再试一次吧！"; themes;;
  esac
}

VimixDark() {

# Set VimixDark Gtk Themes
  echo "     正在设置VimixDark主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark
  echo "     设置完成！"

}

VimixDark-Doder() {

# Set VimixDark-Doder Gtk Themes
  echo "     正在设置VimixDark-Doder主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Doder
  echo "     设置完成！"

}

VimixDark-Ruby() {

# Set VimixDark-Ruby Gtk Themes
  echo "     正在设置VimixDark-Ruby主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Ruby
  echo "设置完成！"

}

VimixDark-Laptop() {

# Set VimixDark-Laptop Gtk Themes
  echo "     正在设置VimixDark-Laptop主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Laptop
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Laptop
  echo "     设置完成！"

}

VimixDark-Laptop-Doder() {

# Set VimixDark-Laptop-Doder Gtk Themes
  echo "     正在设置VimixDark-Laptop-Doder主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Laptop-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Laptop-Doder
  echo "     设置完成！"

}

VimixDark-Laptop-Ruby() {

# Set VimixDark-Laptop-Ruby Gtk Themes
  echo "     正在设置VimixDark-Laptop-Ruby主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Laptop-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Laptop-Ruby
  echo "     设置完成！"

}

install() {

  # PREVIEW

  # Show destination directory
  echo -e "\n     VimixDark 主题会安装在:\n"
  show_dir "\t$DEST_DIR"
  if [ "$UID" -eq "$ROOT_UID" ]; then
    echo -e "\n     主题会安装在系统目录，所有用户共享。"
  else
    echo -e "\n（提示：如果你想安装到系统目录，就用root权限运行这个脚本吧！）."
  fi

  continue

  # INSTALL

  # Check destination directory
  if [ ! -d $DEST_DIR ]; then
    mkdir -p $DEST_DIR
  elif [[ -d $DEST_DIR/VimixDark && -d $DEST_DIR/VimixDark-Doder && -d $DEST_DIR/VimixDark-Ruby && -d $DEST_DIR/VimixDark-Laptop && -d $DEST_DIR/VimixDark-Laptop-Doder && -d $DEST_DIR/VimixDark-Laptop-Ruby ]]; then
    replace $DEST_DIR
  fi

  echo -e "\n     正在安装 VimixDark..."
  
  # Copying files
  cp -a VimixDark VimixDark-Doder VimixDark-Ruby VimixDark-Laptop VimixDark-Laptop-Doder VimixDark-Laptop-Ruby $DEST_DIR
#  chmod -R 755 $DEST_DIR/VimixDark $DEST_DIR/VimixDark-Doder $DEST_DIR/VimixDark-Ruby $DEST_DIR/VimixDark-Laptop $DEST_DIR/VimixDark-Laptop-Doder $DEST_DIR/VimixDark-Laptop-Ruby

  echo -e "\n     安装完成！"

  setup

}

remove() {

  # PREVIEW

  # Show installation directory
  if [[ -d $DEST_DIR/VimixDark && -d $DEST_DIR/VimixDark-Doder && -d $DEST_DIR/VimixDark-Ruby && -d $DEST_DIR/VimixDark-Laptop && -d $DEST_DIR/VimixDark-Laptop-Doder && -d $DEST_DIR/VimixDark-Laptop-Ruby ]]; then
    echo -e "\VimixDark主题 安装在了：\n"
    show_dir "\t$DEST_DIR"
    if [ "$UID" -eq "$ROOT_UID" ]; then
      echo -e "\n     主题会从系统目录删除"
    else
      echo -e "\n     主题会从你的用户目录删除"
    fi

    continue
  
  else
    show_error "\n     VimixDark 主题没有安装 in:\n"
    show_dir "\t$DEST_DIR\n"
    end
  fi

  # REMOVE

  echo -e "\n     正在删除 VimixDark ..."

  # Removing files
  rm -rf $DEST_DIR/VimixDark*

  echo "     删除成功！"
  echo "     看来你并不喜欢这个主题，可能我这个主题还做得不够好！."
}

main() {
  show_question "     你是想安装，还是卸载？  安装：（ I ）  卸载：（ R ）： \n"
  read INPUT
  case $INPUT in
    [Ii]* ) install;;
    [Rr]* ) remove;;
    * ) show_error "\n     不好意思，再试一次吧！"; main;;
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

echo -e "\e[1m\n     +----------------------------------------------+"
echo -e "     |           VimixDark 主题安装脚本             |"
echo -e "     +----------------------------------------------+\n\e[0m"

main
