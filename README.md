[![](https://images.microbadger.com/badges/image/babim/kerio-connect.svg)](https://microbadger.com/images/babim/kerio-connect "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/kerio-connect.svg)](https://microbadger.com/images/babim/kerio-connect "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/kerio-connect:ssh.svg)](https://microbadger.com/images/babim/kerio-connect:ssh "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/kerio-connect:ssh.svg)](https://microbadger.com/images/babim/kerio-connect:ssh "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/kerio-connect:fixed.svg)](https://microbadger.com/images/babim/kerio-connect:fixed "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/kerio-connect:fixed.svg)](https://microbadger.com/images/babim/kerio-connect:fixed "Get your own version badge on microbadger.com")

[![](https://images.microbadger.com/badges/image/babim/kerio-connect:nokrb.svg)](https://microbadger.com/images/babim/kerio-connect:nokrb "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/kerio-connect:nokrb.svg)](https://microbadger.com/images/babim/kerio-connect:nokrb "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/kerio-connect:ssh.nokrb.svg)](https://microbadger.com/images/babim/kerio-connect:ssh.nokrb "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/kerio-connect:ssh.nokrb.svg)](https://microbadger.com/images/babim/kerio-connect:ssh.nokrb "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/kerio-connect:fixed.nokrb.svg)](https://microbadger.com/images/babim/kerio-connect:fixed.nokrb "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/kerio-connect:fixed.nokrb.svg)](https://microbadger.com/images/babim/kerio-connect:fixed "Get your own version badge on microbadger.com")

## Kerio Connect 9 (lastest) on Docker
Run good on coreos. With MX from DNS localhost

tag: with and without kerberos.

Note: Your Linux OS maybe Freeze If you authen over Kerberos to AD

```
$ sudo docker run -it --name=kerioconnect \
-h mail.domain.test -e DNSSERVER=192.168.1.2 \
-p 4040:4040 \
-p 22:22 -p 25:25 -p 465:465 -p 587:587 -p 110:110 -p 995:995 \
-p 143:143 -p 993:993 -p 119:119 -p 563:563 -p 389:389 -p 636:636 \
-p 80:80 -p 443:443 -p 5222:5222 -p 5223:5223 \
-v /keriomail:/opt/kerio babim/kerio-connect
```
## How to update ?

yeah, you can remove kerio files/folders in your volume but keep this follow files/folder:
- *.cfg
- mailserver/store
- mailserver/dbSSL
- mailserver/license
- mailserver/settings
- mailserver/sslca
- mailserver/sslcert
- mailserver/ldapmap

OK. when you pull new images and run. New container will copy new version files/folders of Kerio Connect to your volume but skip files/folders have your settings exists
