#!/bin/bash
set -e

echo "等待openGauss数据库启动..."
sleep 10

echo "开始初始化数据库..."

# 使用gsql执行SQL脚本
gsql -U gaussdb -d hospital -f /docker-entrypoint-initdb.d/hospital_opengauss.sql

echo "数据库初始化完成！"

