## 1. 文件描述符优化

服务器出现了 **==too many open file==** 错误

则需要修改文件句柄大小

#### 1). 查看文件描述符

```sh
$ cat /proc/sys/fs/file-nr
1984    0       3247755
# 第一列：为已分配的FD数量
# 第二列：为已分配但尚未使用的FD数量
# 第三列：为系统可用的最大FD数量
```

#### 2). 查看当前文件描述符总量

```sh
$ ulimit -n
100001
```

#### 3). 临时更改文件描述符总量

```sh
ulimit -n 10240
```



#### 4). 永久更改文件描述符总量

```sh
$ vim /etc/security/limits.conf

*　　soft　　nofile　　65536
*　　hard　　nofile　　65536
```

# 2. sysctl.conf优化

```sh
#最大的待发送TCP数据缓冲区空间 
net.inet.tcp.sendspace=65536 

#最大的接受TCP缓冲区空间 
net.inet.tcp.recvspace=65536 

#最大的接受UDP缓冲区大小 
net.inet.udp.sendspace=65535 

#最大的发送UDP数据缓冲区大小 
net.inet.udp.maxdgram=65535 

#本地套接字连接的数据发送空间 
net.local.stream.sendspace=65535 

#加快网络性能的协议 
net.inet.tcp.rfc1323=1 
net.inet.tcp.rfc1644=1 
net.inet.tcp.rfc3042=1 
net.inet.tcp.rfc3390=1 

#最大的套接字缓冲区 
kern.ipc.maxsockbuf=2097152 

#系统中允许的最多文件数量 
kern.maxfiles=65536 

#每个进程能够同时打开的最大文件数量 
kern.maxfilesperproc=32768 

#当一台计算机发起TCP连接请求时，系统会回应ACK应答数据包。该选项设置是否延迟ACK应答数据包，把它和包含数据的数据包一起发送，在高速网络和低负载的情况下会略微提高性能，但在网络连接较差的时候，对方计算机得不到应答会持续发起连接请求，反而会降低性能。 
net.inet.tcp.delayed_ack=0 

#屏蔽ICMP重定向功能 
net.inet.icmp.drop_redirect=1 
net.inet.icmp.log_redirect=1 
net.inet.ip.redirect=0 
net.inet6.ip6.redirect=0 

#防止ICMP广播风暴 
net.inet.icmp.bmcastecho=0 
net.inet.icmp.maskrepl=0 

#限制系统发送ICMP速率 
net.inet.icmp.icmplim=100 

#安全参数，编译内核的时候加了options TCP_DROP_SYNFIN才可以用 
net.inet.icmp.icmplim_output=0 
net.inet.tcp.drop_synfin=1 

#设置为1会帮助系统清除没有正常断开的TCP连接，这增加了一些网络带宽的使用，但是一些死掉的连接最终能被识别并清除。死的TCP连接是被拨号用户存取的系统的一个特别的问题，因为用户经常断开modem而不正确的关闭活动的连接 
net.inet.tcp.always_keepalive=1 

#若看到net.inet.ip.intr_queue_drops这个在增加，就要调大net.inet.ip.intr_queue_maxlen，为0最好 
net.inet.ip.intr_queue_maxlen=1000 

#防止DOS攻击，默认为30000 
net.inet.tcp.msl=7500 

#接收到一个已经关闭的端口发来的所有包，直接drop，如果设置为1则是只针对TCP包 
net.inet.tcp.blackhole=2 

#接收到一个已经关闭的端口发来的所有UDP包直接drop 
net.inet.udp.blackhole=1 

#为网络数据连接时提供缓冲 
net.inet.tcp.inflight.enable=1 

#如果打开的话每个目标地址一次转发成功以后它的数据都将被记录进路由表和arp数据表，节约路由的计算时间,但会需要大量的内核内存空间来保存路由表 
net.inet.ip.fastforwarding=0 

#kernel编译打开options POLLING功能，高负载情况下使用低负载不推荐SMP不能和polling一起用 
#kern.polling.enable=1 

#并发连接数，默认为128，推荐在1024-4096之间，数字越大占用内存也越大 
kern.ipc.somaxconn=32768 

#禁止用户查看其他用户的进程 
security.bsd.see_other_uids=0 

#设置kernel安全级别 
kern.securelevel=0 

#记录下任何TCP连接 
net.inet.tcp.log_in_vain=1 

#记录下任何UDP连接 
net.inet.udp.log_in_vain=1 

#防止不正确的udp包的攻击 
net.inet.udp.checksum=1 

#防止DOS攻击 
net.inet.tcp.syncookies=1 

#仅为线程提供物理内存支持，需要256兆以上内存 
kern.ipc.shm_use_phys=1 

# 线程可使用的最大共享内存 
kern.ipc.shmmax=67108864 

# 最大线程数量 
kern.ipc.shmall=32768 

# 程序崩溃时不记录 
kern.coredump=0 

# lo本地数据流接收和发送空间 
net.local.stream.recvspace=65536 
net.local.dgram.maxdgram=16384 
net.local.dgram.recvspace=65536 

# 数据包数据段大小，ADSL为1452。 
net.inet.tcp.mssdflt=1460 

# 为网络数据连接时提供缓冲 
net.inet.tcp.inflight_enable=1 

# 数据包数据段最小值，ADSL为1452 
net.inet.tcp.minmss=1460 

# 本地数据最大数量 
net.inet.raw.maxdgram=65536 

# 本地数据流接收空间 
net.inet.raw.recvspace=65536 

#ipfw防火墙动态规则数量，默认为4096，增大该值可以防止某些病毒发送大量TCP连接，导致不能建立正常连接 
net.inet.ip.fw.dyn_max=65535 

#设置ipf防火墙TCP连接空闲保留时间，默认8640000（120小时） 
net.inet.ipf.fr_tcpidletimeout=864000



#默认的接收TCP窗口大小

net.core.rmem_default = 256960



＃最大的TCP数据接收缓冲 
net.core.rmem_max = 256960



#默认的发送TCP窗口大小 
net.core.wmem_default = 256960



#最大的TCP数据发送缓冲
net.core.wmem_max = 256960



#以一种比重发超时更精确的方法（请参阅 RFC 1323）来启用对 RTT 的计算；为了实现更好的性能应该启用这个选项 
net.ipv4.tcp_timestamps = 0



#启用有选择的应答（Selective Acknowledgment），这可以通过有选择地应答乱序接收到的报文来提高性能（这样可以让发送者只发送丢失的报文段）；（对于广域网通信来说）这个选项应该启用，但是这会增加对 CPU 的占用。 
net.ipv4.tcp_sack =1



＃启用转发应答（Forward Acknowledgment），这可以进行有选择应答（SACK）从而减少拥塞情况的发生；这个选项也应该启用。

net.ipv4.tcp_fack =1



#支持更大的TCP窗口. 如果TCP窗口最大超过65535(64K), 必须设置该数值为1 
net.ipv4.tcp_window_scaling = 1



#确定 TCP 栈应该如何反映内存使用；每个值的单位都是内存页（通常是 4KB）。第一个值是内存使用的下限。第二个值是内存压力模式开始对缓冲区使用应用压力的上限。第三个值是内存上限。在这个层次上可以将报文丢弃，从而减少对内存的使用。

net.ipv4.tcp_mem= 24576 32768 49152



#为自动调优定义每个 socket 使用的内存。第一个值是为socket 的发送缓冲区分配的最少字节数。第二个值是默认值（该值会被 wmem_default 覆盖），缓冲区在系统负载不重的情况下可以增长到这个值。第三个值是发送缓冲区空间的最大字节数（该值会被 wmem_max 覆盖）。

net.ipv4.tcp_wmem= 4096 16384 131072



#与 tcp_wmem 类似，不过它表示的是为自动调优所使用的接收缓冲区的值

net.ipv4.tcp_rmem= 4096 87380 174760



#允许 TCP/IP 栈适应在高吞吐量情况下低延时的情况；这个选项应该禁用。

net.ipv4.tcp_low_latency= 0



#启用发送者端的拥塞控制算法，它可以维护对吞吐量的评估，并试图对带宽的整体利用情况进行优化；对于 WAN 通信来说应该启用这个选项

net.ipv4.tcp_westwood= 0



#为快速长距离网络启用 Binary Increase Congestion；这样可以更好地利用以 GB 速度进行操作的链接；对于 WAN 通信应该启用这个选项。

net.ipv4.tcp_bic= 1

 

#通过源路由，攻击者可以尝试到达内部IP地址 –包括RFC1918中的地址，所以不接受源路由信息包可以防止你的内部网络被探测。

net.inet.ip.sourceroute=0
net.inet.ip.accept_sourceroute=0



#vnode 是对文件或目录的一种内部表达。 因此， 增加可以被操作系统利用的 vnode 数量将降低磁盘的 I/O。一般而言， 这是由操作系统自行完成的，也不需要加以修改。但在某些时候磁盘 I/O 会成为瓶颈，而系统的 vnode 不足， 则这一配置应被增加。此时需要考虑是非活跃和空闲内存的数量。要查看当前在用的 vnode 数量：
# sysctl vfs.numvnodes
vfs.numvnodes: 91349

要查看最大可用的 vnode 数量：
# sysctl kern.maxvnodes
kern.maxvnodes: 100000
如果当前的 vnode 用量接近最大值，则将 kern.maxvnodes 值增大 1,000 可能是个好主意。
您应继续查看 vfs.numvnodes 的数值， 如果它再次攀升到接近最大值的程度，
仍需继续提高 kern.maxvnodes。 在 top(1) 中显示的内存用量应有显著变化，

kern.maxvnodes=8446



#最大的进程数

kern.maxproc＝ 964



#每个用户id允许的最大进程数

kern.maxprocperuid＝867

注意，maxprocperuid至少要比maxproc少1，因为init(8) 这个系统程序绝对要保持在运作状态。



＃系统中支持最多同时开启的文件数量，如果你在运行数据库或大的很吃描述符的进程，那么应该设置在20000以上

kern.maxfiles＝2221928


```

