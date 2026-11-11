FROM quay.io/fedora/fedora-bootc:45

RUN --mount=type=bind,source=.,target=/tmp/build,ro \
    bash /tmp/build/packages/install.sh

RUN bootc container lint
