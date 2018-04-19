#!/bin/bash
set -e
set -x

# from /etc/xdg/autostart/warsaw.desktop
# /usr/local/bin/warsaw/core &


sudo /etc/init.d/warsaw restart
sudo /usr/local/bin/warsaw/core 
/usr/local/bin/warsaw/core 
/usr/bin/firefox https://127.0.0.1:30900/ https://www2.bancobrasil.com.br/aapf/login.jsp