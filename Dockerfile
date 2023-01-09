FROM rlespinasse/drawio-export:v4.6.0

RUN apt-get update && apt-get install --no-install-recommends -y git=1:2.30.2-1 && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/google/fonts/archive/main.tar.gz -O gf.tar.gz
RUN tar -xf gf.tar.gz
RUN mkdir -p /usr/share/fonts/truetype/google-fonts
RUN find $PWD/fonts-main/ -name "*.ttf" -exec install -m644 {} /usr/share/fonts/truetype/google-fonts/ \; || return 1
RUN rm -f gf.tar.gz
RUN fc-cache -f && rm -rf /var/cache/*

COPY drawio-export.sh /opt/drawio-export-action/drawio-export.sh

ENV DRAWIO_DESKTOP_RUNNER_COMMAND_LINE "/opt/drawio-export-action/drawio-export.sh"
