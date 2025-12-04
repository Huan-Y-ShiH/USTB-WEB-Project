#!/bin/bash
set -e

echo "=========================================="
echo "开始初始化openGauss数据库..."
echo "=========================================="

# 等待数据库完全启动
echo "等待openGauss数据库完全启动..."
sleep 5

# 检查数据库是否可用（最多等待60秒）
MAX_RETRIES=30
RETRY_COUNT=0

until gsql -h opengauss -p 5432 -U gaussdb -d hospital -c "SELECT 1;" > /dev/null 2>&1; do
  RETRY_COUNT=$((RETRY_COUNT + 1))
  if [ $RETRY_COUNT -ge $MAX_RETRIES ]; then
    echo "错误: 数据库连接超时，请检查数据库服务是否正常运行"
    exit 1
  fi
  echo "等待数据库就绪... ($RETRY_COUNT/$MAX_RETRIES)"
  sleep 2
done

echo "数据库已就绪！"

# 检查表是否已存在（避免重复初始化）
TABLE_COUNT=$(gsql -h opengauss -p 5432 -U gaussdb -d hospital -t -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'patients';" 2>/dev/null | tr -d ' ')

if [ "$TABLE_COUNT" = "1" ]; then
  echo "检测到数据库表已存在，跳过初始化..."
  echo "如需重新初始化，请先删除数据库表或删除Docker Volume"
else
  echo "开始执行数据库初始化脚本..."
  
  # 执行SQL脚本
  gsql -h opengauss -p 5432 -U gaussdb -d hospital -f /hospital_opengauss.sql
  
  echo "=========================================="
  echo "数据库初始化完成！"
  echo "=========================================="
fi

