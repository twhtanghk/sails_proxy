FROM	node

ENV VERSION 0.0.1
RUN	npm install sails_proxy@${VERSION} -g
EXPOSE	1337

CMD sails_proxy
