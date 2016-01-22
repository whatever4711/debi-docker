FROM ubuntu:14.04

ENV DIR /armbian
RUN apt-get update && \
    apt-get install -y git

RUN mkdir $DIR
RUN cd $DIR && git clone https://github.com/igorpecovnik/lib.git --depth 1

RUN cp $DIR/lib/compile.sh $DIR/.
RUN sed -i -e 's/KERNEL_ONLY="no"/KERNEL_ONLY="yes"/g' $DIR/compile.sh
RUN sed -i -e 's/KERNEL_CONFIGURE="no"/KERNEL_CONFIGURE="yes"/g' $DIR/compile.sh
RUN chmod +x $DIR/compile.sh

RUN cd $DIR && ./compile.sh BRANCH=next BOARD=cubietruck KERNEL_ONLY=yes PROGRESS_DISPLAY=plain RELEASE=jessie

#RUN sed -i -e 's#keys.gnupg.net#hkp://keys.gnupg.net:80#g' $DIR/lib/general.sh
#RUN sed -i -e 's#keys.gnupg.net#hkp://keys.gnupg.net:80#g' $DIR/lib/upgrade.sh

#RUN sed -i -e 's#git://git.denx.de/u-boot.git#http://git.denx.de/u-boot.git#g' $DIR/lib/configuration.sh

#ENTRYPOINT ["$DIR/compile.sh"]


