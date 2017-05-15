# MVVMDemo
MVVM在iOS应用的Demo，主要通过经典的TableView来演示

MVVM来自[微软](https://msdn.microsoft.com/en-us/library/hh848246.aspx)，是一个相当不错的架构模式。

首先了解一下MVVM的架构

![MVVM](http://teehanlax.com.s3.amazonaws.com/wordpress/wp-content/uploads/mvvm1.png)

### MVVMDemo的架构

![](http://github.com/zhanglin382847657/MVVM-Reactive-Cocoa/edit/master/MVVMDemo-master/github_mvvmdemo1.png?imageMogr2/thumbnail/!50p)

**Model**:  数据的模型

**View**:  其实包括View和ViewController两部分，统称为View

**ViewModel**:  本Demo，主要是处理网络请求，把获取的数据显示在TableView上

另外

**TableViewProtocol**:  为了避免ViewController太重，我把TableView的DataSource和Delegate分离出来

### MVVMDemo的效果预览

![img{w375}](https://github.com/zhang382847657/MVVM-Reactive-Cocoa/raw/master/tableview_demo.png)

