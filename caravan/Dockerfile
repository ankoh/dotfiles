FROM ubuntu:19.10

# Install core packages
RUN apt-get update -qq \
    && apt-get install -y \
        openssh-server tmux neovim git curl \
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

# Switch to user kohn
RUN useradd -ms /bin/bash kohn
USER kohn
WORKDIR /home/kohn
SHELL ["/bin/bash", "-c"]

# Install rust
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

# Install dotfiles
RUN git clone https://github.com/ankoh/dotfiles .dotfiles \
    && cd .dotfiles \
    && git checkout f94efbc60ae1788192d8eed49eae52aec9de8325 \
    && make install-symlinks install-fzf

# Install language servers
RUN cd .dotfiles && make install-ls-cc
RUN cd .dotfiles && make install-ls-py
RUN source .bashrc && cd .dotfiles && make install-ls-rs

# Setup neovim
RUN pip install neovim \
    && pip3 install neovim \
    && nvim --headless +UpdateRemotePlugins +PlugInstall +qall!
