FROM hotio/base@sha256:5c748f472fd4dda9c2332dbce09046f9b419d6776083ec17df1d4d8370eb5a0b
EXPOSE 8080

RUN apk add --no-cache unrar p7zip python3 py3-six py3-cryptography py3-chardet && \
    apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing par2cmdline && \
    apk add --no-cache --virtual=build-dependencies py3-pip py3-setuptools gcc python3-dev musl-dev && \
    pip3 install --no-cache-dir --upgrade \
        sabyenc3 \
        cheetah3 \
        feedparser \
        configobj \
        cherrypy \
        portend \
        notify2 && \
    apk del --purge build-dependencies

ARG SABNZBD_VERSION
RUN curl -fsSL "https://github.com/sabnzbd/sabnzbd/releases/download/${SABNZBD_VERSION}/SABnzbd-${SABNZBD_VERSION}-src.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"

COPY root/ /
