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
  show_question "\n     继续？  是的：（ Y/y ）， 不用：（ N/n ）： \n"
  read INPUT
  case $INPUT in
    [Yy]* ) ;;
    [Nn]* ) end;;
    * ) show_error "\n     不好意思，再试一次吧！"; continue;;
  esac
}

replace() {
  show_question "\n     发现你以前安装过这个主题，需要替换掉吗? 替换：（ Y/y ）， 不用：（ N/n ） :\n" 
  read INPUT
  case $INPUT in
    [Yy]* ) rm -rf $DEST_DIR/Vimix*;;
    [Nn]* ) ;;
    * ) show_error "\n     不好意思，再试一次吧！"; replace $@;;
  esac
}

setup() {
  show_question "\n     现在要设置主题吗？  是的：（ Y/y ）， 不用：（ N/n ） \n"
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

              (a)  VimixDark
              (b)  VimixDark-Doder
              (c)  VimixDark-Beryl
              (d)  VimixDark-Ruby
              (e)  VimixDark-Laptop
              (f)  VimixDark-Laptop-Doder
              (g)  VimixDark-Laptop-Beryl
              (h)  VimixDark-Laptop-Ruby
              (i)  VimixLight
              (j)  VimixLight-Doder
              (k)  VimixLight-Beryl
              (l)  VimixLight-Ruby
              (m)  VimixLight-Laptop
              (n)  VimixLight-Laptop-Doder
              (o)  VimixLight-Laptop-Beryl
              (p)  VimixLight-Laptop-Ruby

+------------------------------------------------------------------+\n"
  read INPUT
  case $INPUT in
    [Aa]* )  VimixDark;;
    [Bb]* )  VimixDark-Doder;;
    [Cc]* )  VimixDark-Beryl;;
    [Dd]* )  VimixDark-Ruby;;
    [Ee]* )  VimixDark-Laptop;;
    [Ff]* )  VimixDark-Laptop-Doder;;
    [Gg]* )  VimixDark-Laptop-Beryl;;
    [Hh]* )  VimixDark-Laptop-Ruby;;
    [Ii]* )  VimixLight;;
    [Jj]* )  VimixLight-Doder;;
    [Kk]* )  VimixLight-Beryl;;
    [Ll]* )  VimixLight-Ruby;;
    [Mm]* )  VimixLight-Laptop;;
    [Nn]* )  VimixLight-Laptop-Doder;;
    [Oo]* )  VimixLight-Laptop-Beryl;;
    [Pp]* )  VimixLight-Laptop-Ruby;;
    * ) show_error "\n     不好意思，再试一次吧！"; themes;;
  esac
}

VimixDark() {

# 设置VimixDark主题
  echo "     正在设置VimixDark主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark
  echo "     设置完成！"

}

VimixDark-Doder() {

# 正在设置VimixDark-Doder主题
  echo "     正在设置VimixDark-Doder主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Doder
  echo "     设置完成！"

}

VimixDark-Beryl() {

# 设置VimixDark-Beryl主题
  echo "     正在设置VimixDark-Beryl主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Beryl
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Beryl
  echo "     设置完成！"

}


VimixDark-Ruby() {

# 设置VimixDark-Ruby主题
  echo "     正在设置VimixDark-Ruby主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Ruby
  echo "    设置完成！"

}

VimixDark-Laptop() {

# 设置VimixDark-Laptop主题
  echo "     正在设置VimixDark-Laptop主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Laptop
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Laptop
  echo "     设置完成！"

}

VimixDark-Laptop-Doder() {

# 设置VimixDark-Laptop-Doder主题
  echo "     正在设置VimixDark-Laptop-Doder主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Laptop-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Laptop-Doder
  echo "     设置完成！"

}

VimixDark-Laptop-Doder() {

# 设置VimixDark-Laptop-Beryl主题
  echo "     正在设置VimixDark-Laptop-Beryl主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Laptop-Beryl
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Laptop-Beryl
  echo "     设置完成！"

}

VimixDark-Laptop-Ruby() {

# 设置VimixDark-Laptop-Ruby主题
  echo "     正在设置VimixDark-Laptop-Ruby主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixDark-Laptop-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixDark-Laptop-Ruby
  echo "     设置完成！"

}

VimixLight() {

# 设置VimixLight主题
  echo "     正在设置VimixLight主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight
  echo "     设置完成！"

}

VimixLight-Doder() {

# 设置VimixLight-Doder主题
  echo "     正在设置VimixLight-Doder主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Doder
  echo "     设置完成！"

}

VimixLight-Beryl() {

# 设置VimixLight-Doder主题
  echo "     正在设置VimixLight-Beryl主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Beryl
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Beryl
  echo "     设置完成！"

}

VimixLight-Ruby() {

# 设置VimixLight-Ruby主题
  echo "     正在设置VimixLight-Ruby主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Ruby
  echo "    设置完成！"

}

VimixLight-Laptop() {

# 设置VimixLight-Laptop主题
  echo "     正在设置VimixLight-Laptop主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Laptop
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Laptop
  echo "     设置完成！"

}

VimixLight-Laptop-Doder() {

# 设置VimixLight-Laptop-Doder主题
  echo "     正在设置VimixLight-Laptop-Doder主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Laptop-Doder
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Laptop-Doder
  echo "     设置完成！"

}

VimixLight-Laptop-Doder() {

# 设置VimixLight-Laptop-Beryl主题
  echo "     正在设置VimixLight-Laptop-Beryl主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Laptop-Beryl
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Laptop-Beryl
  echo "     设置完成！"

}


VimixLight-Laptop-Ruby() {

# 设置VimixLight-Laptop-Ruby主题
  echo "     正在设置VimixLight-Laptop-Ruby主题为默认主题..."
  gsettings set org.gnome.desktop.interface gtk-theme VimixLight-Laptop-Ruby
  gsettings set org.gnome.desktop.wm.preferences theme VimixLight-Laptop-Ruby
  echo "     设置完成！"

}

install() {

  # 预览
  # 显示主题目录
  echo -e "\n     Vimix 主题会安装在:\n"
  show_dir "\t$DEST_DIR"
  if [ "$UID" -eq "$ROOT_UID" ]; then
    echo -e "\n     主题会安装在系统目录，所有用户共享。"
  else
    echo -e "\n（提示：如果你想安装到系统目录，就用root权限运行这个脚本吧！）."
  fi

  continue

  # 安装

  # 检测主题目录
  if [ ! -d $DEST_DIR ]; then
    mkdir -p $DEST_DIR
  elif [[ -d $DEST_DIR/VimixDark && -d $DEST_DIR/VimixDark-Doder && -d $DEST_DIR/VimixDark-Beryl && -d $DEST_DIR/VimixDark-Ruby && -d $DEST_DIR/VimixDark-Laptop && -d $DEST_DIR/VimixDark-Laptop-Doder && -d $DEST_DIR/VimixDark-Laptop-Beryl && -d $DEST_DIR/VimixDark-Laptop-Ruby && -d $DEST_DIR/VimixLight && -d $DEST_DIR/VimixLight-Doder && -d $DEST_DIR/VimixLight-Beryl && -d $DEST_DIR/VimixLight-Ruby && -d $DEST_DIR/VimixLight-Laptop && -d $DEST_DIR/VimixLight-Laptop-Doder && -d $DEST_DIR/VimixLight-Laptop-Beryl && -d $DEST_DIR/VimixLight-Laptop-Ruby ]]; then
    replace $DEST_DIR
  fi

  echo -e "\n     正在安装 Vimix..."
  
  # 复制文件

  ./Install

  echo -e "\n     安装完成！"

  setup

}

remove() {

  # 预览

  # 显示安装目录
  if [[ -d $DEST_DIR/VimixDark && -d $DEST_DIR/VimixDark-Doder && -d $DEST_DIR/VimixDark-Beryl && -d $DEST_DIR/VimixDark-Ruby && -d $DEST_DIR/VimixDark-Laptop && -d $DEST_DIR/VimixDark-Laptop-Doder && -d $DEST_DIR/VimixDark-Laptop-Beryl && -d $DEST_DIR/VimixDark-Laptop-Ruby && -d $DEST_DIR/VimixLight && -d $DEST_DIR/VimixLight-Doder && -d $DEST_DIR/VimixLight-Beryl && -d $DEST_DIR/VimixLight-Ruby && -d $DEST_DIR/VimixLight-Laptop && -d $DEST_DIR/VimixLight-Laptop-Doder && -d $DEST_DIR/VimixLight-Laptop-Beryl && -d $DEST_DIR/VimixLight-Laptop-Ruby ]]; then
    echo -e "\n    Vimix主题 安装在了：\n"
    show_dir "\t$DEST_DIR"
    if [ "$UID" -eq "$ROOT_UID" ]; then
      echo -e "\n     主题会从系统目录删除"
    else
      echo -e "\n     主题会从你的用户目录删除"
    fi

    continue
  
  else
    show_error "\n     Vimix 主题没有安装在:\n"
    show_dir "\t$DEST_DIR\n"
    end
  fi

  # 卸载

  echo -e "\n     正在删除 Vimix主题 ..."

  # 卸载文件

  rm -rf $DEST_DIR/Vimix*

  echo "     删除成功！"
  echo "     看来你并不喜欢这个主题，可能我这个主题还做得不够好！."
}

ROOT_UID=0
DEST_DIR=

# 主题目录
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/themes"
else
  DEST_DIR="$HOME/.themes"
fi

main() {
  show_question "     你是想安装，还是卸载？  安装：（ I/i ）  卸载：（ R/r ）： \n"
  read INPUT
  case $INPUT in
    [Ii]* ) install;;
    [Rr]* ) remove;;
    * ) show_error "\n     不好意思，再试一次吧！"; main;;
  esac
}

echo -e "\e[1m\n     +----------------------------------------------+"
echo -e "     |              Vimix 主题安装脚本              |"
echo -e "     +----------------------------------------------+\n\e[0m"

main
