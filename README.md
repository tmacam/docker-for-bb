```

 ⚠️  ⚠️  ⚠️  WIP  ⚠️  ⚠️  ⚠️

```

---

This is a (supposedly) lightweight docker VM to be able to access [Banco do Brasil](http://www.bb.com.br). This bank requires the use of a nasty spyware to be able to allow your in so... nothing safer than doing that from within the cozyness of a Docker container, right? This ubuntu-based dockerfile will setup the spyware plugin and flash (the plugin depends on it) 

Firefox is being used as the browser inside that container. Instead of using a VNC, this container uses X11, as in "you need a X Server" to be able to "see" and interact to firefox.


# Requirements

* Docker (obviously)
* A X11 server.
  * On macOs with homebrew, that should be only a matter of installing XQuarts:

    ```sh
    brew cask install xquartz
    ```
    * TODO(tmacam) add references to this
    * You might need to restart your computer to have XQuartz working

		> I had a heckuva time with this... downgraded, etc. Turned out the issue was a mere reboot was necessary. 

		Src: https://stackoverflow.com/questions/38686932/how-to-forward-docker-for-mac-to-x11
	* You will need to allow Firefox from within the container to contact your X11 server:

	  ```sh
	  xhost + $(ipconfig getifaddr en0)
	  ``` 




# Misc notes - WIP

```
docker build -t bb .

docker run -e DISPLAY=$(ipconfig getifaddr en0):0 -v /tmp/.X11-unix:/tmp/.X11-unix -it ubuntu:latest
```

openssl libnss3-tools libcurl3 dbus libdbus-1-3
flashplugin-installer

* http://www.edivaldobrito.com.br/como-instalar-o-adobe-flash-ubuntu-14-04/

* apt-get install ubuntu-restricted-extras


* https://disqus.com/home/discussion/edivaldo/como_instalar_o_modulo_de_seguranca_do_banco_do_brasil_no_linux_27/newest/#comment-3797906173
>  Por algum motivo, a página de autenticação usa Flash (!) pra funcionar. -- Paulo Pernomian
* https://support.mozilla.org/pt-BR/questions/1203370
> "No Firefox 58, por default, o flash está setado para "perguntar para ativar". Alterei para "sempre ativar" e a tela de login do BB apareceu."
about:addons > flash > always activate

https://get.adobe.com/flashplayer/about/ 

wget --no-check-certificat  https://www14.bancobrasil.com.br/downloads/ws/linux/diagbb-1.0.ubuntu16.amd64.deb 

https://seg.bb.com.br/extras/corrige.html

user_pref("plugin.state.flash", 2);

# https://docs.docker.com/engine/examples/apt-cacher-ng/

https://www2.bancobrasil.com.br/aapf/login.jsp
Firefox can’t establish a connection to the server at https://127.0.0.1:30900/.

certutil -L -d sql:dkuxlud4.default