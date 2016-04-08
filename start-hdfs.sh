#!/bin/bash

if [ "${NAMENODE}" == "${HOSTNAME}" ]; then
  if [ ! -d /tmp/hdfs/name/current ]; then
    $HADOOP_HOME/bin/hdfs namenode -format
  fi
fi

$HADOOP_HOME/sbin/start-dfs.sh
