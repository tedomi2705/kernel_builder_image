# Kernel builder docker image
This docker image is used to build Android kernels. It is based on Ubuntu 24.04 and has AOSP clang and gcc toolchains installed.

## Usage

### Building the image
```bash
docker build -t kernel-builder .
```

### Running the image
```bash
docker run -it --rm -v /path/to/kernel:/kernel /path/to/ccache:/ccache kernel-builder
```
