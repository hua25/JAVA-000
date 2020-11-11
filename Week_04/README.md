# 学习笔记

## 线程池

- Executor: 执行者 - 顶层接口
- ExecutorService: 接口API
- ThreadFactory: 线程工厂
- Executors: 工具类

### Executor - 执行者

### ExecutorService

### ThreadFactory

### 线程池参数

#### 缓冲队列

BlockingQueue 是双缓冲队列。BlockingQueue 内部使用两条队列，允许两个线程同 时向队列一个存储，一个取出操作。在保证并发安全的同时，提高了队列的存取效率。

- ArrayBlockingQueue:规定大小的 BlockingQueue，其构造必须指定大小。其所含 的对象是 FIFO 顺序排序的。
- LinkedBlockingQueue:大小不固定的 BlockingQueue，若其构造时指定大小，生成的 BlockingQueue 有大小限制，不指定大小，其大小由 Integer.MAX_VALUE 来决定。其所含的对象是 FIFO 顺序排序的。
- PriorityBlockingQueue:类似于 LinkedBlockingQueue，但是其所含对象的排序不是 FIFO，而是依据对象的自然顺序或者构造函数的 Comparator 决定。
- SynchronizedQueue:特殊的 BlockingQueue，对其的操作必须是放和取交替完成。

#### 拒绝策略

- ThreadPoolExecutor.AbortPolicy:丢弃任务并抛出 RejectedExecutionException 异常。
- ThreadPoolExecutor.DiscardPolicy:丢弃任务，但是不抛出异常。
- ThreadPoolExecutor.DiscardOldestPolicy:丢弃队列最前面的任务，然后重新提 交被拒绝的任务
- ThreadPoolExecutor.CallerRunsPolicy:由调用线程(提交任务的线程)处理该任务

#### 创建线程池的方法

- newSingleThreadExecutor

> 创建一个单线程的线程池。这个线程池只有一个线程在工作，也就是相当于单线程串行执行所有任 务。如果这个唯一的线程因为异常结束，那么会有一个新的线程来替代它。此线程池保证所有任务 的执行顺序按照任务的提交顺序执行。

- newFixedThreadPool

> 创建固定大小的线程池。每次提交一个任务就创建一个线程，直到线程达到线程池的最大大小。线 程池的大小一旦达到最大值就会保持不变，如果某个线程因为执行异常而结束，那么线程池会补充 一个新线程。

- newCachedThreadPool

> 创建一个可缓存的线程池。如果线程池的大小超过了处理任务所需要的线程，
那么就会回收部分空闲(60秒不执行任务)的线程，当任务数增加时，此线程池又可以智能的添 加新线程来处理任务。此线程池不会对线程池大小做限制，线程池大小完全依赖于操作系统(或者 说JVM)能够创建的最大线程大小。

- newScheduledThreadPool

> 创建一个大小无限的线程池。此线程池支持定时以及周期性执行任务的需求。

#### 创建固定线程池的经验

不是越大越好，太小也不好：
假设CPU核心数为N

- 如果是CPU密集型的应用，则线程池大小设置为N或者N+1
- 如果是IO密集型应用，这线程池设置为2N或2N+2