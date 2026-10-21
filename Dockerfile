FROM ruby:3.4-slim-bookworm

# Debian's security update removes both emSign ECC Root CA - G3 and
# AAA Certificate Services, covering the compromised intermediates' cross-signs.
# https://security-tracker.debian.org/tracker/DLA-4845-1
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates build-essential \
    && dpkg --compare-versions "$(dpkg-query -W -f='${Version}' ca-certificates)" ge '20250419~deb12u2' \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \
    SSL_CERT_DIR=/etc/ssl/certs

RUN gem install package_cloud --version 0.3.15 --no-document

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
