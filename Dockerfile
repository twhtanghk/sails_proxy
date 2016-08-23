FROM	node

ENV VERSION 0.0.8
RUN	npm config set user root && \
	npm install sails_proxy@${VERSION} -g
EXPOSE	1337

CMD sails_proxy
