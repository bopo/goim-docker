Django 容器项目部署程序
=================

自动化部署 Django 项目
----------------------

### 1.编译运行镜像

```
# 手动操作如下
docker build . -t alpine:3.6-project

# 自动操作
make setup

# 以上操作二选一即可
```

### 2.初始化数据

```
# 初始化数据库
docker-compose run --rm django python3 manage.py migrate

# 更新静态文件(js, css, img等)
docker-compose run --rm django python3 manage.py collectstatic --no-input

# 创建超级管理员(需要手动输入)
docker-compose run --rm django python3 manage.py createsuperuser
```

### 3.运行 Django 容器

```
docker-compose up -d
```

以后重起服务使用下列命令行
----------------------------

```
docker-compose restart
```

make 和 fab 命令自行百度吧。

### 服务端本地部署使用 make 命令
```bash
make help - 查看各种帮助
make setup - 安装基本依赖(初始化)
make fetch - 更新版本库代码
make build - 编译所需镜像
make start - 开始项目容器
make stop - 停止项目容器
make restart - 重启项目容器
make clean - 清理编译垃圾数据
make destry - 销毁项目容器
```

### 客户端远程部署使用 fab 命令

> 另外, `make help` 或者 `fab list` 查看命令行快捷工具帮助

#### 首先修改 fabfile.py 的远程服务器 ssh 配置

```python
env.roledefs = {
    'dev': ['root@127.7.7.22'],
    'pre': ['root@172.7.7.22'],
}
```

#### 更新代码, 同步到服务器, 重启容器

```bash
fab -R dev pull sync migr rest
```

#### 更新代码, 同步到服务器, 更新数据库, 重启容器

```bash
fab -R pre pull sync migr rest
```

[x] postgres
[x] elastic
[x] thumbor
[x] django
[x] minio
[x] redis

[-] k8s 部署方案
