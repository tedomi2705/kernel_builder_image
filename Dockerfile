FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
        bc \
        bison \
        build-essential \
        ca-certificates \
        ccache \
        cpio \
        flex \
        git \
        libelf-dev \
        libssl-dev \
        zip && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9.git \
        /compiler/aarch64-linux-android-4.9 --depth=1 && \
    git clone https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9.git \
        /compiler/arm-linux-androideabi-4.9 --depth=1 && \
    git clone https://codeberg.org/tedomi2705/aosp_clang.git -b clang-r530567 \
        /compiler/clang --depth=1 && \
    rm -rf /compiler/aarch64-linux-android-4.9/.git /compiler/clang/.git /compiler/arm-linux-androideabi-4.9/.git

RUN ln -s /compiler/clang/python3/bin/python3 /usr/bin/python3 && \
    ln -s /compiler/clang/python3/bin/python3 /usr/bin/python 

# Setup workspace and environment
WORKDIR /kernel
RUN mkdir -p /ccache

ENV PATH="/compiler/clang/python3/bin:/compiler/clang/bin:/compiler/aarch64-linux-android-4.9/bin:/compiler/arm-linux-androideabi-4.9/bin:${PATH}" \
    CCACHE_DIR="/ccache" \
    CCACHE_MAXSIZE="50G" \
    CCACHE_COMPRESS="1"

CMD ["/bin/bash"]
