FROM ubuntu:14.04

ENV DIR /armbian
RUN apt-get update && \
    apt-get install -y git

RUN mkdir $DIR
RUN cd $DIR && git clone https://github.com/igorpecovnik/lib.git --depth 1

RUN cp $DIR/lib/compile.sh $DIR/.
RUN chmod +x $DIR/compile.sh
VOLUME ["$DIR"/compiled]
WORKDIR "$DIR"

ENTRYPOINT ["./compile.sh"] 
