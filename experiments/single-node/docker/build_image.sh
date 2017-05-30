#!/bin/bash
set -ex

#git clone --recursive https://github.com/yzhan298/ceph.git --branch wip_dmclock_clients --single-branch ceph
#git clone --recursive https://github.com/yzhan298/ceph.git
#cd ceph
git clone \
  --recursive https://github.com/leosinclairjr/ceph \
  --branch wip_dmclock_clients \
  --single-branch \
  ceph
cd ceph

#docker pull cephbuilder/ceph:kraken

#source <(wget -qO- https://raw.githubusercontent.com/systemslab/docker-cephdev/master/aliases.sh)

#docker cephbuilder/ceph:kraken ceph/daemon:latest

#wget https://raw.githubusercontent.com/systemslab/docker-cephdev/master/aliases.sh
wget https://raw.githubusercontent.com/systemslab/docker-cephdev/e0e1ba42919388a64a695d2822d3e5f656c2d67b/aliases.sh
source aliases.sh
#rm aliases.sh

#mkdir ceph; cd ceph
docker pull cephbuilder/ceph:kraken
#docker pull ceph/daemon:tag-build-master-jewel-ubuntu-14.04
#docker tag ceph/daemon:tag-build-master-jewel-ubuntu-14.04 ceph/daemon:latest
#mkdir ceph; cd ceph

dmake \
  -e CONFIGURE_FLAGS="-DWITH_TESTS=OFF -DCMAKE_BUILD_TYPE=Release" \
  -e RECONFIGURE="true" \
  -e BASE_DAEMON_IMAGE="ceph/daemon:tag-build-master-kraken-ubuntu-16.04" \
  -e BUILD_THREADS=`grep processor /proc/cpuinfo | wc -l` \
  cephbuilder/ceph:kraken build-cmake
