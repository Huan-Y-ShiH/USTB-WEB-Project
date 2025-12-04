# 医院管理系统 - Docker快速部署指南

## 📋 项目概述

本项目是一个基于Java Web的医院管理系统，使用openGauss数据库，支持Docker容器化部署。

## 🚀 快速开始

### 前置要求

- Docker 20.10+
- Docker Compose 1.29+
- Maven 3.6+ (用于构建项目)

### 一键部署

```bash
# 1. 编译项目
mvn clean package

# 2. 启动所有服务（数据库+应用）
docker-compose up -d

# 3. 查看服务状态
docker-compose ps

# 4. 查看日志
docker-compose logs -f
```

### 访问应用

- **应用地址**: http://localhost:8080
- **管理员登录**:
  - 用户名: `admin`
  - 密码: `123456`
- **患者登录**:
  - 手机号: `13012345678`
  - 密码: `pass123`

## 📁 项目结构

```
HospitalManage/
├── Dockerfile                      # 应用镜像构建文件
├── docker-compose.yml              # Docker Compose编排配置
├── init-db.sh                      # 数据库初始化脚本
├── .dockerignore                   # Docker构建忽略文件
├── DEPLOY.md                       # 详细部署文档
├── README_DOCKER.md                # Docker快速指南（本文件）
└── src/
    └── main/
        ├── resources/
        │   ├── db/
        │   │   └── hospital_opengauss.sql  # openGauss数据库脚本
        │   └── jdbc.properties             # 数据库连接配置
        └── webapp/                          # Web应用资源
```

## 🔧 常用命令

### 启动服务
```bash
docker-compose up -d
```

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
# 所有服务
docker-compose logs -f

# 仅应用服务
docker-compose logs -f hospital-app

# 仅数据库服务
docker-compose logs -f opengauss
```

### 重新构建
```bash
# 重新编译项目
mvn clean package

# 重新构建镜像
docker-compose build

# 重启服务
docker-compose up -d
```

### 数据库操作
```bash
# 进入数据库容器
docker exec -it hospital_opengauss bash

# 连接数据库
gsql -U gaussdb -d hospital

# 查看所有表
\dt

# 退出
\q
```

## 🐛 故障排查

### 应用无法启动
1. 检查数据库是否正常运行: `docker-compose ps opengauss`
2. 查看应用日志: `docker-compose logs hospital-app`
3. 检查端口是否被占用: `netstat -tlnp | grep 8080`

### 数据库连接失败
1. 等待数据库完全启动（约30秒）
2. 检查数据库健康状态: `docker-compose ps`
3. 查看数据库日志: `docker-compose logs opengauss`
4. 手动测试连接: `docker exec -it hospital_opengauss gsql -U gaussdb -d hospital`

### 数据库初始化失败
```bash
# 手动执行初始化脚本
docker exec -i hospital_opengauss gsql -U gaussdb -d hospital < src/main/resources/db/hospital_opengauss.sql
```

## 📊 服务说明

### openGauss数据库
- **容器名**: `hospital_opengauss`
- **端口**: `5432`
- **数据库名**: `hospital`
- **用户名**: `gaussdb`
- **密码**: `Gauss@123`
- **数据持久化**: Docker Volume `opengauss_data`

### 医院管理系统应用
- **容器名**: `hospital_app`
- **端口**: `8080`
- **基础镜像**: `tomcat:9.0-jdk8-openjdk`
- **上传文件目录**: `./src/main/webapp/upload`

## 🔐 安全建议

1. **修改默认密码**: 生产环境请修改数据库和应用默认密码
2. **使用环境变量**: 敏感信息通过环境变量管理
3. **配置防火墙**: 限制数据库端口访问
4. **启用HTTPS**: 生产环境建议使用HTTPS

## 📝 注意事项

1. **首次启动**: 数据库初始化需要约30-60秒，请耐心等待
2. **数据持久化**: 数据库数据存储在Docker Volume中，删除容器不会丢失数据
3. **端口冲突**: 如8080或5432端口被占用，请修改`docker-compose.yml`中的端口映射
4. **资源要求**: 建议至少4GB内存，2核CPU

## 📚 更多信息

详细部署文档请参考: [DEPLOY.md](DEPLOY.md)

## 🆘 获取帮助

如遇到问题，请：
1. 查看日志文件
2. 检查系统资源
3. 参考详细部署文档
4. 检查Docker和Docker Compose版本

---

**版本**: 1.0-SNAPSHOT  
**数据库**: openGauss 3.0.0  
**最后更新**: 2025年11月21日

