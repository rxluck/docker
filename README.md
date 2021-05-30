# maven dockerfile plugin 构建项目镜像
## 一.maven dockerfile plugin使用步骤
### 一.linux安装docker以及docker私有仓库
    1. 下载docker(默认端口2375)
        * yum -y install docker
    2. 设置docker 系统开机启动
        * systemctl enable docker
    3. 开启远程访问权限
        * 进入docker.service文件：vim /lib/systemd/system/docker.service
        * 修改配置：ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
    4. 宿主机防火墙开启2375端口
        * 开启端口：iptables -A INPUT -p tcp --dport 2375 -j ACCEPT
        * 保存设置：service iptables save
        * 重启防火墙：systemctl restart iptables.service
    5. 创建本地仓库
        * 拉取registry仓库：docker pull registry
    6. 关闭仓库https(registry默认是https)
        * 进入目录：vim /etc/docker/daemon.json(没有就创建daemon.json文件)
        * 添加配置：
        `{
          "insecure-registries": [
            "仓库的ip:port"
          ]
        }`
    7. 运行容器启动仓库服务：
        *. docker run -d -v /opt/registry:/var/lib/registry -p 5000:5000 --name repository registry
    8. 下载项目配置maven和java的环境变量
### 二.windows的访问docker服务和docker私有仓库
    1. 配置docker服务的ip或域名环境变量
        * 设置环境变量：DOCKER_HOST=tcp:ip:2375
    2. 配置完成后,在项目内部引入该插件
    3. 配置好Dockerfile文件
    4. 执行maven 插件命令
        * 在项目根目录下执行以下命令完成构建镜像:
            *. mvn package(打包jar or war)
            *. mvn dockerfile:build(构建docker镜像)
            *. mvn dockerfile:push(推送镜像到仓库)