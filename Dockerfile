FROM mirror.gcr.io/python:3-slim

RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
  --mount=type=cache,target=/var/lib/apt,sharing=locked \
  apt update && apt-get --no-install-recommends install -y git
COPY requirements.txt requirements.txt
RUN pip install -U pip && pip install -r requirements.txt

WORKDIR /app
CMD ["tail", "-f", "/dev/null"]