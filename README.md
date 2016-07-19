# Swarmlab

Get started with Docker 1.12 Swarm Mode fast.

Clone this repo and do

```
$ cd swarmlab
$ vagrant up --provider virtualbox
```

This will create three Ubunutu Wily VM with Docker 1.12 RC preinstalled.

This allows to experiment with new Docker Swarm Mode features easily.

## First Steps

Login on node1

```bash
$ vagrant ssh node1
vagrant@node1:~$ sudo docker swarm init --listen-addr 172.28.128.3:2377
vagrant@node1:~$ sudo docker info
```

Login on node2

```bash
$ vagrant ssh node2
vagrant@node2:~$ sudo docker swarm join --listen-addr 172.28.128.4:2377 172.28.128.3:2377
```

Login on node3

```bash
$ vagrant ssh node3
vagrant@node3:~$ sudo docker swarm join --listen-addr 172.28.128.5:2377 172.28.128.3:2377
```

Login on node1

```bash
$ vagrant ssh node1
vagrant@node1:~$ sudo docker node ls
ID                           HOSTNAME  MEMBERSHIP  STATUS  AVAILABILITY  MANAGER STATUS
9fp6he8w3yhqao6nmr8ijyfiq    node2     Accepted    Ready   Active
9kl1cmiiiadpfnjdaj1wsje77    node3     Accepted    Ready   Active
bnzfe2d6mjqkdakslvpg2pfhj *  node1     Accepted    Ready   Active        Leader
vagrant@node1:~$ sudo docker service create --replicas 1 --name helloworld alpine ping docker.com
asbnvaj0s1i2n7736qj83xoq3
vagrant@node1:~$ sudo docker service ls
ID            NAME                REPLICAS  IMAGE           COMMAND
asbnvaj0s1i2  helloworld          1/1       alpine          ping docker.com

vagrant@node1:~$ sudo docker service inspect --pretty helloworld
ID:             asbnvaj0s1i2n7736qj83xoq3
Name:           helloworld
Mode:           Replicated
 Replicas:      1
Placement:
 Strategy:      Spread
UpdateConfig:
 Parallelism:   0
ContainerSpec:
 Image:         alpine
 Args:          ping docker.com
Resources:
Reservations:
Limits:
vagrant@node1:~$ sudo docker service tasks helloworld
ID                         NAME          SERVICE     IMAGE   LAST STATE         DESIRED STATE  NODE
ch3y4crwacgg0v6hckfzh3ryx  helloworld.1  helloworld  alpine  Running 2 minutes  Running        node3
vagrant@node1:~$ sudo docker service scale helloworld=5
helloworld scaled to 5
vagrant@node1:~$ sudo docker service tasks helloworld
ID                         NAME          SERVICE     IMAGE   LAST STATE          DESIRED STATE  NODE
ch3y4crwacgg0v6hckfzh3ryx  helloworld.1  helloworld  alpine  Running 3 minutes   Running        node3
1rgrubhgjqlcgvmh57nn1xqy5  helloworld.2  helloworld  alpine  Running 10 seconds  Running        node2
dkie5usnm4ycdz1ex0tilt7gc  helloworld.3  helloworld  alpine  Running 10 seconds  Running        node2
9cg5o0fmnzlho7a2bsey4h96j  helloworld.4  helloworld  alpine  Running 10 seconds  Running        node3
dyy846ljbv7gk3v6adfweib8s  helloworld.5  helloworld  alpine  Running 10 seconds  Running        node1
vagrant@node1:~$ sudo docker service rm helloworld
helloworld
vagrant@node1:~$ sudo docker service tasks helloworld
Error: No such service: helloworld
vagrant@node1:~$ sudo docker service create --replicas 3 --name redis --update-delay 10s --update-parallelism 1 redis:3.0.6
ameheglone13gz8usi5hp3xbi
vagrant@node1:~$ sudo docker service inspect --pretty redis
ID:             ameheglone13gz8usi5hp3xbi
Name:           redis
Mode:           Replicated
 Replicas:      3
Placement:
 Strategy:      Spread
UpdateConfig:
 Parallelism:   1
 Delay:         10s
ContainerSpec:
 Image:         redis:3.0.6
Resources:
Reservations:
Limits:
vagrant@node1:~$ sudo docker service update --image redis:3.0.7 redis
redis

vagrant@node1:~$ sudo docker service inspect --pretty redis
ID:             ameheglone13gz8usi5hp3xbi
Name:           redis
Mode:           Replicated
 Replicas:      3
Placement:
 Strategy:      Spread
UpdateConfig:
 Parallelism:   1
 Delay:         10s
ContainerSpec:
 Image:         redis:3.0.7
Resources:
Reservations:
Limits:
vagrant@node1:~$ sudo docker service tasks redis
ID                         NAME     SERVICE  IMAGE        LAST STATE                DESIRED STATE  NODE
0a4apxy2r3zwuztbgnlsjjqw4  redis.1  redis    redis:3.0.7  Preparing About a minute  Running        node2
653cezy7cgbfn80wdvx8uk8db  redis.2  redis    redis:3.0.7  Preparing 52 seconds      Running        node1
eztw0qiaemeafc532ywrlwael  redis.3  redis    redis:3.0.7  Preparing About a minute  Running        node3
vagrant@node1:~$ sudo docker service tasks redis
ID                         NAME     SERVICE  IMAGE        LAST STATE         DESIRED STATE  NODE
0a4apxy2r3zwuztbgnlsjjqw4  redis.1  redis    redis:3.0.7  Running 2 minutes  Running        node2
653cezy7cgbfn80wdvx8uk8db  redis.2  redis    redis:3.0.7  Running 2 minutes  Running        node1
eztw0qiaemeafc532ywrlwael  redis.3  redis    redis:3.0.7  Running 2 minutes  Running        node3
vagrant@node1:~$ sudo docker node update --availability drain node2
node2
vagrant@node1:~$ sudo docker service inspect --pretty redis
ID:             ameheglone13gz8usi5hp3xbi
Name:           redis
Mode:           Replicated
 Replicas:      3
Placement:
 Strategy:      Spread
UpdateConfig:
 Parallelism:   1
 Delay:         10s
ContainerSpec:
 Image:         redis:3.0.7
Resources:
Reservations:
Limits:
vagrant@node1:~$ sudo docker service tasks redis
ID                         NAME     SERVICE  IMAGE        LAST STATE          DESIRED STATE  NODE
38uzsy1hsw1k57omn3xsd1dsq  redis.1  redis    redis:3.0.7  Running 46 seconds  Running        node3
653cezy7cgbfn80wdvx8uk8db  redis.2  redis    redis:3.0.7  Running 3 minutes   Running        node1
eztw0qiaemeafc532ywrlwael  redis.3  redis    redis:3.0.7  Running 4 minutes   Running        node3
vagrant@node1:~$ sudo docker node update --availability active node2
node2
vagrant@node1:~$ sudo  docker node inspect --pretty node2
ID:                     9fp6he8w3yhqao6nmr8ijyfiq
Hostname:               node2
Status:
 State:                 Ready
 Availability:          Active
Platform:
 Operating System:      linux
 Architecture:          x86_64
Resources:
 CPUs:                  1
 Memory:                992.8 MiB
Plugins:
  Network:              overlay, overlay, null, host, bridge
  Volume:               local
Engine Version:         1.12.0-rc3
```
