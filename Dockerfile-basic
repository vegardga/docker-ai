# Generisk Dockerfile for å kjøre AI-verktøy i isolerte miljø

# Bytt til ønsket image
FROM ubuntu:24.04

# Unngå unødvendige prompts under installasjon
ENV DEBIAN_FRONTEND=noninteractive

# Oppgrader og installer et utvalg nødvendige og hendige verktøy
# Andre nyttige eksempler: build-essential, openssh-client, sudo, htop, iputils-ping, ..
RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  wget \
  git \
  unzip \
  vim \
  jq \
  tree \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Opprett en ikke-root-bruker, kalt "batman"
RUN useradd --create-home --shell /bin/bash batman

# Bytt til "batman" og endre arbeidsmappen til hjem-mappen
USER batman
WORKDIR /home/batman

# Installer OpenCode gjennom offisiell installasjonsscript
RUN curl -fsSL https://opencode.ai/install | bash

# Opprett opencode-mappe for eventuelle konfigurasjonsfiler
RUN mkdir -p /home/batman/.local/share/opencode
RUN mkdir -p /home/batman/.config/opencode

# Default oppstartskommando
CMD ["/bin/bash"]
