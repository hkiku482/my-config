FROM archlinux

RUN pacman -Syu --noconfirm && pacman -S --noconfirm archlinux-keyring && pacman -S --noconfirm sudo vim git openssh base-devel cmake clang less

RUN groupadd -g 1000 arch && useradd -u 1000 -g 1000 -m -s /bin/bash arch

RUN echo "arch ALL=(ALL:ALL) ALL" >> /etc/sudoers

USER arch

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile default
RUN echo "alias ll='ls -ahlvF'" >> ~/.bashrc

WORKDIR /home/arch

CMD ["/bin/bash"]
