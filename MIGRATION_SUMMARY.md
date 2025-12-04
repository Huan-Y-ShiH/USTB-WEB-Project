# MySQL到openGauss迁移总结

## 一、数据库迁移要点

### 1. SQL语法差异处理

#### 数据类型转换
| MySQL | openGauss | 说明 |
|-------|-----------|------|
| `int(0)` | `INTEGER` 或 `SERIAL` | openGauss不需要指定长度 |
| `varchar(255)` | `VARCHAR(255)` | 保持一致 |
| `text` | `TEXT` | 保持一致 |
| `tinyint(1)` | `SMALLINT` 或 `BOOLEAN` | 布尔值使用SMALLINT |
| `datetime(0)` | `TIMESTAMP` | 时间戳类型 |
| `enum(...)` | `VARCHAR + CHECK约束` | openGauss不支持ENUM |

#### 自增主键处理
- **MySQL**: `AUTO_INCREMENT`
- **openGauss**: `SERIAL` (自动创建序列)

#### 字符集和排序规则
- **MySQL**: `CHARACTER SET utf8 COLLATE utf8_general_ci`
- **openGauss**: 默认UTF-8，无需指定

#### 存储引擎
- **MySQL**: `ENGINE = InnoDB`
- **openGauss**: 不需要指定（自动管理）

#### 索引语法
- **MySQL**: `USING BTREE`
- **openGauss**: 不需要指定索引类型

#### 外键约束
- 语法基本一致，都支持 `ON DELETE RESTRICT ON UPDATE RESTRICT`

### 2. 特殊处理

#### ENUM类型转换
```sql
-- MySQL
status enum('booked','completed','cancelled') DEFAULT 'booked'

-- openGauss
status VARCHAR(20) DEFAULT 'booked' CHECK (status IN ('booked', 'completed', 'cancelled'))
```

#### 序列重置
openGauss使用SERIAL后需要手动重置序列：
```sql
SELECT setval('table_name_id_seq', (SELECT MAX(id) FROM table_name));
```

#### 注释语法
openGauss使用标准SQL注释语法：
```sql
COMMENT ON TABLE table_name IS '表注释';
COMMENT ON COLUMN table_name.column_name IS '列注释';
```

### 3. 迁移后的验证

```sql
-- 检查表是否创建
\dt

-- 检查数据是否导入
SELECT COUNT(*) FROM patients;
SELECT COUNT(*) FROM doctors;
SELECT COUNT(*) FROM appointments;

-- 检查外键约束
SELECT * FROM information_schema.table_constraints 
WHERE constraint_type = 'FOREIGN KEY';
```

## 二、配置文件修改

### 1. JDBC驱动

**pom.xml**:
```xml
<!-- 从MySQL驱动改为openGauss驱动 -->
<dependency>
    <groupId>org.opengauss</groupId>
    <artifactId>opengauss-jdbc</artifactId>
    <version>5.0.0</version>
</dependency>
```

### 2. 数据库连接配置

**jdbc.properties**:
```properties
# MySQL配置
jdbc.driverClassName=com.mysql.cj.jdbc.Driver
jdbc.url=jdbc:mysql://localhost:3306/hospital?useSSL=false&characterEncoding=utf-8&serverTimezone=Asia/Shanghai

# openGauss配置
jdbc.driverClassName=org.opengauss.Driver
jdbc.url=jdbc:opengauss://localhost:5432/hospital?useSSL=false&characterEncoding=utf-8
```

### 3. MyBatis配置

**mybatis-config.xml**: 无需修改，MyBatis兼容openGauss

## 三、Docker部署流程

### 1. 文件结构

```
项目根目录/
├── Dockerfile                    # 应用镜像构建
├── docker-compose.yml            # 服务编排
├── init-db.sh                    # 数据库初始化脚本
├── .dockerignore                 # Docker构建忽略
├── src/main/resources/db/
│   └── hospital_opengauss.sql    # openGauss数据库脚本
└── DEPLOY.md                     # 详细部署文档
```

### 2. 部署步骤

#### 步骤1: 编译项目
```bash
mvn clean package
```

#### 步骤2: 启动服务
```bash
docker-compose up -d
```

#### 步骤3: 验证部署
- 检查容器状态: `docker-compose ps`
- 查看日志: `docker-compose logs -f`
- 访问应用: http://localhost:8080

### 3. Docker Compose服务说明

#### openGauss数据库服务
- **镜像**: `enmotech/opengauss:3.0.0`
- **端口**: 5432
- **数据持久化**: Docker Volume
- **健康检查**: 自动检测数据库就绪状态

#### 应用服务
- **基础镜像**: `tomcat:9.0-jdk8-openjdk`
- **端口**: 8080
- **依赖**: 等待数据库健康检查通过后启动

### 4. 数据初始化

数据库初始化通过以下方式完成：
1. Docker Volume挂载SQL脚本
2. 初始化脚本自动执行
3. 创建所有表和初始数据

## 四、常见问题解决

### 1. 数据库连接失败

**原因**: 
- 数据库未完全启动
- 网络配置错误
- 认证失败

**解决**:
```bash
# 检查数据库状态
docker-compose ps opengauss

# 查看数据库日志
docker-compose logs opengauss

# 测试连接
docker exec -it hospital_opengauss gsql -U gaussdb -d hospital
```

### 2. 表未创建

**原因**: 
- 初始化脚本执行失败
- SQL语法错误

**解决**:
```bash
# 手动执行SQL脚本
docker exec -i hospital_opengauss gsql -U gaussdb -d hospital < src/main/resources/db/hospital_opengauss.sql
```

### 3. 应用启动失败

**原因**:
- WAR文件未找到
- 端口被占用
- 内存不足

**解决**:
```bash
# 检查WAR文件
ls -lh target/HospitalManage-1.0-SNAPSHOT.war

# 检查端口
netstat -tlnp | grep 8080

# 查看应用日志
docker-compose logs hospital-app
```

## 五、性能优化建议

### 1. 数据库优化
- 配置连接池大小
- 创建必要的索引
- 定期分析表统计信息

### 2. 应用优化
- 配置Tomcat线程池
- 启用压缩
- 配置缓存

### 3. Docker优化
- 使用多阶段构建
- 优化镜像大小
- 配置资源限制

## 六、迁移检查清单

- [x] SQL脚本转换为openGauss语法
- [x] 更新JDBC驱动依赖
- [x] 修改数据库连接配置
- [x] 创建Dockerfile
- [x] 创建docker-compose.yml
- [x] 创建数据库初始化脚本
- [x] 测试数据库连接
- [x] 验证数据完整性
- [x] 测试应用功能
- [x] 编写部署文档

## 七、总结

### 迁移优势
1. **国产数据库**: 使用openGauss符合国产化要求
2. **容器化部署**: Docker部署简单快速
3. **数据持久化**: Docker Volume保证数据安全
4. **易于扩展**: Docker Compose便于服务扩展

### 注意事项
1. openGauss不支持ENUM类型，需要使用CHECK约束
2. 序列需要手动重置以保持连续性
3. 数据库初始化需要等待数据库完全启动
4. 生产环境需要修改默认密码

---

**迁移完成日期**: 2025年11月21日  
**数据库版本**: openGauss 3.0.0  
**应用版本**: HospitalManage 1.0-SNAPSHOT

