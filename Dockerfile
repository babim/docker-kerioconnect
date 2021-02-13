FROM babim/ubuntubase:20.04.ssh
ENV SOFT	KerioConnect
ENV FIXED	no
ENV KERBEROS	no

# get option script
RUN curl -Ls https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20SCRIPT%20AUTO/option.sh -o /option.sh

# install
RUN curl -s https://raw.githubusercontent.com/babim/docker-tag-options/master/z%20${SOFT}/${SOFT}_install.sh | bash

# Expose the default portonly 4040 is nessecary for admin access 
EXPOSE 4040 25 465 587 110 995 143 993 119 563 389 636 80 443 5222 5223 5269 44337

VOLUME ["/opt/kerio"]

ENTRYPOINT ["/start.sh"]
