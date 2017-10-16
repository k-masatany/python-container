FROM alpine:3.6

# update and base settings
ENV PYTHON_VERSION 3.5.4
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN apk --update --no-cache add \
        bzip2-dev \
        readline-dev \
        alpine-sdk \
        bash \
        curl \
        git \
        linux-headers \
        openssl \
        openssl-dev \
        sqlite-dev \
        wget \
        zlib-dev && \
    git clone https://github.com/yyuu/pyenv.git ~/.pyenv && \
    pyenv --version && \
    pyenv install $PYTHON_VERSION && \
    pyenv global $PYTHON_VERSION && \
    python -V && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    apk del --purge alpine-sdk && \
    mkdir /app && \
    sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

VOLUME ["/app"]
WORKDIR /app

CMD ["-"]
ENTRYPOINT ["python"]
