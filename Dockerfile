FROM ipython/ipython:3.x

MAINTAINER IPython Project <ipython-dev@scipy.org>

### SSH SECTION ###
# Make ssh dir
# RUN mkdir /root/.ssh/
# Copy over private key, and set permissions
# ADD id_rsa /root/.ssh/id_rsa
# RUN chmod 0600 /root/.ssh/id_rsa

# Add bitbuckets key to known_hosts
# RUN ssh-keyscan bitbucket.org >> /root/.ssh/known_hosts

# RUN git clone git@bitbucket.org:dschien/bbc2015.git /notebook

RUN apt-get install -y -q python-numpy python-scipy python-matplotlib python-pandas libpng-dev libjpeg8-dev libfreetype6-dev

VOLUME /notebooks

RUN pip install --upgrade -r /notebooks/requirements.txt

WORKDIR /notebooks

EXPOSE 8888

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
# $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
ENV PASSWORD Dont make this your default
ENV USE_HTTP 0

ADD notebook.sh /
RUN chmod u+x /notebook.sh

CMD ["/notebook.sh"]