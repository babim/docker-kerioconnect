[![](https://images.microbadger.com/badges/image/babim/kerio-connect.svg)](https://microbadger.com/images/babim/kerio-connect "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/kerio-connect.svg)](https://microbadger.com/images/babim/kerio-connect "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/kerio-connect:ssh.svg)](https://microbadger.com/images/babim/kerio-connect:ssh "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/kerio-connect:ssh.svg)](https://microbadger.com/images/babim/kerio-connect:ssh "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/kerio-connect:fixed.svg)](https://microbadger.com/images/babim/kerio-connect:fixed "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/kerio-connect:fixed.svg)](https://microbadger.com/images/babim/kerio-connect:fixed "Get your own version badge on microbadger.com")

# Kerio Connect 9 (lastest) on Docker
Run good on coreos. With MX from DNS localhost

```
$ sudo docker run -it --name=kerioconnect \
-h mail.domain.test \
-p 4040:4040 \
-p 22:22 -p 25:25 -p 465:465 -p 587:587 -p 110:110 -p 995:995 \
-p 143:143 -p 993:993 -p 119:119 -p 563:563 -p 389:389 -p 636:636 \
-p 80:80 -p 443:443 -p 5222:5222 -p 5223:5223 \
-v /keriomail:/opt/kerio babim/kerio-connect
```
