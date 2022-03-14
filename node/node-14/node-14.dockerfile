FROM gitpod/workspace-node

RUN bash -c 'VERSION="fermium"     && source $HOME/.nvm/nvm.sh && nvm install --lts=$VERSION     && nvm use --lts=$VERSION && nvm alias default 14 && nvm install-latest-npm'
RUN echo "nvm use default &>/dev/null" >> ~/.bashrc.d/51-nvm-fix
