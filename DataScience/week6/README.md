# Week 6:

Azure provides a "managed Hadoop service." Hadoop is not a single tool, rather it is the combination of many tools that are all part of the Hadoop ecosystem. We will work with a 10-node server today (2 8-core head nodes and 4 16-core worker nodes).

```
Web Access:
https://trs.azurehdinsight.net

UserName: admin
Password: ******
=======================
Terminal Access:

ssh sshuser@trs-ssh.azurehdinsight.net
Password: ******
```

* [portal.azure.com](portal.azure.com)
* `Ambari` is a cluster administration and monitoring tool, making it easy to specify the tools you want.

First we will use Apache Pig to analyze some data, this will give us some introduction to using Hadoop commands. Distributed storage (HDFS) breaks data into smaller and smaller chunks and saving it in these.

* `hdfs dfs -ls /`: the "ls" of distributed file system.
* `hdfs dfs -mkdir /user/utd`: "mkdir"