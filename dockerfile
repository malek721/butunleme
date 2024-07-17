FROM openjdk:8-jdk

ENV GLASSFISH_VERSION 4.1.1
ENV GLASSFISH_HOME /glassfish

RUN wget http://download.oracle.com/glassfish/4.1.1/release/glassfish-${GLASSFISH_VERSION}.zip \
    && unzip glassfish-${GLASSFISH_VERSION}.zip -d / \
    && mv /glassfish4 ${GLASSFISH_HOME} \
    && rm glassfish-${GLASSFISH_VERSION}.zip

COPY . /usr/src/app

WORKDIR /usr/src/app

RUN jar cvf Web.war .

RUN cp Web.war ${GLASSFISH_HOME}/glassfish/domains/domain1/autodeploy/

EXPOSE 8080 4848

CMD ["sh", "-c", "${GLASSFISH_HOME}/bin/asadmin start-domain -v"]