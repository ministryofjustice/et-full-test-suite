FROM ruby:2.5.1-slim
RUN apt-get update && apt-get install -y \
    build-essential \
    git-core \
    pdftk \
    libmcrypt-dev mcrypt
RUN gem update --system
RUN gem install bundler
RUN mkdir -p /app
WORKDIR /app
CMD cd /app && tail -f /dev/null
