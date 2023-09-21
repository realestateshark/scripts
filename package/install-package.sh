install_package() {
  if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ]
  then
    sudo apt install $1
  fi
}
