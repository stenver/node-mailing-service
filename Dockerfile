FROM nodesource/jessie:0.12.7

ENV SERVICE_NAME node-mailing-service

RUN apt-get update

RUN apt-get clean && rm -rf /tmp/* /var/tmp/*

ENV APP_HOME /$SERVICE_NAME

RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

ADD . .

RUN npm install
RUN npm install -g coffee-script

ENTRYPOINT ["/node-mailing-service/start"]


