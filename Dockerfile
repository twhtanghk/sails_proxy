FROM	node

ENV VERSION 0.0.7
RUN	npm config set user root && \
	npm install sails_proxy@${VERSION} -g
EXPOSE	1337

CMD sails_proxy
