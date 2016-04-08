FROM mayjojo/hawq-devel:centos7

USER root

#compile HAWQ
ADD incubator-hawq/ /opt/incubator-hawq
RUN cd /opt/incubator-hawq && ./configure --enable-gphdfs --prefix=/opt/hawq-devel && make && make install
#RUN rm -rf /opt/incubator-hawq

RUN chown -R gpadmin /opt/hawq-devel && echo "source /opt/hawq-devel/greenplum_path.sh" >> /home/gpadmin/.bashrc
#Modify hawq-devel/etc/hdfs-client.xml, dfs.default.replica = 1

#Hadoop
ADD hadoop-2.6.1 /usr/local/hadoop-2.6.1
RUN cd /usr/local && ln -s ./hadoop-2.6.1 hadoop
COPY hadoop-conf/* /usr/local/hadoop/etc/hadoop/

ADD ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config && chown root:root /root/.ssh/config

COPY *.sh /
CMD ["/bootstrap.sh", "-bash"]

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020
# Mapred ports
EXPOSE 19888
#Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088
#Other ports
EXPOSE 49707 22 
#hawq ports
EXPOSE 5432 40000

WORKDIR /opt/hawq-devel
