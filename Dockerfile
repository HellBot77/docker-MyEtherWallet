FROM alpine AS base

ARG TAG=latest
RUN [[ "$TAG" = "latest" ]] && \
    TAG=$(wget -qO- https://api.github.com/repos/MyEtherWallet/MyEtherWallet/tags | sed -n 's/.*"name": "\(.*\)".*/\1/p' | head -n 1) || \
    wget https://github.com/MyEtherWallet/MyEtherWallet/releases/download/${TAG}/MyEtherWallet-${TAG}-Offline.zip && \
    unzip MyEtherWallet-${TAG}-Offline.zip -d MyEtherWallet

FROM pierrezemb/gostatic

COPY --from=base /MyEtherWallet /srv/http
EXPOSE 8043
