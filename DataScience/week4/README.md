# Week 4: Important Python Libraries for Data Analysis

This week we discuss libraries, and introduce Spark.

Libraries discussed:

* NLTK (Natural Language ToolKit)  
  1. `pip install nltk`
  2. `python`
  3. ```python
     >>> import nltk
     >>> nltk.download()

     # Select all-nltk, download will take a little while.
     # If space is tight, download as you find things you need.
     ```
* numpy
* Matplotlib
* SciPy
* Pandas

## Apache Spark
Presented by Shrinath Parikh

[https://www.linkedin.com/pulse/teach-yourself-apache-spark-guide-nerds-shrinath-parikh](Shrinath Parikh's Spark Tutorial)

* Apache Spark: designed to be general purpose for "Resilient Distributed Datasets."
* Apache sqoop: tool designed for efficiently transferring bulk data between Apache Hadoop and structured data stores such as relational databases.

### Motivation:

MapReduce greatly simplified "big data" analysis on large, unreliable clusters. Bottleneck tends to be in requiring many I/O from disk. Goal of Spark is to keep data in memory for as long as possible to limit the number of disk accesses.

```scala
lines = spark.textFile("hdfs://...")
errors = lines.filter(_.startsWith("ERROR"))
messages = errors.map(_.split('\t')(2))
messages.persist()

messages.filter(_.contains("foo")).count
messages.filter(_.contains("bar")).count
```