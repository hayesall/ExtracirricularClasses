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

There are two types of nodes: master nodes and named nodes. Master nodes keeps track of the indices (the locations of files, for example).

* `hdfs dfs -ls /`: the "ls" of distributed file system.
* `hdfs dfs -mkdir /user/utd`: "mkdir"
* `hdfs dfs -cp /ratings.txt /user/utd/hayesall/ratings/ratings.txt`: "cp from x to y."
* `hdfs dfs -cat /user/utd/hayesall/ratings/ratings.txt | head -n 5`

## Challenge

We want to know what the highest-rated movie is based on the contents of a large file of movie ratings.

```bash
UserID,MovieID,Rating,Timestamp
1,1193,5,978300760
1,661,3,978302109
1,914,3,978301968
1,3408,4,978300275
1,2355,5,978824291
...
6040,1091,1,956716541
6040,1094,5,956704887
6040,562,5,956704746
6040,1096,4,956715648
6040,1097,4,956715569
```

We will develop an Apache pig script to do this for us.

```PigLatin
--Develop a pig script to find worse 10 movie title with least review.

ratings = LOAD '/user/utd/hayesall/ratings/ratings.txt' USING PigStorage(',') AS (UserID, movieID, Rating,Timestamp);

--rating_limit = LIMIT ratings 10;

ratings_clean = FOREACH ratings GENERATE movieID, Rating;

--rating_limit = LIMIT ratings_clean 10;

rating_group = GROUP ratings_clean BY movieID;
--rating_limit = LIMIT rating_group 10;
--rating_group: {group: bytearray,ratings_clean: {(MovieID: bytearray,Rating: bytearray)}}

movie_avg = FOREACH rating_group GENERATE group as movieID, AVG(ratings_clean.Rating) as avg1;

top_movies = ORDER movie_avg BY avg1 desc;

top_10 = LIMIT top_movies 10;
```