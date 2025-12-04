# 医院管理系统 (Hospital Management System)

基于openGauss数据库的医院管理系统，支持Docker容器化部署。

## 📋 项目简介

本项目是一个完整的医院管理系统，实现了管理员、医生、患者三种角色的完整业务流程。系统采用Java Web技术栈开发，使用openGauss国产数据库，支持Docker一键部署。

## ✨ 功能特性

### 管理员功能
- 医生管理（增删改查、批量操作）
- 科室管理（多级科室结构）
- 职称管理
- 排班管理
- 预约管理
- 公告管理
- 患者管理

### 医生功能
- 个人信息管理
- 排班查看
- 预约管理
- 患者管理
- 诊断功能
- 住院管理
- 公告查看

### 患者功能
- 用户注册登录
- 个人信息管理
- 预约管理（添加、查看、搜索、取消）
- 住院管理（查看、搜索）

## 🛠️ 技术栈

- **后端框架**: Java Servlet + JSP
- **持久层框架**: MyBatis 3.5.9
- **数据库**: openGauss 3.0.0（国产数据库）
- **构建工具**: Maven
- **应用服务器**: Apache Tomcat 9.0
- **容器化**: Docker + Docker Compose
- **其他技术**: PageHelper（分页）、Lombok、FastJSON

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
├── README_DOCKER.md                # Docker快速指南
├── QUICK_START.md                  # 快速开始指南
├── MIGRATION_SUMMARY.md            # MySQL到openGauss迁移总结
├── FAQ.md                          # 常见问题解答
├── pom.xml                         # Maven配置文件
└── src/
    └── main/
        ├── java/com/cxy/           # Java源代码
        ├── resources/              # 配置文件
        │   ├── db/                 # 数据库脚本
        │   └── jdbc.properties     # 数据库连接配置
        └── webapp/                 # Web应用资源
```

## 📚 文档说明

- [QUICK_START.md](QUICK_START.md) - 三分钟快速部署指南
- [DEPLOY.md](DEPLOY.md) - 详细部署文档（包括环境要求、步骤、故障排查）
- [README_DOCKER.md](README_DOCKER.md) - Docker部署快速指南
- [MIGRATION_SUMMARY.md](MIGRATION_SUMMARY.md) - MySQL到openGauss迁移总结
- [FAQ.md](FAQ.md) - 常见问题解答

## 🔧 常用命令

### Docker Compose命令

```bash
# 启动服务
docker-compose up -d

# 停止服务
docker-compose down

# 查看日志
docker-compose logs -f

# 重启服务
docker-compose restart
```

### 数据库操作

```bash
# 进入数据库容器
docker exec -it hospital_opengauss bash

# 连接数据库
gsql -U gaussdb -d hospital

# 查看所有表
\dt
```

## 🗄️ 数据库设计

### 核心数据表

- `admins` - 管理员表
- `patients` - 患者表
- `doctors` - 医生表
- `departments` - 科室表（支持多级结构）
- `professional_titles` - 职称表
- `appointments` - 预约表
- `doctor_schedule` - 医生排班表
- `consultation` - 就诊记录表
- `hospitalization` - 住院记录表
- `announcement` - 公告表

详细数据库设计请参考：`src/main/resources/db/hospital_opengauss.sql`

## 🔐 安全说明

- 默认密码仅用于开发测试环境
- 生产环境请修改所有默认密码
- 建议使用HTTPS协议
- 配置防火墙规则

## 📝 开发说明

### 开发环境

- JDK 1.8
- Maven 3.6+
- IntelliJ IDEA / Eclipse
- Docker Desktop

### 本地开发

```bash
# 1. 启动openGauss数据库（Docker）
docker-compose up -d opengauss

# 2. 等待数据库启动后，初始化数据库
docker exec -i hospital_opengauss gsql -U gaussdb -d hospital < src/main/resources/db/hospital_opengauss.sql

# 3. 配置jdbc.properties（使用localhost）
# jdbc.url=jdbc:opengauss://localhost:5432/hospital

# 4. 使用IDE运行项目
```

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📄 许可证

本项目仅用于学习和研究目的。

## 👥 作者

USTB Web项目团队

## 📞 联系方式

如有问题，请提交Issue或查看FAQ文档。

---

**版本**: 1.0-SNAPSHOT  
**数据库**: openGauss 3.0.0  
**最后更新**: 2025年11月21日

