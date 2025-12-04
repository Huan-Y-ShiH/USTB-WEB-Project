/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : hospital

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 18/07/2025 13:15:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admins
-- ----------------------------
DROP TABLE IF EXISTS `admins`;
CREATE TABLE `admins`  (
  `admin_id` int(0) NOT NULL COMMENT '管理员的唯一标识符',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理员的用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理员的密码',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理员的真实姓名',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理员的头像路径或图片名',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理员的电话号码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '管理员的电子邮箱',
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '这是管理员信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admins
-- ----------------------------
INSERT INTO `admins` VALUES (1, 'admin', '123456', '刘磊', 'avatar_admin1.jpg', '13512345678', 'admin@example.com');
INSERT INTO `admins` VALUES (2, 'chenmei12', 'Chen7890', '陈梅', 'avatar_admin2.jpg', '13623456789', 'chenmei@example.com');
INSERT INTO `admins` VALUES (3, 'wangyang23', 'Wang5678', '王洋', 'avatar_admin3.jpg', '13734567890', 'wangyang@example.com');

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement`  (
  `announcement_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '公告的唯一编号',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '公告标题',
  `imgurl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '公告内容',
  `creation_time` timestamp(0) DEFAULT CURRENT_TIMESTAMP COMMENT '公告创建时间',
  `creator` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '公告创建人',
  PRIMARY KEY (`announcement_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公告信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcement
-- ----------------------------
INSERT INTO `announcement` VALUES (1, '心内科最新进展', 'upload/202407131fdb4b141c2e4b588463f082ad631d82.jpg', '心内科最新进展', '2024-07-13 13:32:48', 'admin');
INSERT INTO `announcement` VALUES (5, '大昌市月报', 'upload/7323f17c-3337-4047-9628-20665ed852c7.jpg', '大昌市月报', '2025-07-15 00:00:00', '杨间');
INSERT INTO `announcement` VALUES (6, '翻斗花园第一人民医院月报', 'upload/26e9dd0f-1542-4eb3-af90-0d2094ae6dbe.jpg', '疫苗接种今日开始', '2025-07-18 00:00:00', '杨间');
INSERT INTO `announcement` VALUES (7, '北科校讯', 'upload/8afd9cf3-a84f-4294-b1ac-8fbacbcd6ca2.jpg', '认识实习即将结束', '2025-07-17 00:00:00', '老王');
INSERT INTO `announcement` VALUES (8, '实践日报', 'upload/fa3f308a-d3cc-44fc-95c0-92ef0d2a45dc.jpg', '答辩已经开始', '2025-07-18 00:00:00', '老陈');
INSERT INTO `announcement` VALUES (9, '暑期通知', 'upload/a1903944-669a-484d-aa37-a0d9bea494d6.jpg', '暑期安全要注意，游泳需要心智成熟的大人陪同', '2025-07-18 00:00:00', '老黄');

-- ----------------------------
-- Table structure for appointments
-- ----------------------------
DROP TABLE IF EXISTS `appointments`;
CREATE TABLE `appointments`  (
  `appointment_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '预约编号',
  `patient_id` int(0) DEFAULT NULL COMMENT '患者编号',
  `doctor_id` int(0) DEFAULT NULL COMMENT '医生编号',
  `appointment_date` date DEFAULT NULL COMMENT '预约的日期',
  `appointment_time` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '预约的具体时间',
  `status` enum('booked','completed','cancelled') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT 'booked' COMMENT '已预订、已完成或已取消',
  `createtime` datetime(0) DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`appointment_id`) USING BTREE,
  INDEX `patient_id`(`patient_id`) USING BTREE,
  INDEX `doctor_id`(`doctor_id`) USING BTREE,
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of appointments
-- ----------------------------
INSERT INTO `appointments` VALUES (1, 1, 1, '2024-06-27', '上午', 'booked', NULL);
INSERT INTO `appointments` VALUES (2, 2, 2, '2024-06-19', '上午', 'booked', NULL);
INSERT INTO `appointments` VALUES (3, 3, 1, '2024-06-10', '下午', 'cancelled', NULL);
INSERT INTO `appointments` VALUES (4, 7, 1, '2024-07-01', '上午', 'completed', NULL);
INSERT INTO `appointments` VALUES (5, 6, 1, '2024-07-01', '上午', 'completed', NULL);
INSERT INTO `appointments` VALUES (6, 8, 3, '2024-07-01', '下午', 'booked', NULL);
INSERT INTO `appointments` VALUES (7, 8, 1, '2024-07-01', '上午', 'booked', NULL);
INSERT INTO `appointments` VALUES (8, 8, 2, '2024-07-04', '下午', 'booked', NULL);
INSERT INTO `appointments` VALUES (9, 10, 1, '2024-07-12', '上午', 'booked', NULL);
INSERT INTO `appointments` VALUES (10, 10, 1, '2024-07-12', '上午', 'booked', NULL);
INSERT INTO `appointments` VALUES (11, 3, 1, '2024-07-15', '下午', 'booked', NULL);
INSERT INTO `appointments` VALUES (12, 3, 19, '2024-07-15', '上午', 'completed', NULL);
INSERT INTO `appointments` VALUES (13, 3, 19, '2024-07-16', '下午', 'booked', NULL);
INSERT INTO `appointments` VALUES (14, 3, 2, '2024-07-16', '上午', 'booked', NULL);
INSERT INTO `appointments` VALUES (15, 3, 6, '2024-07-16', '下午', 'booked', '2024-07-15 15:57:16');
INSERT INTO `appointments` VALUES (16, 3, 2, '2024-07-16', '上午', 'booked', '2024-07-15 16:03:48');
INSERT INTO `appointments` VALUES (17, 3, 1, '2024-10-01', '上午', 'booked', '2024-09-30 11:35:56');
INSERT INTO `appointments` VALUES (18, 5, 1, '2025-07-16', '上午', 'completed', '2025-07-16 16:59:34');
INSERT INTO `appointments` VALUES (22, 9, 6, '2025-07-17', '下午', 'cancelled', '2025-07-17 15:21:27');
INSERT INTO `appointments` VALUES (23, 7, 1, '2025-07-18', '上午', 'completed', '2025-07-18 12:49:52');

-- ----------------------------
-- Table structure for consultation
-- ----------------------------
DROP TABLE IF EXISTS `consultation`;
CREATE TABLE `consultation`  (
  `consultation_id` int(0) NOT NULL COMMENT '就诊编号，自增主键',
  `patient_id` int(0) DEFAULT NULL COMMENT '患者编号',
  `doctor_id` int(0) DEFAULT NULL COMMENT '医生编号',
  `consultation_time` timestamp(0) DEFAULT NULL COMMENT '就诊时间',
  `is_hospital_registered` tinyint(1) DEFAULT NULL COMMENT '是否住院登记',
  `is_hospitalized` tinyint(1) DEFAULT NULL COMMENT '是否住院',
  `medical_advice_case` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '医嘱病例',
  PRIMARY KEY (`consultation_id`) USING BTREE,
  INDEX `patient_id`(`patient_id`) USING BTREE,
  INDEX `doctor_id`(`doctor_id`) USING BTREE,
  CONSTRAINT `consultation_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `consultation_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of consultation
-- ----------------------------
INSERT INTO `consultation` VALUES (1, 10, 1, '2025-07-17 14:00:08', 0, 1, '没救了');
INSERT INTO `consultation` VALUES (2, 1, 1, '2025-07-18 12:42:31', 0, 0, '截肢');

-- ----------------------------
-- Table structure for departments
-- ----------------------------
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments`  (
  `department_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '科室编号',
  `department_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '科室名称',
  `department_pid` int(0) DEFAULT NULL COMMENT '上级科室编号',
  `department_level` int(0) DEFAULT NULL COMMENT '科室级别',
  `department_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '科室路径',
  `department_description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '科室描述',
  PRIMARY KEY (`department_id`) USING BTREE,
  INDEX `department_pid`(`department_pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of departments
-- ----------------------------
INSERT INTO `departments` VALUES (1, '内科', 0, 1, '|1|', '内科主要负责诊治内科系统的各种疾病。');
INSERT INTO `departments` VALUES (2, '外科', 0, 1, '|2|', '外科专注于通过手术等方式治疗各种外科病症。');
INSERT INTO `departments` VALUES (3, '儿科', 0, 1, '|3|', '儿科专门为儿童提供医疗服务。');
INSERT INTO `departments` VALUES (4, '妇产科', 0, 1, '|4|', '妇产科负责女性生殖系统的医疗和生育相关事务。');
INSERT INTO `departments` VALUES (5, '眼科', 0, 1, '|5|', '眼科专注于眼部疾病的诊断和治疗。');
INSERT INTO `departments` VALUES (6, '心内科', 1, 2, '|1||6|', '专注于心脏疾病的诊断与治疗，并获取国家级的认可');
INSERT INTO `departments` VALUES (7, '呼吸内科', 1, 2, '|1||7|', '诊治呼吸系统相关疾病');
INSERT INTO `departments` VALUES (8, '消化内科', 1, 2, '|1||8|', '处理消化系统疾病');
INSERT INTO `departments` VALUES (9, '神经内科', 1, 2, '|1||9|', '专注神经系统病症');
INSERT INTO `departments` VALUES (10, '内分泌科', 1, 2, '|1||10|', '处理内分泌相关问题');
INSERT INTO `departments` VALUES (11, '普外科', 2, 2, '|2||11|', '普通外科相关疾病诊治');
INSERT INTO `departments` VALUES (12, '骨科', 2, 2, '|2||12|', '骨骼相关疾病的治疗');
INSERT INTO `departments` VALUES (13, '泌尿外科', 2, 2, '|2||13|', '泌尿系统疾病的诊疗');
INSERT INTO `departments` VALUES (14, '神经外科', 2, 2, '|2||14|', '神经系统外科疾病');
INSERT INTO `departments` VALUES (15, '儿科呼吸科', 3, 2, '|3||15|', '儿童呼吸系统疾病');
INSERT INTO `departments` VALUES (16, '儿科消化科', 3, 2, '|3||16|', '儿童消化系统疾病');
INSERT INTO `departments` VALUES (17, '妇产科产科', 4, 2, '|4||17|', '产科相关事务');
INSERT INTO `departments` VALUES (18, '妇产科妇科', 4, 2, '|4||18|', '妇科相关疾病');
INSERT INTO `departments` VALUES (19, '眼科屈光科', 5, 2, '|5||19|', '屈光相关问题处理');
INSERT INTO `departments` VALUES (37, '眼科test', 5, 2, '|5||37|', '眼科test');
INSERT INTO `departments` VALUES (42, '眼科test', 0, 1, '|42|', '眼科test');
INSERT INTO `departments` VALUES (44, 'test1111', 3, 2, '|3||44|', '特斯特');
INSERT INTO `departments` VALUES (45, '测试7-9', 0, 1, '|45|', '7-0测试科室');
INSERT INTO `departments` VALUES (54, '测试7-9', 45, 2, '|45||54|', '7-0测试科室');
INSERT INTO `departments` VALUES (59, '灵异事件特行处', 0, 1, '|59|', '灵异事件特行处');
INSERT INTO `departments` VALUES (60, '测试7-9', 45, 2, '|45||60|', '7-0测试科室');

-- ----------------------------
-- Table structure for doctor_schedule
-- ----------------------------
DROP TABLE IF EXISTS `doctor_schedule`;
CREATE TABLE `doctor_schedule`  (
  `schedule_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '排班记录的唯一标识符',
  `doctor_id` int(0) DEFAULT NULL COMMENT '医生的唯一标识符',
  `date` date DEFAULT NULL COMMENT '排班的日期',
  `shift_time` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '具体的排班时间',
  `department_id` int(0) DEFAULT NULL COMMENT '所属科室的标识符',
  `is_available` tinyint(1) DEFAULT 0 COMMENT '是否可排班0 可排班 1 不可排班',
  `visit_count` int(0) DEFAULT 0 COMMENT '就诊数量',
  `sum_count` int(0) DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '备注信息',
  PRIMARY KEY (`schedule_id`) USING BTREE,
  INDEX `doctor_id`(`doctor_id`) USING BTREE,
  INDEX `department_id`(`department_id`) USING BTREE,
  CONSTRAINT `doctor_schedule_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`doctor_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `doctor_schedule_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '医院医生多天排班表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctor_schedule
-- ----------------------------
INSERT INTO `doctor_schedule` VALUES (11, 20, '2024-07-14', '上午', 6, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (12, 20, '2024-07-14', '下午', 6, 1, 0, 80, NULL);
INSERT INTO `doctor_schedule` VALUES (15, 20, '2024-07-15', '上午', 6, 1, 0, 80, NULL);
INSERT INTO `doctor_schedule` VALUES (16, 20, '2024-07-15', '下午', 6, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (19, 20, '2024-07-16', '上午', 6, 1, 0, 50, NULL);
INSERT INTO `doctor_schedule` VALUES (20, 20, '2024-07-16', '下午', 6, 1, 0, 50, NULL);
INSERT INTO `doctor_schedule` VALUES (23, 20, '2024-07-17', '上午', 6, 1, 0, 50, NULL);
INSERT INTO `doctor_schedule` VALUES (24, 20, '2024-07-17', '下午', 6, 1, 0, 50, NULL);
INSERT INTO `doctor_schedule` VALUES (27, 20, '2024-07-18', '上午', 6, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (28, 20, '2024-07-18', '下午', 6, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (29, 2, '2024-07-14', '上午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (30, 2, '2024-07-14', '下午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (31, 19, '2024-07-14', '上午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (32, 19, '2024-07-14', '下午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (33, 2, '2024-07-15', '上午', 7, 1, 0, 50, NULL);
INSERT INTO `doctor_schedule` VALUES (34, 2, '2024-07-15', '下午', 7, 1, 0, 50, NULL);
INSERT INTO `doctor_schedule` VALUES (35, 19, '2024-07-15', '上午', 7, 1, 1, 50, NULL);
INSERT INTO `doctor_schedule` VALUES (36, 19, '2024-07-15', '下午', 7, 1, 0, 80, NULL);
INSERT INTO `doctor_schedule` VALUES (37, 2, '2024-07-16', '上午', 7, 1, 2, 80, NULL);
INSERT INTO `doctor_schedule` VALUES (38, 2, '2024-07-16', '下午', 7, 1, 0, 10, NULL);
INSERT INTO `doctor_schedule` VALUES (39, 19, '2024-07-16', '上午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (40, 19, '2024-07-16', '下午', 7, 1, 2, 20, NULL);
INSERT INTO `doctor_schedule` VALUES (41, 2, '2024-07-17', '上午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (42, 2, '2024-07-17', '下午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (43, 19, '2024-07-17', '上午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (44, 19, '2024-07-17', '下午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (47, 20, '2024-10-01', '上午', 6, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (48, 20, '2024-10-01', '下午', 6, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (49, 2, '2024-10-01', '上午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (50, 2, '2024-10-01', '下午', 7, 1, 0, 20, NULL);
INSERT INTO `doctor_schedule` VALUES (51, 19, '2024-10-01', '上午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (52, 19, '2024-10-01', '下午', 7, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (55, 20, '2024-10-17', '上午', 6, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (56, 20, '2024-10-17', '下午', 6, 0, 0, NULL, NULL);
INSERT INTO `doctor_schedule` VALUES (57, 4, '2025-07-17', '上午', 9, 1, 0, 60, '');
INSERT INTO `doctor_schedule` VALUES (59, 1, '2025-07-18', '上午', 6, 1, 0, 1, '');

-- ----------------------------
-- Table structure for doctors
-- ----------------------------
DROP TABLE IF EXISTS `doctors`;
CREATE TABLE `doctors`  (
  `doctor_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '医生的唯一标识符',
  `job_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '医生的工号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '医生的密码',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '医生的姓名',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '医生的头像路径或图片名',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '医生的电话号码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '医生的电子邮箱',
  `introduction` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '医生的简介',
  `registration_fee` decimal(10, 2) DEFAULT NULL COMMENT '挂号费',
  `entry_date` date DEFAULT NULL COMMENT '入职日期',
  `department_id` int(0) DEFAULT NULL COMMENT '所属科室的标识符',
  `professional_title_id` int(0) DEFAULT NULL COMMENT '职称的标识符',
  `state` int(0) DEFAULT 0 COMMENT '0,正常，1删除',
  PRIMARY KEY (`doctor_id`) USING BTREE,
  INDEX `department_id`(`department_id`) USING BTREE,
  INDEX `professional_title_id`(`professional_title_id`) USING BTREE,
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `doctors_ibfk_2` FOREIGN KEY (`professional_title_id`) REFERENCES `professional_titles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '医生信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of doctors
-- ----------------------------
INSERT INTO `doctors` VALUES (1, '10001', '1234567', '李华', 'upload/8c4ab789-9924-4b33-9207-b33c18e013dd.jpg', '13800002223', 'lihua@example.com', '李华医生毕业于知名医科大学，从事心内科临床工作多年。擅长各类心脏疾病的诊断与治疗，如冠心病、心肌病等。在治疗过程中，注重与患者的沟通和心理疏导，深受患者信赖。11111', 60.00, '2024-05-01', 6, 2, 0);
INSERT INTO `doctors` VALUES (2, '10002', '234567', '张华', 'upload/2012121721450278.jpg', '13900002222', 'zhanghua@example.com', '张华医生在呼吸内科领域积累了丰富的经验，熟练掌握各种呼吸系统疾病的诊断和治疗方法，如肺炎、哮喘等。多次参与疑难病症的会诊，以精准的诊断和有效的治疗方案赢得了同行和患者的赞誉。', 80.00, '2019-03-15', 7, 1, 0);
INSERT INTO `doctors` VALUES (3, '10003', '345678', '王强', 'upload/2012122009564745.jpg', '15800003333', 'wangqiang@example.com', '王强医生专注于消化内科，对胃肠道疾病的诊断和治疗有着深入的研究。擅长运用先进的医疗技术和个性化的治疗方案，为患者解决病痛。在学术方面也积极参与科研项目，为消化内科的发展做出了贡献。', 60.00, '2021-07-20', 8, 3, 0);
INSERT INTO `doctors` VALUES (4, '10004', '456789', '赵刚', 'upload/2012121916201285.jpg', '18700004444', 'zhaogang@example.com', '赵刚医生在神经内科领域造诣深厚，能够准确诊断和治疗各种神经系统疾病，如帕金森病、癫痫等。以其严谨的医疗态度和关怀备至的服务，赢得了患者的良好口碑。', 70.00, '2018-11-05', 9, 1, 0);
INSERT INTO `doctors` VALUES (5, '10005', '567890', '孙敏', 'upload/2012121819450318.jpg', '17600005555', 'unmin@example.com', '孙敏医生在内分泌科工作多年，对糖尿病、甲状腺疾病等内分泌疾病的诊治有着丰富的临床经验。注重患者的健康教育和生活方式指导，帮助患者更好地控制病情。', 90.00, '2017-09-12', 10, 2, 0);
INSERT INTO `doctors` VALUES (6, '10006', '678901', '周婷', 'upload/2012121916580751.jpg', '16700006666', 'zhouting@example.com', '周婷医生在普外科有着出色的表现，熟练操作各种普通外科手术，如阑尾切除术、胆囊切除术等。对待患者耐心细致，术后护理指导到位，促进了患者的快速康复。', 100.00, '2022-02-28', 11, 3, 0);
INSERT INTO `doctors` VALUES (7, '10007', '789012', '吴勇', 'upload/2012121911592436.jpg', '15600007777', 'wuyong@example.com', '吴勇医生在骨科领域深耕细作，擅长骨折的治疗和关节疾病的诊治。积极引进新技术、新方法，为患者提供优质的医疗服务，在同行中具有较高的声誉。', 75.00, '2023-01-05', 12, 1, 0);
INSERT INTO `doctors` VALUES (8, '10008', '890123', '郑丽', 'upload/2013070310490228.jpg', '14500008888', 'zhengli@example.com', '郑丽医生专注于泌尿外科，对泌尿系统结石、肿瘤等疾病的诊断和治疗有着丰富的经验。注重患者的隐私保护和心理支持，让患者在治疗过程中感受到温暖和关怀。', 85.00, '2020-11-18', 13, 2, 0);
INSERT INTO `doctors` VALUES (9, '10009', '901234', '王霞', 'upload/2016032608442264.png', '13400009999', 'wangxia@example.com', '王霞医生在神经外科方面表现出色，参与了众多复杂神经外科手术，具备精湛的手术技巧和丰富的临床经验。同时，注重术后患者的康复指导和跟踪治疗。', 65.00, '2019-08-05', 14, 3, 0);
INSERT INTO `doctors` VALUES (10, '10010', '012345', '李娜', 'upload/2015110710563694.jpg', '12300000000', 'lina@example.com', '李娜医生在儿科呼吸科工作，对儿童呼吸道感染、哮喘等疾病的诊治有着独特的见解和方法。善于与患儿及其家属沟通，以亲切和蔼的态度受到患儿和家长的喜爱。', 70.00, '2021-06-30', 15, 1, 0);
INSERT INTO `doctors` VALUES (11, '10011', '123456', '白华', 'upload/201603221527067.png', '13800001111', 'lihua@example.com', '白华医生毕业于知名医科大学，从事心内科临床工作多年。擅长各类心脏疾病的诊断与治疗，如冠心病、心肌病等。在治疗过程中，注重与患者的沟通和心理疏导，深受患者信赖。', 50.00, '2020-05-01', 15, 1, 0);
INSERT INTO `doctors` VALUES (12, '10012', '234567', '张苗', 'upload/2012121721450278.jpg', '13900002222', 'zhanghua@example.com', '张苗医生在呼吸内科领域积累了丰富的经验，熟练掌握各种呼吸系统疾病的诊断和治疗方法，如肺炎、哮喘等。多次参与疑难病症的会诊，以精准的诊断和有效的治疗方案赢得了同行和患者的赞誉。', 80.00, '2019-03-15', 14, 2, 0);
INSERT INTO `doctors` VALUES (13, '10013', '345678', '王菁', 'upload/2012122009564745.jpg', '15800003333', 'wangqiang@example.com', '王菁医生专注于消化内科，对胃肠道疾病的诊断和治疗有着深入的研究。擅长运用先进的医疗技术和个性化的治疗方案，为患者解决病痛。在学术方面也积极参与科研项目，为消化内科的发展做出了贡献。', 60.00, '2021-07-20', 13, 3, 0);
INSERT INTO `doctors` VALUES (14, '10014', '456789', '李刚', 'upload/2012121916201285.jpg', '18700004444', 'zhaogang@example.com', '李刚医生在神经内科领域造诣深厚，能够准确诊断和治疗各种神经系统疾病，如帕金森病、癫痫等。以其严谨的医疗态度和关怀备至的服务，赢得了患者的良好口碑。', 70.00, '2018-11-05', 12, 1, 0);
INSERT INTO `doctors` VALUES (15, '10015', '567890', '赵敏', 'upload/2012121819450318.jpg', '17600005555', 'unmin@example.com', '赵敏医生在内分泌科工作多年，对糖尿病、甲状腺疾病等内分泌疾病的诊治有着丰富的临床经验。注重患者的健康教育和生活方式指导，帮助患者更好地控制病情。', 90.00, '2017-09-12', 11, 2, 0);
INSERT INTO `doctors` VALUES (16, '10016', '678901', '孙婷', 'upload/2012121916580751.jpg', '16700006666', 'zhouting@example.com', '孙婷医生在普外科有着出色的表现，熟练操作各种普通外科手术，如阑尾切除术、胆囊切除术等。对待患者耐心细致，术后护理指导到位，促进了患者的快速康复。', 100.00, '2022-02-28', 10, 3, 0);
INSERT INTO `doctors` VALUES (17, '10017', '789012', '周勇', 'upload/2012121911592436.jpg', '15600007777', 'wuyong@example.com', '周勇医生在骨科领域深耕细作，擅长骨折的治疗和关节疾病的诊治。积极引进新技术、新方法，为患者提供优质的医疗服务，在同行中具有较高的声誉。', 75.00, '2023-01-05', 9, 1, 0);
INSERT INTO `doctors` VALUES (18, '10018', '890123', '张丽', 'upload/2013070310490228.jpg', '14500008888', 'zhengli@example.com', '张丽医生专注于泌尿外科，对泌尿系统结石、肿瘤等疾病的诊断和治疗有着丰富的经验。注重患者的隐私保护和心理支持，让患者在治疗过程中感受到温暖和关怀。', 85.00, '2020-11-18', 8, 2, 0);
INSERT INTO `doctors` VALUES (19, '10019', '901234', '李霞', 'upload/2016032608442264.png', '13400009999', 'wangxia@example.com', '李霞医生在神经外科方面表现出色，参与了众多复杂神经外科手术，具备精湛的手术技巧和丰富的临床经验。同时，注重术后患者的康复指导和跟踪治疗。', 65.00, '2019-08-05', 7, 3, 0);
INSERT INTO `doctors` VALUES (20, '10020', '012345', '张娜', 'upload/2015110710563694.jpg', '12300000000', 'lina@example.com', '张娜医生在儿科呼吸科工作，对儿童呼吸道感染、哮喘等疾病的诊治有着独特的见解和方法。善于与患儿及其家属沟通，以亲切和蔼的态度受到患儿和家长的喜爱。', 70.00, '2021-06-30', 6, 1, 0);
INSERT INTO `doctors` VALUES (40, '10021', '012348', '杨间', 'upload/3b18c2e9-89c0-4489-8726-e964cc0ecac2.jpg', '18801039624', '18801039624@163.com', '御鬼者，亦或是鬼驱人，人引冥途', 10000.00, '2025-07-11', 9, 3, 0);
INSERT INTO `doctors` VALUES (43, '10023', '012351', '刘卡', 'upload/442976ec-518b-415d-9e83-db35405bef79.jpg', '18801039628', '18801039628@163.com', '刘卡', 50.00, '2025-07-17', 37, 4, 0);
INSERT INTO `doctors` VALUES (45, '10022', '012349', '齐夏', 'upload/cb15a1dc-e63e-4fa2-af98-b7e3d950607f.jpg', '18801039625', '18801039625@163.com', '十日终焉', 1000.00, '2025-07-17', 14, 3, 0);

-- ----------------------------
-- Table structure for hospitalization
-- ----------------------------
DROP TABLE IF EXISTS `hospitalization`;
CREATE TABLE `hospitalization`  (
  `hospitalization_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '住院记录的唯一标识符',
  `patient_id` int(0) DEFAULT NULL COMMENT '患者的标识符',
  `room_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '病房号',
  `cost` decimal(10, 2) DEFAULT NULL COMMENT '住院费用',
  `payment_status` enum('paid','unpaid','partially_paid') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '支付状态（已支付、未支付、部分支付）',
  `is_insured` tinyint(1) DEFAULT NULL COMMENT '是否有保险',
  `hospitalization_status` enum('admitted','discharged','in_progress') CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '住院状态（已入院、已出院、进行中）',
  PRIMARY KEY (`hospitalization_id`) USING BTREE,
  INDEX `patient_id`(`patient_id`) USING BTREE,
  CONSTRAINT `hospitalization_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '住院信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hospitalization
-- ----------------------------
INSERT INTO `hospitalization` VALUES (1, 10, '101', 200.00, 'unpaid', 1, 'admitted');
INSERT INTO `hospitalization` VALUES (2, 1, '102', 200.00, 'unpaid', 1, 'in_progress');
INSERT INTO `hospitalization` VALUES (3, 1, '103', 200.00, 'paid', 1, 'admitted');

-- ----------------------------
-- Table structure for patients
-- ----------------------------
DROP TABLE IF EXISTS `patients`;
CREATE TABLE `patients`  (
  `patient_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '患者的唯一标识符',
  `id_card_number` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '身份证号码',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '密码',
  `pname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '姓名',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '头像路径或图片名',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电话号码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '电子邮箱',
  `balance` decimal(10, 2) DEFAULT NULL COMMENT '账户余额',
  PRIMARY KEY (`patient_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '患者信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of patients
-- ----------------------------
INSERT INTO `patients` VALUES (1, '110101199001011234', 'pass123', '赵一', 'avatar1.jpg', '13012345678', 'zhaoyi@example.com', 500.00);
INSERT INTO `patients` VALUES (2, '110102198505052345', 'pass456', '钱二', 'avatar2.jpg', '13123456789', 'qianer@example.com', 800.00);
INSERT INTO `patients` VALUES (3, '110103199208083456', 'pass789', '孙三', 'avatar3.jpg', '13234567890', 'unsan@example.com', 300.00);
INSERT INTO `patients` VALUES (4, '110104198811114567', 'pass012', '李四', 'avatar4.jpg', '13345678901', 'lisi@example.com', 600.00);
INSERT INTO `patients` VALUES (5, '110105199503035678', 'pass345', '周五', 'avatar5.jpg', '13456789012', 'zhouwu@example.com', 400.00);
INSERT INTO `patients` VALUES (6, '110106198207076789', 'pass678', '吴六', 'avatar6.jpg', '13567890123', 'wuliu@example.com', 700.00);
INSERT INTO `patients` VALUES (7, '110107199809097890', 'pass901', '郑七', 'avatar7.jpg', '13678901234', 'zhengqi@example.com', 200.00);
INSERT INTO `patients` VALUES (8, '110108198612128901', 'pass234', '王八', 'avatar8.jpg', '13789012345', 'wangba@example.com', 900.00);
INSERT INTO `patients` VALUES (9, '110109199304049012', 'pass567', '冯九', 'avatar9.jpg', '13890123456', 'fengjiu@example.com', 350.00);
INSERT INTO `patients` VALUES (10, '110110198906060123', 'pass890', '陈十', 'avatar10.jpg', '13901234567', 'chenshi@example.com', 550.00);

-- ----------------------------
-- Table structure for professional_titles
-- ----------------------------
DROP TABLE IF EXISTS `professional_titles`;
CREATE TABLE `professional_titles`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of professional_titles
-- ----------------------------
INSERT INTO `professional_titles` VALUES (1, '主任医师', '医院中最高级别的医师职称');
INSERT INTO `professional_titles` VALUES (2, '副主任医师', '仅次于主任医师的职称');
INSERT INTO `professional_titles` VALUES (3, '主治医师', '具有一定独立诊疗能力的中级职称');
INSERT INTO `professional_titles` VALUES (4, '住院医师', '处于初级阶段的医师');
INSERT INTO `professional_titles` VALUES (5, '实习医师', '处于实习阶段，尚未获得正式职称');
INSERT INTO `professional_titles` VALUES (12, '御鬼者', '以身养鬼，亦或是鬼驱人，人借鬼势\r\n');

SET FOREIGN_KEY_CHECKS = 1;
