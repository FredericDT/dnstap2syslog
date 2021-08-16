FROM ubuntu:focal AS builder
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
RUN apt update && apt install -y libfstrm-dev libldns-dev libprotobuf-c-dev libevent-dev \
        tzdata build-essential autoconf libtool automake pkg-config protobuf-c-compiler 
ADD . /opt
WORKDIR /opt
RUN cd dnstap-ldns-tcp && ./autogen.sh && ./configure && make -j8 

FROM ubuntu:focal 
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
RUN apt update && apt install -y libfstrm0 libldns2 libprotobuf-c1 libevent-2.1-7 \ 
    tzdata \ 
    && apt clean
COPY --from=builder /opt/dnstap-ldns/dnstap-ldns /usr/bin/dnstap-ldns
ENV LIBLOGFAF_SERVER=localhost
ENV LIBLOGFAF_PORT=514
ENTRYPOINT ["/usr/bin/dnstap-ldns"]
CMD ["-a", "0.0.0.0", "-p", "6000"]
EXPOSE 6000

