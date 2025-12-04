# 医院管理系统 Docker 部署文档

## 一、环境要求

### 硬件环境
- CPU: 2核及以上
- 内存: 4GB及以上
- 磁盘: 20GB及以上可用空间

### 软件环境
- 操作系统: Linux (CentOS 7+, Ubuntu 18.04+) 或 Windows 10+ (使用WSL2)
- Docker: 20.10+
- Docker Compose: 1.29+

## 二、部署步骤

### 1. 安装Docker和Docker Compose

#### Linux系统
```bash
# 安装Docker
curl -fsSL https://get.docker.com | bash -s docker

# 启动Docker服务
sudo systemctl start docker
sudo systemctl enable docker

# 安装Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

#### Windows系统
下载并安装 [Docker Desktop](https://www.docker.com/products/docker-desktop)

### 2. 准备项目文件

确保项目已编译，生成WAR文件：
```bash
# 在项目根目录执行
mvn clean package
```

### 3. 配置数据库连接

编辑 `src/main/resources/jdbc.properties` 文件，确保配置正确：
```properties
jdbc.driverClassName=org.opengauss.Driver
jdbc.url=jdbc:opengauss://opengauss:5432/hospital?useSSL=false&characterEncoding=utf-8
jdbc.username=gaussdb
jdbc.password=Gauss@123
```

**注意**: Docker Compose中应用连接数据库时，使用服务名 `opengauss` 作为主机名。

### 4. 构建和启动服务

#### 方式一：使用Docker Compose（推荐）

```bash
# 构建并启动所有服务
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f
```

#### 方式二：手动构建

```bash
# 1. 构建应用镜像
docker build -t hospital-app:latest .

# 2. 启动openGauss数据库
docker run -d \
  --name hospital_opengauss \
  -e GS_PASSWORD=Gauss@123 \
  -e GS_USERNAME=gaussdb \
  -e GS_DATABASE=hospital \
  -p 5432:5432 \
  -v opengauss_data:/var/lib/opengauss/data \
  enmotech/opengauss:3.0.0

# 3. 等待数据库启动（约30秒）
sleep 30

# 4. 初始化数据库
docker exec -i hospital_opengauss gsql -U gaussdb -d hospital < src/main/resources/db/hospital_opengauss.sql

# 5. 启动应用
docker run -d \
  --name hospital_app \
  --link hospital_opengauss:opengauss \
  -p 8080:8080 \
  hospital-app:latest
```

### 5. 验证部署

#### 检查服务状态
```bash
# 查看容器运行状态
docker ps

# 应该看到两个容器：
# - hospital_opengauss (数据库)
# - hospital_app (应用)
```

#### 访问应用
- 应用地址: http://localhost:8080
- 管理员登录: 
  - 用户名: admin
  - 密码: 123456
- 患者登录: 
  - 手机号: 13012345678
  - 密码: pass123

#### 检查数据库连接
```bash
# 进入数据库容器
docker exec -it hospital_opengauss bash

# 连接数据库
gsql -U gaussdb -d hospital

# 查看表
\dt

# 退出
\q
exit
```

## 三、常用操作

### 停止服务
```bash
docker-compose down
```

### 重启服务
```bash
docker-compose restart
```

### 查看日志
```bash
# 查看所有服务日志
docker-compose logs -f

# 查看特定服务日志
docker-compose logs -f hospital-app
docker-compose logs -f opengauss
```

### 进入容器
```bash
# 进入应用容器
docker exec -it hospital_app bash

# 进入数据库容器
docker exec -it hospital_opengauss bash
```

### 备份数据库
```bash
# 备份数据库
docker exec hospital_opengauss gs_dump -U gaussdb -d hospital -f /tmp/hospital_backup.sql

# 复制备份文件到主机
docker cp hospital_opengauss:/tmp/hospital_backup.sql ./hospital_backup.sql
```

### 恢复数据库
```bash
# 复制SQL文件到容器
docker cp hospital_backup.sql hospital_opengauss:/tmp/

# 恢复数据库
docker exec -i hospital_opengauss gsql -U gaussdb -d hospital < hospital_backup.sql
```

## 四、故障排查

### 1. 应用无法连接数据库

**问题**: 应用启动失败，日志显示数据库连接错误

**解决方案**:
```bash
# 检查数据库是否正常运行
docker-compose ps opengauss

# 检查数据库日志
docker-compose logs opengauss

# 测试数据库连接
docker exec -it hospital_opengauss gsql -U gaussdb -d hospital -c "SELECT 1;"
```

### 2. 端口被占用

**问题**: 端口8080或5432已被占用

**解决方案**:
- 修改 `docker-compose.yml` 中的端口映射
- 或停止占用端口的服务

### 3. 数据库初始化失败

**问题**: 数据库表未创建

**解决方案**:
```bash
# 手动执行SQL脚本
docker exec -i hospital_opengauss gsql -U gaussdb -d hospital < src/main/resources/db/hospital_opengauss.sql
```

### 4. 应用无法访问

**问题**: 浏览器无法访问 http://localhost:8080

**解决方案**:
```bash
# 检查应用容器状态
docker-compose ps hospital-app

# 查看应用日志
docker-compose logs hospital-app

# 检查端口是否监听
netstat -tlnp | grep 8080
```

## 五、生产环境部署建议

### 1. 安全配置
- 修改默认密码
- 使用环境变量管理敏感信息
- 配置防火墙规则
- 启用HTTPS

### 2. 性能优化
- 配置数据库连接池
- 启用Tomcat压缩
- 配置缓存策略
- 使用Nginx作为反向代理

### 3. 数据持久化
- 使用Docker Volume持久化数据库数据
- 定期备份数据库
- 配置日志轮转

### 4. 监控和日志
- 配置应用监控
- 集中管理日志
- 设置告警规则

## 六、项目结构说明

```
HospitalManage/
├── Dockerfile                 # 应用镜像构建文件
├── docker-compose.yml         # Docker Compose编排文件
├── .dockerignore              # Docker构建忽略文件
├── DEPLOY.md                  # 部署文档（本文件）
├── pom.xml                    # Maven配置文件
├── src/
│   └── main/
│       ├── resources/
│       │   ├── db/
│       │   │   ├── hospital.sql              # MySQL版本（原始）
│       │   │   └── hospital_opengauss.sql     # openGauss版本
│       │   ├── jdbc.properties               # 数据库连接配置
│       │   └── mybatis-config.xml             # MyBatis配置
│       └── webapp/                            # Web应用资源
└── target/                                    # 编译输出目录
```

## 七、技术支持

如遇到问题，请检查：
1. Docker和Docker Compose版本是否符合要求
2. 系统资源是否充足
3. 端口是否被占用
4. 日志文件中的错误信息

## 八、更新部署

当代码更新后，重新部署：

```bash
# 1. 停止服务
docker-compose down

# 2. 重新编译项目
mvn clean package

# 3. 重新构建镜像
docker-compose build

# 4. 启动服务
docker-compose up -d
```

---

**部署完成时间**: 2025年11月21日  
**数据库版本**: openGauss 3.0.0  
**应用版本**: HospitalManage 1.0-SNAPSHOT

