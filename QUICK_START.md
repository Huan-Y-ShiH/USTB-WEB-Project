# 快速开始指南

## 🚀 三分钟快速部署

### 前置条件
- 已安装 Docker 和 Docker Compose
- 已安装 Maven（用于编译项目）

### 部署步骤

#### 1. 编译项目
```bash
mvn clean package
```

#### 2. 启动服务
```bash
docker-compose up -d
```

#### 3. 等待初始化（约30-60秒）
```bash
# 查看日志，等待数据库初始化完成
docker-compose logs -f opengauss
```

看到 "数据库初始化完成！" 后，按 `Ctrl+C` 退出日志查看。

#### 4. 访问应用
打开浏览器访问: **http://localhost:8080**

### 测试账号

**管理员登录**:
- 用户名: `admin`
- 密码: `123456`

**患者登录**:
- 手机号: `13012345678`
- 密码: `pass123`

### 常用命令

```bash
# 查看服务状态
docker-compose ps

# 查看所有日志
docker-compose logs -f

# 停止服务
docker-compose down

# 重启服务
docker-compose restart
```

### 故障排查

如果应用无法访问：

1. **检查服务是否运行**
   ```bash
   docker-compose ps
   ```

2. **查看应用日志**
   ```bash
   docker-compose logs hospital-app
   ```

3. **检查数据库连接**
   ```bash
   docker exec -it hospital_opengauss gsql -U gaussdb -d hospital -c "SELECT 1;"
   ```

4. **手动初始化数据库**（如果自动初始化失败）
   ```bash
   docker exec -i hospital_opengauss gsql -U gaussdb -d hospital < src/main/resources/db/hospital_opengauss.sql
   ```

---

**提示**: 首次启动需要下载Docker镜像，可能需要几分钟时间。

