# SoftEther VPN server

FROM debian

ENV VERSION v4.29-9680
ENV DATA 2019.02.28


WORKDIR /usr/local/vpnserver


RUN apt-get update &&\
        apt-get -y -q install iptables gcc make wget && \
        apt-get clean && \
        rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
        wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/${VERSION}-rtm/softether-vpnserver-${VERSION}-rtm-${DATA}-linux-x64-64bit.tar.gz -O /tmp/softether-vpnserver.tar.gz && \
        tar -xzvf /tmp/softether-vpnserver.tar.gz -C /usr/local/ &&\
        rm /tmp/softether-vpnserver.tar.gz &&\
        make i_read_and_agree_the_license_agreement &&\
        apt-get purge -y -q --auto-remove gcc make wget

ADD runner.sh /usr/local/vpnserver/runner.sh
RUN chmod 755 /usr/local/vpnserver/runner.sh

EXPOSE 443/tcp 992/tcp 1194/tcp 1194/udp 5555/tcp 500/udp 4500/udp

ENTRYPOINT ["/usr/local/vpnserver/runner.sh"]
