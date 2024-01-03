FROM registry.wearlab.tech/arm-compiler

ARG DEBIAN_FRONTEND=noninteractive
ARG HTTP_PROXY=192.168.1.19:7890
ARG HTTPS_PROXY=192.168.1.19:7890
LABEL maintainer="tech@wearlab.tech"
LABEL description="This is a Docker Image for XRobot build."

RUN apt update && apt upgrade -y --no-install-recommends

RUN apt install -y --no-install-recommends git curl sudo wget zip make && apt install -y net-tools usbutils nano

RUN apt install -y --no-install-recommends cmake ninja-build python3-tk python3-pip && apt clean
RUN apt install -y --no-install-recommends g++ gdb
RUN git clone https://github.com/ithewei/libhv.git && cd libhv && ./configure && make && sudo make install && cd .. && rm -rf libhv

RUN wget https://github.com/xrobot-org/XRobot/raw/master/hw/mcu/esp/Shell/install_esp-idf.sh && bash install_esp-idf.sh && \
wget https://github.com/xrobot-org/XRobot/raw/master/hw/mcu/esp/Shell/set-idf-path.sh && bash set-idf-path.sh

RUN wget https://github.com/cyberbotics/webots/releases/download/R2023a/webots_2023a_amd64.deb -O ./webots.deb && apt install ./webots.deb -y --no-install-recommends && rm webots.deb
