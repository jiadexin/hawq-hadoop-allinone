# hawq-hadoop-allinone
1.镜像内容
参考https://github.com/wangzw/hawq-devel-env , 
制作的allinone的Docker镜像，包含hadoop、已经编译的hawq。

镜像文件命名为：jiadx/hawq-hadoop-allinone:centos7

2.启动
docker run -ti -p jiadx/hawq-hadoop-allinone:centos7

bootstrap.sh会启动hadoop集群，然后执行bash，可以直接交互。

3.初始化hawq
启动容器后，在容器内使用gpadmin用户初始化hawq集群：
su gpadmin
hawq init cluster
createdb

4.简单测试
psql

gpadmin=#  CREATE TABLE my_table ( first integer not null default 0,second text);

gpadmin=# insert into my_table values(1,'hello');
gpadmin=# insert into my_table values(2,'world');
gpadmin=# select * from my_table;


