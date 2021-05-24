# Docker
##maven dockerfile plugin

###一.maven dockerfile plugin使用步骤
	    1.linux
            a.下载docker(默认端口2375)
            b.设置docker 系统开机启动
                1.systemctl enable docker
            c.配置远程访问
                1.进入docker.service文件
                    vim /lib/systemd/system/docker.service
                2.修改配置
                    ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock
            e.防火墙开启2375端口
                1.开启端口
                    iptables -A INPUT -p tcp --dport 2375 -j ACCEPT
                2.保存设置
                    service iptables save
                3.重启防火墙
                    systemctl restart iptables.service
            f.创建本地仓库
            g.关闭仓库的https
                1.进入该目录：/etc/docker/daemon.json(没有就创建daemon.json文件)
                b.添加该内容：
                    {
                      "insecure-registries": [
                        "仓库的ip:port"
                      ]
                    }
            h.下载项目配置maven和java的环境变量
            i.在项目根目录下执行以下命令:
                1.mvn package(打包jar or war)
                2.mvn dockerfile:build(构建docker镜像)
                3.mvn dockerfile:push(推送镜像到仓库)
