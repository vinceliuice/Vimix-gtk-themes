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
    [Yy]* ) rm -rf "$@/VimixLight*" 2>/dev/null;;
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
  请输入数字选择主题：（提示：笔记本用户推荐Laptop版，板式更紧凑。）
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
    * ) show_error "\n     不好意思，再试一次吧！"; themes;;
  esac
}

VimixLight() {

# Set VimixLight Gtk Themes
  echo "     正在设置VimixLight主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight
  echo "     设置完成！"

}

VimixLight-Doder() {

# Set VimixLight-Doder Gtk Themes
  echo "     正在设置VimixLight-Doder主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Doder
  echo "     设置完成！"

}

VimixLight-Ruby() {

# Set VimixLight-Ruby Gtk Themes
  echo "     正在设置VimixLight-Ruby主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Ruby
  echo "设置完成！"

}

VimixLight-Laptop() {

# Set VimixLight-Laptop Gtk Themes
  echo "     正在设置VimixLight-Laptop主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Laptop
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Laptop
  echo "     设置完成！"

}

VimixLight-Laptop-Doder() {

# Set VimixLight-Laptop-Doder Gtk Themes
  echo "     正在设置VimixLight-Laptop-Doder主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Laptop-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Laptop-Doder
  echo "     设置完成！"

}

VimixLight-Laptop-Ruby() {

# Set VimixLight-Laptop-Ruby Gtk Themes
  echo "     正在设置VimixLight-Laptop-Ruby主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Laptop-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Laptop-Ruby
  echo "     设置完成！"

}

install() {

  # PREVIEW

  # Show destination directory
  echo -e "\n     VimixLight 主题会安装在:\n"
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
  elif [[ -d $DEST_DIR/VimixLight && -d $DEST_DIR/VimixLight-Doder && -d $DEST_DIR/VimixLight-Ruby && -d $DEST_DIR/VimixLight-Laptop && -d $DEST_DIR/VimixLight-Laptop-Doder && -d $DEST_DIR/VimixLight-Laptop-Ruby ]]; then
    replace $DEST_DIR
  fi

  echo -e "\n     正在安装 VimixLight..."
  
  # Copying files
  cp -a VimixLight VimixLight-Doder VimixLight-Ruby VimixLight-Laptop VimixLight-Laptop-Doder VimixLight-Laptop-Ruby $DEST_DIR
#  chmod -R 755 $DEST_DIR/VimixLight $DEST_DIR/VimixLight-Doder $DEST_DIR/VimixLight-Ruby $DEST_DIR/VimixLight-Laptop $DEST_DIR/VimixLight-Laptop-Doder $DEST_DIR/VimixLight-Laptop-Ruby

  echo -e "\n     安装完成！"

  setup

}

remove() {

  # PREVIEW

  # Show installation directory
  if [[ -d $DEST_DIR/VimixLight && -d $DEST_DIR/VimixLight-Doder && -d $DEST_DIR/VimixLight-Ruby && -d $DEST_DIR/VimixLight-Laptop && -d $DEST_DIR/VimixLight-Laptop-Doder && -d $DEST_DIR/VimixLight-Laptop-Ruby ]]; then
    echo -e "\VimixLight主题 安装在了：\n"
    show_dir "\t$DEST_DIR"
    if [ "$UID" -eq "$ROOT_UID" ]; then
      echo -e "\n     主题会从系统目录删除"
    else
      echo -e "\n     主题会从你的用户目录删除"
    fi

    continue
  
  else
    show_error "\n     VimixLight 主题没有安装 in:\n"
    show_dir "\t$DEST_DIR\n"
    end
  fi

  # REMOVE

  echo -e "\n     正在删除 VimixLight ..."

  # Removing files
  rm -rf $DEST_DIR/VimixLight*

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
echo -e "     |           VimixLight 主题安装脚本            |"
echo -e "     +----------------------------------------------+\n\e[0m"

main
