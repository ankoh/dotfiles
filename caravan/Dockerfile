FROM ubuntu:20.10

# Install core packages
RUN apt-get update -qq \
    && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
        sudo openssh-server tmux neovim git curl locales tig exuberant-ctags \
        build-essential binutils make cmake clang clang-format lld ninja-build ccache bison gdb lldb \
        linux-tools-common linux-tools-generic \
        python3-pip \
        htop golang \
        unzip \
    && ln -fs /usr/lib/linux-tools/*/perf /usr/bin/perf \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install dev packages
RUN apt-get update -qq \
    && apt-get install -y \
        llvm-11 libasan5 libboost-all-dev libc6-dev libclang-11-dev libjemalloc-dev libssl-dev libtinfo-dev \
        libpthread-stubs0-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install rr debugger
# RUN cd /tmp \
#     && curl -L -o rr.deb https://github.com/mozilla/rr/releases/download/5.3.0/rr-5.3.0-Linux-x86_64.deb \
#     && dpkg -i rr.deb \
#     && rm -rf rr.deb

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
    && pip3 install neovim \
    && nvim --headless +UpdateRemotePlugins +PlugInstall +qall! \
    && ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# Configure SSH daemon
USER root
EXPOSE 22
ENTRYPOINT ["/home/caravan/.dotfiles/caravan/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]
