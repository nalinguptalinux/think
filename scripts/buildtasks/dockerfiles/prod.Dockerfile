FROM nginx
MAINTAINER Nalin
ARG market
ENV MARKET=$market

EXPOSE 80

CMD ["nginx"]
