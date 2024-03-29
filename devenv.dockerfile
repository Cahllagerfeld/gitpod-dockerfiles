FROM gitpod/workspace-base

USER root

# Install Nix
RUN addgroup --system nixbld \
    && adduser gitpod nixbld \
    && for i in $(seq 1 30); do useradd -ms /bin/bash nixbld$i &&  adduser nixbld$i nixbld; done \
    && mkdir -m 0755 /nix && chown gitpod /nix \
    && mkdir -p /etc/nix && echo 'sandbox = false' > /etc/nix/nix.conf

# Install Nix
CMD /bin/bash -l
USER gitpod
ENV USER gitpod
WORKDIR /home/gitpod

RUN touch .bash_profile \
    && curl https://nixos.org/releases/nix/nix-2.16.1/install | sh

RUN echo '. /home/gitpod/.nix-profile/etc/profile.d/nix.sh' >> /home/gitpod/.bashrc
RUN mkdir -p /home/gitpod/.config/nixpkgs && echo '{ allowUnfree = true; }' >> /home/gitpod/.config/nixpkgs/config.nix

# Install cachix environement
RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
    && nix-env -iA cachix -f https://cachix.org/api/v1/install \
    && cachix use cachix \
    && cachix use devenv \
    && nix-env -if https://github.com/cachix/devenv/tarball/latest


# Install direnv
RUN . /home/gitpod/.nix-profile/etc/profile.d/nix.sh \
    && nix-env -i direnv \
    && direnv hook bash >> /home/gitpod/.bashrc \
    && mkdir -p ~/.config/direnv \
    && echo '[whitelist]' > ~/.config/direnv/config.toml \
    && echo 'prefix = [ "/workspace" ]' >> ~/.config/direnv/config.toml
