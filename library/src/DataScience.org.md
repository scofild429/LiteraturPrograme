---
title: Data Science and Cloud Service Computing
---

```{=org}
#+STARTUP: overview
```
# Hadoop

## one node installation

### .bashrc

    export HADOOP_HOME=/home/cloud/hadoop-3.3.1
    export HADOOP_INSTALL=$HADOOP_HOME
    export HADOOP_MAPRED_HOME=$HADOOP_HOME
    export HADOOP_COMMON_HOME=$HADOOP_HOME
    export HADOOP_HDFS_HOME=$HADOOP_HOME
    export YARN_HOME=$HADOOP_HOME
    export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
    export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
    export HADOOP_OPTS"-Djava.library.path=$HADOOP_HOME/lib/nativ"

### \$HADOOP~HOME~/etc/hadoop/hadoop-env.sh

append to end

    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

### \$HADOOP~HOME~/etc/hadoop/core-site.xml

in configuration

    <property>
         <name>hadoop.tmp.dir</name>
         <value>/home/cloud/tmpdata</value>
         <description>A base for other temporary directories.</description>
     </property>
     <property>
         <name>fs.default.name</name>
         <value>hdfs://localhost:9000</value>
         <description>The name of the default file system></description>
     </property>

### \$HADOOP~HOME~/etc/hadoop/hdfs-site.xml

in configuration

    <property>
      <name>dfs.data.dir</name>
      <value>/home/cloud/dfsdata/namenode</value>
    </property>
    <property>
      <name>dfs.data.dir</name>
      <value>/home/cloud/dfsdata/datanode</value>
    </property>
    <property>
      <name>dfs.replication</name>
      <value>1</value>
    </property>

### \$HADOOP~HOME~/etc/hadoop/mapred-site.xml

in configuration

    <property>
      <name>mapreduce.framework.name</name>
      <value>yarn</value>
    </property>

### \$HADOOP~HOME~/etc/hadoop/yarn-site.xml

    <property>
      <name>yarn.nodemanager.aux-services</name>
      <value>mapreduce_shuffle</value>
    </property>
    <property>
      <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
      <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>
    <property>
      <name>yarn.resourcemanager.hostname</name>
      <value>127.0.0.1</value>
    </property>
    <property>
      <name>yarn.acl.enable</name>
      <value>0</value>
    </property>
    <property>
      <name>yarn.nodemanager.env-whitelist</name>
      <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PERPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
    </property>

### init nodename

    cd hadoop-3---
    hdfs namenode -format
    cd sbin
    ./start-dfs.sh
    ./start-yarn.sh
    jps

## 3 node installation

### GWDG deployment

  software         .1            .10               .19
  ---------------- ------------- ----------------- -------------------
  hadoop           hadoop1       hadoop2           hadoop3
  hostname         project       q3lb              q3l
  HDFS Namenode    NameNode                        SecondaryNameNode
  HDFS DataNode    DataNode      DataNode          DataNode
  YARN ResourceM                 ResourceManager   
  YARN NodeM       NodeManager   NodeManager       NodeManager

### .bashrc

    export HADOOP_HOME=/home/cloud/hadoop-3.3.1
    export HADOOP_INSTALL=$HADOOP_HOME
    export HADOOP_MAPRED_HOME=$HADOOP_HOME
    export HADOOP_COMMON_HOME=$HADOOP_HOME
    export HADOOP_HDFS_HOME=$HADOOP_HOME
    export YARN_HOME=$HADOOP_HOME
    export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
    export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin
    export HADOOP_OPTS"-Djava.library.path=$HADOOP_HOME/lib/nativ"

### \$HADOOP~HOME~/etc/hadoop/hadoop-env.sh

append to end

    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

### \$HADOOP~HOME~/etc/hadoop/core-site.xml

in configuration

    <property>
         <name>hadoop.tmp.dir</name>
         <value>/home/cloud/hadoop-3.3.1/data</value>
         <description>A base for other temporary directories.</description>
     </property>
     <property>
         <name>fs.default.name</name>
         <value>hdfs://hostname:9000</value> watch out for inter floatip for localhost 
         <description>The name of the default file system></description>
     </property>

### \$HADOOP~HOME~/etc/hadoop/hdfs-site.xml

in configuration

    <property>
      <name>dfs.data.dir</name>
      <value>/home/cloud/hahoop-3.3.1/dfsdata/namenode</value>
    </property>
    <property>
      <name>dfs.data.dir</name>
      <value>/home/cloud/hahoop-3.3.1/dfsdata/datanode</value>
    </property>
    <property>
      <name>dfs.replication</name>
      <value>3</value>
    </property>
    <property>
      <name>dfs.namenode.http-address</name>
      <value>*inter floatip:9870*</value>
    </property>
    <property>
      <name>dfs.namenode.secondary.http-address</name>
      <value>inter floatip:9868</value>
    </property>


### \$HADOOP~HOME~/etc/hadoop/yarn-site.xml

    <property>
      <name>yarn.nodemanager.aux-services</name>
      <value>mapreduce_shuffle</value>
    </property>
    <property>
      <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
      <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>
    <property>
      <name>yarn.resourcemanager.hostname</name>
      <value>*inter floatip*</value>
    </property>
    <property>
      <name>yarn.acl.enable</name>
      <value>0</value>
    </property>
    <property>
      <name>yarn.nodemanager.env-whitelist</name>
      <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PERPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
    </property>

### \$HADOOP~HOME~/etc/hadoop/mapred-site.xml

in configuration

    <property>
      <name>mapreduce.framework.name</name>
      <value>yarn</value>
    </property>

### \$HADOOP~HOME~/etc/hadoop/wores

gwdg01 gwdg10 gwdg19

### init nodename

    cd hadoop-3---
    xsycn etc/hadoop
    hdfs namenode -format
    cd sbin
    ./start-dfs.sh
    ./start-yarn.sh
    jps

## command

general comands

    hdfs dfs -ls /
    hdfs dfs -chmod 777 /testFolder
    hdfs dfs -cat /tesFolder/text.txt
    hdfs dfs -get hdfspath localpath
    hdfs dfs -put localpath hdfspath
    hdfs dfsadmin -report
    hdfs fsck /

word example

    hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar wordcount /input /output/
    hadoop fs -cat /output/part-r-00000
    cd output
    hadoop fs -getmerge /hpda04-2.3-output/ out
    cat out

## map()

map(fun \<key1, val1\>) -\> list(\<key2, val2\>) to a list of key-value
pairs all elemenet in list must have the same type

## Schuffle

schuffle(list(\<key2, val2\>)) -\> list(\<key2, list(val2)\>)

## reduce

reduce (fun, list(\<key2, list(val2)\>)) -\> list(val3)

## Limitation

1, multiple map() and reduce() must be manually specified 2,
intermediary results has to be written to the HDFS, not on memory
iterative algorithms are not very efficient with Hadoop.

# HDFS

## descripation


    Hadoop distributed file system
    Namenode vs Datanodes

    1, high throughout with low latency
    2, support large file
    3, locally computation in Node, less transfer zwischen Nodes
    4, resilient design for hardware failurs

## install

tut link
<https://drive.google.com/drive/folders/1XdPbyAc9iWml0fPPNX91Yq3BRwkZAG2M>


    java
    ssh localhost(ssh-keygen -t rsa)
    edit 6 file
    ./hdfs  namenode -format



# YARN

Yet Another Resource Negotiator Resource Manager vs NodeManager Resource
Manager avoid overutilization and underutilization The NodeManager
execute tasks on the local resources 1, Client send a requirement to
Resource Manager 2, Resource manager allocate container in Node Manager
3, Container in Node Manager start the application Master 4, Application
Master require Resource from Resoure Manager 5, as the required Resoure
is allocated, application master start the Application

# Spark

## 3 node installation

### GWDG deployment

  floatip          .1            .10               .19
  ---------------- ------------- ----------------- -------------------
  hostname         gwdg01        gwdg10            gwdg19
  ip               .8            .5                .10
  HDFS Namenode    NameNode                        SecondaryNameNode
  HDFS DataNode    DataNode      DataNode          DataNode
  YARN ResourceM                 ResourceManager   
  YARN NodeM       NodeManager   NodeManager       NodeManager

## descripation

results do not need to save in HDFS, it support in memory executation.
Resilient Distributed Datasets RDDS DataFrame from SparkSQL

## scala

can from binary file can from source file can from IDEA blugin can from
spark installation

## install

### from source

this is a full eco system, can build a cluster by my own, with embended
scala

### from pip

my Prof can also build a eco system in pip download file, with config in
master: spark-submit --deploy-mode --master yarn test.py But I can\'t, I
can even not find conf file in pip file for pyspark, if you still want
to consturcte a cluster, use spark installation from source file, like
following

## single master node configuration with

``` {.bash org-language="sh" results="output"}
cat ~/Documents/spark/myown/test.py
```

print(\"hello world\")

    cd .../spark
    ./sbin/start-all
    curl localhost:8080(spark-url for master)
    ./bin/spark-submit --master spark-url ./myown/test.py

test.py will be executed

    ./bin/pyspark --master spark-url 

will open a terminal with master configuration

## pyspark

    cd spark
    bin/spark-submit examples/src/main/python/wordcount.py testtext.txt &> output.txt

# Big data lecture

## Association Rule Minning

-   Transaction: T, one behavior, which accomplished a lot of
    things(items) -transaction instances t,
-   Item : I, which stands for the smallest unit, that can be done.
-   Our task is to find out, the relationship between items

**Support** the probabilty of a itemset occurs
$$Support (IS) = \frac{|t \in T: IS \subseteq t |}{|T|}$$ All IS bigger
than a setted value is called frequent itemset, but how to set the value
is self-define

**Confidence** $$C(a->b) = P(b|a) = \frac{P(ab)}{P(a)}$$

    the Probabilities  If a is done, b will also be done.

**Support** $$S(a->b)=P(a\cap b) = P(ab)$$

    a and b be done together from all Transaction, identify the special Transaction case

$$X -> Y(C=c, S=s)$$

**practicability** (Lift)
$$L(a->b)=\frac{Confidence(a->b)}{P(b)} =\frac{P(ab)}{P(a)P(b)}$$

    The impact of a on b to be done

**Aprioir** **algorithm**

1.(with support level(S) )

-   find the frequently itemset(L)
-   the subsets of frequently itemset is also frequently itemset
-   collect the total Transaction set(T), and set the the support level
-   find all $L_{1}$, which satisfied S,
-   find all $L_{2}$, which come from all 2-items combinations, which
    satisfied S
-   .....to only one left, $L_{k}$.

2.(with Confidence (C) )find all subsets of $L_{k}$, which satisfied C.

**Note** all the operations in this 2 step is done in the whole
Transaction sets

## Data Exploration

Singal feather: histogram density, rug, Box-Whisker Box-Whisker: low
quartile to high quartile is interquartile range (IQR)

low boundary: low quartile - IQR high boundary: high quartile + IQR

pair-wise scatterplot

hexbin plot

correlation heatmap

## Time Series Analysis

### Descripation

Discrete values {$x_1$,....,\$x~T~\$} = $(x_t)_{t=1}^T$ A core
assumpation is the time difference between $x_{t}$ and $x_{t+1}$ is
equal for $t \in (1...T)$. $x_{t}$ can be decomposed into 3 components:

  ----- ----------------- --- ----------------------------------------
  1\.   trend component   T   change over all time
  2\.   seasonality       S   the results of seasons effect
  3\.   autocorrelation   R   how the values depends on prior values
  ----- ----------------- --- ----------------------------------------

so $$X = T + S + R$$

### Box-Jenkins for stationary

1.  stationary

    Time series is stationary Mean and Variance of the trend and
    seasonality are constant and can be removed so the autocorrelation
    is stochastic process,

2.  Trend and Series Effects

    1.  model the trend $T_{t}$ on the time series $x_{t}$
    2.  detrended time series $\hat{x}=x_{t}-T_{t}$
    3.  model the seasonality $S_{t}$ on the time series $x_{t}$
    4.  get the seasonality adjusted time series
        $\hat{\hat{x_{t}}}=\hat{x}-S_{t}$

3.  Regession and Seasonal Means

    In this context we can only use linear regession to fit the all time
    series, get $\hat{x}$.

    and then substract the seasonal Means:
    $\hat{\hat{x}}= \hat{x}-(Mean(\hat x^{´}_{t})-Mean(\hat x_{t}))$
    $Mean(\hat x^{´}_{t})$ is special for mod(t, s), in the recursive
    seasonal effect, only the same time slot element will be calculated,
    this happens if the last season is not complete.

    **Cons** only works for linear trends and with seasonal effects that
    have no trend.

### Differencing for not stationary

for $y=f(x)$ for two points($x_1$, $y_1$) and ($x_2, y_2$), the
first-order difference to detrended time series:
$\hat x_{t} = \Delta x^{1}_{t}=x_{t}-x_{t-1}$. or if you want, you can
get the second-order-difference
$\Delta^{2}x_{}{t} = \Delta^{1}x_{t}-\Delta^{1}x_{t-1} = x_{t}-2x_{t-1}+x_{t-2}$

using difference to adjust the seasonal effect: using the difference
between two consecutive points in time during the season.
$\hat{\hat{x}} = \Delta_{s} \hat x_{t} = \hat x_{t} - \hat x_{t-s}$

**pro** it can deal with both changes in the mean, as well as changes in
the movement of the mean

### Correlation

Autocorrelation is the direct relationship of the values of the time
series at different points in time, for two adjacent points

Partial autocorrelation is the autocorrelation without the carryover,
i.e., only the direct correlation, not for two adjacent points

for Authentication and Partial authentication we can see the residual
seasonal effect for regession and seasonal means

### ARIMA

three ways to model correlation

1.  AR: atuoregressive

    model the direct influence of the past p points on time series
    $c + \epsilon_{t} + \sum_{i=1}^{p}a_{i}x_{t-i}$ c :constant over all
    time $\epsilon_{t}$: white noise, mean of 0, normal distribution

2.  MA: Moving average

    model the random effect on time series
    $c + \epsilon_{t} + \sum_{j=1}^{q}b_{j}\epsilon_{t-j}$ the
    difference is the random influence of the past noise to next value

3.  ARMA: autoregressive and Moving average

    $c + \epsilon_{t} + \sum_{i=1}^{p}a_{i}x_{t-i} + \sum_{j=1}^{q}b_{j}\epsilon_{t-j}$

4.  select p and q

    partial authentication estimate the p for AR, but if p can cover all
    the season, but if p is too big, it can lead to overfitting.

    autocorrelation can estimate the q for MA, using q as the steps for
    autocorrelation to be 0, so we look at when the autocorrelation goes
    towards zero and use this for q. at the same time the effect of AR
    should also be counted for determinate q.

## Text minning

### Preprocessing

1.  Creation of a Corpus

    contains all text to analysis

2.  remove the irrelevant content,

    links, timestamps

3.  Punctuation and Cases

    remove all Punctuation, and all use small cases a problem is about
    acronyms

4.  Stop words

    commons words should be removed, auch as I, to ,a

5.  Stemming and Lemmatization

    first Lemmatization, and then Stemming

### Visualiztation

1.  bag-of-words with wordclouds

2.  Term frequency(TF)

    is the count of a words within document

3.  Inverse Document Frequency(IDF)

    is to weight words by their uniqueness within the corpus
    $$IDF_{t} = \log \frac{N}{D_{t}}$$ t: word(term) N: the number of
    document in corpus $D_{t}$: the number of document in corpus, which
    contains word t

4.  TFIDF

    $$TFIDF = TF \cdot IDF $$

5.  beyond the bag-of-words

    ignore the structure of document ignore simiarity of words

### challages

1.  dimensionality

2.  Ambiguities

# Sensor Fusion lecture

## Sensor Dataverarbeitung

Tensor Fehler, Präzision: stochastisch Richtigkeit: systematisch

## concepts

  ---------------- -----------------------------------------------------
  competitive      many sensor for the same place für higher accuracy
  complementary    many sensor for many places für higher completeness
  dead reckoning   errors accumulation over previous knowlegde
  ---------------- -----------------------------------------------------

$$ y = H x + e $$

  ---------------------- -----------------------------------------------
  measurement equation   projects the state onto the measurement space
  y                      measurement
  x                      state
  H                      measurement matrix
  e                      measurement error
  ---------------------- -----------------------------------------------

**Jacobian Matrix** one order

**Hessian Matrix** two order

**Partial Matrix**

-   $$ \frac{\partial}{\partial x}c^{T}x = \frac{\partial}{\partial x}x^{T}c  = c $$
-   $$ \frac{\partial}{\partial x}x^{T}Ax = 2 Ax $$
-   $$ \frac{\partial}{\partial x}Ax = \frac{\partial}{\partial x}x^{T}A = A $$

# data analysis code demo

## statistical mothode

``` {.python results="output"}
from scipy import stats
from scipy.stats import norm
import numpy as np
import scipy as sp
print(sp.stats.t.ppf(0.95,6))
print(norm.cdf([-1,0,1]))
print(norm.cdf(np.array([-1,0,1])))
print(norm.mean(), norm.std(), norm.var() )
print(norm.pdf(0))
print(norm.cdf(1.96))
print(norm.ppf(0.975))
print(norm.cdf(1))
print(norm.ppf(0.841344746090))
print(norm.sf(1-norm.cdf(1)))
print(norm.ppf(0.9))
print(stats.t.ppf(0.975,3))
print(stats.t.ppf(0.975,3))

```

## confidence level interval determinate

``` python
import numpy as np
import scipy as sp
import scipy.stats

b = [8*x**0 for x in range(200)] + np.random.normal(0, 0.05, (200))


def t_stastik(data, confidence):
    m, se = np.mean(data), sp.stats.sem(data)
    h = se*sp.stats.t.isf((1-confidence)/2. , df = (len(data)-1) )
    return m, m-h, m+h
print(" For given data sete we have their mean  with 95% confidence level of region :",t_stastik(b,0.95))

def mean_confidence_interval(data, confidence):
    m, se = np.mean(data), sp.stats.sem(data)
    h = se*sp.stats.t.ppf((1+confidence)/2.,len(data)-1)
    return m, m-h, m+h
print('For data the mean  can also  be calcaleted as at 95% confidence level is :', mean_confidence_interval(b, 0.95))


```

## a complete ploted distribution of confidence level on t mode

``` python
  import numpy as np
#  import seaborn as sns
  from scipy import stats
  import matplotlib.pyplot as plt

  np.random.seed(3)
  MU = 64
  sigma = 5
  size = 10
  heights = np.random.normal(MU, sigma,size)
  print("accoding to the mean and deviation we have a example of 10 rondom number : ", heights)

  mean_heights = np.mean(heights)
  deviation_heights = np.std(heights)
  SE = np.std(heights)/np.sqrt(size)

  print('99% confidence interval is :', stats.t.interval(0.99, df = size-1 , loc = mean_heights, scale=SE))
  print('90% confidence interval is :', stats.t.interval(0.90, df = size-1 , loc = mean_heights, scale=SE))
  print('80% confidence interval is :', stats.t.interval(0.80, df = size-1 , loc = mean_heights, scale=SE)) 

```

## a complete ploted distribution

``` python
import numpy as np

sample_size = 1000
heights = np.random.normal(MU, sigma, sample_size)
SE = np.std(heights)/np.sqrt(sample_size)
(l,u) = stats.norm.interval(0.95, loc = np.mean(heights), scale = SE)
print(l,u)
plt.hist(heights, bins = 20)
y_height = 5
plt.plot([l,u], [y_height, y_height], '_', color='r')
plt.plot(np.mean(heights), y_height, 'o', color= 'b')
plt.show()

```

## a complete ploted distribution on between region

``` python
x = np.linspace(-5,5,100)
y = stats.norm.pdf(x,0,1)
plt.plot(x,y)
plt.vlines(-1.96,0,1,colors='r',linestyles='dashed')
plt.vlines(1.96,0,1,colors='r',linestyles='dashed')
fill_x = np.linspace(-1.96,1.96,500)
fill_y = stats.norm.pdf(fill_x, 0,1)
plt.fill_between(fill_x,fill_y)
plt.show()

```

## a example from internet

``` python
import pandas as pd
from scipy import stats as ss
data_url = "https://raw.githubusercontent.com/alstat/Analysis-with-Programming/master/2014/Python/Numerical-Descriptions-of-the-Data/data.csv"
df = pd.read_csv(data_url)
print(df.describe())
import matplotlib.pyplot as plt
pd.options.display.mpl_style = 'default' 
plt.show(df.plot(kind = 'box'))

```

## 1 2 3 order and gauss fitting

``` python
import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize
from scipy.optimize import curve_fit


def f_1_degree(x,A,B):
    return A*x + B

def f_2_degree(x,A,B,C):
    return A*x**2 + B*x + C

def f_3_degree(x,A,B,C,D):
    return A*x**3 + B*x**2 + C*x + D


def f_gauss(x,A,B,sigma):
    return A*np.exp(-(x-B)**2/(2*sigma**2))

def plot_figure():
    plt.figure()

    x0 = [1,2,3,4,5]
    y0 = [1,3,8,18,36]

    #plot original data
    plt.scatter(x0,y0,25,"red")

    # plot f1
    params_1, pcovariance_1 = optimize.curve_fit(f_1_degree,x0,y0)

    params_f_1, pcovariance_f_1 = curve_fit(f_1_degree,x0,y0)
    x1 = np.arange(0,6,0.01)
    y1 = params_1[0]*x1+params_1[1]
    plt.plot(x1,y1,"blue")
    print("The liear fitting for date is : y = ",params_1[1],"*x + ",params_1[0])
    print("The params uncertainies are:")
    print("a =", params_1[0], "+/-", round(pcovariance_1[0,0]**0.5,3))
    print("b =", params_1[1], "+/-", round(pcovariance_1[1,1]**0.5,3))


    #plot f2
    params_2, pcovariance_2 = curve_fit(f_2_degree,x0,y0)
    x2 = np.arange(0,6,0.01)
    y2 = params_2[0]*x1**2+params_2[1]*x1 + params_2[2]
    plt.plot(x2,y2,"green")
    print("The second order curve fitting for date is : y = " ,params_2[2],"*x² + " ,params_2[1],"*x + ",params_2[0])
    print("The params uncertainies are:")
    print("a =", params_2[0], "+/-", round(pcovariance_2[0,0]**0.5,3))
    print("a =", params_2[0], "+/-", round(pcovariance_2[0,0]**0.5,3))
    print("b =", params_2[1], "+/-", round(pcovariance_2[1,1]**0.5,3))
    print("c =", params_2[2], "+/-", round(pcovariance_2[2,2]**0.5,3))

    #plot f3
    params_3, pcovariance_3 = curve_fit(f_3_degree,x0,y0)
    x3 = np.arange(0,6,0.01)
    y3 = params_3[0]*x1**3+params_3[1]*x1**2 + params_3[2]*x1 + params_3[3]
    plt.plot(x3,y3,"purple")
    print("The second order curve fitting for date is:y =",params_3[3],"*x³+",params_2[2],"*x² + " ,params_2[1],"*x + ",params_2[0])
    print("The params uncertainies are:")
    print("a =", params_3[0], "+/-", round(pcovariance_3[0,0]**0.5,3))
    print("b =", params_3[1], "+/-", round(pcovariance_3[1,1]**0.5,3))
    print("c =", params_3[2], "+/-", round(pcovariance_3[2,2]**0.5,3))
    print("d =", params_3[3], "+/-", round(pcovariance_3[3,3]**0.5,3))

    #plot gauss
    params_gauss, pcovariance_gauss = curve_fit(f_gauss,x0,y0)
    xgauss = np.arange(0,6,0.01)
    ygauss = params_gauss[0]*np.exp(-(xgauss-params_gauss[1])**2/(2*params_gauss[2]**2))
    plt.plot(xgauss,ygauss,"black")
    print("The gauss function curve fitting for date is : y = ",params_gauss[2],"*exp{-(x-",params_gauss[1],")²/(2*sigma²) +",params_gauss[0])
    print("The params uncertainies are:")
    print("a =", params_gauss[0], "+/-", round(pcovariance_gauss[0,0]**0.5,3))
    print("mean =", params_gauss[1], "+/-", round(pcovariance_gauss[1,1]**0.5,3))
    print("std =", params_gauss[2], "+/-", round(pcovariance_gauss[2,2]**0.5,3))



    plt.title("plot for different fittign")
    plt.xlabel("x")
    plt.ylabel("y")
    plt.show()
    return

plot_figure()


```

## linear fitting

``` python
# matplotlib inline
import matplotlib.pyplot as plt;
import numpy as np;
from scipy import integrate
from scipy.optimize import curve_fit
import math

#1. x axis coordinnat for 10 points data
xmin=0.01; xmax=2; pts = 10;
xx = np.linspace(xmin, xmax, pts);

#2. y axis coordinnat for 10 points data
rho = np.sqrt(1/xx) + 0.5*np.exp(xx)*xx**2;

#plot the original data
plt.plot(xx, rho, 'bo', label='Original data')

#3. x axis coordinnat for 200 points fitting
x_fine = np.linspace(xmin, xmax, 200);

#fiting
params, cov = np.polyfit(xx, rho, 1, cov=True)

#to reconstruct the linear function
bestfit_rho = params[0]*x_fine + params[1]
plt.plot(x_fine, bestfit_rho, 'r-', lw=2, label='One order of linear fit');

print(params)



```

## linear fitting with ployfit

``` python
# matplotlib inline
import matplotlib.pyplot as plt;
import numpy as np;
from scipy import integrate
from scipy.optimize import curve_fit
import math

#1. x axis coordinnat for 10 points data
xmin=0.01; xmax=2; pts = 10;
xx = np.linspace(xmin, xmax, pts);

#2. y axis coordinnat for 10 points data
rho = np.sqrt(1/xx) + 0.5*np.exp(xx)*xx**2;

#plot the original data
plt.plot(xx, rho, 'bo', label='Original data')

#3. x axis coordinnat for 200 points fitting
x_fine = np.linspace(xmin, xmax, 200);

#fiting  it can be any order 
params, cov = np.polyfit(xx, rho, 4, cov=True);
p = np.poly1d(params)
plt.plot(x_fine, p(x_fine), 'g-', lw=2, label='The Best poly1d fit');

print(params)
plt.xlabel('$x$');
plt.ylabel(r'$\rho$');
plt.legend(fontsize=13);
plt.show()


```

# High performance Data Analysis lecture

## concepts

High performance Data Analysis: with parallel processing to quickly find
the insights from extremely large data sets

## Chap01 overview

### Distributed System

1.  Definiation:

-   Components separate located
-   communicatation through passing massage between components

1.  Characteristics:

-   own memory
-   concurrency
-   locks

1.  Applcation:

-   cloud compuation
-   internet of Things

1.  Algorithm:

Consensus, Repication

1.  Challages:

-   Programm
-   resource sharing

### Levels of parallelism

Bit-level, Instruction level, Data level, Task level

### Name typical applications for high-performance data analytics

1.  weather forecast
2.  Simulating kernel fusion, tokamak reactor

### Distinguish HPDA from D/P/S computing and how these topics blend

Stricter than distributed system( strongly scalling: weak scalling)

### Describe use-cases and challenges in the domain of D/P/S computing

Recommendation engine

### Describe how the scientific method relies on D/P/S computing

Simulation models real systems to gain new insight Big Data Analytics
extracts insight from data

### Name big data challenges and the typical workflow

how to deal with big data(5Vs) Raw-\> Descriptive -\> Diagnostics -\>
Predictive -\> Prescriptive

### Recite system characteristics for distributed/parallel/computational science

### Sketch generic D/P system architectures

## Chap02 DataModels & Data Processing Strategies

### Define important terminology for data handling and data processing

Raw data, semantic normalization, Data management plan, Data life cycle,
data governance, data provenance...

### Sketch the ETL process used in data warehouses

extract from a source database, transform with controlling, error and
missing treatment, change the layout to fit loading, integrate them into
data warehouses for user

### Sketch a typical HPDA data analysis workflow

classical: discovery, integration, exploitation in high level, with SQL,
java, scala, Python, with parallelism for data Exploration

### Sketch the lambda architecture

Lambda architecture is a concept for enabling real-time processing and
batch methods together. batch layer(large scala) + serving layer speed
layer(read time)

### Construct suitable data models for a given use-case and discuss their pro/cons

### Define relevant semantics for data

### data models

Concurrency, Durability, Consensus,

-   relational model
-   Clumnar Model (combinded relational model)(HBase)
-   key-value model (BigTable)
-   Documents model (MongoDB)
-   Graph

## Chap03 Databases and DataWarehouses

### relatation model

1.  Cardinality

    -   one to one
    -   one to many
    -   many to many

2.  Normalization Form

    reduces dependencies, prevents inconsistency, save space

    -   1NF: no collections in row tuples
    -   2NF: no redundancy (entities of many-to-many relations are
        stored in separate tables)
    -   3NF: no dependence between columns
    -   4NF: no multiplie relationships in one table(not good for big
        data)

3.  group by

    it\'s done with Aggregatation(in sql or in python, both)

4.  join

    cross join: Cartesian product of two tables natural jon: all
    combinations that are equal on their common attributes inner join:
    only all condition satisfied left join: condition strict on left
    right join: condition strict on right full join

5.  Transactions

    ACID

### Define Database, DBMS, and Data Warehouse

-   an organized collection of data
-   software application for user to use the collected data
-   a system used for reporting and data analysis, with multidimensional
    data cube

### Create a relational model for a given problem

### Draw an ER(Entity Relational) diagram for a given relational model (and vice versa)

### Normalize a small relational model into a redundant-free model

### List the result of an inner join of two tables to resolve relationships

### Formulate SQL queries for a relational model

### Create a Star-Schema from a relational model (and formulate queries)

### Sketch the operations for an OLAP cube

-   Slice
-   Dice
-   Roll up
-   Pivot

### Appraise the pro/cons of OLAP vs. traditional relational model

Star-Schema: pro: simplification of query and performancd gain, emulates
OLAP cube start-Schema: cons: data integrity is not guaranteed, no
natural support of many to many relations,

### Describe DBMS optimizations: index, bulk loading, garbage cleaning

## Chap04 Distributed Storage and Processing with Hadoop

### hadoop

map: filter and convert all input into key-value tuples reduce: receives
all tuples with the same keys, accumulated

### Describe the architecture and features of Apache Hadoop

-   HDFS and MapReduce executation engine
-   High availability,
-   automatic recovery
-   Replication of data
-   Parallel file access
-   Hierarchical namespace
-   Rack-awareness

### Formulate simple algorithms using the MapReduce programming model

### Justify architectural decisions made in Apache Hadoop

### Sketch the execution phases of MapReduce and describe their behavior

1.  distributed code
2.  determine fiels
3.  map
4.  combine
5.  shuffle
6.  partition
7.  reduce
8.  output

### Describe limitations of Hadoop1 and the benefits of Hadoop2 with TEZ

-   Allow modelling and execution of data processing logic
-   Reconfigure dataflow graph based on data sizes and target load
-   Controlled by vertex management modules
-   Task and resource aware scheduling
-   Pre-launch and re-use containers and caching intermediate results
-   Everyone has to wait for the prozess between mapping and reducing

### Sketch the parallel file access performed by MapReduce jobs

## Chap05 Big Data SQL using Hive

### Compare the execution model of SQL in an RDBMS with Hive

-   Table: Like in relational databases with a schema
-   Partitions: table key determining the mapping to directories
-   Buckets/Clusters: Data of partitions are mapped into files

### Justify the features of the ORC format(Optimized Row Columnar)

-   Light-weight index stored within the file
-   Compression based on data type
-   Concurrent reads of the same file
-   Split files without scanning for markers
-   Support for adding/removal of fields
-   Partial support of table updates
-   Partial ACID support (if requested by users)

### Apply a bloom filter on example data

Identify if an element is a member of a set with n elements Allow false
positives but not false negatives

### Describe how tables are generally mapped to the file system hierarchy and optimizations

### Describe how data sampling can be optimizing via the mapping of tables on HDFS

### Sketch the mapping of a (simple) SQL query to a MapReduce job

## Chap06

### Create a Columnar Data Model (for HBase) for a given use case

### Justify the reasons and implications behind the HBase storage format

-   medium-size object,

-   stored by row key,

-   cell data is kept in store files on HDFS,

-   Encoding can optimize storage space

    -   row keys and date
    -   column family
    -   Reading data

### Describe how HBase interacts with Hive and Hadoop

### Describe the features and namespace handling in Zookeeper

### Create a Document Data Model (for MongDB) for a given use case

### Provide example data (JSON) for the MongoDB data model and the queries

### Sketch the mapping of keys to servers in MongoDB and HBase

### Select and justify a suitable shard key for a simple use case

## Chap07

### Define in-memory processing

Processing of data stored in memory

-   Data will fit in memory
-   Additional persistency is required
-   Fault-tolerance is mandatory

### Describe the basic data model of Apache Spark and the SQL extension

it based on RDDs, which are immutable tuples, (Resilient Distributed
Datasets) Computation is programmed by transformation, lazy evaluation,
all computaion is deferred until needed by actions

### Program a simple data flow algorithm using Spark RDDs

nums = sc.parallelize(arange(1,100000)) r1 = nums.filter(lambda x: (x%2)
== 1) r1 = r1.map(lambda x:(x, x\*\*2)) r1. = r1.reduce(lambda a,b :a \*
b)

### Sketch the architecture of Spark and the roles of its components

-   Transformation: map, filter, union, pipe, groupbykey, join
-   Actions: reduct, count, token, frist
-   Schuffle: repartation

### Describe the execution of a simple program on the Spark architecture

## Chap08

### Define stream processing and its basic concepts

Application for real-time continuous stream-computation for
high-velocity data Stream groupings defines how tuples are transferred

### Describe the parallel execution of a Storm topology

the graph of the calculation represented as network, the parallelism
(tasks) is statically defined for a topology

### Illustrate how the at-least-once processing semantics is achieved via tuple tracking

one tuple may be executed multiple time, and if error occurs, tuple
restarted from Spout

-   each tuple has a tuple ID
-   Acker tracks tuple ID with hashing map
-   Ack execute each step with XOR of all derived tuple ID, if it
    retures value 0, retart from Spout agin

### Describe alternatives for obtaining exactly-once semantics and their challenges

-   each tuple is executed exactly once,
-   provide idempotent operations
-   Execute tuples strongly ordered to avoid replicated execution
-   Use Storm's transactional topology(processing phase, commit
    phase\[stong ordering\])

### Sketch how a data flow could be parallelized and distributed across CPU nodes on an example

## Chap09

## Chap10

### List example problems for distributed systems

Reliable broadcast, Atomic commit, Consensus, Leader election,
Replication

### Sketch the algorithms for two-phase commit

Prepare phase, Commit phase

### consistent hashing

manage the key/value data in distributed system load balancing, and faul
tolerant

### Discuss semantics when designing distributed systems

Consistency(atomicity, visibility, isolation) Availability(Robustness,
Scalability, Partition) Durability

### Discuss limitations when designing distributed systems

CAP(Consistency, Available, Partition tolerance) can\'t meet together in
a DS

### Explain the meaning of the CAP-theorem

### Sketch the 3-tier architecture

Presentation, Application precessing, Data management

### Design systems using the RESTful architecture

Simplicity of the interface, Portability, Cachable, Tracable

### Describing relevant performance factors for HPDA

Time, cost, energie, Productivity

### Listing peak performance of relevant components

Computation, Communicatation, Input/Output devices

### Assessing /Judging observed application performance

-   Estimate the workload
-   Compute the workload throughout per node, W
-   Compute the Hardware capabilities P

E = W / P

## Chap11

### Sketching the visual analytics workflow

### Listing optical illusions

Color, Size&Shape, Moving,Interpretation of objects,

### Listing 5 goals of graphical displays

-   show the data
-   induce the viewer to think about the substance
-   present many numbers in a small space
-   make large data sets coherent
-   serve a reasonably clear purpose
-   be closely integrated with the statistical

### Discuss the 4 guidelines for designing graphics on examples

-   Use the right visualization for data types
-   Use building blocks for graphics (known plot styles)
-   Reduce information to the essential part to be communicated
-   Consistent use of building blocks and themes (retinal properties)

### Describe the challenges when analyzing data

-   large data volumes and velocities
-   complex system and storage topologies
-   understand the system behavior is difficult
-   data movement of memory and CPU is costly

### Discuss the benefit of in-situ and in-transit data analysis

-   in-situ: analyze results while the applications is still running
-   in-transit: analyze data while it is on the IO path
-   interact with application while it runs

## Chap12

### Sketch a typical I/O stack

### Develop a NetCDF data model for a given use case

### Compare the performance of different storage media

### Sketch application types and access patterns

### Justify the use for I/O benchmarks

Can use simple/understandable sequence of operations May use a pattern
like a realistic workloads Sometimes only possibility to understand
hardware capabilities

### Describe an I/O performance optimization technique

Read-ahead, write-behind, async-IO

### Describe a strategy for trustworthy benchmark result

single-shot: acceptance test periodically: regression test

## 03-01

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
drop table if exists WikipediaArticles ;
create table WikipediaArticles (
id int,
title varchar(50), 
text varchar(50),
category varchar(50),
link int
) ;
\d wikipediaarticles;
```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
drop table if exists linkarticles ;
    create table linkarticles (
    id int,
    linked int
 ) ;
```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
delete from wikipediaarticles where id = 1;
insert into WikipediaArticles (id, title, text, category, link) values (1, 'math', 'mathematics and nature and nature', 'nature', 1) ;
delete from wikipediaarticles where id = 2;
insert into WikipediaArticles (id, title, text, category, link) values (2, 'phy', 'physics', 'nature', 2) ;
delete from wikipediaarticles where id = 3;
insert into WikipediaArticles (id, title, text, category, link) values (3, 'chemie', 'chemistry', 'science', 3) ;
delete from wikipediaarticles where id = 4;
insert into WikipediaArticles (id, title, text, category, link) values (4, 'bio', 'biology', 'science', 4) ;
select * from wikipediaarticles ;
```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
delete from linkarticles where id = 1;
insert into Linkarticles (id, linked) values (1, 2) ;
insert into Linkarticles (id, linked) values (1, 3) ;
delete from linkarticles where id = 2;
insert into Linkarticles (id, linked) values (2, 3) ;
delete from linkarticles where id = 3;
insert into Linkarticles (id, linked) values (3, 4) ;
delete from linkarticles where id = 4;
insert into Linkarticles (id, linked) values (4, 1) ;
select * from linkarticles ;
```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
select * from wikipediaarticles where title = 'phy';
```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
select * from wikipediaarticles where id in
 (select linked from linkarticles where id in
  (select id from wikipediaarticles where title = 'math')
);

```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
select count(*) , linked from linkarticles group by linked;
```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
select unnest(string_to_array('this is is is a test', ' '))
```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
select id,  unnest(string_to_array(text , ' ')) as word, count(*) from WikipediaArticles group by id, word
```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
select * from wikipediaarticles where category = 'science';
```

## 03-02

``` {.dot file="./foto/hpdas03-02.png"}
digraph diagramm {
  WikipediaArticles  -> id
  WikipediaArticles  -> Title
  WikipediaArticles  -> Text
  WikipediaArticles  -> Category
  WikipediaArticles  -> Links
  Links  -> linkarticles
  linkarticles -> lid
  linkarticles -> linked
}

```

## 04-01

### mapper and reducer in own

``` python
def mapper(key, value):
  words = key.split()
  for word in words:
    Wmr.emit(word, 1)

def mapper(key, value):
  words = key.split()
  for word in words:
    Wmr.emit("s", stem(word), 1)
  for word in words:
    Wmr.emit("l", lemmatize(word), 1)


def reducer(key, values):
  count = 0
  for value in values:
    count += int(value)
    Wmr.emit(key, count)

```

### sql

``` {.bash org-language="sh"}
cat ~/Documents/hpda0404.csv 
```

``` {.sql engine="postgresql" dbhost="localhost" dbuser="postgres" dbpassword="du" database="postgres" dbport="5432"}
drop table if exists hpda0401 ;

create table hpda0401 (
num int,
germany varchar(10),
english varchar(10),
chinese varchar(10),
listed int
) ;

insert into hpda0401 (num, germany, english, chinese, listed) values (1, 'eins', 'one','一', 1);
insert into hpda0401 (num, germany, english, chinese, listed) values (2, 'zwei', 'two','二', 1);
insert into hpda0401 (num, germany, english, chinese, listed) values (3, 'drei', 'three','三', 2);
insert into hpda0401 (num, germany, english, chinese, listed) values (6, 'sechs', 'six','六', 2);

select germany from hpda0401 where  germany = 'zwei';

select listed, sum(num) as mysum from hpda0401 group by listed;
```

### select

``` {.python results="output"}
import csv
from functools import reduce
path = "/home/si/Documents/hpda0404.csv"
data = []
with open(path) as f:
    records = csv.DictReader(f)
    for row in records:
        data.append(row)
    print(data)


mapiter = map(lambda x: x["germany"], data)
maplist = [ele for ele in mapiter]
print(maplist)    

filteriter = filter(lambda x: x=="zwei", maplist)
filterlist = [ele for ele in filteriter]
print("select germany WHERE germany == zwei :", filterlist)

```

### summation

``` {.python results="output"}
import csv
from functools import reduce
path = "/home/si/Documents/hpda0404.csv"
data = []
with open(path) as f:
    records = csv.DictReader(f)
    for row in records:
        data.append(row)
    print(data)


iters = map(lambda x: x["listed"], data)
iterslist = [ele for ele in iters]
iterset = set(iterslist)
print("grouped by ", iterset)

dic = {}
for i in iterset:
    temp = []
    for d in data:
        for (j, n) in [b for b in map(lambda x: (x["listed"],x["num"]), [d])]:
            if i == j:
                temp.append(int(n))
    reduer = reduce(lambda x, y:x+y, temp)
    dic[i]= reduer

print("sum (num) GROUP) BY listed : ", dic)
```

### join {#join-1}

``` {.bash org-language="sh"}
cat ~/Documents/hpda0404a.csv 
cat ~/Documents/hpda0404b.csv
```

``` {.python results="output"}
import csv
from functools import reduce
path1 = "/home/si/Documents/hpda0404a.csv"
path2 = "/home/si/Documents/hpda0404b.csv"
data1 = []
with open(path1) as f:
    records = csv.DictReader(f)
    for row in records:
        data1.append(row)
    print(data1)

data2 = []
with open(path2) as f:
    records = csv.DictReader(f)
    for row in records:
        data2.append(row)
    print(data2)    


for a in data1:
    aid = [y for y in map(lambda x: x["id"], [a])]
    for b in data2:
        bid = [y for y in map(lambda x: x["id"], [b])]
        if aid == bid:
            (af1, bf2) = ([y for y in map(lambda x: x["germany"], [a])], [y for y in map(lambda x: x["fan"], [b])])
            print(af1, bf2)

```

## 04-02

### 2.1

``` {.python results="output"}
from nltk.stem.snowball import SnowballStemmer
from nltk.stem import WordNetLemmatizer

stemmer = SnowballStemmer("english")
lemmatizer = WordNetLemmatizer()

file = "/home/si/Documents/hpda0402wordscount.txt"
sdict = {}
ldict = {}
with open(file, "r") as data:
    datas = data.read()
    words = datas.split(' ')
    for word in words:
        sword = stemmer.stem(word)
        lword = lemmatizer.lemmatize(word)
        if sword in sdict:
            sdict[sword] += 1
        else:
            sdict[sword] = 1

        if lword in ldict:
            ldict[lword] += 1
        else:
            ldict[lword] = 1

    print("---------sdict----------------------")
    for (item, key) in sdict.items():
          print(item, key)

    print("---------ldict----------------------")
    for (item, key) in sdict.items():
        print(item, key)


```

### 2.2

### 2.3

see in Document folder

### 2.4

mapper

``` python
import sys
for line in sys.stdin:
  words = line.strip().split(" ")
    for word in words:
    print(word + "\t" + "1")

```

reducer

``` python
import sys

oldword = ""
count = 0
for line in sys.stdin:
    (word, c) = line.strip().split("\t")
    if word != oldword:
        if count != 0:
            print(oldword +"\t"+ str(count))
        count = 0
        oldword = word
    count = count + int(c)
if oldword != "":
    print(oldword +"\t%d" %(count))
```

``` shell
cd /home/hadoop/hadoop-3-3.1/sbin
./start-dfs.sh
./start-yarn.sh
jps
```

word count example

``` {.bash org-language="sh"}
hdfs daf -put /home/si/Documents/hpda/hpda04-2.3.txt /
hadoop fs -rm -r /hpda04-2.3-output/
hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.1.jar wordcount /hpda04-2.3.txt /hpda04-2.3-output/
hadoop fs -cat /hpda04-2.3-output/part-r-00000
cd output
hadoop fs -getmerge /hpda04-2.3-output/ out
```

With errors

``` shell
yarn jar share/hadoop/tools/lib/hadoop-streaming-3.3.1.jar -Dmapred.reduce.tasks=1 -Dmapred.map.tasks=11 --mapper /home/si/Documents/hpda/04/mapper.py -reducer /home/si/Documents/hpda/04/reducer.py -input /hpda04-2.3.txt --output /hpda04-2.3-output/
```

## 05

``` {.python results="output"}
import csv

class dataflow:
    def __init__(self):
        self.data = []

    def read(filename):
        d = dataflow()
        with open(filename, newline='') as csvfile:
            spamreader = csv.reader(csvfile)
            for row in spamreader:
                d.data.append(row)
        return d

    def map(self, func):
        d = dataflow()
        for x in self.data:
            d.data.append(func(x))
        return d

    def filter(self, func):
        d = dataflow()
        for x in self.data:
            if func(x):
                d.data.append(x)
        return d

    def write(self, filename):
        d = dataflow()
        with open(filename, 'w', newline='') as csvfile:
            spamwriter = csv.writer(csvfile, quoting=csv.QUOTE_MINIMAL)
            for d in self.data:
                spamwriter.writerow(d)
        return d
    def __str__(self):
        return str(self.data)


d = dataflow.read("/home/si/Documents/hpda/05/file.csv")
print(d)
flat = d.map(lambda t: (t[0], eval(t[3])))
bd = flat.filter(lambda t: "HPDA" in t[1])
bd.write("/home/si/Documents/hpda/05/out.csv")

```

## 06

MongoDB

``` {.mongo db="testdatabase"}
show dbs
```

``` {.mongo db="testdatabase"}
use testdatabase
db.getCollectionNames()
```

``` {.mongo db="testdatabase"}
use testdatabase;
db.wiki.drop();
db.createCollection("wiki");
show collections;
```

``` {.mongo db="testdatabase"}
use testdatabase;
db.wiki.insert({_id:1, "person":"Gauss","Beruf":"Mathematiker" })
db.wiki.find()
```

``` {.mongo db="testdatabase"}
use testdatabase;
db.wiki.update({"person":"Gauss"},{"Beruf": "Mathematiker Physiker" })
db.wiki.find()
```

``` {.mongo db="testdatabase"}
use testdatabase;
db.wiki.update({"person":"Gauss"}, {"Beruf": "Mathematiker Physiker", "Wohnsite": "Göttingen Hannover"})
db.wiki.find()
```

``` {.mongo db="testdatabase"}
use testdatabase;
db.wiki.drop()
```

# Paralle compuation lecture

## performance

### Andel\'s law:

$$ S_{total} = \frac{1}{1-p+\frac{p}{s}} $$
$$S = \frac{s}{1-P_{B}-P_{D} + \frac{P_{B}}{N_{B}} + \frac{P_{D}}{N_{D}}} $$

### if the task is changed, Gostafan\'s law,

$$ s_{g} = \frac{T_{s} + p T_{p}}{T_{s} + T_{p}} $$

$$ S = \frac{s_g}{(s_g - P_p) + \frac{P_p}{N_p}}$$

all $P_{p}$ is changed task, such as 70% task doubled, will be 1.4

### Effectivy:

$$ E = \frac{S}{P}$$

$$ S = \frac{T_{s}}{T_{p}} = \frac{n}{\frac{n}{p}+ \log_{2} p}$$

## Chap1: introduction

### Von Nroven

cpu, interconnection, memory

### memory mode

shared memory distributed memory

### shared memory

easy to build ,hard to large scare

### distribution memory

## Chap 2: Proformance

CPI: cycles per instruction MIPS: Million Instructions per second FLOPS:
Floating Point Operation per second

Benchmark idle

Does this also mean in a hundred percent parallel code , the speed up is
proportional to the number of threads?

-   Yes

fashion inductive

$$T_{serial}$$: The Time for task which can\'t be parallelized.
$$T_{parallel}$$: The Time for task which can be parallelized. $$p$$:
number of processes $$P$$: Precent of Task, which can be parallelized

### single Process:

$$T_{parallel} = \frac{T_{serial}}{p}$$ speedup:
$$S = \frac{T_{serial}}{T_{parallel}}$$. if the parallelized part are
perfect parallelable, $S==p$.

### Multi processes

$$T_{parallel} = (1-P)T_{serial} +  \frac{P \cdot T_{serial}}{p}$$

speedup:
$$S = \frac{T_{serial}}{T_{parallel}} = \frac{1}{(1-P)+ \frac{P}{p}}$$.
$$S = \lim_{p -> \infty}\frac{1}{(1-P)+ \frac{P}{p}} = \frac{1}{1-P}$$

### Efficient

$$E = \frac{S}{p}$$

### Adaes-low

### Gustafon low

$$ S_{p} = \frac{T_{serial} -p T_{paralle}}{T_{seria} + T_{parallel}}$$

# Cloud computation lecture

## Platform Virtualization

### Defination of Virtualization

the processes of creating software-based version of resources.

### The reasons for applying virtualization

-   **Utilization**: Server consolidation
-   **Isolation**: Implication of errors is restricted in virtual
    resource only
-   **Flexiblity**: many Application access the same physical Hardware
-   **On-demand**: virtual resource is created/destoryed on request
-   **Migration**: Fault tolerance, live update, optimization of
    performance
-   New reaserch:new OS new technology
-   Encapsulation: current stats can be saved copied and loaded
-   Minimal downtime
-   Fast provisioning

### Full virtualization (Hypervisor system, Bare matal)

-   Translation of instructions
-   implantation: Virtual Box
-   Hypervisor receive the IO from application,and translate to HW
-   Hypervisor translate the request from Guest OS to HW
-   no need special HW support
-   no need modified OS

### Hardware-assisted virtualization (Hypervisor system, Bare matal)

-   implantation: VMware Workstation
-   can install many virtual machine
-   need special HW support
-   no need modified OS

### Para virtualization (Hypervisor system, Bare matal)

-   VM(modified OS) runs on Host

-   Host on hypervisor

-   implantation: linux kernel

-   need modified OS

-   need Host OS level on hypervisor

### Host OS virtualization (Hypervisor system, Hosted)

-   Guest OS on Hypervisor
-   Hypervisor on Host OS
-   Host on HW

```{=html}
<!-- -->
```
-   no need modified OS
-   need Hypervisor on Host OS
-   inter VM communication is difficult

### OS-level virtualization (Container system)

-   no hypervisor
-   multiple useer instances(light-weight) run on a host OS
-   implantation: Docker

### Memory virtualization

-   shadow page table on Guest OS
-   Extended Page table in Host

### Network virtualization

hypervisor provide virtual switch, offering every VM a ip address

### Feathers

  ----------------------
  Encapsulation
  solation
  Hardware abstraction
  Migration
  Partation
  ----------------------

## Kubernetes

Container-Orchestration System

-   Cluster
-   Control Plane
-   Workload:application on Kubernetes
-   Pod: many containers share the same volume
-   Deployment
-   Service

## Virtual Machine

-   Partition
-   Isolation
-   Encapsulation
-   Hardware abstraction
-   Live Migration

## Storage Virtualization

### SSD advantage and disadvanage over HDD

-   Reliablity

-   Fast

-   small Size

-   More expensive

-   less Space

### Storage virtualization advantage

-   Faster access: because you can have multiple data sources for the
    same data
-   Independence of logic storage resources
-   improvement of management: Moving data easy, in multiple localaction
-   High reliablity: because of Redundancy
-   High effience: Replication and Duplication
-   compression, compaction
-   increasing volume if needed

### Provisioning:

-   allocate disk space to user on demand
-   give a mount of Storage, but not really allocated so much

### Deduplication

Single instance Storage: if the hash value of a datablock is the same
with one we already stored, dann save its link

-   checksum with hash value

### Compression:

compacting the data so that it comsumes less space

### Cloning

Consuming no storage except what is required for metadata until changes
are written to the copy

### Snapshotting Copies

a read-only, point-in-time image of a volume

### increasing the proformance

with more physical disks at the same time

## Modern Datacenters

### automation

-   scaling

-   Inreases Repeatablity

-   Make processes Faster

-   imporve Reliablity

-   disadvanage Additional Complexity illusion of Stability

### Idempotent

the same code generate the same result, without any change

### Infrastructure as code

-   Benefits:
    -   Repeatablity
    -   Agility
    -   Disaster Recovery
    -   fast deploy
    -   live upgrade
-   Imperative:describe the stes to get to desired state
-   Declarative: describe the desired state

### Foreman:

give the initial configuration to run an OS

### Puppet

-   Declarative description of resource states
-   Client / server Architecture
-   Security throgh cettificate
-   OS abstraction

## Monitor

### challange

collecte data from large mount of servers Watch out the overhitting

### Real time monitoring

-   Availability Monitoring: altering of failure
-   Capacity Monitoring: detect outages of resource

### Historical Monitoring

-   Long-term information
-   Trend analysis
-   Capacity planning

### Architecture

-   Measurement: Blackbox, Whitebot,Gauges, Conntes
-   Collection: push, pull
-   Analysis: real time, short term, long term, Anomaly detection with
    AI
-   Alerting:
-   Virtualization

## Cloud Computing Concepts

### Cloud Defination

    Cloud Computing is a model for enabling on-demand network
    access to a shared pool of configurable computing resource
    (network, server, storage, application, service) that can
    be rapidly provisioned and released with minimal management
    effort or service provider interaction

### SOA

Servive Oriented Architecture SOA has become a core concept of service
computing and provides the fundamental technologies for realizing
service computing

### Advantage

-   No captial costs
-   High scalability
-   Highh Flexiblity

### Network design

Different: SDN: software define Network New architectures have a
detached control plane instead of heavy logic switching/routing in
hardware

-   hardware independent
-   better shaping and Qos(Quit of service)
-   Data Center Briding for local and remote network

### GWDG feathers

-   self service front-end
-   SSH authenticate
-   snapshotting
-   using Openstack

### Infrastructure as Service

1.  Different deployment methode

      -----------------
      Private Cloud
      community Cloud
      public Cloud
      Hybird Cloud
      -----------------

2.  Storage

    CDMI: Cloud Data Management Interface File, Block Devices, Object
    Stores, Database Store example: AWS S3

3.  Network

4.  advantage

    -   quick implement of new project
    -   Flexiblity and scalability
    -   no hardware costs
    -   pay only what you need

5.  disadvantage

    -   complicated to change provider
    -   dependency on provider
    -   internet access is essential

### Platform as a Service

-   Rapid Time-to-Market
-   Minimal Development
-   Reduced Pressure on internal resources

### Software as a Service

based on IaaS, fouce on Applications

## Web services

### Benefits

-   Programmable access
-   Distribution over internet
-   Encapsulation of discrete functionality
-   can offer stardartized Interface
    -   TCP/IP prokotoll
    -   HTTP based

### SOAP

Simple Object Access Protocol xml based RPC based

### WSDL

Web Services Description Language xml based

### REST

-   Everything is resource

-   Every resource is identified by a unique Identifier

-   Using simple and uniform interface

-   Communication is done by representation

-   be stateless

-   more flexiblity

-   less redundancy, raw message based

-   URI and URL

### API

Application Programming Interface

## Big Data Service

### feathers

-   Volume: Scale of data
-   Velocity : spend of transfer data
-   Variety: Different form of data
-   Veracity: Uncertainty of data

### processes

-   Acquisition, Recording
-   Extraction, Cleaning, Annotation
-   Integration, Representation
-   Analysis, Modeling
-   Interpretation, Virtualization

### Challenges

-   Heterogeneity, Incompleteness
-   Scale
-   Timeliness
-   Privacy

## Mapreduce

  ----------- ------------------------------------------------------------
  map         map the data into key-value-pairs according to our problem
  reduce      key-value-pairs get accumlated
  shuffling   
  ----------- ------------------------------------------------------------

## Large Scale Data Analysis

### batch process

disadvanage: views generated in batch may out of date

### steaming process

disadvanage: expensive and complex

### Stream Computation Platform

-   Apache Storm
-   Spark Streaming
-   Apache Flink
-   Heron

### Hadoop

### HDFS

Namenode vs DataNodes

### YARN

Resource Manager vs NodeManager

### Apache Kafka

-   Fast, efficient IO
-   Fault tolerant storage
-   Publish and Subscribe to steams of records

### Data management cycle

-   Data
-   Meta-data
-   PID
-   Search
-   Disposition

## Data Grid Data Management

### Data Lake

A data lake is a data storage, where raw data can be stored, whos
structure is determined at the extraction from the lake

1.  Challenges

    -   Reliablity
    -   Slow Performance
    -   Lack of security

2.  Zones

    -   Transient
    -   raw
    -   trusted
    -   refined

### ETL

Extract transform load

### Storage data in Multiable locations

Redundancy for high-availability because of server falied and fast
access of data

### Storage data in remote data center

it is harder to acidentally delete something, such as because of
disaster.

### code storage

ssd

### fair data management

Find-able Accessable Interoperable Reproducible

## ITIL &SLA

### non functional service

organizational Operation of server server quality like availability
usability

server value value co-creation IT service Management IT service Provider

### ITIL Information Technology Infrastructure Library

a framework of best practices of IT service management and delivering

1.  service value system SVS

    1.  Guiding principles

        -   focus on value
        -   start where you are
        -   progress iteratively with feedback
        -   collaborate and promote visibility
        -   think and work holistically
        -   keep in simple and practical
        -   optimize and automate

    2.  Service Value Chain

        -   plan
        -   improve
        -   engage
        -   design
        -   transition
        -   obtain
        -   deliver

    3.  ITIL Practices

2.  the four dimensions model

    Organization&People Information & Technology Value streams&Processes
    Partners&suppliers

### SLA Service Level Agreement Life cycle

-   Development
-   Negotiation
-   Implementation
-   Execution
-   Assessment
-   Termination

### SLA components include

-   Parties, terms, conditions
-   service defination include costs
-   Performance parameters
-   what is measured, how and when(monitoring)
-   what is done to in case a SLA is voilated

## Security

### Confidentiality

The ability to hide the information from the unauthorized people

### Integrity

The ability to ensure that data are unchanged and remain a correct
representation of original data

### Availablity

data is available to authorized people

### Asymmetric Encrytion RSA

    Meassage: M
    Content: N
    Ciphertext: C
    Public key: E
    Encryption: E(x)
    private key: D
    Decryption: D(x)

    RSA Algorithm
    1. Select two prime number, p[13] and q[17]
    2. Generate Algorithm content N[221]: N = q*p
    3. calcalete the Eular function [192]: $\varphi(N)=(p-1)*(q-1)$
    4. Rondomly generate public key e[5]: and e is relatively prime with $\varphi(N)$
    5. calcalete the private key d[77]: so that $e*d =1$  mod $\varphi(N)$
    6. pack Public key E = (n, e) and publish to someone
    7. save Private key D =(n, d) 

    Someone want to some me Mesaage M: [12]
    Encryption: $C = M^{e}$ mod n  [207]
    send C [207] to me 

    I do the Decryption
    Message M: $M=C^{d}$ mod n  [207**77%221]
    get the Mesaage [12]

### security benefits

-   Integrity
-   authentify the sender
-   non deniable for message

### symmetric encryption

-   challange of key exchange
-   en/decryption with the same key

### asymmetic encryption

-   en/decryption need more resource
-   safe key exchange

### Digital Signiture

It\'s a certificate to identify the sender of message

### how Certificate is trusted

OS deliver a list of already trusted accepted CAs, it\'s preconfigured

### Authentication

verifies you are who you say you are

### Authorization

verifies if you have the permission to access data

### Confusion and Diffusion

confusion is to create faint ciphertexts in crytoprahic Diffusion, if
one place of plain text the modified, many places can be modified
