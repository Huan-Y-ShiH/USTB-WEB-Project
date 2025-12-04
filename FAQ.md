# 常见问题解答

## Q1: 我需要自己创建openGauss数据库吗？

**答：不需要！** 

数据库会在运行 `docker-compose up -d` 时自动创建和初始化。

### 自动创建流程：

1. **数据库自动创建**：
   - Docker Compose启动openGauss容器时，会根据环境变量 `GS_DATABASE=hospital` 自动创建名为 `hospital` 的数据库
   - 同时自动创建用户 `gaussdb`（通过 `GS_USERNAME` 指定）

2. **表结构自动初始化**：
   - 数据库启动后，`db-init` 服务会自动执行初始化脚本
   - 脚本会创建所有表结构并插入初始数据
   - 如果表已存在，会自动跳过（避免重复初始化）

3. **应用自动启动**：
   - 等待数据库初始化完成后，应用服务才会启动
   - 确保应用启动时数据库已完全就绪

### 执行顺序：

```
1. openGauss容器启动 → 自动创建数据库和用户
2. 数据库健康检查通过
3. db-init服务执行 → 创建表结构和初始数据
4. 应用服务启动 → 连接数据库
```

## Q2: 如何验证数据库是否已创建？

```bash
# 方法1: 查看容器日志
docker-compose logs opengauss

# 方法2: 进入数据库容器测试连接
docker exec -it hospital_opengauss gsql -U gaussdb -d hospital

# 方法3: 查看表是否创建
docker exec -it hospital_opengauss gsql -U gaussdb -d hospital -c "\dt"
```

## Q3: 如果初始化失败怎么办？

### 检查初始化日志
```bash
docker-compose logs db-init
```

### 手动执行初始化
```bash
# 方法1: 重新运行初始化服务
docker-compose up db-init

# 方法2: 手动执行SQL脚本
docker exec -i hospital_opengauss gsql -U gaussdb -d hospital < src/main/resources/db/hospital_opengauss.sql
```

## Q4: 如何重新初始化数据库？

### 完全重置（删除所有数据）
```bash
# 1. 停止所有服务
docker-compose down

# 2. 删除数据卷（会删除所有数据）
docker volume rm hospitalmanage_opengauss_data

# 3. 重新启动（会重新创建数据库和表）
docker-compose up -d
```

### 仅重新执行初始化脚本
```bash
# 删除所有表后重新初始化
docker exec -it hospital_opengauss gsql -U gaussdb -d hospital -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
docker exec -i hospital_opengauss gsql -U gaussdb -d hospital < src/main/resources/db/hospital_opengauss.sql
```

## Q5: 数据库数据会丢失吗？

**不会！** 数据存储在Docker Volume中，即使删除容器，数据也会保留。

### 数据持久化位置
- Docker Volume名称: `hospitalmanage_opengauss_data`
- 物理位置: Docker管理的存储位置

### 查看数据卷
```bash
docker volume ls | grep opengauss
docker volume inspect hospitalmanage_opengauss_data
```

## Q6: 如何备份和恢复数据库？

### 备份
```bash
# 备份数据库
docker exec hospital_opengauss gs_dump -U gaussdb -d hospital -f /tmp/hospital_backup.sql

# 复制到主机
docker cp hospital_opengauss:/tmp/hospital_backup.sql ./hospital_backup_$(date +%Y%m%d).sql
```

### 恢复
```bash
# 复制备份文件到容器
docker cp hospital_backup.sql hospital_opengauss:/tmp/

# 恢复数据库
docker exec -i hospital_opengauss gsql -U gaussdb -d hospital < hospital_backup.sql
```

## Q7: 如何修改数据库密码？

### 方法1: 修改docker-compose.yml
```yaml
environment:
  - GS_PASSWORD=新密码
```

然后重新创建容器：
```bash
docker-compose down
docker-compose up -d
```

### 方法2: 在容器内修改
```bash
docker exec -it hospital_opengauss gsql -U gaussdb -d hospital
ALTER USER gaussdb WITH PASSWORD '新密码';
```

**注意**: 修改密码后需要同步更新 `jdbc.properties` 文件。

## Q8: 如何查看数据库连接信息？

### 连接信息
- **主机**: `localhost` (外部访问) 或 `opengauss` (容器内访问)
- **端口**: `5432`
- **数据库名**: `hospital`
- **用户名**: `gaussdb`
- **密码**: `Gauss@123`

### 使用gsql连接
```bash
# 从容器内连接
docker exec -it hospital_opengauss gsql -U gaussdb -d hospital

# 从主机连接（需要安装openGauss客户端）
gsql -h localhost -p 5432 -U gaussdb -d hospital
```

## Q9: 初始化需要多长时间？

- **数据库启动**: 约20-30秒
- **表结构创建**: 约5-10秒
- **初始数据插入**: 约5-10秒
- **总计**: 约30-50秒

可以通过日志查看进度：
```bash
docker-compose logs -f db-init
```

## Q10: 如何确认数据库已完全初始化？

```bash
# 检查表数量（应该有10个表）
docker exec -it hospital_opengauss gsql -U gaussdb -d hospital -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public';"

# 检查数据是否插入
docker exec -it hospital_opengauss gsql -U gaussdb -d hospital -c "SELECT COUNT(*) FROM patients;"
docker exec -it hospital_opengauss gsql -U gaussdb -d hospital -c "SELECT COUNT(*) FROM doctors;"
```

---

**提示**: 如果遇到其他问题，请查看 `DEPLOY.md` 中的详细故障排查章节。

