FROM quay.io/fedora/fedora-bootc:44

COPY image/config/dnf.conf /etc/dnf/dnf.conf
COPY image/config/tmpfiles.conf /usr/lib/tmpfiles.d/bootc-var.conf

RUN --mount=type=bind,source=image,target=/tmp/image,ro,Z \
    bash /tmp/image/build.sh

RUN bootc container lint --fatal-warnings
