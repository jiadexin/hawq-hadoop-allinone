#!/bin/bash

#/etc/init.d/sshd start
/usr/sbin/sshd
export HADOOP_HOME=/usr/local/hadoop
export JAVA_HOME=/etc/alternatives/java_sdk
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

if [ -z "${NAMENODE}" ]; then
  export NAMENODE=${HOSTNAME}
fi

: ${HADOOP_PREFIX:=/usr/local/hadoop}

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the core-site configuration
#sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml


/start-hdfs.sh
#$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh

if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
