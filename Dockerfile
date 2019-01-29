FROM uqlibrary/alpine as builder
RUN apk --no-cache add git gcc python2-dev libxslt-dev libxml2-dev libc-dev libffi-dev libressl-dev mariadb-connector-c-dev py-mysqldb py-setuptools py2-urllib3 py2-gunicorn libffi py2-pip &&\
mkdir /patchman &&\
pip install whitenoise==3.3.1 &&\
git clone https://github.com/furlongm/patchman.git /patchman
RUN cd /patchman && ./setup.py install
ADD etc/patchman/local_settings.py /etc/patchman/local_settings.py
ADD entry.sh /entry.sh
RUN chmod 755 /entry.sh
ENTRYPOINT ["/entry.sh"]
