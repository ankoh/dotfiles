FROM ubuntu:19.10

# Install core packages
RUN apt-get update -qq \
    && apt-get install -y \
        openssh-server tmux neovim git curl locales tig \
        build-essential binutils make cmake clang clang-format lld ninja-build ccache bison \
        python-pip python3-pip \
        htop golang \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install dev packages
RUN apt-get update -qq \
    && apt-get install -y \
        llvm-9 libasan5 libboost-all-dev libc6-dev libclang-9-dev libjemalloc-dev libssl-dev libtinfo-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure locale
RUN locale-gen en_US.UTF-8 \
    && echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Configure SSH server
RUN mkdir /var/run/sshd \
    && sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && sed -i 's/session\s*required\s*pam_loginuid.so/session optional pam_loginuid.so/g' /etc/pam.d/sshd

# Switch to caravan user
RUN useradd -ms /bin/bash caravan \
    && usermod -aG sudo caravan
USER caravan
WORKDIR /home/caravan
SHELL ["/bin/bash", "-c"]

# Install rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

# Install dotfiles
COPY --chown=caravan:caravan . /home/caravan/.dotfiles/
RUN cd .dotfiles \
    && make install-symlinks \
    && source ../.bashrc \
    && make install-fzf install-ls-cc install-ls-py install-ls-rs \
    && chmod +x ./caravan/entrypoint.sh

# Setup neovim & tmux
RUN source .bashrc \
    && pip install neovim \
    && pip3 install neovim \
    && nvim --headless +UpdateRemotePlugins +PlugInstall +qall! \
    && ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# Configure SSH daemon
USER root
EXPOSE 22
ENTRYPOINT ["/home/caravan/.dotfiles/caravan/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
