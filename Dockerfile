FROM ruby:2.4.2

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  sudo \
  curl \
  git \
  vim

RUN curl -sL https://deb.nodesource.com/setup_9.x | bash - \
  && apt-get install -y nodejs 

RUN npm install -g yarn


RUN useradd -u alaa -m -r alaa && \
  echo "alaa ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers
USER alaa

# rbenv
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN cd ~/.rbenv && src/configure && make -C src

ENV TERM xterm
ENV PATH="/home/alaa/.rbenv/bin:$PATH"
ENV RBENV_SHELL=sh

# ruby-build
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# ruby
RUN rbenv install 2.4.2
RUN rbenv global 2.4.2

RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc

WORKDIR /usr/src/app

RUN gem install bundler && rbenv rehash

CMD sleep infinity
