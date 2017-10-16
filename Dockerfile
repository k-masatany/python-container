FROM alpine:3.6

# update and base settings
RUN apk --update add \
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
    zlib-dev

# install python
ENV PYTHON_VERSION 3.5.4

RUN git clone https://github.com/yyuu/pyenv.git ~/.pyenv
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH
RUN pyenv --version
RUN pyenv install $PYTHON_VERSION
RUN pyenv global $PYTHON_VERSION
RUN python -V
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
RUN echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(pyenv init -)"' >> ~/.bashrc

RUN mkdir /app
WORKDIR /app
ENTRYPOINT ['python']
