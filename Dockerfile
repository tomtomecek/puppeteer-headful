FROM node:12.3.1

LABEL "com.github.actions.name"="Puppeteer Headful"
LABEL "com.github.actions.description"="A GitHub Action / Docker image for Puppeteer, the Headful Chrome Node API"
LABEL "com.github.actions.icon"="chrome"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/jcblw/puppeteer-headful"
LABEL "homepage"="https://github.com/jcblw/puppeteer-headful"
LABEL "maintainer"="Jacob Lowe"

RUN  apt-get update \
     # See https://crbug.com/795759
     && apt-get install -yq libgconf-2-4 \
     # Install latest chrome dev package, which installs the necessary libs to
     # make the bundled version of Chromium that Puppeteer installs work.
     && apt-get install -y wget xvfb --no-install-recommends \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     && apt-get install -y google-chrome-unstable --no-install-recommends \
     && rm -rf /var/lib/apt/lists/*


ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
ENV PUPPETEER_EXEC_PATH google-chrome-unstable

# Startup xvfb to allow for Headfulness
RUN Xvfb :99 -screen 0 1024x768x24
ENV DISPLAY :99.0