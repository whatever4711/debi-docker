FROM ubuntu:16.04

ENV DIR /armbian

RUN apt-get update && \
    apt-get install -y git build-essential binutils apt-cacher-ng

RUN mkdir $DIR
RUN cd $DIR && git clone https://github.com/igorpecovnik/lib.git --depth 1

RUN cp $DIR/lib/compile.sh $DIR/.
RUN chmod +x $DIR/compile.sh
VOLUME ["$DIR"/compiled]
WORKDIR "$DIR"

RUN ./compile.sh BRANCH=dev BOARD=nanopineo KERNEL_ONLY=yes KERNEL_CONFIGURE=no BUILD_DESKTOP=no PROGRESS_DISPLAY=plain RELEASE=jessie

#ENTRYPOINT ["./compile.sh"] 
