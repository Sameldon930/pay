/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : install

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2018-09-19 20:18:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pay_admin
-- ----------------------------
DROP TABLE IF EXISTS `pay_admin`;
CREATE TABLE `pay_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `username` varchar(50) NOT NULL COMMENT '后台用户名',
  `password` varchar(32) NOT NULL COMMENT '后台用户密码',
  `groupid` tinyint(1) unsigned DEFAULT '0' COMMENT '用户组',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `google_secret_key` varchar(128) NOT NULL DEFAULT '' COMMENT '谷歌令牌密钥',
  `mobile` varchar(255) NOT NULL DEFAULT '' COMMENT '手机号码',
  `session_random` varchar(50) NOT NULL DEFAULT '' COMMENT 'session随机字符串',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_admin
-- ----------------------------
INSERT INTO `pay_admin` VALUES ('1', 'adminroot', '81b5234976a55e5181f24d9eab8fb697', '1', '0', '', '', '');

-- ----------------------------
-- Table structure for pay_apimoney
-- ----------------------------
DROP TABLE IF EXISTS `pay_apimoney`;
CREATE TABLE `pay_apimoney` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL DEFAULT '0',
  `payapiid` int(11) DEFAULT NULL,
  `money` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `freezemoney` decimal(15,3) NOT NULL DEFAULT '0.000' COMMENT '冻结金额',
  `status` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_apimoney
-- ----------------------------
INSERT INTO `pay_apimoney` VALUES ('10', '6', '207', '18000.0000', '0.000', '1');

-- ----------------------------
-- Table structure for pay_area_city
-- ----------------------------
DROP TABLE IF EXISTS `pay_area_city`;
CREATE TABLE `pay_area_city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `province_code` varchar(10) DEFAULT NULL,
  `code` varchar(10) DEFAULT NULL COMMENT '城市编号',
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=430 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_area_city
-- ----------------------------
INSERT INTO `pay_area_city` VALUES ('1', '24', '2510', '松原市');
INSERT INTO `pay_area_city` VALUES ('2', '26', '2610', '哈尔滨市');
INSERT INTO `pay_area_city` VALUES ('3', '26', '2640', '齐齐哈尔市');
INSERT INTO `pay_area_city` VALUES ('4', '26', '2660', '鸡西市');
INSERT INTO `pay_area_city` VALUES ('5', '26', '2670', '鹤岗市');
INSERT INTO `pay_area_city` VALUES ('6', '26', '2680', '双鸭山市');
INSERT INTO `pay_area_city` VALUES ('7', '26', '2690', '大庆市');
INSERT INTO `pay_area_city` VALUES ('8', '26', '2710', '伊春市');
INSERT INTO `pay_area_city` VALUES ('9', '26', '2720', '佳木斯市');
INSERT INTO `pay_area_city` VALUES ('10', '26', '2740', '七台河市');
INSERT INTO `pay_area_city` VALUES ('11', '26', '2750', '牡丹江市');
INSERT INTO `pay_area_city` VALUES ('12', '26', '2760', '绥化市');
INSERT INTO `pay_area_city` VALUES ('13', '26', '2780', '黑河市');
INSERT INTO `pay_area_city` VALUES ('14', '26', '2790', '大兴安岭地区');
INSERT INTO `pay_area_city` VALUES ('15', '29', '2901', '松江区');
INSERT INTO `pay_area_city` VALUES ('16', '29', '2902', '青浦区');
INSERT INTO `pay_area_city` VALUES ('17', '29', '2903', '奉贤区');
INSERT INTO `pay_area_city` VALUES ('18', '29', '2904', '浦东新区');
INSERT INTO `pay_area_city` VALUES ('19', '29', '2905', '金山区');
INSERT INTO `pay_area_city` VALUES ('20', '29', '2906', '闵行区');
INSERT INTO `pay_area_city` VALUES ('21', '29', '2907', '黄浦区');
INSERT INTO `pay_area_city` VALUES ('22', '29', '2908', '徐汇区');
INSERT INTO `pay_area_city` VALUES ('23', '29', '2909', '长宁区');
INSERT INTO `pay_area_city` VALUES ('24', '29', '2911', '静安区');
INSERT INTO `pay_area_city` VALUES ('25', '29', '2912', '普陀区');
INSERT INTO `pay_area_city` VALUES ('26', '29', '2913', '闸北区');
INSERT INTO `pay_area_city` VALUES ('27', '29', '2914', '虹口区');
INSERT INTO `pay_area_city` VALUES ('28', '29', '2915', '杨浦区');
INSERT INTO `pay_area_city` VALUES ('29', '29', '2916', '宝山区');
INSERT INTO `pay_area_city` VALUES ('30', '29', '2917', '嘉定区');
INSERT INTO `pay_area_city` VALUES ('31', '29', '2929', '崇明县');
INSERT INTO `pay_area_city` VALUES ('32', '30', '3010', '南京市');
INSERT INTO `pay_area_city` VALUES ('33', '30', '3020', '无锡市');
INSERT INTO `pay_area_city` VALUES ('34', '30', '3030', '徐州市');
INSERT INTO `pay_area_city` VALUES ('35', '30', '3040', '常州市');
INSERT INTO `pay_area_city` VALUES ('36', '30', '3050', '苏州市');
INSERT INTO `pay_area_city` VALUES ('37', '30', '3060', '南通市');
INSERT INTO `pay_area_city` VALUES ('38', '30', '3070', '连云港市');
INSERT INTO `pay_area_city` VALUES ('39', '30', '3080', '淮安市');
INSERT INTO `pay_area_city` VALUES ('40', '30', '3110', '盐城市');
INSERT INTO `pay_area_city` VALUES ('41', '30', '3120', '扬州市');
INSERT INTO `pay_area_city` VALUES ('42', '30', '3140', '镇江市');
INSERT INTO `pay_area_city` VALUES ('43', '30', '3160', '泰州市');
INSERT INTO `pay_area_city` VALUES ('44', '30', '3180', '宿迁市');
INSERT INTO `pay_area_city` VALUES ('45', '33', '3310', '杭州市');
INSERT INTO `pay_area_city` VALUES ('46', '33', '3320', '宁波市');
INSERT INTO `pay_area_city` VALUES ('47', '33', '3330', '温州市');
INSERT INTO `pay_area_city` VALUES ('48', '33', '3350', '嘉兴市');
INSERT INTO `pay_area_city` VALUES ('49', '33', '3360', '湖州市');
INSERT INTO `pay_area_city` VALUES ('50', '33', '3370', '绍兴市');
INSERT INTO `pay_area_city` VALUES ('51', '33', '3380', '金华市');
INSERT INTO `pay_area_city` VALUES ('52', '33', '3410', '衢州市');
INSERT INTO `pay_area_city` VALUES ('53', '33', '3420', '舟山市');
INSERT INTO `pay_area_city` VALUES ('54', '33', '3430', '丽水市');
INSERT INTO `pay_area_city` VALUES ('55', '33', '3450', '台州市');
INSERT INTO `pay_area_city` VALUES ('56', '36', '3610', '合肥市');
INSERT INTO `pay_area_city` VALUES ('57', '36', '3620', '芜湖市');
INSERT INTO `pay_area_city` VALUES ('58', '36', '3630', '蚌埠市');
INSERT INTO `pay_area_city` VALUES ('59', '36', '3640', '淮南市');
INSERT INTO `pay_area_city` VALUES ('60', '36', '3650', '马鞍山市');
INSERT INTO `pay_area_city` VALUES ('61', '36', '3660', '淮北市');
INSERT INTO `pay_area_city` VALUES ('62', '36', '3670', '铜陵市');
INSERT INTO `pay_area_city` VALUES ('63', '36', '3680', '安庆市');
INSERT INTO `pay_area_city` VALUES ('64', '36', '3710', '黄山市');
INSERT INTO `pay_area_city` VALUES ('65', '36', '3720', '阜阳市');
INSERT INTO `pay_area_city` VALUES ('66', '36', '3740', '宿州市');
INSERT INTO `pay_area_city` VALUES ('67', '36', '3750', '滁州市');
INSERT INTO `pay_area_city` VALUES ('68', '36', '3760', '六安市');
INSERT INTO `pay_area_city` VALUES ('69', '36', '3770', '宣城市');
INSERT INTO `pay_area_city` VALUES ('70', '36', '3790', '池州市');
INSERT INTO `pay_area_city` VALUES ('71', '36', '3810', '亳州市');
INSERT INTO `pay_area_city` VALUES ('72', '39', '3910', '福州市');
INSERT INTO `pay_area_city` VALUES ('73', '39', '3930', '厦门市');
INSERT INTO `pay_area_city` VALUES ('74', '39', '3940', '莆田市');
INSERT INTO `pay_area_city` VALUES ('75', '39', '3950', '三明市');
INSERT INTO `pay_area_city` VALUES ('76', '39', '3970', '泉州市');
INSERT INTO `pay_area_city` VALUES ('77', '39', '3990', '漳州市');
INSERT INTO `pay_area_city` VALUES ('78', '39', '4010', '南平市');
INSERT INTO `pay_area_city` VALUES ('79', '39', '4030', '宁德市');
INSERT INTO `pay_area_city` VALUES ('80', '39', '4050', '龙岩市');
INSERT INTO `pay_area_city` VALUES ('81', '42', '4210', '南昌市');
INSERT INTO `pay_area_city` VALUES ('82', '42', '4220', '景德镇市');
INSERT INTO `pay_area_city` VALUES ('83', '42', '4230', '萍乡市');
INSERT INTO `pay_area_city` VALUES ('84', '42', '4240', '九江市');
INSERT INTO `pay_area_city` VALUES ('85', '42', '4260', '新余市');
INSERT INTO `pay_area_city` VALUES ('86', '42', '4270', '鹰潭市');
INSERT INTO `pay_area_city` VALUES ('87', '42', '4280', '赣州市');
INSERT INTO `pay_area_city` VALUES ('88', '42', '4310', '宜春市');
INSERT INTO `pay_area_city` VALUES ('89', '42', '4330', '上饶市');
INSERT INTO `pay_area_city` VALUES ('90', '42', '4350', '吉安市');
INSERT INTO `pay_area_city` VALUES ('91', '42', '4370', '抚州市');
INSERT INTO `pay_area_city` VALUES ('92', '45', '4510', '济南市');
INSERT INTO `pay_area_city` VALUES ('93', '45', '4520', '青岛市');
INSERT INTO `pay_area_city` VALUES ('94', '45', '4530', '淄博市');
INSERT INTO `pay_area_city` VALUES ('95', '45', '4540', '枣庄市');
INSERT INTO `pay_area_city` VALUES ('96', '45', '4550', '东营市');
INSERT INTO `pay_area_city` VALUES ('97', '45', '4560', '烟台市');
INSERT INTO `pay_area_city` VALUES ('98', '45', '4580', '潍坊市');
INSERT INTO `pay_area_city` VALUES ('99', '45', '4610', '济宁市');
INSERT INTO `pay_area_city` VALUES ('100', '45', '4630', '泰安市');
INSERT INTO `pay_area_city` VALUES ('101', '45', '4650', '威海市');
INSERT INTO `pay_area_city` VALUES ('102', '45', '4660', '滨州市');
INSERT INTO `pay_area_city` VALUES ('103', '45', '4680', '德州市');
INSERT INTO `pay_area_city` VALUES ('104', '45', '4710', '聊城市');
INSERT INTO `pay_area_city` VALUES ('105', '45', '4730', '临沂市');
INSERT INTO `pay_area_city` VALUES ('106', '45', '4750', '菏泽市');
INSERT INTO `pay_area_city` VALUES ('107', '45', '4770', '日照市');
INSERT INTO `pay_area_city` VALUES ('108', '49', '4910', '郑州市');
INSERT INTO `pay_area_city` VALUES ('109', '49', '4920', '开封市');
INSERT INTO `pay_area_city` VALUES ('110', '49', '4930', '洛阳市');
INSERT INTO `pay_area_city` VALUES ('111', '49', '4950', '平顶山市');
INSERT INTO `pay_area_city` VALUES ('112', '49', '4960', '安阳市');
INSERT INTO `pay_area_city` VALUES ('113', '49', '4970', '鹤壁市');
INSERT INTO `pay_area_city` VALUES ('114', '49', '4980', '新乡市');
INSERT INTO `pay_area_city` VALUES ('115', '49', '5010', '焦作市');
INSERT INTO `pay_area_city` VALUES ('116', '49', '5020', '濮阳市');
INSERT INTO `pay_area_city` VALUES ('117', '49', '5030', '许昌市');
INSERT INTO `pay_area_city` VALUES ('118', '49', '5040', '漯河市');
INSERT INTO `pay_area_city` VALUES ('119', '49', '5050', '三门峡市');
INSERT INTO `pay_area_city` VALUES ('120', '10', '1021', '东城区');
INSERT INTO `pay_area_city` VALUES ('121', '10', '1022', '西城区');
INSERT INTO `pay_area_city` VALUES ('122', '10', '1023', '朝阳区');
INSERT INTO `pay_area_city` VALUES ('123', '10', '1024', '丰台区');
INSERT INTO `pay_area_city` VALUES ('124', '10', '1025', '石景山区');
INSERT INTO `pay_area_city` VALUES ('125', '10', '1026', '海淀区');
INSERT INTO `pay_area_city` VALUES ('126', '10', '1027', '密云县');
INSERT INTO `pay_area_city` VALUES ('127', '10', '1028', '延庆县');
INSERT INTO `pay_area_city` VALUES ('128', '10', '1029', '门头沟区');
INSERT INTO `pay_area_city` VALUES ('129', '10', '1031', '通州区');
INSERT INTO `pay_area_city` VALUES ('130', '10', '1032', '顺义区');
INSERT INTO `pay_area_city` VALUES ('131', '10', '1033', '昌平区');
INSERT INTO `pay_area_city` VALUES ('132', '10', '1034', '大兴区');
INSERT INTO `pay_area_city` VALUES ('133', '10', '1035', '平谷区');
INSERT INTO `pay_area_city` VALUES ('134', '10', '1036', '房山区');
INSERT INTO `pay_area_city` VALUES ('135', '10', '1039', '怀柔区');
INSERT INTO `pay_area_city` VALUES ('136', '11', '1121', '宁河县');
INSERT INTO `pay_area_city` VALUES ('137', '11', '1123', '静海县');
INSERT INTO `pay_area_city` VALUES ('138', '11', '1124', '北辰区');
INSERT INTO `pay_area_city` VALUES ('139', '11', '1125', '蓟县');
INSERT INTO `pay_area_city` VALUES ('140', '11', '1126', '宝坻区');
INSERT INTO `pay_area_city` VALUES ('141', '11', '1127', '滨海新区');
INSERT INTO `pay_area_city` VALUES ('142', '11', '1128', '和平区');
INSERT INTO `pay_area_city` VALUES ('143', '11', '1129', '河东区');
INSERT INTO `pay_area_city` VALUES ('144', '11', '1131', '河西区');
INSERT INTO `pay_area_city` VALUES ('145', '11', '1132', '南开区');
INSERT INTO `pay_area_city` VALUES ('146', '11', '1133', '河北区');
INSERT INTO `pay_area_city` VALUES ('147', '11', '1134', '红桥区');
INSERT INTO `pay_area_city` VALUES ('148', '11', '1135', '东丽区');
INSERT INTO `pay_area_city` VALUES ('149', '11', '1136', '西青区');
INSERT INTO `pay_area_city` VALUES ('150', '11', '1137', '津南区');
INSERT INTO `pay_area_city` VALUES ('151', '11', '1138', '武清区');
INSERT INTO `pay_area_city` VALUES ('152', '12', '1210', '石家庄市');
INSERT INTO `pay_area_city` VALUES ('153', '12', '1240', '唐山市');
INSERT INTO `pay_area_city` VALUES ('154', '12', '1260', '秦皇岛市');
INSERT INTO `pay_area_city` VALUES ('155', '12', '1270', '邯郸市');
INSERT INTO `pay_area_city` VALUES ('156', '12', '1310', '邢台市');
INSERT INTO `pay_area_city` VALUES ('157', '12', '1340', '保定市');
INSERT INTO `pay_area_city` VALUES ('158', '12', '1380', '张家口市');
INSERT INTO `pay_area_city` VALUES ('159', '12', '1410', '承德市');
INSERT INTO `pay_area_city` VALUES ('160', '12', '1430', '沧州市');
INSERT INTO `pay_area_city` VALUES ('161', '12', '1460', '廊坊市');
INSERT INTO `pay_area_city` VALUES ('162', '12', '1480', '衡水市');
INSERT INTO `pay_area_city` VALUES ('163', '16', '1610', '太原市');
INSERT INTO `pay_area_city` VALUES ('164', '16', '1620', '大同市');
INSERT INTO `pay_area_city` VALUES ('165', '16', '1650', '阳泉市');
INSERT INTO `pay_area_city` VALUES ('166', '16', '1660', '长治市');
INSERT INTO `pay_area_city` VALUES ('167', '16', '1680', '晋城市');
INSERT INTO `pay_area_city` VALUES ('168', '16', '1690', '朔州市');
INSERT INTO `pay_area_city` VALUES ('169', '16', '1710', '忻州市');
INSERT INTO `pay_area_city` VALUES ('170', '16', '1730', '吕梁市');
INSERT INTO `pay_area_city` VALUES ('171', '16', '1750', '晋中市');
INSERT INTO `pay_area_city` VALUES ('172', '16', '1770', '临汾市');
INSERT INTO `pay_area_city` VALUES ('173', '16', '1810', '运城市');
INSERT INTO `pay_area_city` VALUES ('174', '19', '1910', '呼和浩特市');
INSERT INTO `pay_area_city` VALUES ('175', '19', '1920', '包头市');
INSERT INTO `pay_area_city` VALUES ('176', '19', '1930', '乌海市');
INSERT INTO `pay_area_city` VALUES ('177', '19', '1940', '赤峰市');
INSERT INTO `pay_area_city` VALUES ('178', '19', '1960', '呼伦贝尔市');
INSERT INTO `pay_area_city` VALUES ('179', '19', '1980', '兴安盟');
INSERT INTO `pay_area_city` VALUES ('180', '19', '1990', '通辽市');
INSERT INTO `pay_area_city` VALUES ('181', '19', '2010', '锡林郭勒盟');
INSERT INTO `pay_area_city` VALUES ('182', '19', '2030', '乌兰察布市');
INSERT INTO `pay_area_city` VALUES ('183', '19', '2050', '鄂尔多斯市');
INSERT INTO `pay_area_city` VALUES ('184', '19', '2070', '巴彦淖尔市');
INSERT INTO `pay_area_city` VALUES ('185', '19', '2080', '阿拉善盟');
INSERT INTO `pay_area_city` VALUES ('186', '22', '2210', '沈阳市');
INSERT INTO `pay_area_city` VALUES ('187', '22', '2220', '大连市');
INSERT INTO `pay_area_city` VALUES ('188', '22', '2230', '鞍山市');
INSERT INTO `pay_area_city` VALUES ('189', '22', '2240', '抚顺市');
INSERT INTO `pay_area_city` VALUES ('190', '22', '2250', '本溪市');
INSERT INTO `pay_area_city` VALUES ('191', '22', '2260', '丹东市');
INSERT INTO `pay_area_city` VALUES ('192', '22', '2270', '锦州市');
INSERT INTO `pay_area_city` VALUES ('193', '22', '2280', '营口市');
INSERT INTO `pay_area_city` VALUES ('194', '22', '2290', '阜新市');
INSERT INTO `pay_area_city` VALUES ('195', '22', '2310', '辽阳市');
INSERT INTO `pay_area_city` VALUES ('196', '22', '2320', '盘锦市');
INSERT INTO `pay_area_city` VALUES ('197', '22', '2330', '铁岭市');
INSERT INTO `pay_area_city` VALUES ('198', '22', '2340', '朝阳市');
INSERT INTO `pay_area_city` VALUES ('199', '22', '2360', '葫芦岛市');
INSERT INTO `pay_area_city` VALUES ('200', '24', '2410', '长春市');
INSERT INTO `pay_area_city` VALUES ('201', '24', '2420', '吉林市');
INSERT INTO `pay_area_city` VALUES ('202', '24', '2430', '四平市');
INSERT INTO `pay_area_city` VALUES ('203', '24', '2440', '辽源市');
INSERT INTO `pay_area_city` VALUES ('204', '24', '2450', '通化市');
INSERT INTO `pay_area_city` VALUES ('205', '24', '2460', '白山市');
INSERT INTO `pay_area_city` VALUES ('206', '24', '2470', '白城市');
INSERT INTO `pay_area_city` VALUES ('207', '24', '2490', '延边朝鲜族自治州');
INSERT INTO `pay_area_city` VALUES ('208', '49', '5060', '商丘市');
INSERT INTO `pay_area_city` VALUES ('209', '49', '5080', '周口市');
INSERT INTO `pay_area_city` VALUES ('210', '49', '5110', '驻马店市');
INSERT INTO `pay_area_city` VALUES ('211', '49', '5130', '南阳市');
INSERT INTO `pay_area_city` VALUES ('212', '49', '5150', '信阳市');
INSERT INTO `pay_area_city` VALUES ('213', '52', '5210', '武汉市');
INSERT INTO `pay_area_city` VALUES ('214', '52', '5220', '黄石市');
INSERT INTO `pay_area_city` VALUES ('215', '52', '5230', '十堰市');
INSERT INTO `pay_area_city` VALUES ('216', '52', '5250', '宜昌市');
INSERT INTO `pay_area_city` VALUES ('217', '52', '5270', '随州市');
INSERT INTO `pay_area_city` VALUES ('218', '52', '5280', '襄阳市');
INSERT INTO `pay_area_city` VALUES ('219', '52', '5310', '鄂州市');
INSERT INTO `pay_area_city` VALUES ('220', '52', '5320', '荆门市');
INSERT INTO `pay_area_city` VALUES ('221', '52', '5330', '黄冈市');
INSERT INTO `pay_area_city` VALUES ('222', '52', '5350', '孝感市');
INSERT INTO `pay_area_city` VALUES ('223', '52', '5360', '咸宁市');
INSERT INTO `pay_area_city` VALUES ('224', '52', '5370', '荆州市');
INSERT INTO `pay_area_city` VALUES ('225', '52', '5410', '恩施土家族苗族自治州');
INSERT INTO `pay_area_city` VALUES ('226', '55', '5510', '长沙市');
INSERT INTO `pay_area_city` VALUES ('227', '55', '5520', '株洲市');
INSERT INTO `pay_area_city` VALUES ('228', '55', '5530', '湘潭市');
INSERT INTO `pay_area_city` VALUES ('229', '55', '5540', '衡阳市');
INSERT INTO `pay_area_city` VALUES ('230', '55', '5550', '邵阳市');
INSERT INTO `pay_area_city` VALUES ('231', '55', '5570', '岳阳市');
INSERT INTO `pay_area_city` VALUES ('232', '55', '5580', '常德市');
INSERT INTO `pay_area_city` VALUES ('233', '55', '5590', '张家界市');
INSERT INTO `pay_area_city` VALUES ('234', '55', '5610', '益阳市');
INSERT INTO `pay_area_city` VALUES ('235', '55', '5620', '娄底市');
INSERT INTO `pay_area_city` VALUES ('236', '55', '5630', '郴州市');
INSERT INTO `pay_area_city` VALUES ('237', '55', '5650', '永州市');
INSERT INTO `pay_area_city` VALUES ('238', '55', '5670', '怀化市');
INSERT INTO `pay_area_city` VALUES ('239', '55', '5690', '湘西土家族苗族自治州');
INSERT INTO `pay_area_city` VALUES ('240', '58', '5810', '广州市');
INSERT INTO `pay_area_city` VALUES ('241', '58', '5820', '韶关市');
INSERT INTO `pay_area_city` VALUES ('242', '58', '5840', '深圳市');
INSERT INTO `pay_area_city` VALUES ('243', '58', '5850', '珠海市');
INSERT INTO `pay_area_city` VALUES ('244', '58', '5860', '汕头市');
INSERT INTO `pay_area_city` VALUES ('245', '58', '5880', '佛山市');
INSERT INTO `pay_area_city` VALUES ('246', '58', '5890', '江门市');
INSERT INTO `pay_area_city` VALUES ('247', '58', '5910', '湛江市');
INSERT INTO `pay_area_city` VALUES ('248', '58', '5920', '茂名市');
INSERT INTO `pay_area_city` VALUES ('249', '58', '5950', '惠州市');
INSERT INTO `pay_area_city` VALUES ('250', '58', '5960', '梅州市');
INSERT INTO `pay_area_city` VALUES ('251', '58', '5970', '汕尾市');
INSERT INTO `pay_area_city` VALUES ('252', '58', '5980', '河源市');
INSERT INTO `pay_area_city` VALUES ('253', '58', '5990', '阳江市');
INSERT INTO `pay_area_city` VALUES ('254', '58', '6010', '清远市');
INSERT INTO `pay_area_city` VALUES ('255', '58', '6020', '东莞市');
INSERT INTO `pay_area_city` VALUES ('256', '58', '6030', '中山市');
INSERT INTO `pay_area_city` VALUES ('257', '58', '6040', '潮州市');
INSERT INTO `pay_area_city` VALUES ('258', '58', '6050', '揭阳市');
INSERT INTO `pay_area_city` VALUES ('259', '58', '6060', '云浮市');
INSERT INTO `pay_area_city` VALUES ('260', '61', '6110', '南宁市');
INSERT INTO `pay_area_city` VALUES ('261', '61', '6140', '柳州市');
INSERT INTO `pay_area_city` VALUES ('262', '61', '6170', '桂林市');
INSERT INTO `pay_area_city` VALUES ('263', '61', '6210', '梧州市');
INSERT INTO `pay_area_city` VALUES ('264', '61', '6230', '北海市');
INSERT INTO `pay_area_city` VALUES ('265', '61', '6240', '玉林市');
INSERT INTO `pay_area_city` VALUES ('266', '61', '6260', '百色市');
INSERT INTO `pay_area_city` VALUES ('267', '61', '6280', '河池市');
INSERT INTO `pay_area_city` VALUES ('268', '61', '6310', '钦州市');
INSERT INTO `pay_area_city` VALUES ('269', '61', '6320', '防城港市');
INSERT INTO `pay_area_city` VALUES ('270', '61', '6330', '贵港市');
INSERT INTO `pay_area_city` VALUES ('271', '61', '6340', '贺州市');
INSERT INTO `pay_area_city` VALUES ('272', '61', '6350', '来宾市');
INSERT INTO `pay_area_city` VALUES ('273', '61', '6360', '崇左市');
INSERT INTO `pay_area_city` VALUES ('274', '64', '6410', '海口市');
INSERT INTO `pay_area_city` VALUES ('275', '64', '6420', '三亚市');
INSERT INTO `pay_area_city` VALUES ('276', '64', '6440', '三沙市');
INSERT INTO `pay_area_city` VALUES ('277', '65', '6510', '成都市');
INSERT INTO `pay_area_city` VALUES ('278', '65', '6550', '自贡市');
INSERT INTO `pay_area_city` VALUES ('279', '65', '6560', '攀枝花市');
INSERT INTO `pay_area_city` VALUES ('280', '65', '6570', '泸州市');
INSERT INTO `pay_area_city` VALUES ('281', '65', '6580', '德阳市');
INSERT INTO `pay_area_city` VALUES ('282', '65', '6590', '绵阳市');
INSERT INTO `pay_area_city` VALUES ('283', '65', '6610', '广元市');
INSERT INTO `pay_area_city` VALUES ('284', '65', '6620', '遂宁市');
INSERT INTO `pay_area_city` VALUES ('285', '65', '6630', '内江市');
INSERT INTO `pay_area_city` VALUES ('286', '65', '6650', '乐山市');
INSERT INTO `pay_area_city` VALUES ('287', '65', '6710', '宜宾市');
INSERT INTO `pay_area_city` VALUES ('288', '65', '6730', '南充市');
INSERT INTO `pay_area_city` VALUES ('289', '65', '6750', '达州市');
INSERT INTO `pay_area_city` VALUES ('290', '65', '6770', '雅安市');
INSERT INTO `pay_area_city` VALUES ('291', '65', '6790', '阿坝藏族羌族自治州');
INSERT INTO `pay_area_city` VALUES ('292', '65', '6810', '甘孜藏族自治州');
INSERT INTO `pay_area_city` VALUES ('293', '65', '6840', '凉山彝族自治州');
INSERT INTO `pay_area_city` VALUES ('294', '65', '6670', '眉山市');
INSERT INTO `pay_area_city` VALUES ('295', '65', '6690', '广安市');
INSERT INTO `pay_area_city` VALUES ('296', '65', '6870', '巴中市');
INSERT INTO `pay_area_city` VALUES ('297', '65', '6880', '资阳市');
INSERT INTO `pay_area_city` VALUES ('298', '69', '6901', '大足区');
INSERT INTO `pay_area_city` VALUES ('299', '69', '6902', '合川区');
INSERT INTO `pay_area_city` VALUES ('300', '69', '6903', '万州区');
INSERT INTO `pay_area_city` VALUES ('301', '69', '6904', '涪陵区');
INSERT INTO `pay_area_city` VALUES ('302', '69', '6905', '渝中区');
INSERT INTO `pay_area_city` VALUES ('303', '69', '6906', '九龙坡区');
INSERT INTO `pay_area_city` VALUES ('304', '69', '6907', '南岸区');
INSERT INTO `pay_area_city` VALUES ('305', '69', '6908', '北碚区');
INSERT INTO `pay_area_city` VALUES ('306', '69', '6909', '綦江区');
INSERT INTO `pay_area_city` VALUES ('307', '69', '6911', '渝北区');
INSERT INTO `pay_area_city` VALUES ('308', '69', '6912', '巴南区');
INSERT INTO `pay_area_city` VALUES ('309', '69', '6913', '黔江区');
INSERT INTO `pay_area_city` VALUES ('310', '69', '6914', '潼南区');
INSERT INTO `pay_area_city` VALUES ('311', '69', '6915', '铜梁区');
INSERT INTO `pay_area_city` VALUES ('312', '69', '6916', '长寿区');
INSERT INTO `pay_area_city` VALUES ('313', '69', '6917', '江津区');
INSERT INTO `pay_area_city` VALUES ('314', '69', '6918', '荣昌区');
INSERT INTO `pay_area_city` VALUES ('315', '69', '6919', '璧山区');
INSERT INTO `pay_area_city` VALUES ('316', '69', '6921', '梁平县');
INSERT INTO `pay_area_city` VALUES ('317', '69', '6922', '城口县');
INSERT INTO `pay_area_city` VALUES ('318', '69', '6923', '丰都县');
INSERT INTO `pay_area_city` VALUES ('319', '69', '6924', '垫江县');
INSERT INTO `pay_area_city` VALUES ('320', '69', '6925', '武隆县');
INSERT INTO `pay_area_city` VALUES ('321', '69', '6926', '忠县');
INSERT INTO `pay_area_city` VALUES ('322', '69', '6927', '开县');
INSERT INTO `pay_area_city` VALUES ('323', '69', '6928', '云阳县');
INSERT INTO `pay_area_city` VALUES ('324', '69', '6929', '奉节县');
INSERT INTO `pay_area_city` VALUES ('325', '69', '6931', '巫山县');
INSERT INTO `pay_area_city` VALUES ('326', '69', '6932', '巫溪县');
INSERT INTO `pay_area_city` VALUES ('327', '69', '6933', '石柱土家族自治县');
INSERT INTO `pay_area_city` VALUES ('328', '69', '6934', '秀山土家族苗族自治县');
INSERT INTO `pay_area_city` VALUES ('329', '69', '6935', '酉阳土家族苗族自治县');
INSERT INTO `pay_area_city` VALUES ('330', '69', '6936', '彭水苗族土家族自治县');
INSERT INTO `pay_area_city` VALUES ('331', '69', '6937', '沙坪坝区');
INSERT INTO `pay_area_city` VALUES ('332', '69', '6938', '江北区');
INSERT INTO `pay_area_city` VALUES ('333', '69', '6939', '大渡口区');
INSERT INTO `pay_area_city` VALUES ('334', '69', '6941', '永川区');
INSERT INTO `pay_area_city` VALUES ('335', '69', '6942', '南川区');
INSERT INTO `pay_area_city` VALUES ('336', '70', '7004', '贵安新区');
INSERT INTO `pay_area_city` VALUES ('337', '70', '7010', '贵阳市');
INSERT INTO `pay_area_city` VALUES ('338', '70', '7020', '六盘水市');
INSERT INTO `pay_area_city` VALUES ('339', '70', '7030', '遵义市');
INSERT INTO `pay_area_city` VALUES ('340', '70', '7050', '铜仁市');
INSERT INTO `pay_area_city` VALUES ('341', '70', '7070', '黔西南布依族苗族自治州');
INSERT INTO `pay_area_city` VALUES ('342', '70', '7090', '毕节市');
INSERT INTO `pay_area_city` VALUES ('343', '70', '7110', '安顺市');
INSERT INTO `pay_area_city` VALUES ('344', '70', '7130', '黔东南苗族侗族自治州');
INSERT INTO `pay_area_city` VALUES ('345', '70', '7150', '黔南布依族苗族自治州');
INSERT INTO `pay_area_city` VALUES ('346', '73', '7310', '昆明市');
INSERT INTO `pay_area_city` VALUES ('347', '73', '7340', '昭通市');
INSERT INTO `pay_area_city` VALUES ('348', '73', '7360', '曲靖市');
INSERT INTO `pay_area_city` VALUES ('349', '73', '7380', '楚雄彝族自治州');
INSERT INTO `pay_area_city` VALUES ('350', '73', '7410', '玉溪市');
INSERT INTO `pay_area_city` VALUES ('351', '73', '7430', '红河哈尼族彝族自治州');
INSERT INTO `pay_area_city` VALUES ('352', '73', '7450', '文山壮族苗族自治州');
INSERT INTO `pay_area_city` VALUES ('353', '73', '7470', '普洱市');
INSERT INTO `pay_area_city` VALUES ('354', '73', '7490', '西双版纳傣族自治州');
INSERT INTO `pay_area_city` VALUES ('355', '73', '7510', '大理白族自治州');
INSERT INTO `pay_area_city` VALUES ('356', '73', '7530', '保山市');
INSERT INTO `pay_area_city` VALUES ('357', '73', '7540', '德宏傣族景颇族自治州');
INSERT INTO `pay_area_city` VALUES ('358', '73', '7550', '丽江市');
INSERT INTO `pay_area_city` VALUES ('359', '73', '7560', '怒江傈僳族自治州');
INSERT INTO `pay_area_city` VALUES ('360', '73', '7570', '迪庆藏族自治州');
INSERT INTO `pay_area_city` VALUES ('361', '73', '7580', '临沧市');
INSERT INTO `pay_area_city` VALUES ('362', '77', '7710', '拉萨市');
INSERT INTO `pay_area_city` VALUES ('363', '77', '7720', '昌都市');
INSERT INTO `pay_area_city` VALUES ('364', '77', '7740', '山南市');
INSERT INTO `pay_area_city` VALUES ('365', '77', '7760', '日喀则市');
INSERT INTO `pay_area_city` VALUES ('366', '77', '7790', '那曲地区');
INSERT INTO `pay_area_city` VALUES ('367', '77', '7810', '阿里地区');
INSERT INTO `pay_area_city` VALUES ('368', '77', '7830', '林芝市');
INSERT INTO `pay_area_city` VALUES ('369', '79', '7904', '西咸新区');
INSERT INTO `pay_area_city` VALUES ('370', '79', '7910', '西安市');
INSERT INTO `pay_area_city` VALUES ('371', '79', '7920', '铜川市');
INSERT INTO `pay_area_city` VALUES ('372', '79', '7930', '宝鸡市');
INSERT INTO `pay_area_city` VALUES ('373', '79', '7950', '咸阳市');
INSERT INTO `pay_area_city` VALUES ('374', '79', '7970', '渭南市');
INSERT INTO `pay_area_city` VALUES ('375', '79', '7990', '汉中市');
INSERT INTO `pay_area_city` VALUES ('376', '79', '8010', '安康市');
INSERT INTO `pay_area_city` VALUES ('377', '79', '8030', '商洛市');
INSERT INTO `pay_area_city` VALUES ('378', '79', '8040', '延安市');
INSERT INTO `pay_area_city` VALUES ('379', '79', '8060', '榆林市');
INSERT INTO `pay_area_city` VALUES ('380', '82', '8210', '兰州市');
INSERT INTO `pay_area_city` VALUES ('381', '82', '8220', '嘉峪关市');
INSERT INTO `pay_area_city` VALUES ('382', '82', '8230', '金昌市');
INSERT INTO `pay_area_city` VALUES ('383', '82', '8240', '白银市');
INSERT INTO `pay_area_city` VALUES ('384', '82', '8250', '天水市');
INSERT INTO `pay_area_city` VALUES ('385', '82', '8260', '酒泉市');
INSERT INTO `pay_area_city` VALUES ('386', '82', '8270', '张掖市');
INSERT INTO `pay_area_city` VALUES ('387', '82', '8280', '武威市');
INSERT INTO `pay_area_city` VALUES ('388', '82', '8290', '定西市');
INSERT INTO `pay_area_city` VALUES ('389', '82', '8310', '陇南市');
INSERT INTO `pay_area_city` VALUES ('390', '82', '8330', '平凉市');
INSERT INTO `pay_area_city` VALUES ('391', '82', '8340', '庆阳市');
INSERT INTO `pay_area_city` VALUES ('392', '82', '8360', '临夏回族自治州');
INSERT INTO `pay_area_city` VALUES ('393', '82', '8380', '甘南藏族自治州');
INSERT INTO `pay_area_city` VALUES ('394', '85', '8510', '西宁市');
INSERT INTO `pay_area_city` VALUES ('395', '85', '8520', '海东市');
INSERT INTO `pay_area_city` VALUES ('396', '85', '8540', '海北藏族自治州');
INSERT INTO `pay_area_city` VALUES ('397', '85', '8550', '黄南藏族自治州');
INSERT INTO `pay_area_city` VALUES ('398', '85', '8560', '海南藏族自治州');
INSERT INTO `pay_area_city` VALUES ('399', '85', '8570', '果洛藏族自治州');
INSERT INTO `pay_area_city` VALUES ('400', '85', '8580', '玉树藏族自治州');
INSERT INTO `pay_area_city` VALUES ('401', '85', '8590', '海西蒙古族藏族自治州');
INSERT INTO `pay_area_city` VALUES ('402', '87', '8710', '银川市');
INSERT INTO `pay_area_city` VALUES ('403', '87', '8720', '石嘴山市');
INSERT INTO `pay_area_city` VALUES ('404', '87', '8730', '吴忠市');
INSERT INTO `pay_area_city` VALUES ('405', '87', '8740', '固原市');
INSERT INTO `pay_area_city` VALUES ('406', '87', '8750', '中卫市');
INSERT INTO `pay_area_city` VALUES ('407', '88', '8810', '乌鲁木齐市');
INSERT INTO `pay_area_city` VALUES ('408', '88', '8820', '克拉玛依市');
INSERT INTO `pay_area_city` VALUES ('409', '88', '8830', '吐鲁番市');
INSERT INTO `pay_area_city` VALUES ('410', '88', '8840', '哈密市');
INSERT INTO `pay_area_city` VALUES ('411', '88', '8850', '昌吉回族自治州');
INSERT INTO `pay_area_city` VALUES ('412', '88', '8870', '博尔塔拉蒙古自治州');
INSERT INTO `pay_area_city` VALUES ('413', '88', '8880', '巴音郭楞蒙古自治州');
INSERT INTO `pay_area_city` VALUES ('414', '88', '8910', '阿克苏地区');
INSERT INTO `pay_area_city` VALUES ('415', '88', '8930', '克孜勒苏柯尔克孜自治州');
INSERT INTO `pay_area_city` VALUES ('416', '88', '8940', '喀什地区');
INSERT INTO `pay_area_city` VALUES ('417', '88', '8960', '和田地区');
INSERT INTO `pay_area_city` VALUES ('418', '88', '8980', '伊犁哈萨克自治州');
INSERT INTO `pay_area_city` VALUES ('419', '88', '9010', '塔城地区');
INSERT INTO `pay_area_city` VALUES ('420', '88', '9020', '阿勒泰地区');
INSERT INTO `pay_area_city` VALUES ('421', '88', '9028', '石河子市（自治区直辖）');
INSERT INTO `pay_area_city` VALUES ('422', '88', '9041', '阿拉尔市（自治区直辖）');
INSERT INTO `pay_area_city` VALUES ('423', '88', '9042', '图木舒克市（自治区直辖）');
INSERT INTO `pay_area_city` VALUES ('424', '88', '9043', '五家渠市（自治区直辖）');
INSERT INTO `pay_area_city` VALUES ('425', '88', '9044', '北屯市（自治区直辖）');
INSERT INTO `pay_area_city` VALUES ('426', '88', '9045', '双河市（自治区直辖）');
INSERT INTO `pay_area_city` VALUES ('427', '88', '9046', '可克达拉市(自治区直辖)');
INSERT INTO `pay_area_city` VALUES ('428', '88', '8890', '铁门关市（自治区直辖）');
INSERT INTO `pay_area_city` VALUES ('429', '88', '9047', '昆玉市(自治区直辖)');

-- ----------------------------
-- Table structure for pay_area_province
-- ----------------------------
DROP TABLE IF EXISTS `pay_area_province`;
CREATE TABLE `pay_area_province` (
  `province_id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) DEFAULT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`province_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_area_province
-- ----------------------------
INSERT INTO `pay_area_province` VALUES ('2', '26', '黑龙江省');
INSERT INTO `pay_area_province` VALUES ('3', '29', '上海市');
INSERT INTO `pay_area_province` VALUES ('4', '30', '江苏省');
INSERT INTO `pay_area_province` VALUES ('5', '33', '浙江省');
INSERT INTO `pay_area_province` VALUES ('6', '36', '安徽省');
INSERT INTO `pay_area_province` VALUES ('7', '39', '福建省');
INSERT INTO `pay_area_province` VALUES ('8', '42', '江西省');
INSERT INTO `pay_area_province` VALUES ('9', '45', '山东省');
INSERT INTO `pay_area_province` VALUES ('10', '49', '河南省');
INSERT INTO `pay_area_province` VALUES ('11', '10', '北京市');
INSERT INTO `pay_area_province` VALUES ('12', '11', '天津市');
INSERT INTO `pay_area_province` VALUES ('13', '12', '河北省');
INSERT INTO `pay_area_province` VALUES ('14', '16', '山西省');
INSERT INTO `pay_area_province` VALUES ('15', '19', '内蒙古自治区');
INSERT INTO `pay_area_province` VALUES ('16', '22', '辽宁省');
INSERT INTO `pay_area_province` VALUES ('17', '24', '吉林省');
INSERT INTO `pay_area_province` VALUES ('18', '52', '湖北省');
INSERT INTO `pay_area_province` VALUES ('19', '55', '湖南省');
INSERT INTO `pay_area_province` VALUES ('20', '58', '广东省');
INSERT INTO `pay_area_province` VALUES ('21', '61', '广西壮族自治区');
INSERT INTO `pay_area_province` VALUES ('22', '64', '海南省');
INSERT INTO `pay_area_province` VALUES ('23', '65', '四川省');
INSERT INTO `pay_area_province` VALUES ('24', '69', '重庆市');
INSERT INTO `pay_area_province` VALUES ('25', '70', '贵州省');
INSERT INTO `pay_area_province` VALUES ('26', '73', '云南省');
INSERT INTO `pay_area_province` VALUES ('27', '77', '自治区');
INSERT INTO `pay_area_province` VALUES ('28', '79', '陕西省');
INSERT INTO `pay_area_province` VALUES ('29', '82', '甘肃省');
INSERT INTO `pay_area_province` VALUES ('30', '85', '青海省');
INSERT INTO `pay_area_province` VALUES ('31', '87', '宁夏回族自治区');
INSERT INTO `pay_area_province` VALUES ('32', '88', '新疆维吾尔族自治区');

-- ----------------------------
-- Table structure for pay_article
-- ----------------------------
DROP TABLE IF EXISTS `pay_article`;
CREATE TABLE `pay_article` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `catid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '分类ID',
  `groupid` tinyint(1) NOT NULL DEFAULT '0' COMMENT '分组  0：所有 1：商户 2：代理',
  `title` varchar(300) NOT NULL COMMENT '标题',
  `content` text COMMENT '内容',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0',
  `description` varchar(255) NOT NULL COMMENT '描述',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1显示 0 不显示',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_article
-- ----------------------------
INSERT INTO `pay_article` VALUES ('1', '1', '0', '八月央行严打升级！大开罚单，环迅支付、汇付等机构躺枪', '&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; 8月以来，人民银行对第三方支付机构的罚单不断。截止目前，多家支付机构违反支付业务规定，已有易联支付、汇付、环迅支付等近10多家支付机构被罚。就在今日公布消息，迅付信息科技有限公司，被中国人民银行上海分行发布“上海银罚字〔2017〕28号”处罚决定。罚款金额包括没收违法所得285696.89元及罚款150万元，罚款合计1785696.89元。这是截止今年，人行对第三方支付机构开出的一张最高金额大罚单了。同时，汇付、易联支付在内其它几家支付机构罚款明细如下：上海汇付数据服务有限公司因违反支付业务规定 罚款人民币6万元。汇潮支付有限公司违反支付业务规定被罚处以罚款人民币4万元；上海德颐网络技术有限公司违反支付业务规定被罚处以罚款人民币6万元；上海富友支付服务有限公司违反支付业务规定被罚处以罚款人民币3万元。上海电银信息技术有限公司、卡友支付服务有限公司因违反支付业务规定，均被罚限期改正，并各处6万元罚款。上海巾帼三六五企业服务有限公司、上海银联电子支付服务有限公司、上海乐易信息技术有限公司因为违反支付业务规定，分别被处以2万元、6万元、4万元罚款。易联支付有限公司因违反银行卡收单业务管理规定，被广州分行罚款601435.92元。', '1503808262', '8月以来，人民银行对第三方支付机构的罚单不断。截止目前，多家支付机构违反支付业务规定，已有易联支付、汇付、环迅支付等近10多家支付机构被罚。', '1', '1503812262');
INSERT INTO `pay_article` VALUES ('2', '1', '0', '华尔街上再掀投资热潮，支付与金融科技比翼双飞', '华尔街上赫赫有名的几大投行高盛、花旗、摩根大通，面对势不可挡的金融科技，再也无法淡定了。他们一起纷纷重金砸向了金融科技领域，在华尔街上跳起了一支支投资热舞。几组数据可以让你看到这场热舞的火辣与动感。&amp;nbsp;● 花旗、高盛和摩根大通是三大最活跃的投资者。花旗(包括花旗风险投资公司)参加了30轮投资，涉22家公司;高盛参与31轮投资，涉25家公司;摩根大通参与14轮投资，涉13家公司。（来自管理咨询公司Opimas的报告，按银行投资金融科技公司的数量排序）● 根据摩根大通透露，近期将投入96亿美元并聘用专业技术团队专攻大数据、机器人和云基础设施。&amp;nbsp;● “华尔街大银行及其他成熟的金融公司可能会在2017年通过44笔交易向金融科技领域投入创纪录的17亿美元”。（来自管理咨询公司Opimas的报告）● 自2012年以来，美国前十大银行(按管理资产)已向56家金融科技公司进行了72次总计36亿美元的投资。（来自CB Insights年度数据）重磅投资金融科技领域同时，高盛、摩根大通在企业内部更是深植科技基因。高盛CEO劳尔德•贝兰克梵(Lloyd Blankfein)最常挂在嘴边的一句话是：其实，我们是一家科技公司。高盛雇用的3.6万名员工中，9000名是程序员和技术工程师。&amp;nbsp;摩根大通于去年7月投入使用的一款金融合同解析软件COIN，通过机器学习和加密云网络技术，负责处理智能合约以及解析商业贷款协议，在几秒内就能将原先律师和贷款人员每年需要36万小时做完的工作完成，在大大降低错误率的同时保证全年无休。&amp;nbsp;乐在其中的不止投行大咖，麦肯锡、普华永道等世界著名的咨询公司也为这场热舞，演绎着优美的背景音乐。&amp;nbsp;麦肯锡咨询公司(McKinsey &amp;amp; Company)早在2015年便呼吁金融机构，紧抓金融科技发展机遇，否则将失去逾四成传统金融业务营收，失去超六成传统金融业务利润。&amp;nbsp;普华永道在4月份公布的报告中称，全球将近50%的金融服务公司计划在未来3到5年收购金融科技类创业公司。&amp;nbsp;当然金融科技的内涵极为丰富，包含支付、保险、规划、借贷/众筹、区块链、交易&amp;amp;投资、数据&amp;amp;分析以及安全在内八大主题。其中支付作为构建金融科技的基层设施，最受到青睐。&amp;nbsp;据某些记者了解，高盛从2012年至今，在支付领域共投资了6家公司，参加了八轮融资，总额约5.7亿美元。包括对新晋的越南移动钱包应用MoMo的B轮融资。&amp;nbsp;摩根大通也创新发布了自己在支付领域的新产品Chase Pay。并动用资源，收购MCX（美国最大的商户网络），同时与波士顿软件公司LevelUp展开深入合作，提升Chase Pay的含金量，壮大Chase Pay的竞争实力。&amp;nbsp;看着世界金融中心华尔街，上演着热情洋溢的金融科技投资热舞。回看我们大洋彼岸的中国，中国金融科技市场更是一片欣欣向荣。从2016年全球与中国金融科技投融资情况统计图表，可以看出。', '1503808362', '华尔街上赫赫有名的几大投行高盛、花旗、摩根大通，面对势不可挡的金融科技，再也无法淡定了。他们一起纷纷重金砸向了金融科技领域，在华尔街上跳起了一支支投资热舞。几组数据可以让你看到这场热舞的火辣与动感。', '1', '0');
INSERT INTO `pay_article` VALUES ('3', '1', '0', '爆料：12家支付机构吃了工商税务的罚单 最高被罚8万元', '以下为中国支付网根据“国家企业信用信息公示系统”的数据进行统计，部分信息来自于“天眼查”。本次统计截至日期为2017年8月22日，统计范围为当前持有《支付业务许可证》的247家支付机构。&amp;nbsp;这12家机构分别是通联支付网络服务股份有限公司、上海银联电子支付服务有限公司、天津城市一卡通有限公司、厦门易通卡运营有限责任公司、安易联融电子商务有限公司、广西支付通商务服务有限公司、海南海岛一卡通支付网络有限公司、广东汇卡商务服务有限公司、供销中百支付有限公司、银盈通支付有限公司、北京国华汇银科技有限公司。', '1503808474', '《企业信息公示暂行条例》规定，有关部门应当建立健全信用约束机制，在政府采购、工程招投标、国有土地出让、授予荣誉称号等工作中，将企业信息作为重要考量因素，对被列入经营异常名录或者严重违法企业名单的企业依法予以限制或者禁入。', '1', '0');
INSERT INTO `pay_article` VALUES ('4', '1', '0', '银联ChinaPay、巾帼三六五、乐易三家支付机构被上海人行处罚', '上海巾帼三六五企业服务有限公司由上海巾帼社会服务有限公司组建，是一支隶属于上海市妇联的社会专业团队。2017年6月26日，央行正式公布第四批支付牌照续展名单，上海巾帼三六五企业服务有限公司成功续展《支付业务许可证》，支付业务类型包括预付卡发行与受理。► 中国人民银行上海分行于2017年8月15日作出行政处罚决定，上海银联电子支付服务有限公司因“违反支付业务规定”，被罚款6万元，行政处罚决定书文号是上海银罚〔2017〕25号。据中国支付网统计，这是上海银联首次被公开处罚。&amp;nbsp;上海银联电子支付服务有限公司(ChinaPay)是由中国银联控股，支付业务类型包括互联网支付、移动电话支付。&quot;银联在线&quot;是中国银联倾力打造的互联网业务综合商务门户网站，依托具有中国自主知识产权、国内领先的银联CUPSecure互联网安全认证支付系统和银联EBPP互联网收单系统，构建了银联便民支付网上平台、银联理财平台、银联网上商城三大业务平台，为广大持卡人提供公共事业缴费、通信缴费充值、信用卡还款、跨行转账、账单号支付、机票预订、基金理财和商城购物等全方位的互联网金融支付服务。► 中国人民银行上海分行于2017年8月15日作出行政处罚决定，上海乐易信息技术有限公司因“违反支付业务规定”，被罚款4万元，行政处罚决定书文号是上海银罚〔2017〕26号。据中国支付网统计，这是上海乐易首次被公开处罚。&amp;nbsp;上海乐易信息技术有限公司是容大集团控股的从事第三方支付和电子商务的专业化服务公司。2017年6月26日，央行正式公布第四批支付牌照续展名单，上海乐易成功续展《支付业务许可证》，支付业务类型包括预付卡发行与受理。', '1503808535', '中国人民银行上海分行于2017年8月15日作出行政处罚决定，上海巾帼三六五企业服务有限公司因“违反支付业务规定”，被罚款2万元，行政处罚决定书文号是上海银罚〔2017〕24号。据中国支付网统计，这是上海巾帼首次被公开处罚。', '1', '1503809486');
INSERT INTO `pay_article` VALUES ('5', '1', '0', '支付宝被列入“经营异常名录”！ 从此，支付宝被刻上“不良记录”烙印', '8月16日，网上曝出支付宝（中国）信息技术有限公司被监管部门列入 “经营异常名录”。什么？没搞错吧？小编马上到国家企业信用信息公示系统上查询求证，是真的！支付宝确实上了“经营异常名录”。有图有真相。&amp;nbsp;&amp;nbsp;&amp;nbsp;图中清晰看到，支付宝因未依照《企业信息公示暂行条例》第八条规定的限期公示年度报告，2017年7月7日，由中国（上海）自由贸易试验区市场监督管理局将其列入经营异常名录。&amp;nbsp;特意翻阅了下《企业信息公示暂行条例》第八条规定：也就是说，支付宝迟迟未上报自己企业的年度报告，从而被列入了“异常经营名录”。是支付宝太忙了，忘了上报？还是支付宝企业有什么不可告人的秘密、藏有猫腻，那就不得而知了！不管是何种原因，但这个结果，就像是在支付宝的信任大楼里砸出了一道裂缝。对支付宝的信任感降级了！众所周知，“企业信用”对一家企业来说是项非常重要的无形资产，特别是像支付宝这样的大型支付企业，它的信用值好坏牵动着中国上亿用户的资金安全，更直接影响着广大中小型企业与支付宝的合作发展。国家企业信用信息公示系统自2014年上线以来，以一个社会中介机构的角色，客观、公正的对各企业评定资信情况，取得良好信用等级的企业，能吸引广大企业放心大胆的与之合作；相反，如果信用等级不佳或有问题，就犹如在双方合作面前出现了拦路虎，阻挡了合作的可能。信用，是一个企业发展之根本。企业一旦被载入经营异常名录，这个“不良记录”的烙印就将与企业并存。也就是说，即使之后支付宝被移出了经营异常名录，但曾经被载入不良名单的记录并不会消失，这不但影响着企业声誉，就连企业日常经营也会受限，例如：企业在需要申请办理各类登记备案事项、行政许可审批事项和资质审核等，都会因为这个曾有的“不良记录”遭遇行政管理部门审慎审查，被限制或者禁入。&amp;nbsp;支付宝树大招风，坏消息也不止这一个。前不久，据说，蚂蚁金服被央行约谈不得用“无现金”宣传，上周末，余额宝宣布限额10万，年化利率下跌4%以下；这周，支付宝“亲密付”出现网络诈骗，有人被骗上万元….. 坏消息接踵而至，支付宝再次被推到风口浪尖上，支付宝是见过大场面的，相信也是没有在怕的。但这次被监管部门载入经营异常名录，无凝是对支付宝永久的伤害。当初以解决人与人之间信任为初衷而成立的支付宝，如今支付宝的企业信任值却出现瑕疵。这不免让人觉得有点讽刺。看来，支付宝，这次是真的失策了。马云爸爸或许马上就要来霸屏了。', '1503808590', '8月16日，网上曝出支付宝（中国）信息技术有限公司被监管部门列入 “经营异常名录”。什么？没搞错吧？', '1', '0');
INSERT INTO `pay_article` VALUES ('11', '4', '0', '银联通道维护！', '银联通道维护！', '1503810697', '银联通道维护！', '1', '0');
INSERT INTO `pay_article` VALUES ('12', '4', '0', '支付宝扫码通道维护！', '支付宝扫码通道维护！', '1503810718', '支付宝扫码通道维护！', '1', '1527661258');
INSERT INTO `pay_article` VALUES ('13', '1', '0', '文章1', '1', '0', '1', '1', '0');
INSERT INTO `pay_article` VALUES ('14', '1', '1', 'test', '1', '1527750819', '11', '1', '1527750832');
INSERT INTO `pay_article` VALUES ('15', '1', '2', 'test2', '11', '1527004800', '1111', '1', '0');

-- ----------------------------
-- Table structure for pay_attachment
-- ----------------------------
DROP TABLE IF EXISTS `pay_attachment`;
CREATE TABLE `pay_attachment` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `filename` varchar(100) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_attachment
-- ----------------------------
INSERT INTO `pay_attachment` VALUES ('48', '2', '242dd42a2834349b88359f1eccea15ce36d3be7e.jpg', 'Uploads/verifyinfo/59a2b65d0816c.jpg');
INSERT INTO `pay_attachment` VALUES ('46', '2', '6-140F316125V44.jpg', 'Uploads/verifyinfo/59a2b65cd9877.jpg');
INSERT INTO `pay_attachment` VALUES ('47', '2', '6-140F316132J02.jpg', 'Uploads/verifyinfo/59a2b65cea2ec.jpg');

-- ----------------------------
-- Table structure for pay_auth_error_log
-- ----------------------------
DROP TABLE IF EXISTS `pay_auth_error_log`;
CREATE TABLE `pay_auth_error_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `auth_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：商户登录 1：后台登录 2：商户短信验证 3：后台短信验证 4：谷歌令牌验证 5：支付密码验证 ',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_auth_error_log
-- ----------------------------

-- ----------------------------
-- Table structure for pay_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `pay_auth_group`;
CREATE TABLE `pay_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `is_manager` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1需要验证权限 0 不需要验证权限',
  `rules` varchar(500) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_auth_group
-- ----------------------------
INSERT INTO `pay_auth_group` VALUES ('1', '超级管理员', '1', '0', '1,49,2,3,51,4,57,5,55,56,58,59,6,44,52,53,48,70,54,126,7,8,60,61,62,9,63,64,65,66,10,67,68,69,11,131,12,79,80,81,82,83,84,85,86,87,88,89,90,91,93,94,95,96,97,98,99,100,101,120,13,14,15,92,16,73,76,77,78,17,121,132,18,19,71,75,20,72,74,22,127,24,25,26,130,23,114,115,46,125,27,28,108,129,29,102,30,103,106,107,119,21,104,105,109,110,111,128,31,32,33,34,35,36,37,38,42,116,122,133');
INSERT INTO `pay_auth_group` VALUES ('2', '运营管理员', '1', '0', '1,77,3,18,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,49,92,93,94,98,99,19,50,51,52,4,14,54,55,56,57,15,59,60,61,62,63,5,23,65,66,24,67,6,13,68,69,70,71,73,76,7,12,78,79,80,81,82,22,83,84,85,86,87');
INSERT INTO `pay_auth_group` VALUES ('3', '财务管理员', '1', '1', '1,77,5,23,65,66,24,67,6,13,68,69,70,71,73,76,25,72,26,74,75');
INSERT INTO `pay_auth_group` VALUES ('4', '普通商户', '1', '1', '');
INSERT INTO `pay_auth_group` VALUES ('5', '普通代理商', '1', '1', '');

-- ----------------------------
-- Table structure for pay_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `pay_auth_group_access`;
CREATE TABLE `pay_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_auth_group_access
-- ----------------------------
INSERT INTO `pay_auth_group_access` VALUES ('1', '1');
INSERT INTO `pay_auth_group_access` VALUES ('2', '4');
INSERT INTO `pay_auth_group_access` VALUES ('7', '2');

-- ----------------------------
-- Table structure for pay_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `pay_auth_rule`;
CREATE TABLE `pay_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `icon` varchar(100) DEFAULT '' COMMENT '图标',
  `menu_name` varchar(100) NOT NULL DEFAULT '' COMMENT '规则唯一标识Controller/action',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '菜单名称',
  `pid` tinyint(5) NOT NULL DEFAULT '0' COMMENT '菜单ID ',
  `is_menu` tinyint(1) unsigned DEFAULT '0' COMMENT '1:是主菜单 0否',
  `is_race_menu` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1:是 0:不是',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  `sorts` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=134 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of pay_auth_rule
-- ----------------------------
INSERT INTO `pay_auth_rule` VALUES ('1', 'fa fa-home', 'Index/main', '管理首页', '0', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('2', 'fa fa-cogs', 'System/#', '系统设置', '0', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('3', 'fa fa-cog', 'System/base', '基本设置', '2', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('4', 'fa fa-envelope-o', 'System/email', '邮件设置', '2', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('5', 'fa fa-send', 'System/smssz', '短信设置', '2', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('6', 'fa fa-hourglass', 'System/planning', '计划任务', '2', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('7', 'fa fa-user-circle', 'Admin/#', '管理员管理', '0', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('8', 'fa fa-vcard ', 'Admin/index', '管理员信息', '7', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('9', 'fa fa-street-view', 'Auth/index', '角色配置', '7', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('10', 'fa fa-universal-access', 'Menu/index', '权限配置', '7', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('11', 'fa fa-users', 'User/#', '用户管理', '0', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('12', 'fa fa-user', 'User/index?status=1&authorized=1', '已认证用户', '11', '1', '0', '1', '1', '', '90');
INSERT INTO `pay_auth_rule` VALUES ('13', 'fa fa-user-o', 'User/index?status=1&authorized=2', '待审核认证用户', '11', '1', '0', '1', '1', '', '80');
INSERT INTO `pay_auth_rule` VALUES ('14', 'fa fa-user-plus', 'User/index?status=1&authorized=0', '未认证用户', '11', '1', '0', '1', '1', '', '70');
INSERT INTO `pay_auth_rule` VALUES ('15', 'fa fa-user-times', 'User/index?status=0', '冻结用户', '11', '1', '0', '1', '1', '', '60');
INSERT INTO `pay_auth_rule` VALUES ('16', 'fa fa-gift', 'User/invitecode', '邀请码', '11', '1', '0', '1', '1', '', '50');
INSERT INTO `pay_auth_rule` VALUES ('17', 'fa fa-address-book', 'User/loginrecord', '登录记录', '11', '1', '0', '1', '1', '', '10');
INSERT INTO `pay_auth_rule` VALUES ('18', 'fa fa-sitemap', 'Agent/#', '代理管理', '0', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('19', 'fa fa-hand-lizard-o', 'User/agentList', '代理列表', '18', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('20', 'fa fa-signing', 'Order/changeRecord?bank=9', '佣金记录', '18', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('21', 'fa fa-sellsy', 'Order/dfApiOrderList', '商户代付审核', '27', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('22', 'fa fa-reorder', 'User/#', '订单管理', '0', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('23', 'fa fa-indent', 'Order/changeRecord', '流水记录', '38', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('24', 'fa fa-thumbs-up', 'Order/index?status=1or2', '成功订单', '22', '1', '0', '1', '1', '', '90');
INSERT INTO `pay_auth_rule` VALUES ('25', 'fa fa-thumbs-down', 'Order/index?status=0', '未支付订单', '22', '1', '0', '1', '1', '', '80');
INSERT INTO `pay_auth_rule` VALUES ('26', 'fa fa-hand-o-right', 'Order/index?status=1', '异常订单', '22', '1', '0', '1', '1', '', '70');
INSERT INTO `pay_auth_rule` VALUES ('27', 'fa fa-user-secret', 'Withdrawal', '提款管理', '0', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('28', 'fa fa-wrench', 'Withdrawal/setting', '提款设置', '27', '1', '0', '1', '1', '', '50');
INSERT INTO `pay_auth_rule` VALUES ('29', 'fa fa-asl-interpreting', 'Withdrawal/index', '手动结算', '27', '1', '0', '1', '1', '', '40');
INSERT INTO `pay_auth_rule` VALUES ('30', 'fa fa-window-restore', 'Withdrawal/payment', '代付结算', '27', '1', '0', '1', '1', '', '30');
INSERT INTO `pay_auth_rule` VALUES ('31', 'fa fa-bank', 'Channel/#', '通道管理', '0', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('32', 'fa fa-product-hunt', 'Channel/index', '入金渠道设置', '31', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('33', 'fa fa-sitemap', 'Channel/product', '支付产品设置', '31', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('34', 'fa fa-sliders', 'PayForAnother/index', '代付渠道设置', '31', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('35', 'fa fa-book', 'Content/#', '文章管理', '0', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('36', 'fa fa-tags', 'Content/category', '栏目列表', '35', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('37', 'fa fa-list-alt', 'Content/article', '文章列表', '35', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('38', 'fa fa-line-chart', 'Statistics/#', '财务分析', '0', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('39', 'fa fa-bar-chart-o', 'Statistics/index', '交易统计', '38', '1', '0', '1', '0', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('40', 'fa fa-area-chart', 'Statistics/userFinance', '商户交易统计', '38', '1', '0', '1', '0', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('41', 'fa fa-industry', 'Statistics/userFinance?groupid=agent', '代理商交易统计', '38', '1', '0', '1', '0', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('42', 'fa fa-pie-chart', 'Statistics/channelFinance', '接口交易统计', '38', '1', '0', '1', '1', '', '80');
INSERT INTO `pay_auth_rule` VALUES ('43', 'fa fa-cubes', 'Template/index', '模板设置', '2', '1', '0', '1', '0', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('44', 'fa fa-mobile', 'System/mobile', '手机设置', '2', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('45', 'fa fa-signal', 'Statistics/chargeRank', '充值排行榜', '38', '1', '0', '1', '0', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('46', 'fa fa-first-order', 'Deposit/index', '投诉保证金设置', '11', '1', '0', '1', '1', '', '20');
INSERT INTO `pay_auth_rule` VALUES ('47', 'fa fa-asterisk', 'Statistics/complaintsDeposit', '投诉保证金统计', '38', '1', '0', '1', '0', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('48', 'fa fa-database', 'System/clearData', '数据清理', '2', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('49', '', 'Index/main', 'Dashboard', '1', '1', '0', '1', '0', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('51', '', 'System/SaveBase', '保存设置', '3', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('52', '', 'System/BindMobileShow', '绑定手机号码', '44', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('53', '', 'System/editMobileShow', '手机修改', '44', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('54', 'fa fa-lock', 'System/editPassword', '修改密码', '2', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('55', '', 'System/editSmstemplate', '短信模板', '5', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('56', '', 'System/saveSmstemplate', '保存短信模板', '5', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('57', '', 'System/saveEmail', '邮件保存', '4', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('58', '', 'System/testMobile', '测试短信', '5', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('59', '', 'System/deleteAdmin', '删除短信模板', '5', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('60', '', 'Admin/addAdmin', '管理员添加', '8', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('61', '', 'Admin/editAdmin', '管理员修改', '8', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('62', '', 'Admin/deleteAdmin', '管理员删除', '8', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('63', '', 'Auth/addGroup', '添加角色', '9', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('64', '', 'Auth/editGroup', '修改角色', '9', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('65', '', 'Auth/giveRole', '选择角色', '9', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('66', '', 'Auth/ruleGroup', '分配权限', '9', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('67', '', 'Menu/addMenu', '添加菜单', '10', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('68', '', 'Menu/editMenu', '修改菜单', '10', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('69', '', 'Menu/delMenu', '删除菜单', '10', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('70', '', 'System/clearDataSend', '数据清理提交', '48', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('71', '', 'User/addAgentCate', '代理级别', '19', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('72', '', 'User/saveAgentCate', '保存代理级别', '18', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('73', '', 'User/addInvitecode', '添加激活码', '16', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('74', '', 'User/EditAgentCate', '修改代理分类', '18', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('75', '', 'User/deleteAgentCate', '删除代理分类', '19', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('76', '', 'User/setInvite', '邀请码设置', '16', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('77', '', 'User/addInvite', '创建邀请码', '16', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('78', '', 'User/delInvitecode', '删除邀请码', '16', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('79', '', 'User/editUser', '用户编辑', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('80', '', 'User/changeuser', '修改状态', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('81', '', 'User/authorize', '用户认证', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('82', '', 'User/usermoney', '用户资金管理', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('83', '', 'User/userWithdrawal', '用户提现设置', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('84', '', 'User/userRateEdit', '用户费率设置', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('85', '', 'User/editPassword', '用户密码修改', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('86', '', 'User/editStatus', '用户状态修改', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('87', '', 'User/delUser', '用户删除', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('88', '', 'User/thawingFunds', 'T1解冻任务管理', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('89', '', 'User/exportuser', '导出用户', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('90', '', 'User/editAuthoize', '修改用户认证', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('91', '', 'User/getRandstr', '切换商户密钥', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('92', '', 'User/suoding', '用户锁定', '15', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('93', '', 'User/editbankcard', '银行卡管理', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('94', '', 'User/saveUser', '添加用户', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('95', '', 'User/saveUserProduct', '保存用户产品', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('96', '', 'User/saveUserRate', '保存用户费率', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('97', '', 'User/edittongdao', '编辑通道', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('98', '', 'User/frozenMoney', '用户资金冻结', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('99', '', 'User/unfrozenHandles', 'T1资金解冻', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('100', '', 'User/frozenOrder', '冻结订单列表', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('101', '', 'User/frozenHandles', 'T1订单解冻展示', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('102', '', 'Withdrawal/editStatus', '操作状态', '29', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('103', '', 'Withdrawal/editwtStatus', '操作订单状态', '30', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('104', '', 'Withdrawal/exportorder', '导出数据', '27', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('105', '', 'Withdrawal/editwtAllStatus', '批量修改提款状态', '27', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('106', '', 'Withdrawal/exportweituo', '导出委托提现', '30', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('107', '', 'Payment/index', '提交上游', '30', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('108', '', 'Withdrawal/saveWithdrawal', '保存设置', '28', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('109', '', 'Withdrawal/AddHoliday', '添加假日', '27', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('110', '', 'Withdrawal/settimeEdit', '编辑提款时间', '27', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('111', '', 'Withdrawal/delHoliday', '删除节假日', '27', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('112', '', 'Statistics/exportorder', '订单数据导出', '40', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('113', '', 'Statistics/details', '查看详情', '39', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('114', '', 'Order/exportorder', '订单导出', '23', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('115', '', 'Order/exceldownload', '记录导出', '23', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('116', 'fa fa-area-chart', 'Statistics/platformReport', '平台报表', '38', '1', '0', '1', '1', '', '90');
INSERT INTO `pay_auth_rule` VALUES ('117', 'fa fa-area-chart', 'Statistics/merchantReport', '商户报表', '38', '1', '0', '1', '0', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('118', 'fa fa-area-chart', 'Statistics/agentReport', '代理报表', '38', '1', '0', '1', '0', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('119', '', 'Withdrawal/submitDf', '代付提交', '30', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('120', '', 'User/editUserProduct', '分配用户通道', '12', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('121', 'fa fa-wrench', 'Transaction/index', '风控设置', '11', '1', '0', '1', '1', '', '30');
INSERT INTO `pay_auth_rule` VALUES ('122', '', 'Statistics/exportPlatform', '导出平台报表', '116', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('123', '', 'Statistics/exportMerchant', '导出商户报表', '117', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('124', '', 'Statistics/exportAgent', '导出代理报表', '118', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('125', '', 'Order/show', '查看订单', '22', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('126', 'fa fa-cog', 'Withdrawal/checkNotice', '提现申请声音提示', '2', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('127', 'fa fa-snowflake-o', 'Order/index', '全部订单', '22', '1', '0', '1', '1', '', '100');
INSERT INTO `pay_auth_rule` VALUES ('128', '', 'Withdrawal/rejectAllDf', '批量驳回代付', '27', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('129', '', 'User/saveWithdrawal', '保存用户提款设置', '28', '0', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('130', 'fa fa-snowflake-o', 'Order/frozenOrder', '冻结订单', '22', '1', '0', '1', '1', '', '60');
INSERT INTO `pay_auth_rule` VALUES ('131', 'fa fa-group', 'User/index', '全部用户', '11', '1', '0', '1', '1', '', '100');
INSERT INTO `pay_auth_rule` VALUES ('132', 'fa fa-file-text', 'Log/index', '商户操作日志', '11', '1', '0', '1', '1', '', '0');
INSERT INTO `pay_auth_rule` VALUES ('133', 'fa fa-area-chart', 'Statistics/analysis', '交易统计分析', '38', '1', '0', '1', '1', '', '100');

-- ----------------------------
-- Table structure for pay_auto_df_log
-- ----------------------------
DROP TABLE IF EXISTS `pay_auto_df_log`;
CREATE TABLE `pay_auto_df_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `df_id` int(11) NOT NULL DEFAULT '0' COMMENT '代付ID',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型：1提交 2查询',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '结果 0：提交失败 1：提交成功 2：代付成功 3：代付失败',
  `msg` varchar(255) DEFAULT '' COMMENT '描述',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '提交时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_auto_df_log
-- ----------------------------

-- ----------------------------
-- Table structure for pay_auto_unfrozen_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_auto_unfrozen_order`;
CREATE TABLE `pay_auto_unfrozen_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `freeze_money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '冻结金额',
  `unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '计划解冻时间',
  `real_unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '实际解冻时间',
  `is_pause` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否暂停解冻 0正常解冻 1暂停解冻',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '解冻状态 0未解冻 1已解冻',
  `create_at` int(11) NOT NULL COMMENT '记录创建时间',
  `update_at` int(11) NOT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_unfreezeing` (`status`,`is_pause`,`unfreeze_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉保证金余额';

-- ----------------------------
-- Records of pay_auto_unfrozen_order
-- ----------------------------

-- ----------------------------
-- Table structure for pay_bankcard
-- ----------------------------
DROP TABLE IF EXISTS `pay_bankcard`;
CREATE TABLE `pay_bankcard` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `bankname` varchar(100) NOT NULL COMMENT '银行名称',
  `subbranch` varchar(100) NOT NULL COMMENT '支行名称',
  `accountname` varchar(100) NOT NULL COMMENT '开户名',
  `cardnumber` varchar(100) NOT NULL COMMENT '银行卡号',
  `province_code` int(10) NOT NULL DEFAULT '0' COMMENT '省份代码',
  `province` varchar(100) NOT NULL COMMENT '所属省',
  `city_code` int(10) NOT NULL DEFAULT '0' COMMENT '城市代码',
  `city` varchar(100) NOT NULL COMMENT '所属市',
  `ip` varchar(100) DEFAULT NULL COMMENT '上次修改IP',
  `ipaddress` varchar(300) DEFAULT NULL COMMENT 'IP地址',
  `alias` varchar(255) DEFAULT '' COMMENT '备注',
  `isdefault` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认 1是 0 否',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `IND_UID` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_bankcard
-- ----------------------------

-- ----------------------------
-- Table structure for pay_blockedlog
-- ----------------------------
DROP TABLE IF EXISTS `pay_blockedlog`;
CREATE TABLE `pay_blockedlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(100) NOT NULL COMMENT '订单号',
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `amount` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '冻结金额',
  `thawtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '解冻时间',
  `pid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '商户支付通道',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1 解冻 0 冻结',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='资金冻结待解冻记录';

-- ----------------------------
-- Records of pay_blockedlog
-- ----------------------------

-- ----------------------------
-- Table structure for pay_browserecord
-- ----------------------------
DROP TABLE IF EXISTS `pay_browserecord`;
CREATE TABLE `pay_browserecord` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `articleid` int(11) NOT NULL DEFAULT '0',
  `userid` int(11) NOT NULL DEFAULT '0',
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_browserecord
-- ----------------------------

-- ----------------------------
-- Table structure for pay_category
-- ----------------------------
DROP TABLE IF EXISTS `pay_category`;
CREATE TABLE `pay_category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `pid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '父级ID',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1开启 0关闭',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='文章栏目';

-- ----------------------------
-- Records of pay_category
-- ----------------------------
INSERT INTO `pay_category` VALUES ('1', '最新资讯', '0', '1');
INSERT INTO `pay_category` VALUES ('2', '公司新闻', '0', '1');
INSERT INTO `pay_category` VALUES ('3', '公告通知', '0', '1');
INSERT INTO `pay_category` VALUES ('4', '站内公告', '3', '1');
INSERT INTO `pay_category` VALUES ('5', '公司新闻', '3', '1');

-- ----------------------------
-- Table structure for pay_channel
-- ----------------------------
DROP TABLE IF EXISTS `pay_channel`;
CREATE TABLE `pay_channel` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT COMMENT '供应商通道ID',
  `code` varchar(200) DEFAULT NULL COMMENT '供应商通道英文编码',
  `title` varchar(200) DEFAULT NULL COMMENT '供应商通道名称',
  `mch_id` varchar(100) DEFAULT NULL COMMENT '商户号',
  `signkey` varchar(500) DEFAULT NULL COMMENT '签文密钥',
  `appid` varchar(100) DEFAULT NULL COMMENT '应用APPID',
  `appsecret` varchar(100) DEFAULT NULL COMMENT '安全密钥',
  `gateway` varchar(300) DEFAULT NULL COMMENT '网关地址',
  `pagereturn` varchar(255) DEFAULT NULL COMMENT '页面跳转网址',
  `serverreturn` varchar(255) DEFAULT NULL COMMENT '服务器通知网址',
  `defaultrate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '下家费率',
  `fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '封顶手续费',
  `rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '银行费率',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次更改时间',
  `unlockdomain` varchar(100) NOT NULL COMMENT '防封域名',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1开启 0关闭',
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '渠道类型: 1 微信扫码 2 微信H5 3 支付宝扫码 4 支付宝H5 5网银跳转 6网银直连 7百度钱包 8 QQ钱包 9 京东钱包',
  `start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `paying_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当天交易金额',
  `all_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当天上游可交易量',
  `last_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后交易时间',
  `min_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最小交易额',
  `max_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最大交易额',
  `control_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '风控状态:0否1是',
  `offline_status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '通道上线状态:0已下线，1上线',
  `t0defaultrate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0运营费率',
  `t0fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0封顶手续费',
  `t0rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0成本费率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8 COMMENT='供应商列表';

-- ----------------------------
-- Records of pay_channel
-- ----------------------------
INSERT INTO `pay_channel` VALUES ('199', 'WxSm', '微信扫码支付', '', '', '', '', '', '', '', '0.0400', '0.0900', '0.0000', '1503846107', '', '1', '1', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('200', 'WxGzh', '微信H5', '', '', 'wxf33668d58442ff6e', '', '', '', '', '0.0000', '0.0000', '0.0000', '1502378687', '', '1', '2', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('201', 'Aliscan', '支付宝扫码', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1503857975', '', '1', '3', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('202', 'Aliwap', '支付宝H5', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1503857966', '', '1', '4', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('203', 'QQSCAN', 'QQ扫码', '', '', '', '', '', '', '', '0.0050', '0.0000', '0.0000', '1503280494', '', '1', '8', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');

-- ----------------------------
-- Table structure for pay_channel_account
-- ----------------------------
DROP TABLE IF EXISTS `pay_channel_account`;
CREATE TABLE `pay_channel_account` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT COMMENT '供应商通道账号ID',
  `channel_id` smallint(6) unsigned NOT NULL COMMENT '通道id',
  `mch_id` varchar(100) DEFAULT NULL COMMENT '商户号',
  `signkey` varchar(500) DEFAULT NULL COMMENT '签文密钥',
  `appid` varchar(100) DEFAULT NULL COMMENT '应用APPID',
  `appsecret` varchar(2500) DEFAULT NULL COMMENT '安全密钥',
  `defaultrate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '下家费率',
  `fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '封顶手续费',
  `rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '银行费率',
  `updatetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上次更改时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1开启 0关闭',
  `title` varchar(100) DEFAULT NULL COMMENT '账户标题',
  `weight` tinyint(2) DEFAULT NULL COMMENT '轮询权重',
  `custom_rate` tinyint(1) DEFAULT NULL COMMENT '是否自定义费率',
  `start_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '开始交易时间',
  `end_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '结束时间',
  `last_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后一笔交易时间',
  `paying_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当天交易金额',
  `all_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单日可交易金额',
  `max_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔交易最大金额',
  `min_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔交易最小金额',
  `offline_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '上线状态-1上线,0下线',
  `control_status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '风控状态-0不风控,1风控中',
  `is_defined` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否自定义:1-是,0-否',
  `unit_frist_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间第一笔交易时间',
  `unit_paying_number` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '单时间交易笔数',
  `unit_paying_amount` decimal(11,0) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间交易金额',
  `unit_interval` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间数值',
  `time_unit` char(1) NOT NULL DEFAULT 's' COMMENT '限制时间单位',
  `unit_number` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间次数',
  `unit_all_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单位时间金额',
  `t0defaultrate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0运营费率',
  `t0fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0封顶手续费',
  `t0rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0成本费率',
  `unlockdomain` varchar(255) NOT NULL COMMENT '防封域名',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='供应商账号列表';

-- ----------------------------
-- Records of pay_channel_account
-- ----------------------------

-- ----------------------------
-- Table structure for pay_complaints_deposit
-- ----------------------------
DROP TABLE IF EXISTS `pay_complaints_deposit`;
CREATE TABLE `pay_complaints_deposit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `pay_orderid` varchar(100) NOT NULL DEFAULT '0' COMMENT '系统订单号',
  `out_trade_id` varchar(50) NOT NULL DEFAULT '' COMMENT '下游订单号',
  `freeze_money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '冻结保证金额',
  `unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '计划解冻时间',
  `real_unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '实际解冻时间',
  `is_pause` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否暂停解冻 0正常解冻 1暂停解冻',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '解冻状态 0未解冻 1已解冻',
  `create_at` int(11) NOT NULL COMMENT '记录创建时间',
  `update_at` int(11) NOT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_unfreezeing` (`status`,`is_pause`,`unfreeze_time`),
  KEY `pay_orderid` (`pay_orderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='投诉保证金余额';

-- ----------------------------
-- Records of pay_complaints_deposit
-- ----------------------------

-- ----------------------------
-- Table structure for pay_complaints_deposit_rule
-- ----------------------------
DROP TABLE IF EXISTS `pay_complaints_deposit_rule`;
CREATE TABLE `pay_complaints_deposit_rule` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `is_system` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否系统规则 1是 0否',
  `ratio` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '投诉保证金比例（百分比）',
  `freeze_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '冻结时间（秒）',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '规则是否开启 1开启 0关闭',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='投诉保证金规则表';

-- ----------------------------
-- Records of pay_complaints_deposit_rule
-- ----------------------------
INSERT INTO `pay_complaints_deposit_rule` VALUES ('1', '180586943', '0', '10.00', '3', '1');

-- ----------------------------
-- Table structure for pay_df_api_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_df_api_order`;
CREATE TABLE `pay_df_api_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `trade_no` varchar(30) NOT NULL DEFAULT '' COMMENT '平台订单号',
  `out_trade_no` varchar(30) NOT NULL DEFAULT '' COMMENT '商户订单号',
  `money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '金额',
  `bankname` varchar(100) NOT NULL DEFAULT '' COMMENT '银行名称',
  `subbranch` varchar(100) NOT NULL DEFAULT '' COMMENT '支行名称',
  `accountname` varchar(100) NOT NULL DEFAULT '' COMMENT '开户名',
  `cardnumber` varchar(100) NOT NULL DEFAULT '' COMMENT '银行卡号',
  `province` varchar(100) NOT NULL DEFAULT '' COMMENT '所属省',
  `city` varchar(100) NOT NULL DEFAULT '' COMMENT '所属市',
  `ip` varchar(100) DEFAULT '' COMMENT 'IP地址',
  `check_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：待审核 1：已提交后台审核 2：审核驳回',
  `extends` text COMMENT '扩展字段',
  `df_id` int(11) NOT NULL DEFAULT '0' COMMENT '代付ID',
  `notifyurl` varchar(255) DEFAULT '' COMMENT '异步通知地址',
  `reject_reason` varchar(255) NOT NULL DEFAULT '' COMMENT '驳回原因',
  `check_time` int(11) NOT NULL DEFAULT '0' COMMENT '审核时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `df_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '代付API扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  PRIMARY KEY (`id`),
  KEY `IND_UID` (`userid`),
  KEY `df_id` (`df_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_df_api_order
-- ----------------------------

-- ----------------------------
-- Table structure for pay_email
-- ----------------------------
DROP TABLE IF EXISTS `pay_email`;
CREATE TABLE `pay_email` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `smtp_host` varchar(300) DEFAULT NULL,
  `smtp_port` varchar(300) DEFAULT NULL,
  `smtp_user` varchar(300) DEFAULT NULL,
  `smtp_pass` varchar(300) DEFAULT NULL,
  `smtp_email` varchar(300) DEFAULT NULL,
  `smtp_name` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_email
-- ----------------------------
INSERT INTO `pay_email` VALUES ('1', 'smtpdm.aliyun.com', '465', 'info@mail.tianniu.cc', 'Mailpush123', 'info@mail.tianniu.cc', '知宇聚合API支付系统');

-- ----------------------------
-- Table structure for pay_invitecode
-- ----------------------------
DROP TABLE IF EXISTS `pay_invitecode`;
CREATE TABLE `pay_invitecode` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invitecode` varchar(32) NOT NULL,
  `fmusernameid` int(11) unsigned NOT NULL DEFAULT '0',
  `syusernameid` int(11) NOT NULL DEFAULT '0',
  `regtype` tinyint(1) unsigned NOT NULL DEFAULT '4' COMMENT '用户组 4 普通用户 5 代理商',
  `fbdatetime` int(11) unsigned NOT NULL DEFAULT '0',
  `yxdatetime` int(11) unsigned NOT NULL DEFAULT '0',
  `sydatetime` int(11) unsigned DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '邀请码状态 0 禁用 1 未使用 2 已使用',
  `is_admin` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否管理员添加',
  PRIMARY KEY (`id`),
  UNIQUE KEY `invitecode` (`invitecode`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_invitecode
-- ----------------------------

-- ----------------------------
-- Table structure for pay_inviteconfig
-- ----------------------------
DROP TABLE IF EXISTS `pay_inviteconfig`;
CREATE TABLE `pay_inviteconfig` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invitezt` tinyint(1) unsigned DEFAULT '1',
  `invitetype2number` int(11) NOT NULL DEFAULT '20',
  `invitetype2ff` smallint(6) NOT NULL DEFAULT '1',
  `invitetype5number` int(11) NOT NULL DEFAULT '20',
  `invitetype5ff` smallint(6) NOT NULL DEFAULT '1',
  `invitetype6number` int(11) NOT NULL DEFAULT '20',
  `invitetype6ff` smallint(6) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_inviteconfig
-- ----------------------------
INSERT INTO `pay_inviteconfig` VALUES ('1', '1', '0', '0', '10', '1', '0', '0');

-- ----------------------------
-- Table structure for pay_loginrecord
-- ----------------------------
DROP TABLE IF EXISTS `pay_loginrecord`;
CREATE TABLE `pay_loginrecord` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0',
  `logindatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `loginip` varchar(100) NOT NULL,
  `loginaddress` varchar(300) DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型：0：前台用户 1：后台用户',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_loginrecord
-- ----------------------------

-- ----------------------------
-- Table structure for pay_member
-- ----------------------------
DROP TABLE IF EXISTS `pay_member`;
CREATE TABLE `pay_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `groupid` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '用户组',
  `salt` varchar(10) NOT NULL COMMENT '密码随机字符',
  `parentid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '代理ID',
  `agent_cate` int(11) NOT NULL DEFAULT '0' COMMENT '代理级别',
  `balance` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '可用余额',
  `blockedbalance` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '冻结可用余额',
  `email` varchar(100) NOT NULL,
  `activate` varchar(200) NOT NULL,
  `regdatetime` int(11) unsigned NOT NULL DEFAULT '0',
  `activatedatetime` int(11) unsigned NOT NULL DEFAULT '0',
  `realname` varchar(50) DEFAULT NULL COMMENT '姓名',
  `sex` tinyint(1) NOT NULL DEFAULT '1' COMMENT '性别',
  `birthday` int(11) NOT NULL DEFAULT '0',
  `sfznumber` varchar(20) DEFAULT NULL,
  `mobile` varchar(15) DEFAULT NULL COMMENT '联系电话',
  `qq` varchar(15) DEFAULT NULL COMMENT 'QQ',
  `address` varchar(200) DEFAULT NULL COMMENT '联系地址',
  `paypassword` varchar(32) DEFAULT NULL COMMENT '支付密码',
  `authorized` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1 已认证 0 未认证 2 待审核',
  `apidomain` varchar(500) DEFAULT NULL COMMENT '授权访问域名',
  `apikey` varchar(32) NOT NULL COMMENT 'APIKEY',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1激活 0未激活',
  `receiver` varchar(255) DEFAULT NULL COMMENT '台卡显示的收款人信息',
  `unit_paying_number` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间已交易次数',
  `unit_paying_amount` decimal(15,4) unsigned NOT NULL DEFAULT '0.00' COMMENT '单位时间已交易金额',
  `unit_frist_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间已交易的第一笔时间',
  `last_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天最后一笔已交易时间',
  `paying_money` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '当天已交易金额',
  `login_ip` varchar(255) NOT NULL DEFAULT ' ' COMMENT '登录IP',
  `last_error_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录错误时间',
  `login_error_num` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '错误登录次数',
  `google_auth` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启谷歌身份验证登录',
  `df_api` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启代付API',
  `open_charge` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启充值功能',
  `df_domain` text NOT NULL COMMENT '代付域名报备',
  `df_auto_check` tinyint(1) NOT NULL DEFAULT '0' COMMENT '代付API自动审核',
  `google_secret_key` varchar(255) NOT NULL DEFAULT '' COMMENT '谷歌密钥',
  `df_ip` text NOT NULL COMMENT '代付域名报备IP',
  `session_random` varchar(50) NOT NULL DEFAULT '' COMMENT 'session随机字符串',
  `df_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '代付API扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  `last_login_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_member
-- ----------------------------
INSERT INTO `pay_member` VALUES ('2', 'demouser', '0f69c07fc7967666fb2870349775751a', '4', '6450', '1', '0', '19193.0000', '3.0000', '', '8f9a2804950df5c2ff9ba1f8a9b64937', '1503828960', '2017', '', '1', '1282838400', '', '', '', '中国', 'e10adc3949ba59abbe56e057f20f883e', '1', null, 't4ig5acnpx4fet4zapshjacjd9o4bhbi', '1', null, '0', '0.00', '0', '0', '0.0000', ' ', '0', '0', '0', '1', '1', '', '1', '', '', '', '0', '0');

-- ----------------------------
-- Table structure for pay_member_agent_cate
-- ----------------------------
DROP TABLE IF EXISTS `pay_member_agent_cate`;
CREATE TABLE `pay_member_agent_cate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cate_name` varchar(50) DEFAULT NULL COMMENT '等级名',
  `desc` varchar(255) DEFAULT NULL COMMENT '等级描述',
  `ctime` int(11) DEFAULT '0' COMMENT '添加时间',
  `sort` int(11) DEFAULT '99' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_member_agent_cate
-- ----------------------------
INSERT INTO `pay_member_agent_cate` VALUES ('4', '普通商户', '', '1522638122', '99');
INSERT INTO `pay_member_agent_cate` VALUES ('5', '普通代理商户', '', '1522638122', '99');
INSERT INTO `pay_member_agent_cate` VALUES ('6', '中级代理商户', '', '1522638122', '99');
INSERT INTO `pay_member_agent_cate` VALUES ('7', '高级代理商户', '', '1522638122', '99');

-- ----------------------------
-- Table structure for pay_moneychange
-- ----------------------------
DROP TABLE IF EXISTS `pay_moneychange`;
CREATE TABLE `pay_moneychange` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `ymoney` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '原金额',
  `money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '变动金额',
  `gmoney` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '变动后金额',
  `datetime` datetime DEFAULT NULL COMMENT '修改时间',
  `transid` varchar(50) DEFAULT NULL COMMENT '交易流水号',
  `tongdao` smallint(6) unsigned DEFAULT '0' COMMENT '支付通道ID',
  `lx` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `tcuserid` int(11) DEFAULT NULL,
  `tcdengji` int(11) DEFAULT NULL,
  `orderid` varchar(50) DEFAULT NULL COMMENT '订单号',
  `contentstr` varchar(255) DEFAULT NULL COMMENT '备注',
  `t` int(4) NOT NULL DEFAULT '0' COMMENT '结算方式',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_moneychange
-- ----------------------------

-- ----------------------------
-- Table structure for pay_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_order`;
CREATE TABLE `pay_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pay_memberid` varchar(100) NOT NULL COMMENT '商户编号',
  `pay_orderid` varchar(100) NOT NULL COMMENT '系统订单号',
  `pay_amount` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000',
  `pay_poundage` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000',
  `pay_actualamount` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000',
  `pay_applydate` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单创建日期',
  `pay_successdate` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单支付成功时间',
  `pay_bankcode` varchar(100) DEFAULT NULL COMMENT '银行编码',
  `pay_notifyurl` varchar(500) NOT NULL COMMENT '商家异步通知地址',
  `pay_callbackurl` varchar(500) NOT NULL COMMENT '商家页面通知地址',
  `pay_bankname` varchar(300) DEFAULT NULL,
  `pay_status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '订单状态: 0 未支付 1 已支付未返回 2 已支付已返回',
  `pay_productname` varchar(300) DEFAULT NULL COMMENT '商品名称',
  `pay_tongdao` varchar(50) DEFAULT NULL,
  `pay_zh_tongdao` varchar(50) DEFAULT NULL,
  `pay_tjurl` varchar(1000) DEFAULT NULL,
  `out_trade_id` varchar(50) NOT NULL COMMENT '商户订单号',
  `num` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '已补发次数',
  `memberid` varchar(100) DEFAULT NULL COMMENT '支付渠道商家号',
  `key` varchar(500) DEFAULT NULL COMMENT '支付渠道密钥',
  `account` varchar(100) DEFAULT NULL COMMENT '渠道账号',
  `isdel` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '伪删除订单 1 删除 0 未删',
  `ddlx` int(11) DEFAULT '0',
  `pay_ytongdao` varchar(50) DEFAULT NULL,
  `pay_yzh_tongdao` varchar(50) DEFAULT NULL,
  `xx` smallint(6) unsigned NOT NULL DEFAULT '0',
  `attach` text CHARACTER SET utf8mb4 COMMENT '商家附加字段,原样返回',
  `pay_channel_account` varchar(255) DEFAULT NULL COMMENT '通道账户',
  `cost` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '成本',
  `cost_rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '成本费率',
  `account_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '子账号id',
  `channel_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '渠道id',
  `t` tinyint(2) NOT NULL DEFAULT '1' COMMENT '结算周期（计算费率）',
  `last_reissue_time` int(11) NOT NULL DEFAULT '11' COMMENT '最后补发时间',
  `lock_status` tinyint(1) DEFAULT '0' COMMENT '是否冻结订单，1冻结，2解冻',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IND_ORD` (`pay_orderid`),
  KEY `account_id` (`account_id`),
  KEY `channel_id` (`channel_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_order
-- ----------------------------

-- ----------------------------
-- Table structure for pay_paylog
-- ----------------------------
DROP TABLE IF EXISTS `pay_paylog`;
CREATE TABLE `pay_paylog` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `out_trade_no` varchar(50) NOT NULL,
  `result_code` varchar(50) NOT NULL,
  `transaction_id` varchar(50) NOT NULL,
  `fromuser` varchar(50) NOT NULL,
  `time_end` int(11) unsigned NOT NULL DEFAULT '0',
  `total_fee` smallint(6) unsigned NOT NULL DEFAULT '0',
  `payname` varchar(50) NOT NULL,
  `bank_type` varchar(20) DEFAULT NULL,
  `trade_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IND_TRD` (`transaction_id`),
  UNIQUE KEY `IND_ORD` (`out_trade_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_paylog
-- ----------------------------

-- ----------------------------
-- Table structure for pay_pay_channel_extend_fields
-- ----------------------------
DROP TABLE IF EXISTS `pay_pay_channel_extend_fields`;
CREATE TABLE `pay_pay_channel_extend_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NOT NULL DEFAULT '0' COMMENT '代付渠道ID',
  `code` varchar(64) NOT NULL DEFAULT '' COMMENT '代付渠道代码',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '扩展字段名',
  `alias` varchar(50) NOT NULL DEFAULT '' COMMENT '扩展字段别名',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `etime` int(11) NOT NULL DEFAULT '0' COMMENT '修改时间',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_pay_channel_extend_fields
-- ----------------------------

-- ----------------------------
-- Table structure for pay_pay_for_another
-- ----------------------------
DROP TABLE IF EXISTS `pay_pay_for_another`;
CREATE TABLE `pay_pay_for_another` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` varchar(64) NOT NULL COMMENT '代付代码',
  `title` varchar(64) NOT NULL COMMENT '代付名称',
  `mch_id` varchar(255) NOT NULL DEFAULT ' ' COMMENT '商户号',
  `appid` varchar(100) NOT NULL DEFAULT ' ' COMMENT '应用APPID',
  `appsecret` varchar(100) NOT NULL DEFAULT ' ' COMMENT '应用密钥',
  `signkey` varchar(500) NOT NULL DEFAULT ' ' COMMENT '加密的秘钥',
  `public_key` varchar(1000) NOT NULL DEFAULT '  ' COMMENT '加密的公钥',
  `private_key` varchar(1000) NOT NULL DEFAULT '  ' COMMENT '加密的私钥',
  `exec_gateway` varchar(255) NOT NULL DEFAULT ' ' COMMENT '请求代付的地址',
  `query_gateway` varchar(255) NOT NULL DEFAULT ' ' COMMENT '查询代付的地址',
  `serverreturn` varchar(255) NOT NULL DEFAULT ' ' COMMENT '服务器通知网址',
  `unlockdomain` varchar(255) NOT NULL DEFAULT ' ' COMMENT '防封域名',
  `updatetime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更改时间',
  `status` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1开启 0关闭',
  `is_default` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认：1是，0否',
  `cost_rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '成本费率',
  `rate_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '费率类型：按单笔收费0，按比例收费：1',
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `updatetime` (`updatetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代付通道表';

-- ----------------------------
-- Records of pay_pay_for_another
-- ----------------------------

-- ----------------------------
-- Table structure for pay_product
-- ----------------------------
DROP TABLE IF EXISTS `pay_product`;
CREATE TABLE `pay_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '通道名称',
  `code` varchar(50) NOT NULL COMMENT '通道代码',
  `polling` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '接口模式 0 单独 1 轮询',
  `paytype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '支付类型 1 微信扫码 2 微信H5 3 支付宝扫码 4 支付宝H5 5 网银跳转 6网银直连  7 百度钱包  8 QQ钱包 9 京东钱包',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `isdisplay` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '用户端显示 1 显示 0 不显示',
  `channel` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '通道ID',
  `weight` text COMMENT '平台默认通道权重',
  `t0defaultrate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT 'T0运营费率',
  `t0fengding` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT 'T0封顶手续费',
  `defaultrate` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT 'T1运营费率',
  `fengding` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT 'T1封顶手续费',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=911 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_product
-- ----------------------------
INSERT INTO `pay_product` VALUES ('901', '微信公众号', 'WXJSAPI', '0', '2', '1', '1', '0', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('902', '微信扫码支付', 'WXSCAN', '0', '1', '1', '1', '199', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('903', '支付宝扫码支付', 'ALISCAN', '0', '3', '1', '1', '201', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('904', '支付宝手机', 'ALIWAP', '0', '4', '1', '1', '202', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('905', 'QQ手机支付', 'QQWAP', '1', '2', '0', '1', '0', '200:7', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('907', '网银支付', 'DBANK', '0', '5', '1', '1', '205', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('908', 'QQ扫码支付', 'QSCAN', '0', '8', '0', '0', '203', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('909', '百度钱包', 'BAIDU', '0', '7', '0', '0', '0', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('910', '京东支付', 'JDPAY', '0', '9', '0', '0', '0', '', '0.0000', '0.0000', '0.0000', '0.0000');

-- ----------------------------
-- Table structure for pay_product_user
-- ----------------------------
DROP TABLE IF EXISTS `pay_product_user`;
CREATE TABLE `pay_product_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT ' ',
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `pid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '商户通道ID',
  `polling` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '接口模式：0 单独 1 轮询',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '通道状态 0 关闭 1 启用',
  `channel` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '指定单独通道ID',
  `weight` varchar(255) DEFAULT NULL COMMENT '通道权重',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_product_user
-- ----------------------------

-- ----------------------------
-- Table structure for pay_reconciliation
-- ----------------------------
DROP TABLE IF EXISTS `pay_reconciliation`;
CREATE TABLE `pay_reconciliation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT '0' COMMENT '用户ID',
  `order_total_count` int(11) DEFAULT '0' COMMENT '总订单数',
  `order_success_count` int(11) DEFAULT '0' COMMENT '成功订单数',
  `order_fail_count` int(11) DEFAULT '0' COMMENT '未支付订单数',
  `order_total_amount` decimal(11,4) DEFAULT '0.0000' COMMENT '订单总额',
  `order_success_amount` decimal(11,4) DEFAULT '0.0000' COMMENT '订单实付总额',
  `date` date DEFAULT NULL COMMENT '日期',
  `ctime` int(11) DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_reconciliation
-- ----------------------------

-- ----------------------------
-- Table structure for pay_redo_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_redo_order`;
CREATE TABLE `pay_redo_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作管理员',
  `money` decimal(15,4) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：增加 2：减少',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '冲正备注',
  `date` datetime NOT NULL COMMENT '冲正周期',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_redo_order
-- ----------------------------

-- ----------------------------
-- Table structure for pay_route
-- ----------------------------
DROP TABLE IF EXISTS `pay_route`;
CREATE TABLE `pay_route` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `urlstr` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_route
-- ----------------------------

-- ----------------------------
-- Table structure for pay_sms
-- ----------------------------
DROP TABLE IF EXISTS `pay_sms`;
CREATE TABLE `pay_sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_key` varchar(255) DEFAULT NULL COMMENT 'App Key',
  `app_secret` varchar(255) DEFAULT NULL COMMENT 'App Secret',
  `sign_name` varchar(255) DEFAULT NULL COMMENT '默认签名',
  `is_open` int(11) DEFAULT '0' COMMENT '是否开启，0关闭，1开启',
  `admin_mobile` varchar(255) DEFAULT NULL COMMENT '管理员接收手机',
  `is_receive` int(11) DEFAULT '0' COMMENT '是否开启，0关闭，1开启',
  `sms_channel` varchar(20) NOT NULL DEFAULT 'aliyun' COMMENT '短信通道',
  `smsbao_user` varchar(50) NOT NULL DEFAULT '' COMMENT '短信宝账号',
  `smsbao_pass` varchar(50) NOT NULL DEFAULT '' COMMENT '短信宝密码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_sms
-- ----------------------------
INSERT INTO `pay_sms` VALUES ('3', 'LTAIRR5X8fMzp3do', 'Ku8NjuKhx9N6igyaHYstZFsc8GplwV', '德兴支付', '1', null, '0', 'aliyun', '1', '1');

-- ----------------------------
-- Table structure for pay_sms_template
-- ----------------------------
DROP TABLE IF EXISTS `pay_sms_template`;
CREATE TABLE `pay_sms_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `template_code` varchar(255) DEFAULT NULL COMMENT '模板代码',
  `call_index` varchar(255) DEFAULT NULL COMMENT '调用字符串',
  `template_content` text COMMENT '模板内容',
  `ctime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_sms_template
-- ----------------------------
INSERT INTO `pay_sms_template` VALUES ('3', '修改支付密码', 'SMS_125115291', 'editPayPassword', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1512202260');
INSERT INTO `pay_sms_template` VALUES ('4', '修改登录密码', 'SMS_125115291', 'editPassword', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1512190115');
INSERT INTO `pay_sms_template` VALUES ('5', '异地登录', 'SMS_125115291', 'loginWarning', '您的账号于${time}登录异常，异常登录地址：${address}，如非本人操纵，请及时修改账号密码。', '1512202260');
INSERT INTO `pay_sms_template` VALUES ('6', '申请结算', 'SMS_125115291', 'clearing', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1512202260');
INSERT INTO `pay_sms_template` VALUES ('7', '委托结算', 'SMS_125115291', 'entrusted', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1512202260');
INSERT INTO `pay_sms_template` VALUES ('8', '绑定手机', 'SMS_125115291', 'bindMobile', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1514534290');
INSERT INTO `pay_sms_template` VALUES ('9', '更新手机', 'SMS_125115291', 'editMobile', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1514535688');
INSERT INTO `pay_sms_template` VALUES ('10', '更新银行卡 ', 'SMS_125115291 ', 'addBankcardSend', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1514535688');
INSERT INTO `pay_sms_template` VALUES ('11', '修改个人资料', 'SMS_125115291', 'saveProfile', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', null);
INSERT INTO `pay_sms_template` VALUES ('12', '绑定管理员手机号码', 'SMS_125115291', 'adminbindMobile', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('13', '修改管理员手机号码', 'SMS_125115291', 'admineditMobile', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('14', '批量删除订单', 'SMS_125115291', 'delOrderSend', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('15', '解绑谷歌身份验证器', 'SMS_125115291', 'unbindGoogle', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('16', '设置订单为已支付', 'SMS_125115291', 'setOrderPaidSend', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('17', '清理数据', 'SMS_125115291', 'clearDataSend', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('18', '增加/减少余额（冲正）', 'SMS_125115291', 'adjustUserMoneySend', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('19', '提交代付', 'SMS_125115291', 'submitDfSend', '您的验证码为：${code} ，你正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('20', '测试短信', 'SMS_125115291', 'test', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('21', '系统配置', 'SMS_125115291', 'sysconfig', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('22', '提款设置', 'SMS_125115291', 'tkconfig', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');

-- ----------------------------
-- Table structure for pay_systembank
-- ----------------------------
DROP TABLE IF EXISTS `pay_systembank`;
CREATE TABLE `pay_systembank` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bankcode` varchar(100) DEFAULT NULL,
  `bankname` varchar(300) DEFAULT NULL,
  `images` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=198 DEFAULT CHARSET=utf8 COMMENT='结算银行';

-- ----------------------------
-- Records of pay_systembank
-- ----------------------------
INSERT INTO `pay_systembank` VALUES ('162', 'BOB', '北京银行', 'BOB.gif');
INSERT INTO `pay_systembank` VALUES ('164', 'BEA', '东亚银行', 'BEA.gif');
INSERT INTO `pay_systembank` VALUES ('165', 'ICBC', '中国工商银行', 'ICBC.gif');
INSERT INTO `pay_systembank` VALUES ('166', 'CEB', '中国光大银行', 'CEB.gif');
INSERT INTO `pay_systembank` VALUES ('167', 'GDB', '广发银行', 'GDB.gif');
INSERT INTO `pay_systembank` VALUES ('168', 'HXB', '华夏银行', 'HXB.gif');
INSERT INTO `pay_systembank` VALUES ('169', 'CCB', '中国建设银行', 'CCB.gif');
INSERT INTO `pay_systembank` VALUES ('170', 'BCM', '交通银行', 'BCM.gif');
INSERT INTO `pay_systembank` VALUES ('171', 'CMSB', '中国民生银行', 'CMSB.gif');
INSERT INTO `pay_systembank` VALUES ('172', 'NJCB', '南京银行', 'NJCB.gif');
INSERT INTO `pay_systembank` VALUES ('173', 'NBCB', '宁波银行', 'NBCB.gif');
INSERT INTO `pay_systembank` VALUES ('174', 'ABC', '中国农业银行', '5414c87492ad8.gif');
INSERT INTO `pay_systembank` VALUES ('175', 'PAB', '平安银行', '5414c0929a632.gif');
INSERT INTO `pay_systembank` VALUES ('176', 'BOS', '上海银行', 'BOS.gif');
INSERT INTO `pay_systembank` VALUES ('177', 'SPDB', '上海浦东发展银行', 'SPDB.gif');
INSERT INTO `pay_systembank` VALUES ('178', 'SDB', '深圳发展银行', 'SDB.gif');
INSERT INTO `pay_systembank` VALUES ('179', 'CIB', '兴业银行', 'CIB.gif');
INSERT INTO `pay_systembank` VALUES ('180', 'PSBC', '中国邮政储蓄银行', 'PSBC.gif');
INSERT INTO `pay_systembank` VALUES ('181', 'CMBC', '招商银行', 'CMBC.gif');
INSERT INTO `pay_systembank` VALUES ('182', 'CZB', '浙商银行', 'CZB.gif');
INSERT INTO `pay_systembank` VALUES ('183', 'BOC', '中国银行', 'BOC.gif');
INSERT INTO `pay_systembank` VALUES ('184', 'CNCB', '中信银行', 'CNCB.gif');
INSERT INTO `pay_systembank` VALUES ('193', 'ALIPAY', '支付宝', '58b83a5820644.jpg');
INSERT INTO `pay_systembank` VALUES ('194', 'WXZF', '微信支付', '58b83a757a298.jpg');

-- ----------------------------
-- Table structure for pay_template
-- ----------------------------
DROP TABLE IF EXISTS `pay_template`;
CREATE TABLE `pay_template` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT ' ' COMMENT '模板名称',
  `theme` varchar(255) NOT NULL DEFAULT ' ' COMMENT '模板代码',
  `is_default` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否默认模板:1是，0否',
  `add_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `remarks` varchar(255) NOT NULL DEFAULT ' ' COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='模板表';

-- ----------------------------
-- Records of pay_template
-- ----------------------------
INSERT INTO `pay_template` VALUES ('1', ' 默认模板', 'default', '0', '1524299660', '1524299660', ' 默认模板');
INSERT INTO `pay_template` VALUES ('2', '模板一', 'view1', '0', '1524299660', '1524299660', '模板一');
INSERT INTO `pay_template` VALUES ('3', '模板二', 'view2', '0', '0', '1524623473', '模板二');
INSERT INTO `pay_template` VALUES ('4', '模板三', 'view3', '1', '0', '1524623494', '模板三');

-- ----------------------------
-- Table structure for pay_tikuanconfig
-- ----------------------------
DROP TABLE IF EXISTS `pay_tikuanconfig`;
CREATE TABLE `pay_tikuanconfig` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `tkzxmoney` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最小提款金额',
  `tkzdmoney` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最大提款金额',
  `dayzdmoney` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当日提款最大总金额',
  `dayzdnum` int(11) NOT NULL DEFAULT '0' COMMENT '当日提款最大次数',
  `t1zt` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT 'T+1 ：1开启 0 关闭',
  `t0zt` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'T+0 ：1开启 0 关闭',
  `gmt0` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '购买T0',
  `tkzt` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '提款设置 1 开启 0 关闭',
  `tktype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '提款手续费类型 1 每笔 0 比例 ',
  `systemxz` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 系统规则 1 用户规则',
  `sxfrate` varchar(20) DEFAULT NULL COMMENT '单笔提款比例',
  `sxffixed` varchar(20) DEFAULT NULL COMMENT '单笔提款手续费',
  `issystem` tinyint(1) unsigned DEFAULT '0' COMMENT '平台规则 1 是 0 否',
  `allowstart` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '提款允许开始时间',
  `allowend` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '提款允许结束时间',
  `daycardzdmoney` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单人单卡单日最高提现额',
  `auto_df_switch` tinyint(1) NOT NULL DEFAULT '0' COMMENT '自动代付开关',
  `auto_df_maxmoney` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '单笔代付最大金额限制',
  `auto_df_stime` varchar(20) NOT NULL DEFAULT '' COMMENT '自动代付开始时间',
  `auto_df_etime` varchar(20) NOT NULL DEFAULT '' COMMENT '自动代付结束时间',
  `auto_df_max_count` int(11) NOT NULL DEFAULT '0' COMMENT '商户每天自动代付笔数限制',
  `auto_df_max_sum` int(11) NOT NULL DEFAULT '0' COMMENT '商户每天自动代付最大总金额限制',
  `tk_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IND_UID` (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_tikuanconfig
-- ----------------------------
INSERT INTO `pay_tikuanconfig` VALUES ('28', '1', '100.00', '100000.00', '1000.00', '10', '0', '0', '200.00', '1', '1', '0', '2', '5', '1', '0', '0', '2000.00', '1', '10000.00', '00:00', '23:59', '0', '0', '0');
INSERT INTO `pay_tikuanconfig` VALUES ('29', '2', '0.00', '0.00', '0.00', '0', '1', '0', '0.00', '1', '1', '0', '', '2', '0', '0', '0', '0.00', '0', '0.00', '', '', '0', '0', '0');

-- ----------------------------
-- Table structure for pay_tikuanholiday
-- ----------------------------
DROP TABLE IF EXISTS `pay_tikuanholiday`;
CREATE TABLE `pay_tikuanholiday` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排除日期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='排除节假日';

-- ----------------------------
-- Records of pay_tikuanholiday
-- ----------------------------
INSERT INTO `pay_tikuanholiday` VALUES ('5', '1503676800');
INSERT INTO `pay_tikuanholiday` VALUES ('6', '1503763200');
INSERT INTO `pay_tikuanholiday` VALUES ('8', '1504281600');
INSERT INTO `pay_tikuanholiday` VALUES ('9', '1504368000');

-- ----------------------------
-- Table structure for pay_tikuanmoney
-- ----------------------------
DROP TABLE IF EXISTS `pay_tikuanmoney`;
CREATE TABLE `pay_tikuanmoney` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL DEFAULT '0' COMMENT '结算用户ID',
  `websiteid` int(11) NOT NULL DEFAULT '0',
  `payapiid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '结算通道ID',
  `t` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '结算方式: 1 T+1 ,0 T+0',
  `money` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `datetype` varchar(2) NOT NULL,
  `createtime` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=691 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_tikuanmoney
-- ----------------------------

-- ----------------------------
-- Table structure for pay_tikuantime
-- ----------------------------
DROP TABLE IF EXISTS `pay_tikuantime`;
CREATE TABLE `pay_tikuantime` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `baiks` tinyint(2) unsigned DEFAULT '0' COMMENT '白天提款开始时间',
  `baijs` tinyint(2) unsigned DEFAULT '0' COMMENT '白天提款结束时间',
  `wanks` tinyint(2) unsigned DEFAULT '0' COMMENT '晚间提款开始时间',
  `wanjs` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='提款时间';

-- ----------------------------
-- Records of pay_tikuantime
-- ----------------------------
INSERT INTO `pay_tikuantime` VALUES ('1', '24', '17', '18', '24');

-- ----------------------------
-- Table structure for pay_tklist
-- ----------------------------
DROP TABLE IF EXISTS `pay_tklist`;
CREATE TABLE `pay_tklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `bankname` varchar(300) NOT NULL,
  `bankzhiname` varchar(300) NOT NULL,
  `banknumber` varchar(300) NOT NULL,
  `bankfullname` varchar(300) NOT NULL,
  `sheng` varchar(300) NOT NULL,
  `shi` varchar(300) NOT NULL,
  `sqdatetime` datetime DEFAULT NULL,
  `cldatetime` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `tkmoney` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `sxfmoney` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000',
  `money` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000',
  `t` int(4) NOT NULL DEFAULT '1',
  `payapiid` int(11) NOT NULL DEFAULT '0',
  `memo` text COMMENT '备注',
  `tk_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_tklist
-- ----------------------------

-- ----------------------------
-- Table structure for pay_updatelog
-- ----------------------------
DROP TABLE IF EXISTS `pay_updatelog`;
CREATE TABLE `pay_updatelog` (
  `version` varchar(20) NOT NULL,
  `lastupdate` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_updatelog
-- ----------------------------

-- ----------------------------
-- Table structure for pay_userrate
-- ----------------------------
DROP TABLE IF EXISTS `pay_userrate`;
CREATE TABLE `pay_userrate` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `payapiid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '通道ID',
  `feilv` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '运营费率',
  `fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '封顶费率',
  `t0feilv` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0运营费率',
  `t0fengding` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT 'T0封顶费率',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='商户通道费率';

-- ----------------------------
-- Records of pay_userrate
-- ----------------------------

-- ----------------------------
-- Table structure for pay_user_channel_account
-- ----------------------------
DROP TABLE IF EXISTS `pay_user_channel_account`;
CREATE TABLE `pay_user_channel_account` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `account_ids` varchar(255) NOT NULL DEFAULT '' COMMENT '子账号id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否开启指定账号',
  PRIMARY KEY (`id`),
  KEY `userid` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户指定指账号';

-- ----------------------------
-- Records of pay_user_channel_account
-- ----------------------------

-- ----------------------------
-- Table structure for pay_user_code
-- ----------------------------
DROP TABLE IF EXISTS `pay_user_code`;
CREATE TABLE `pay_user_code` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT '0' COMMENT '0找回密码',
  `code` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `status` int(11) DEFAULT '0',
  `ctime` int(11) DEFAULT NULL,
  `uptime` int(11) DEFAULT NULL COMMENT '更新时间',
  `endtime` int(11) DEFAULT NULL COMMENT '有效时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_user_code
-- ----------------------------

-- ----------------------------
-- Table structure for pay_user_log
-- ----------------------------
DROP TABLE IF EXISTS `pay_user_log`;
CREATE TABLE `pay_user_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `node` char(200) NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作人用户ID',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT '用户名',
  `action` varchar(200) NOT NULL DEFAULT '' COMMENT '操作行为',
  `type` tinyint(3) NOT NULL DEFAULT '0' COMMENT '操作类型 1：查看 2：新增 3：修改 4：删除 5：导出',
  `content` text NOT NULL COMMENT '操作内容描述',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户操作日志表';

-- ----------------------------
-- Records of pay_user_log
-- ----------------------------

-- ----------------------------
-- Table structure for pay_user_riskcontrol_config
-- ----------------------------
DROP TABLE IF EXISTS `pay_user_riskcontrol_config`;
CREATE TABLE `pay_user_riskcontrol_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `min_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最小金额',
  `max_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单笔最大金额',
  `unit_all_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '单位时间内交易总金额',
  `all_money` decimal(11,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '当天交易总金额',
  `start_time` tinyint(10) unsigned NOT NULL DEFAULT '0' COMMENT '一天交易开始时间',
  `end_time` tinyint(10) unsigned NOT NULL DEFAULT '0' COMMENT '一天交易结束时间',
  `unit_number` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间内交易的总笔数',
  `is_system` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否平台规则',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态:1开通，0关闭',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edit_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `time_unit` char(1) NOT NULL DEFAULT 'i' COMMENT '限制的时间单位',
  `unit_interval` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间值',
  `domain` varchar(255) NOT NULL DEFAULT ' ' COMMENT '防封域名',
  `systemxz` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0 系统规则 1 用户规则',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='交易配置';

-- ----------------------------
-- Records of pay_user_riskcontrol_config
-- ----------------------------
INSERT INTO `pay_user_riskcontrol_config` VALUES ('1', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '1', '0', '1522289886', '0', 'i', '0', '', '0');

-- ----------------------------
-- Table structure for pay_version
-- ----------------------------
DROP TABLE IF EXISTS `pay_version`;
CREATE TABLE `pay_version` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(255) NOT NULL DEFAULT '0' COMMENT '版本',
  `author` varchar(255) NOT NULL DEFAULT ' ' COMMENT '作者',
  `save_time` varchar(255) NOT NULL DEFAULT '0000-00-00' COMMENT '修改时间,格式YYYY-mm-dd',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='数据库版本表';

-- ----------------------------
-- Records of pay_version
-- ----------------------------
INSERT INTO `pay_version` VALUES ('1', '5.5', '陈嘉杰', '2018-4-8');
INSERT INTO `pay_version` VALUES ('2', '5.6', ' mapeijian', '2018/4/17 17:45:33');
INSERT INTO `pay_version` VALUES ('3', '5.7', ' mio', '2018-4-17');

-- ----------------------------
-- Table structure for pay_websiteconfig
-- ----------------------------
DROP TABLE IF EXISTS `pay_websiteconfig`;
CREATE TABLE `pay_websiteconfig` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `websitename` varchar(300) DEFAULT NULL COMMENT '网站名称',
  `domain` varchar(300) DEFAULT NULL COMMENT '网址',
  `email` varchar(100) DEFAULT NULL,
  `tel` varchar(30) DEFAULT NULL,
  `qq` varchar(30) DEFAULT NULL,
  `directory` varchar(100) DEFAULT NULL COMMENT '后台目录名称',
  `icp` varchar(100) DEFAULT NULL,
  `tongji` varchar(1000) DEFAULT NULL COMMENT '统计',
  `login` varchar(100) DEFAULT NULL COMMENT '登录地址',
  `payingservice` tinyint(1) unsigned DEFAULT '0' COMMENT '商户代付 1 开启 0 关闭',
  `authorized` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商户认证 1 开启 0 关闭',
  `invitecode` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '邀请码注册',
  `company` varchar(200) DEFAULT NULL COMMENT '公司名称',
  `serverkey` varchar(50) DEFAULT NULL COMMENT '授权服务key',
  `withdraw` tinyint(1) DEFAULT '0' COMMENT '提现通知：0关闭，1开启',
  `login_warning_num` tinyint(3) unsigned NOT NULL DEFAULT '3' COMMENT '前台可以错误登录次数',
  `login_ip` varchar(1000) NOT NULL DEFAULT ' ' COMMENT '登录IP',
  `is_repeat_order` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否允许重复订单:1是，0否',
  `google_auth` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启谷歌身份验证登录',
  `df_api` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启代付API',
  `logo` varchar(255) NOT NULL DEFAULT ' ' COMMENT '公司logo',
  `random_mchno` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否开启随机商户号',
  `register_need_activate` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户注册是否需激活',
  `admin_alone_login` tinyint(1) NOT NULL DEFAULT '0' COMMENT '管理员是否只允许同时一次登录',
  `max_auth_error_times` int(10) NOT NULL DEFAULT '5' COMMENT '验证错误最大次数',
  `auth_error_ban_time` int(10) NOT NULL DEFAULT '10' COMMENT '验证错误超限冻结时间（分钟）',
  `document_url` varchar(255) NOT NULL DEFAULT '' COMMENT '对接文档链接',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_websiteconfig
-- ----------------------------
INSERT INTO `pay_websiteconfig` VALUES ('1', 'api支付系统', 'www.zuyapi.loc', 'support@pay.com', '4001234456', '', 'manage', '沪ICP备12031756号', '', 'pay9', '1', '1', '1', '', '0d6de302cbc615de3b09463acea87662', '0', '3', ' ', '1', '0', '1', ' ', '0', '1', '0', '5', '10', '');

-- ----------------------------
-- Table structure for pay_wttklist
-- ----------------------------
DROP TABLE IF EXISTS `pay_wttklist`;
CREATE TABLE `pay_wttklist` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `bankname` varchar(300) NOT NULL,
  `bankzhiname` varchar(300) NOT NULL,
  `banknumber` varchar(300) NOT NULL,
  `bankfullname` varchar(300) NOT NULL,
  `sheng` varchar(300) NOT NULL,
  `shi` varchar(300) NOT NULL,
  `sqdatetime` datetime DEFAULT NULL,
  `cldatetime` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `tkmoney` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `sxfmoney` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '手续费',
  `money` decimal(15,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '实际到账',
  `t` int(4) NOT NULL DEFAULT '1',
  `payapiid` int(11) NOT NULL DEFAULT '0',
  `memo` text COMMENT '备注',
  `additional` varchar(1000) NOT NULL DEFAULT ' ' COMMENT '额外的参数',
  `code` varchar(64) NOT NULL DEFAULT ' ' COMMENT '代码控制器名称',
  `df_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '代付通道id',
  `df_name` varchar(64) NOT NULL DEFAULT ' ' COMMENT '代付名称',
  `orderid` varchar(100) NOT NULL DEFAULT ' ' COMMENT '订单id',
  `cost` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '成本',
  `cost_rate` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '成本费率',
  `rate_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '费率类型：按单笔收费0，按比例收费：1',
  `extends` text COMMENT '扩展数据',
  `out_trade_no` varchar(30) DEFAULT '' COMMENT '下游订单号',
  `df_api_id` int(11) DEFAULT '0' COMMENT '代付API申请ID',
  `auto_submit_try` int(10) NOT NULL DEFAULT '0' COMMENT '自动代付尝试提交次数',
  `is_auto` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否自动提交',
  `last_submit_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后提交时间',
  `df_lock` tinyint(1) NOT NULL DEFAULT '0' COMMENT '代付锁，防止重复提交',
  `lock_time` int(11) NOT NULL DEFAULT '0' COMMENT '锁定时间',
  `auto_query_num` int(10) NOT NULL DEFAULT '0' COMMENT '自动查询次数',
  `channel_mch_id` varchar(50) NOT NULL DEFAULT '' COMMENT '通道商户号',
  `df_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '代付API扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  `transaction_id` varchar(50) NOT NULL DEFAULT '' COMMENT '上游订单号',
  `billno` varchar(50) NOT NULL DEFAULT '' COMMENT '上游交易流水号',
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `df_id` (`df_id`),
  KEY `orderid` (`orderid`),
  KEY `df_api_id` (`df_api_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_wttklist
-- ----------------------------
