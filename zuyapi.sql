/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : zuyapi

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001
git pull fix

Date: 2018-09-15 22:34:37
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_admin
-- ----------------------------
INSERT INTO `pay_admin` VALUES ('1', 'adminroot', '81b5234976a55e5181f24d9eab8fb697', '1', '0', 'EM2XLGBKTN3OMPIJ', '15815295199', 'v4Qj9ZzLh1I2Thf5y774UKE4xk6kychY');
INSERT INTO `pay_admin` VALUES ('2', 'test', '7aa5e695be95cdd64a88410a64dfe2c1', '2', '1528767314', '', '', '');

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
INSERT INTO `pay_article` VALUES ('15', '1', '2', 'test2', '<p><span><img src=\"x\" alt=\"x\" /></span></p>', '1527004800', '1111', '1', '1532574452');

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
  `auth_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：商户登录 1：后台登录 2：商户短信验证 3：后台短信验证 4：商户谷歌令牌验证 5：后台谷歌令牌验证 6：支付密码验证 ',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_auth_error_log
-- ----------------------------
INSERT INTO `pay_auth_error_log` VALUES ('1', '0', '180586948', '1535537421');
INSERT INTO `pay_auth_error_log` VALUES ('2', '0', '180586949', '1535538786');

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
INSERT INTO `pay_auth_group` VALUES ('1', '超级管理员', '1', '0', '1,2,3,51,4,57,5,55,56,58,59,6,44,52,53,48,70,54,126,7,8,60,61,62,9,63,64,65,66,10,67,68,69,11,131,12,79,80,81,82,83,84,85,86,87,88,89,90,91,93,94,95,96,97,98,99,100,101,120,13,14,15,92,16,73,76,77,78,121,46,17,132,18,19,71,75,20,72,74,22,127,24,25,26,130,125,27,28,108,29,102,30,103,106,107,119,21,104,105,109,110,111,128,31,32,33,34,35,36,37,38,133,116,122,42,23,114,115');
INSERT INTO `pay_auth_group` VALUES ('2', '运营管理员', '1', '0', '1,49,3,4,5,6,43,44,7,12,13,14,15,18,19,22,23,24,46,33,34,35,36,37,38,39,40,41,42,45,47,50,51,52,54,55');
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
INSERT INTO `pay_auth_group_access` VALUES ('2', '1');
INSERT INTO `pay_auth_group_access` VALUES ('2', '2');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_auto_df_log
-- ----------------------------
INSERT INTO `pay_auto_df_log` VALUES ('1', '58', '1', '3', '错误：缺少银行编码', '1535766467');
INSERT INTO `pay_auto_df_log` VALUES ('2', '59', '1', '3', '错误：缺少银行编码', '1535766467');
INSERT INTO `pay_auto_df_log` VALUES ('3', '60', '1', '3', '错误：缺少银行编码', '1535766467');
INSERT INTO `pay_auto_df_log` VALUES ('4', '61', '1', '3', '错误：缺少银行编码', '1535785895');

-- ----------------------------
-- Table structure for pay_auto_unfrozen_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_auto_unfrozen_order`;
CREATE TABLE `pay_auto_unfrozen_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `freeze_money` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '冻结金额',
  `unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '计划解冻时间',
  `real_unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '实际解冻时间',
  `is_pause` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否暂停解冻 0正常解冻 1暂停解冻',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '解冻状态 0未解冻 1已解冻',
  `create_at` int(11) NOT NULL COMMENT '记录创建时间',
  `update_at` int(11) NOT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_unfreezeing` (`status`,`is_pause`,`unfreeze_time`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='投诉保证金余额';

-- ----------------------------
-- Records of pay_auto_unfrozen_order
-- ----------------------------
INSERT INTO `pay_auto_unfrozen_order` VALUES ('1', '2', '1.0000', '1528422720', '1528428990', '0', '1', '1528422302', '1528428990');
INSERT INTO `pay_auto_unfrozen_order` VALUES ('2', '2', '1.0000', '1528646400', '1528525926', '1', '1', '1528524518', '1528524518');
INSERT INTO `pay_auto_unfrozen_order` VALUES ('3', '2', '2.0000', '1528527554', '1528527687', '0', '1', '1528527557', '1528527557');
INSERT INTO `pay_auto_unfrozen_order` VALUES ('4', '2', '1.0000', '1528700581', '1528527896', '0', '1', '1528527789', '1528527789');
INSERT INTO `pay_auto_unfrozen_order` VALUES ('5', '2', '2.0000', '0', '1528527918', '0', '1', '1528527908', '1528527908');
INSERT INTO `pay_auto_unfrozen_order` VALUES ('6', '2', '3.0000', '0', '1528528030', '0', '1', '1528528019', '1528528019');
INSERT INTO `pay_auto_unfrozen_order` VALUES ('7', '2', '11.0000', '1530288000', '0', '0', '0', '1528528180', '1528528180');

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
) ENGINE=MyISAM AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_bankcard
-- ----------------------------
INSERT INTO `pay_bankcard` VALUES ('44', '2', '中国工商银行', '广州石牌支行', '马培坚', '6212263602033031881', '0', '广东省', '0', '广州市', null, null, '工行卡', '0', '0');

-- ----------------------------
-- Table structure for pay_blockedlog
-- ----------------------------
DROP TABLE IF EXISTS `pay_blockedlog`;
CREATE TABLE `pay_blockedlog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(100) NOT NULL COMMENT '订单号',
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `amount` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '冻结金额',
  `thawtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '解冻时间',
  `pid` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '商户支付通道',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 1 解冻 0 冻结',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='资金冻结待解冻记录';

-- ----------------------------
-- Records of pay_blockedlog
-- ----------------------------
INSERT INTO `pay_blockedlog` VALUES ('1', '20180604140857575297', '2', '0.0100', '1528303931', '903', '1528258643', '0');
INSERT INTO `pay_blockedlog` VALUES ('2', '20180607131100524956', '2', '0.9900', '1528392869', '907', '1528354899', '0');
INSERT INTO `pay_blockedlog` VALUES ('3', '20180615191459515352', '2', '0.9920', '1529425054', '907', '1529391569', '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_browserecord
-- ----------------------------
INSERT INTO `pay_browserecord` VALUES ('32', '14', '2', '2018-09-14 10:49:42');

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
) ENGINE=MyISAM AUTO_INCREMENT=237 DEFAULT CHARSET=utf8 COMMENT='供应商列表';

-- ----------------------------
-- Records of pay_channel
-- ----------------------------
INSERT INTO `pay_channel` VALUES ('199', 'WxSm', '微信扫码支付', '', '', '', '', '', '', '', '0.0400', '0.0900', '0.0000', '1503846107', '', '1', '1', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0400', '0.0900', '0.0000');
INSERT INTO `pay_channel` VALUES ('200', 'WxGzh', '微信H5', '', '', 'wxf33668d58442ff6e', '', '', '', '', '0.0000', '0.0000', '0.0000', '1502378687', '', '1', '2', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('201', 'Aliscan', '支付宝扫码', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1503857975', '', '1', '3', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('202', 'Aliwap', '支付宝H5', '', '', '', '', '', '', '', '0.0020', '0.0000', '0.0000', '1503857966', '', '1', '4', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0030', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('203', 'QQSCAN', 'QQ扫码', '', '', '', '', '', '', '', '0.0050', '0.0000', '0.0000', '1503280494', '', '1', '8', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0050', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('207', 'ceishi', '测试支付', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1516441965', '', '1', '1', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('208', 'AliwapOld', '支付宝WAP（老版）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1527738054', '', '1', '4', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('209', 'LzfBank', '乐支付网银', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1527755052', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('210', 'CodepayAliSm', '码支付（支付宝扫码）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1528083079', '', '1', '3', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('211', 'UnionpayWgMobile', '银联网关支付', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1528340853', 'http://payvip.subangjinlong.com', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('212', 'Rzfwxscan', '睿支付微信扫码', '', '', '', '', '', '', '', '0.0050', '0.0080', '0.0030', '1529047760', '', '1', '1', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0050', '0.0080', '0.0031');
INSERT INTO `pay_channel` VALUES ('213', 'Htbank', '汇通网关支付', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1529048021', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('214', 'Rzfbank', '睿支付网银支付', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1529057456', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('215', 'Swzfbank', '思维支付网银支付', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1529477914', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('216', 'WftWxSm', '威富通微信扫码', '', '', '', '', 'https://pay.swiftpass.cn/pay/gateway', '', '', '0.0000', '0.0000', '0.0000', '1529480679', '', '1', '1', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('217', 'DlmQqSm', '多来米QQ扫码', '', '', '', '', 'http://spay.shengshizhuoge.com/pay', '', '', '0.0000', '0.0000', '0.0000', '1529493012', '', '1', '8', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0010', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('218', 'KxBank', '开心支付网银', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1529918594', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0001', '0.0001', '0.0001');
INSERT INTO `pay_channel` VALUES ('219', 'Rzfkj', '睿支付银联快捷', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1530671087', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('220', 'Gtzfkj', '国通支付快捷', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1531220556', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('221', 'MqyWxSm', '免签约微信', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1532342977', '', '1', '1', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('222', 'GmAliScan', '固码支付宝扫码', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1532690486', '', '1', '3', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('223', 'DyAliwap', '独依支付（支付宝H5）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1533209685', '', '1', '4', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('224', 'DyBank', '独依支付（网关支付）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1533277129', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('225', 'JytWxSm', '金银通（微信扫码）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1533628437', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('226', 'KmcBank', '凯美晨网关支付', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1534419104', 'http://pay.zuyapi.loc', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('227', 'HeyWxSm', 'Hey（微信扫码）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1534845615', '', '1', '1', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('228', 'TonglianWxSm', '通联（微信扫码）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1534851448', '', '1', '1', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('229', 'XbpBank', '星宝-网关支付', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1535112541', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('230', 'HeyYlSm', 'Hey（银联扫码）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1535115238', '', '1', '13', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('231', 'HaixiaWxSm', '海峡银行（微信扫码支付）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0030', '1537004570', '', '1', '1', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('232', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0030', '1537004508', '', '1', '3', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('233', 'ShouBeiBank', '收呗网银支付', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1535688660', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('234', 'SkmAliSm', '收款码（支付宝扫码）', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1535770436', '', '1', '3', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('235', 'Meizi50Bank', '捷易付网银支付', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1536901677', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_channel` VALUES ('236', 'BwmBank', 'BWMPAY网银支付', '', '', '', '', '', '', '', '0.0000', '0.0000', '0.0000', '1536919016', '', '1', '5', '0', '0', '0.00', '0.00', '0', '0.00', '0.00', '0', '1', '0.0000', '0.0000', '0.0000');

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
) ENGINE=MyISAM AUTO_INCREMENT=254 DEFAULT CHARSET=utf8 COMMENT='供应商账号列表';

-- ----------------------------
-- Records of pay_channel_account
-- ----------------------------
INSERT INTO `pay_channel_account` VALUES ('218', '199', '', '', '', '', '0.0400', '0.0900', '0.0000', '1513408073', '1', '微信扫码支付', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0400', '0.0900', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('219', '200', '', '', 'wxf33668d58442ff6e', '', '0.0000', '0.0000', '0.0000', '1513408073', '1', '微信H5', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('220', '201', '', '', '', '', '0.0000', '0.0000', '0.0000', '1513408073', '1', '支付宝扫码', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('221', '202', '', '', '', '', '0.0000', '0.0000', '0.0000', '1513408073', '1', '支付宝H5', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('222', '203', '', '', '', '', '0.0050', '0.0000', '0.0000', '1513408073', '1', 'QQ扫码', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0050', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('223', '207', '测试商户号', '测试证书密钥', '', '', '0.0000', '0.0000', '0.0000', '1516441979', '1', '测试名称', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('224', '208', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '', '0.0000', '0.0000', '0.0000', '1527738739', '1', '2088131085175285', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('225', '209', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '', '0.0000', '0.0000', '0.0000', '1527751621', '1', '10003', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('226', '210', '15575', 'm9VdgCnAZynwxK5sTTH2dXSyXmEAPBei', '', '', '0.0000', '0.0000', '0.0000', '1528082947', '1', '15575', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('227', '211', '827320557320008', '', '', '', '0.0000', '0.0000', '0.0000', '1528283218', '1', '827320557320008', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('228', '212', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '', '0.0060', '0.0080', '0.0030', '1529047649', '1', '100000057', '1', '1', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0061', '0.0080', '0.0030', '');
INSERT INTO `pay_channel_account` VALUES ('229', '213', '2', '893701E6A0C5EB903BFF6A12818ED9E0', '', 'test123456', '0.0000', '0.0000', '0.0000', '1529055304', '1', '测试账号', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('230', '214', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '', '0.0000', '0.0000', '0.0000', '1529057574', '1', '100000057', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('231', '215', '10887', 'c1c4f8ae34a86f217b7e791c6c06187e677bec75', '', '', '0.0000', '0.0000', '0.0000', '1529477953', '1', '10887', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('232', '216', '102545570975', '', '', '', '0.0000', '0.0000', '0.0000', '1529479891', '1', '102545570975', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('233', '217', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '', '0.0000', '0.0000', '0.0000', '1529663567', '1', 'B1000017', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('234', '218', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '', '0.0000', '0.0000', '0.0000', '1529918673', '1', '285670000001', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('235', '219', '100000047', 'WVdtZ1lFMW5UNjNiZEQ3VmVjRGUydz09', '', '', '0.0000', '0.0000', '0.0000', '1530671101', '1', '100000047', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('236', '200', '2222', '', '', '', '0.0000', '0.0000', '0.0000', '1530842081', '1', '2', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('237', '220', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '', '0.0000', '0.0000', '0.0000', '1531967710', '1', '152773671732458', '1', '0', '10', '23', '0', '0.00', '0.00', '0.00', '0.00', '1', '1', '1', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('238', '221', '10191', 'b0b6caec665e71c7b45a272fa1ec2a65', 'B1', '', '0.0000', '0.0000', '0.0000', '1532343777', '1', 'B1', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('239', '222', '', 'HTTPS://QR.ALIPAY.COM/FKX02713M2ZHLUHJL00ECC', '', '', '0.0000', '0.0000', '0.0000', '1532690823', '1', '固码1', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('240', '223', 'M000037', '', '', '', '0.0000', '0.0000', '0.0000', '1533209707', '1', 'M000037', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('241', '224', 'M000037', '', '', '', '0.0000', '0.0000', '0.0000', '1533277147', '1', 'M000037', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('242', '226', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '', '0.0000', '0.0000', '0.0000', '1534314402', '1', '88000074', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('243', '227', '80086000602', '5Udh82Zunuf6528i9ko5B76A3q448Spum14S404r03PSi131slH837V3xtgt', '', '', '0.0000', '0.0000', '0.0000', '1534845668', '1', '80086000602', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('244', '228', '990581007426001', 'allinpay888', '00000051', '', '0.0000', '0.0000', '0.0000', '1534851558', '1', '990581007426001', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('245', '229', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '', '0.0000', '0.0000', '0.0000', '1535112576', '1', '20000046', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('247', '230', '80086000602', '5Udh82Zunuf6528i9ko5B76A3q448Spum14S404r03PSi131slH837V3xtgt', '', '', '0.0000', '0.0000', '0.0000', '1535115123', '1', '80086000602', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('248', '231', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '', '0.0000', '0.0000', '0.0000', '1535447416', '1', '196', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('249', '232', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '', '0.0000', '0.0000', '0.0000', '1535448890', '1', '196', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('250', '233', 'apitest', '91dd20e362dc423cae5baa7a4ec8b996', '', '', '0.0000', '0.0000', '0.0000', '1535692231', '1', 'apitest', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('251', '234', '11201808311511025', '', '', '', '0.0000', '0.0000', '0.0000', '1535770454', '1', '11201808311511025', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('252', '235', '9a7315f3063344f68980437ac2bcb5bc', 'eb0edb60551a430c8a08651e2c59ba51', '', '', '0.0000', '0.0000', '0.0000', '1535801633', '1', 'BOSS88882018083110001352', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');
INSERT INTO `pay_channel_account` VALUES ('253', '236', '001027', '', '13067410260', 'MIICXgIBAAKBgQC/keosQW2TAFPyP5IqxQcjyNdgxzK5kQPcRmg0vrQslSiITiNRunqshKfLWfGM6Ae0aT4FCwAZHdt921dVBWaInFtf7H5ldAh8VrCCot5Diq6SPNCH7bq7z+fY2TKVd1AR3wH4LollgM0m8BXggU48/AFZbOIVvq+VZh/EmLOSDwIDAQABAoGBALqmgtEn1ok58pC/W70MR46YKzGCJGwlXOuMNg/eF1Kw6dMUvtjspoXcolhBhFZT5N3lBKaJN0lBjBAuXALcxi54xvl4Vbjp5ihbSdQuT9xebMC1j86a99o/IFyywe62KetVYpXGtTXKxwFDzmuI7WGLLwGQTEvtRb1R6FYrF53BAkEA5Zq/ln9w3H5MkFG4wKPOmZAQXG+CFXBvyloeAcMaKGB5mAOdfD0gzvfjROMS9w1jn6XtMzNc4ILRAFx0EpuL8QJBANWXz+1gYXUzf/XEAXEfRaYagnoB5KVjZblzGAJ1h5NxEXXmoatRbA53Ft4HFPACgUUBck5UhgJzci/4OAvW/f8CQQDTTXQOM+CQ+ybJFnxZxSbISj3UY8aqplwrNH4zDvOOvyKIFKOlh7ge4SDl77gvZsINVa2TFizebWWc2Hj1+vJxAkEAk6Q1mPrXQwFPQR20dXJNXYzTheyLFPuJFFCHVyPQjE1K6Xl7ZQWKMNGG4AB7K5A/tOhUD+sDGuycEKZ+b0i0FwJAJzEMV7AGp035dZ2AWNwmmpsltyoUj4sNzNc4Mx5VlPcw66LASZZ2ETQxwMZxKHQ8pLkOr+kyGKqlVZQPnBWttQ==', '0.0000', '0.0000', '0.0000', '1536919871', '1', '001027', '1', '0', '0', '0', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '0', 's', '0', '0.00', '0.0000', '0.0000', '0.0000', '');

-- ----------------------------
-- Table structure for pay_complaints_deposit
-- ----------------------------
DROP TABLE IF EXISTS `pay_complaints_deposit`;
CREATE TABLE `pay_complaints_deposit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `pay_orderid` varchar(100) NOT NULL DEFAULT '0' COMMENT '系统订单号',
  `out_trade_id` varchar(50) NOT NULL DEFAULT '' COMMENT '下游订单号',
  `freeze_money` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '冻结保证金额',
  `unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '计划解冻时间',
  `real_unfreeze_time` int(11) NOT NULL DEFAULT '0' COMMENT '实际解冻时间',
  `is_pause` tinyint(3) NOT NULL DEFAULT '0' COMMENT '是否暂停解冻 0正常解冻 1暂停解冻',
  `status` tinyint(3) NOT NULL DEFAULT '0' COMMENT '解冻状态 0未解冻 1已解冻',
  `create_at` int(11) NOT NULL COMMENT '记录创建时间',
  `update_at` int(11) NOT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_unfreezeing` (`status`,`is_pause`,`unfreeze_time`),
  KEY `pay_orderid` (`pay_orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='投诉保证金余额';

-- ----------------------------
-- Records of pay_complaints_deposit
-- ----------------------------
INSERT INTO `pay_complaints_deposit` VALUES ('1', '2', '20180602235108995456', 'C20180602235107427887', '2.4800', '1530546725', '0', '0', '0', '1527954725', '1527954725');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='投诉保证金规则表';

-- ----------------------------
-- Records of pay_complaints_deposit_rule
-- ----------------------------
INSERT INTO `pay_complaints_deposit_rule` VALUES ('1', '180586943', '1', '1.00', '0', '0');
INSERT INTO `pay_complaints_deposit_rule` VALUES ('2', '2', '0', '0.00', '0', '1');
INSERT INTO `pay_complaints_deposit_rule` VALUES ('3', '2', '0', '1.00', '3600', '1');

-- ----------------------------
-- Table structure for pay_df_api_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_df_api_order`;
CREATE TABLE `pay_df_api_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商户编号',
  `trade_no` varchar(30) NOT NULL DEFAULT '' COMMENT '平台订单号',
  `out_trade_no` varchar(30) NOT NULL DEFAULT '' COMMENT '商户订单号',
  `money` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '金额',
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
  KEY `IND_UID` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_df_api_order
-- ----------------------------
INSERT INTO `pay_df_api_order` VALUES ('1', '2', 'H0601236061696254', '19700101080000', '100.0000', '1111', '111', '111', '111', '11', '111', '127.0.0.1', '0', '{\"lhh\":\"11\"}', '0', '', '', '0', '1527823606', '0');
INSERT INTO `pay_df_api_order` VALUES ('2', '2', 'H0601239597206183', '201806011132391669', '100.0000', '3345', '23423', '423423', '4234', '2432423', '423423', '127.0.0.1', '0', '{\"lhh\":\"234\"}', '0', '', '', '0', '1527823959', '0');
INSERT INTO `pay_df_api_order` VALUES ('3', '2', 'H0601241112282145', '201806011135118476', '100.0000', '3345', '23423', '423423', '4234', '2432423', '423423', '127.0.0.1', '0', '{\"lhh\":\"234\"}', '0', '', '', '0', '1527824111', '0');
INSERT INTO `pay_df_api_order` VALUES ('4', '2', 'H0601292798767714', '201806011301195354', '100.0000', '112121', '12121', '2121', '212121', '2121', '212121', '127.0.0.1', '1', '{\"lhh\":\"121\"}', '36', '', '', '1527845294', '1527829279', '0');
INSERT INTO `pay_df_api_order` VALUES ('13', '2', 'H0601303800250710', '201806011310335771', '100.0000', '112121', '12121', '2121', '212121', '2121', '212121', '127.0.0.1', '1', '{\"lhh\":\"121\"}', '0', '', '', '0', '1527830380', '0');
INSERT INTO `pay_df_api_order` VALUES ('22', '2', 'H0601308399422032', '201806011322112911', '100.0000', '112121', '12121', '2121', '212121', '2121', '212121', '127.0.0.1', '1', '{\"lhh\":\"121\"}', '33', '', '', '1527830840', '1527830839', '0');
INSERT INTO `pay_df_api_order` VALUES ('23', '2', 'H0601450678097402', '201806011724274583', '100.0000', '234234', '23423', '234234234', '23423', '234', '43223', '127.0.0.1', '2', '{\"lhh\":\"4234\"}', '34', '', '', '1528690002', '1527845067', '0');
INSERT INTO `pay_df_api_order` VALUES ('24', '2', 'H0601452019801950', '201806011726412997', '100.0000', '中国工商银行', '广州石牌支行', '马培坚', '23423', '234', '43223', '127.0.0.1', '2', '{\"lhh\":\"4234\"}', '35', '', '', '1528690002', '1527845201', '0');
INSERT INTO `pay_df_api_order` VALUES ('25', '2', 'H0619055370206327', '201806191852168827', '100.0000', '1', '1', '1', '1', '1', '1', '127.0.0.1', '1', '{\"lhh\":\"1\"}', '42', '', '', '1529405537', '1529405537', '1');
INSERT INTO `pay_df_api_order` VALUES ('26', '2', 'H0619060458819310', '201806191900451071', '100.0000', '1', '1', '1', '1', '1', '1', '127.0.0.1', '1', '{\"lhh\":\"1\"}', '43', '', '', '1529406045', '1529406045', '1');
INSERT INTO `pay_df_api_order` VALUES ('27', '2', 'H0619063721056252', '201806191906119790', '100.0000', '1', '1', '1', '1', '1', '1', '127.0.0.1', '1', '{\"lhh\":\"1\"}', '44', '', '', '1529406372', '1529406372', '1');
INSERT INTO `pay_df_api_order` VALUES ('28', '2', 'H0619064979453326', '201806191908175000', '100.0000', '1', '1', '1', '1', '1', '1', '127.0.0.1', '1', '{\"lhh\":\"1\"}', '45', '', '', '1529406498', '1529406497', '1');
INSERT INTO `pay_df_api_order` VALUES ('29', '2', 'H0619066034867955', '201806191910039650', '100.0000', '1', '1', '1', '1', '1', '1', '127.0.0.1', '1', '{\"lhh\":\"1\"}', '0', '', '', '0', '1529406603', '0');
INSERT INTO `pay_df_api_order` VALUES ('30', '2', 'H0619066514687530', '201806191910513356', '100.0000', '1', '1', '1', '1', '1', '1', '127.0.0.1', '1', '{\"lhh\":\"1\"}', '0', '', '', '0', '1529406651', '0');
INSERT INTO `pay_df_api_order` VALUES ('31', '2', 'H0619066931441930', '201806191911328822', '100.0000', '1', '1', '1', '1', '1', '1', '127.0.0.1', '1', '{\"lhh\":\"1\"}', '0', '', '', '0', '1529406693', '0');
INSERT INTO `pay_df_api_order` VALUES ('32', '2', 'H0619067356265560', '201806191912154786', '100.0000', '1', '1', '1', '1', '1', '1', '127.0.0.1', '1', '{\"lhh\":\"1\"}', '46', '', '', '1529406735', '1529406735', '0');
INSERT INTO `pay_df_api_order` VALUES ('33', '2', 'H0619068120014398', '201806191913317717', '100.0000', '1', '1', '1', '1', '1', '1', '127.0.0.1', '2', '{\"lhh\":\"1\"}', '47', '', '11', '1531971231', '1529406812', '0');
INSERT INTO `pay_df_api_order` VALUES ('34', '2', 'H0629389741607243', '201806291022534278', '100.0000', '234234', '2342', '234234', '23423', '23423', '234', '127.0.0.1', '1', '{\"lhh\":\"423\"}', '49', '', '', '1530238974', '1530238974', '1');
INSERT INTO `pay_df_api_order` VALUES ('35', '2', 'H0629390921544940', '201806291024517591', '100.0000', '234234', '2342', '234234', '23423', '23423', '234', '127.0.0.1', '1', '{\"lhh\":\"423\"}', '50', '', '', '1530239115', '1530239092', '1');
INSERT INTO `pay_df_api_order` VALUES ('36', '2', 'H0629396631040448', '201806291034223932', '100.0000', '234234', '2342', '234234', '23423', '23423', '234', '127.0.0.1', '1', '{\"lhh\":\"423\"}', '51', '', '', '1530239697', '1530239663', '1');
INSERT INTO `pay_df_api_order` VALUES ('37', '2', 'H0830205701924917', '201808301650116602', '100.0000', '中国工商银行', '广州石牌支行', '马培坚', '111', '11', '1', '127.0.0.1', '0', '{\"bankAgentId\":\"\"}', '0', '', '', '0', '1535620570', '0');
INSERT INTO `pay_df_api_order` VALUES ('38', '2', 'H0830235211535734', '201808301805201288', '100.0000', '中国工商银行', '广州石牌支行', '马培坚', '1111', '11', '11', '127.0.0.1', '0', '{\"bankAgentId\":\"\"}', '0', '', '', '0', '1535623521', '0');
INSERT INTO `pay_df_api_order` VALUES ('39', '2', 'H0830243089835820', '201808301806118047', '100.0000', '中国工商银行', '广州石牌支行', '马培坚', '1111', '11', '11', '127.0.0.1', '0', '{\"bankAgentId\":\"\"}', '0', '', '', '0', '1535624308', '0');

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
INSERT INTO `pay_email` VALUES ('1', 'smtp.qq.com', '465', '551882927@qq.com', 'dhqhethawiehbbaa', '551882927@qq.com', '知宇聚合API支付系统');

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
) ENGINE=MyISAM AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_invitecode
-- ----------------------------
INSERT INTO `pay_invitecode` VALUES ('12', '97xThB1Cz4OoV7y9OrdKW7HbmMDdeC', '1', '17', '4', '1491146221', '1491148800', '1491146782', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('13', 'XSR1xQqTuBAOflNTaGVJsShJe9ihpj', '1', '18', '4', '1491147225', '1491148800', '1491147268', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('5', 'Icrt3mdyaiwKtR9sEqqL9a43jU4qHI', '1', '7', '4', '1491064074', '1491148800', '1491069586', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('6', 'f2yOFZJcqjxzVYBITX1WKEVQbYycM5', '1', '8', '4', '1491069805', '1491148800', '1491069829', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('7', 'kqkPFdRhF4mHxbuGKnTrTUBOhh8BUR', '1', '9', '4', '1491100066', '1491148800', '1491100145', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('14', '8dCbyzAO1GasJ5Ycqtc4apoLIszGVs', '1', '19', '4', '1491149144', '1491235200', '1491149186', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('61', '9ucguw5j42hmpp9alrw83obs6ew070', '1', '0', '4', '1503653302', '1503739701', '0', '1', '1');
INSERT INTO `pay_invitecode` VALUES ('60', '6fbm325wa702pywe6d0voou70t5lz4', '1', '0', '4', '1503653299', '1503739698', '0', '1', '1');
INSERT INTO `pay_invitecode` VALUES ('28', 'GJhipszCqCRrFQTH5vQvOB3GZnBBb7', '19', '20', '4', '1491235513', '1491321600', '1491235668', '2', '0');
INSERT INTO `pay_invitecode` VALUES ('29', 'gElczzSWWpznTeXFPdyDbxgPNCvZb8', '1', '21', '4', '1491317272', '1491321600', '1491317286', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('30', 'um7KnpqaAapwrMjjqg4R5qh88zvLjZ', '1', '22', '4', '1491319745', '1491321600', '1491319789', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('31', 'ALP9duzS6BpSJgzRevRPY2iqFSxi4v', '1', '23', '4', '1491320343', '1491321600', '1491320387', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('32', 'k7IuU11htdy9AVSNZZFOzRIlSqUVkz', '1', '24', '4', '1491539877', '1491580800', '1491540040', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('33', 'SYMhPSCV2wLORE6ZrClUigccU6LsTp', '24', '25', '4', '1492017189', '1492099200', '1492017227', '2', '0');
INSERT INTO `pay_invitecode` VALUES ('58', 'y93ctdv8p27pq39788fjt6z78724iv', '1', '37', '4', '1503652737', '1503739136', '1503653097', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('43', '1swx1xq9b34kickbmwn3lfbowe1hj5', '1', '26', '4', '1499962964', '1500048000', '1499963193', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('44', 'nolpvni01tv174cupsn24lacuosge9', '1', '27', '4', '1500630828', '1500652800', '1500630876', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('59', '5pzj0lpb9o8nsf557f9ryl83dcgx42', '1', '0', '4', '1503653296', '1503739695', '0', '1', '1');
INSERT INTO `pay_invitecode` VALUES ('57', '6jym8c5eozmjahiky10jt6upb5l0px', '1', '38', '4', '1503652613', '1503739012', '1503653199', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('62', '9q2vrirdz3rym272vs8n5dfnv8m0qa', '1', '39', '4', '1503716035', '1503802434', '1503716302', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('63', 'd4tzgycfnpyktlenpbp7xk4tv22tyq', '1', '2', '4', '1503828843', '1503915242', '1503828960', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('64', 'vcpnps', '1', '3', '7', '1516440243', '1516526633', '1516440798', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('65', '6on1r7', '3', '4', '6', '1516440851', '1516527245', '1516440891', '2', '0');
INSERT INTO `pay_invitecode` VALUES ('66', 'kmrvm8', '4', '5', '5', '1516440924', '1516527320', '1516440963', '2', '0');
INSERT INTO `pay_invitecode` VALUES ('67', 'ht9qun', '5', '6', '4', '1516440996', '1516527392', '1516441030', '2', '0');
INSERT INTO `pay_invitecode` VALUES ('68', 'ryaern', '1', '180583931', '4', '1527695528', '1527781927', '1527695537', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('69', '6qy46f', '1', '180586944', '4', '1528105378', '1528191776', '1528105388', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('70', 'shlgjj', '1', '180586945', '4', '1528107817', '1528194215', '1528107823', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('71', 'rh8tfe', '1', '180586946', '4', '1528107908', '1528194307', '1528107925', '2', '1');
INSERT INTO `pay_invitecode` VALUES ('72', 'i11z1e', '2', '0', '4', '1528767366', '1528853765', '0', '1', '1');

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
-- Table structure for pay_ips_accpay
-- ----------------------------
DROP TABLE IF EXISTS `pay_ips_accpay`;
CREATE TABLE `pay_ips_accpay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(30) NOT NULL DEFAULT '' COMMENT '订单号',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `amount` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0未支付 1已支付',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_ips_accpay
-- ----------------------------

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
) ENGINE=MyISAM AUTO_INCREMENT=294 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_loginrecord
-- ----------------------------
INSERT INTO `pay_loginrecord` VALUES ('71', '1', '2017-12-16 15:08:11', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('72', '1', '2018-01-06 09:43:15', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('73', '1', '2018-01-06 11:22:34', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('74', '1', '2018-01-08 11:34:23', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('75', '1', '2018-01-08 15:02:05', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('76', '1', '2018-01-18 19:12:32', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('77', '1', '2018-01-20 17:23:29', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('78', '1', '2018-01-20 17:26:02', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('79', '1', '2018-01-26 14:25:00', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('80', '1', '2018-02-26 18:13:31', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('81', '1', '2018-02-27 14:25:08', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('82', '1', '2018-03-01 10:27:54', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('83', '1', '2018-03-03 10:17:30', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('84', '1', '2018-04-24 11:24:37', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('85', '1', '2018-05-30 09:39:28', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('86', '1', '2018-05-31 09:19:31', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('87', '1', '2018-05-31 11:38:56', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('88', '1', '2018-06-01 09:23:47', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('89', '1', '2018-06-01 18:06:44', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('90', '1', '2018-06-01 18:31:30', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('91', '2', '2018-06-01 18:33:23', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('92', '2', '2018-06-01 18:34:58', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('93', '1', '2018-06-04 09:25:34', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('94', '1', '2018-06-05 19:00:55', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('95', '1', '2018-06-06 09:32:58', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('96', '1', '2018-06-07 10:03:08', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('97', '1', '2018-06-08 09:35:45', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('98', '1', '2018-06-09 09:16:50', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('99', '3', '2018-06-09 16:02:26', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('100', '3', '2018-06-09 16:03:45', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('101', '3', '2018-06-09 16:04:09', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('102', '3', '2018-06-09 16:04:24', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('103', '3', '2018-06-09 16:05:39', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('104', '1', '2018-06-11 09:26:41', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('105', '180586947', '2018-06-11 14:23:33', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('106', '1', '2018-06-12 09:18:43', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('107', '2', '2018-06-12 09:35:29', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('108', '1', '2018-06-12 14:43:24', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('109', '1', '2018-06-13 09:38:27', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('110', '1', '2018-06-13 14:05:44', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('111', '2', '2018-06-13 19:08:38', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('112', '1', '2018-06-13 19:13:32', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('113', '2', '2018-06-13 19:14:45', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('114', '1', '2018-06-13 19:16:12', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('115', '1', '2018-06-13 19:23:47', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('116', '1', '2018-06-15 09:20:09', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('117', '1', '2018-06-19 09:35:00', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('118', '1', '2018-06-20 09:10:29', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('119', '1', '2018-06-21 09:24:27', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('120', '1', '2018-06-22 10:43:16', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('121', '1', '2018-06-25 09:28:31', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('122', '1', '2018-06-26 10:59:55', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('123', '1', '2018-06-27 17:34:47', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('124', '1', '2018-06-28 10:05:58', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('125', '1', '2018-06-29 09:22:00', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('126', '2', '2018-06-29 09:43:49', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('127', '1', '2018-06-29 10:15:05', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('128', '1', '2018-06-30 09:13:10', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('129', '2', '2018-07-02 15:55:35', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('130', '2', '2018-07-02 15:56:32', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('131', '1', '2018-07-02 16:47:23', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('132', '1', '2018-07-03 09:53:32', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('133', '1', '2018-07-04 10:24:12', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('134', '1', '2018-07-05 09:27:38', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('135', '1', '2018-07-06 09:34:26', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('136', '1', '2018-07-10 09:20:15', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('137', '1', '2018-07-11 09:48:22', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('138', '1', '2018-07-11 20:01:21', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('139', '1', '2018-07-12 09:29:14', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('140', '2', '2018-07-12 15:20:29', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('141', '2', '2018-07-12 15:25:04', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('142', '1', '2018-07-12 15:27:33', '127.0.0.1', '本机地址-', '1');
INSERT INTO `pay_loginrecord` VALUES ('192', '1', '2018-07-12 19:31:02', '61.242.114.180', '广东省江门市', '1');
INSERT INTO `pay_loginrecord` VALUES ('193', '1', '2018-07-12 19:35:31', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('194', '1', '2018-07-13 09:47:48', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('195', '1', '2018-07-14 17:08:35', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('196', '1', '2018-07-16 09:19:16', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('147', '1', '2018-07-12 18:30:50', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('148', '1', '2018-07-12 18:34:20', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('149', '1', '2018-07-12 18:34:48', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('150', '1', '2018-07-12 18:38:42', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('151', '1', '2018-07-12 18:39:38', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('152', '1', '2018-07-12 18:43:24', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('153', '1', '2018-07-12 18:44:19', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('154', '1', '2018-07-12 18:45:00', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('155', '1', '2018-07-12 18:46:29', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('156', '1', '2018-07-12 18:47:10', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('157', '1', '2018-07-12 18:47:43', '47.75.176.101', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('197', '1', '2018-07-17 11:02:07', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('198', '1', '2018-07-18 12:10:28', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('199', '1', '2018-07-19 09:37:06', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('200', '1', '2018-07-20 09:09:58', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('162', '1', '2018-07-12 18:52:19', '47.106.144.106', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('163', '1', '2018-07-12 18:53:02', '47.106.144.106', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('164', '1', '2018-07-12 18:54:27', '47.106.144.106', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('165', '1', '2018-07-12 18:55:38', '47.106.144.106', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('166', '1', '2018-07-12 18:56:16', '47.106.144.106', '加拿大-', '1');
INSERT INTO `pay_loginrecord` VALUES ('201', '1', '2018-07-23 18:49:02', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('202', '1', '2018-07-24 18:29:36', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('203', '1', '2018-07-26 10:04:47', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('204', '1', '2018-07-26 11:34:53', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('205', '1', '2018-07-27 11:40:14', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('206', '1', '2018-07-27 19:20:21', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('207', '1', '2018-07-27 19:56:05', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('208', '1', '2018-07-28 12:09:54', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('209', '1', '2018-07-28 15:26:34', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('210', '1', '2018-07-28 17:19:45', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('211', '1', '2018-07-30 09:23:02', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('212', '1', '2018-07-31 18:37:53', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('213', '1', '2018-08-01 09:43:53', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('214', '1', '2018-08-02 14:09:14', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('215', '1', '2018-08-03 10:04:36', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('216', '1', '2018-08-04 09:31:21', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('217', '1', '2018-08-06 09:14:17', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('218', '1', '2018-08-07 15:53:27', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('219', '1', '2018-08-13 14:10:01', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('220', '1', '2018-08-14 09:34:17', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('221', '1', '2018-08-15 14:23:10', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('222', '1', '2018-08-16 09:19:07', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('223', '1', '2018-08-17 13:22:25', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('224', '1', '2018-08-18 11:37:03', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('225', '1', '2018-08-20 17:12:42', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('226', '1', '2018-08-21 14:44:56', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('227', '1', '2018-08-22 09:46:41', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('228', '1', '2018-08-23 10:58:06', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('229', '1', '2018-08-24 11:08:41', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('230', '1', '2018-08-27 09:36:49', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('231', '1', '2018-08-28 16:46:53', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('232', '1', '2018-08-29 09:25:04', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('233', '180586949', '2018-08-29 18:31:53', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('234', '180586949', '2018-08-29 18:32:43', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('235', '1', '2018-08-30 09:32:24', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('236', '1', '2018-08-31 09:27:31', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('237', '2', '2018-08-31 19:17:58', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('238', '2', '2018-08-31 19:19:50', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('239', '2', '2018-08-31 19:21:46', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('240', '1', '2018-09-01 09:22:26', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('241', '1', '2018-09-03 16:35:00', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('242', '1', '2018-09-04 11:09:24', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('243', '1', '2018-09-04 11:28:19', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('244', '1', '2018-09-04 11:40:15', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('245', '1', '2018-09-04 11:40:40', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('246', '1', '2018-09-05 09:16:13', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('247', '1', '2018-09-06 09:21:11', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('248', '1', '2018-09-07 09:55:29', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('249', '1', '2018-09-10 14:44:24', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('250', '2', '2018-09-10 16:05:29', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('251', '2', '2018-09-10 16:19:37', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('252', '1', '2018-09-10 18:23:56', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('253', '1', '2018-09-10 18:26:54', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('254', '1', '2018-09-10 18:28:42', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('255', '1', '2018-09-11 09:14:29', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('256', '1', '2018-09-12 09:37:00', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('257', '1', '2018-09-12 15:11:21', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('258', '1', '2018-09-12 15:29:51', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('259', '1', '2018-09-12 15:36:26', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('260', '2', '2018-09-12 18:08:21', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('261', '2', '2018-09-12 18:09:08', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('262', '2', '2018-09-12 18:21:48', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('263', '2', '2018-09-12 18:22:23', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('264', '2', '2018-09-12 18:24:03', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('265', '2', '2018-09-12 18:26:39', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('266', '1', '2018-09-12 18:29:44', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('267', '2', '2018-09-12 19:23:21', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('268', '1', '2018-09-12 19:48:15', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('269', '1', '2018-09-13 09:23:16', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('270', '1', '2018-09-13 09:52:53', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('271', '2', '2018-09-13 10:16:54', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('272', '2', '2018-09-13 10:24:07', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('273', '1', '2018-09-13 10:39:02', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('274', '1', '2018-09-13 10:44:01', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('275', '2', '2018-09-13 11:48:58', '127.0.0.1', '本机地址-', '0');
INSERT INTO `pay_loginrecord` VALUES ('276', '1', '2018-09-13 11:50:25', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('277', '1', '2018-09-13 14:08:35', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('278', '1', '2018-09-13 15:28:14', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('279', '1', '2018-09-13 16:25:39', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('280', '1', '2018-09-13 17:51:13', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('281', '1', '2018-09-13 18:53:07', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('282', '1', '2018-09-13 22:07:43', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('283', '1', '2018-09-14 01:20:34', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('284', '1', '2018-09-14 09:30:01', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('285', '1', '2018-09-14 12:14:00', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('286', '1', '2018-09-14 12:53:44', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('287', '1', '2018-09-14 14:53:21', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('288', '1', '2018-09-14 17:47:39', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('289', '1', '2018-09-14 18:47:32', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('290', '1', '2018-09-14 20:09:06', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('291', '1', '2018-09-15 10:52:19', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('292', '1', '2018-09-15 14:27:33', '127.0.0.1', '本机地址', '1');
INSERT INTO `pay_loginrecord` VALUES ('293', '1', '2018-09-15 20:27:54', '127.0.0.1', '本机地址', '1');

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
  `balance` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '可用余额',
  `blockedbalance` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '冻结可用余额',
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
  `unit_paying_number` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间已交易次数',
  `unit_paying_amount` decimal(11,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '单位时间已交易金额',
  `unit_frist_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '单位时间已交易的第一笔时间',
  `last_paying_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '当天最后一笔已交易时间',
  `paying_money` decimal(11,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '当天已交易金额',
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
) ENGINE=InnoDB AUTO_INCREMENT=180586951 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_member
-- ----------------------------
INSERT INTO `pay_member` VALUES ('2', 'demouser', '0f69c07fc7967666fb2870349775751a', '4', '6450', '1', '0', '203.1920', '14.0100', '551882927@qq.com', '8f9a2804950df5c2ff9ba1f8a9b64937', '1503828960', '2017', '曹军', '1', '1282838400', '440582198705204311', '15815295199', '', '中国', 'e10adc3949ba59abbe56e057f20f883e', '1', null, 't4ig5acnpx4fet4zapshjacjd9o4bhbi', '1', null, '3', '1.9920', '0', '1529391569', '1.9920', '127.0.0.*\r\n69.172.89.61\r\n120.24.19.107\r\n127.0.0.2\r\n47.75.176.101', '1527849159', '0', '1', '1', '1', 'www.zuy.cn\r\nwww.baidu.cn\r\nwww.alipay.com\r\nwww.zuyapi.loc\r\npay.kadiya66.com', '0', 'YIXOVRNUYXUBRGSF', '69.172.89.61\r\n120.24.19.107\r\n127.0.0.1\r\n47.75.176.101', '7vjc8VtcSaN16GrK8fGmGSaUZ5MUHNRM', '1', '1536810538');
INSERT INTO `pay_member` VALUES ('3', 'ceishi_1', '7192f1fe70e36411dc90db51d5c35147', '7', '8577', '1', '0', '600.0030', '0.0000', 'ceishi1@qq.com', '296aa7fd77e854637ff15542ad1ba329', '1516440798', '0', null, '1', '0', null, null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '1', null, 'axcxvdq0tqnqjvor93e57bo6t1ynpykw', '1', null, '0', '0.0000', '0', '0', '0.0000', ' ', '1528531587', '1', '0', '0', '0', '', '0', '', '', '', '0', '0');
INSERT INTO `pay_member` VALUES ('4', 'ceishi2', '42eb548234c44a4165e36dbf4149bec0', '6', '5791', '3', '0', '700.0000', '0.0000', 'ceishi2@qq.com', 'fd007f16a134cfdf8c636ee953370983', '1516440891', '0', null, '1', '0', null, null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '1', null, 'bt5neypv3849wvj58exlabu2yk0p9xle', '0', null, '0', '0.0000', '0', '0', '0.0000', ' ', '0', '0', '0', '0', '0', '', '0', '', '', '', '0', '0');
INSERT INTO `pay_member` VALUES ('5', 'ceishi3', 'f92f32b9f44bd948ee6a06b676a92871', '7', '9833', '4', '0', '200.0000', '0.0000', 'ceishi3@qq.com', '6209d3c4247516f34417d0abba6a9f36', '1516440963', '0', null, '1', '0', null, null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '1', null, 'q7aa42dgaxwtmw75s6rdolpplte6d269', '1', null, '0', '0.0000', '0', '0', '0.0000', ' ', '0', '0', '0', '1', '0', '', '0', '', '', '', '0', '0');
INSERT INTO `pay_member` VALUES ('6', 'ceishi4', 'e2dd36a784d10e27494f17624d843b52', '4', '3064', '5', '0', '18000.0000', '0.0000', 'cheshi4@qq.com', 'decf50b881b0a5ad12d3759e1800f5c7', '1516441030', '0', null, '1', '0', null, null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '1', null, 'lhd5d6miu1i5n99rfaiast79agn3o3ma', '1', null, '0', '0.0000', '0', '0', '0.0000', ' ', '0', '0', '0', '0', '0', '', '0', '', '', '', '0', '0');
INSERT INTO `pay_member` VALUES ('180586944', 'mapeijian2', '91724b82f5d43023923d466e6ba5c2b0', '4', '2806', '1', '0', '0.0000', '0.0000', '551882927@qq.com', 'cb16ba38fd0b8d50bcc57c3365fdc9e7', '1528105388', '0', null, '1', '0', null, null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '0', null, 'uzsrcupdsjw06hrbfshrggwgp5b6g5xy', '1', null, '0', '0.0000', '0', '0', '0.0000', ' ', '0', '0', '0', '0', '0', '', '0', '', '', '', '0', '0');
INSERT INTO `pay_member` VALUES ('180586945', 'mapeijian3', '4f1164e505b7cc60f9e4fcd45e549439', '4', '8291', '1', '0', '0.0000', '0.0000', '551882927@qq.com', '60f9b265f624c6b552c56b54dc4469f0', '1528107823', '0', null, '1', '0', null, null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '0', null, 'ot3oosmt58dn316ecqzbxtqyymk8hzha', '1', null, '0', '0.0000', '0', '0', '0.0000', ' ', '0', '0', '0', '0', '0', '', '0', '', '', '', '0', '0');
INSERT INTO `pay_member` VALUES ('180586946', 'mapeijian5', '8bc7b8fdd5af088f6bffa9dc85da88c1', '4', '6520', '1', '0', '0.0000', '0.0000', '551882927@qq.com', 'd1af06acbd2965e76c64a15f62a82eaf', '1528107925', '2018', null, '1', '0', null, null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '0', null, 'pqts9wh9b7m58tg5mx84911kf09iqcdv', '1', null, '0', '0.0000', '0', '0', '0.0000', ' ', '0', '0', '0', '0', '0', '', '0', '', '', '', '0', '0');
INSERT INTO `pay_member` VALUES ('180586947', 'test', '494cb94ea4832196361fb59f77e4dec9', '4', '2023', '1', '4', '0.0000', '0.0000', '2287827147@qq.com', '2a13044648c71b41de0c7503f66eb2ba', '1528697733', '2018', 'test', '1', '-28800', '44058219870204311', '15815295199', '2287827147', '大学城', 'e10adc3949ba59abbe56e057f20f883e', '1', null, 'lunfsnxuklutr4frrgt7qnun3i1v0mtx', '1', null, '0', '0.0000', '0', '0', '0.0000', '', '1528698032', '0', '0', '1', '0', '', '1', '', '', '', '0', '0');
INSERT INTO `pay_member` VALUES ('180586949', 'mapeijian', 'e63c269881e2bfb51356fecc66394c4e', '4', '8029', '1', '4', '0.0000', '0.0000', 'mapeijiancs@126.com', '2c21666c1966e51f08b58e4426fc372d', '1535538652', '2018', '马培坚', '1', '-28800', '440582198705204311', '15815295199', '551882927', '海珠区', 'e10adc3949ba59abbe56e057f20f883e', '1', null, 'wg0fend5stj7dzo21hb8tiixh68kf3f0', '1', null, '0', '0.0000', '0', '0', '0.0000', '', '0', '0', '0', '0', '0', '', '0', '', '', 'PnDjnFiiBuTHb50z4BoUoClXSRIUeR3x', '0', '1535538763');
INSERT INTO `pay_member` VALUES ('180586950', 'test2', '75b6f5a5505908d423da1273d924ff80', '4', '3670', '1', '4', '0.0000', '0.0000', 'mapeijiancs1@126.com', 'fd8ce2ac250fa149fd4eaf882ca1dc7b', '1536747278', '2018', 'test3', '1', '-28800', '440582198705204311', '15815295199', '', 'aa', 'e10adc3949ba59abbe56e057f20f883e', '0', null, 'sg118wz1wjd5fw1bpdbfyzx9n7l646pp', '0', null, '0', '0.0000', '0', '0', '0.0000', '', '0', '0', '0', '0', '0', '', '0', '', '', '', '0', '0');

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
  `ymoney` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '原金额',
  `money` decimal(15,4) NOT NULL DEFAULT '0.0000' COMMENT '变动金额',
  `gmoney` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '变动后金额',
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
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_moneychange
-- ----------------------------
INSERT INTO `pay_moneychange` VALUES ('1', '2', '900.0000', '100.0000', '800.0000', '2018-05-30 10:11:21', 'H0530462819993974', '0', '6', null, null, 'H0530462819993974', '2018-05-30 10:11:21提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('2', '2', '800.0000', '100.0000', '700.0000', '2018-05-30 11:03:46', 'H0530494268984682', '0', '6', null, null, 'H0530494268984682', '2018-05-30 11:03:46委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('3', '2', '700.0000', '100.0000', '600.0000', '2018-05-30 11:27:50', 'H0530508708137860', '0', '6', null, null, 'H0530508708137860', '2018-05-30 11:27:50委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('4', '2', '600.0000', '200.0000', '400.0000', '2018-05-30 11:31:12', 'H0530510726156224', '0', '6', null, null, 'H0530510726156224', '2018-05-30 11:31:12委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('5', '2', '400.0000', '200.0000', '200.0000', '2018-05-30 11:35:09', 'H0530513095989090', '0', '6', null, null, 'H0530513095989090', '2018-05-30 11:35:09委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('6', '2', '20000.0000', '101.0000', '19899.0000', '2018-05-30 11:38:37', 'H0530515178959059', '0', '6', null, null, 'H0530515178959059', '2018-05-30 11:38:37委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('7', '2', '19899.0000', '102.0000', '19797.0000', '2018-05-30 11:38:37', 'H0530515178975627', '0', '6', null, null, 'H0530515178975627', '2018-05-30 11:38:37委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('8', '2', '19797.0000', '103.0000', '19694.0000', '2018-05-30 11:38:37', 'H0530515178985969', '0', '6', null, null, 'H0530515178985969', '2018-05-30 11:38:37委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('9', '2', '19694.0000', '104.0000', '19590.0000', '2018-05-30 11:38:37', 'H0530515178996043', '0', '6', null, null, 'H0530515178996043', '2018-05-30 11:38:37委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('13', '2', '19590.0000', '100.0000', '19490.0000', '2018-06-01 13:27:20', 'H0601308400200127', '0', '6', null, null, 'H0601308400200127', '2018-06-01 13:27:20委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('14', '2', '19490.0000', '100.0000', '19390.0000', '2018-06-01 17:24:27', 'H0601450678889614', '0', '6', null, null, 'H0601450678889614', '2018-06-01 17:24:27委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('15', '2', '19390.0000', '100.0000', '19290.0000', '2018-06-01 17:26:42', 'H0601452020606953', '0', '6', null, null, 'H0601452020606953', '2018-06-01 17:26:42委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('16', '2', '19290.0000', '100.0000', '19190.0000', '2018-06-01 17:28:14', 'H0601452942112740', '0', '6', null, null, 'H0601452942112740', '2018-06-01 17:28:14委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('17', '2', '0.0000', '0.0100', '0.0100', '2018-06-06 12:17:23', '20180604140857575297', '903', '1', null, null, 'E20180604140855329174', 'E20180604140855329174订单充值,结算方式：t+1', '0');
INSERT INTO `pay_moneychange` VALUES ('18', '2', '0.0000', '1.0000', '0.0000', '2018-06-08 09:45:02', '1', '0', '7', null, null, null, '测试', '0');
INSERT INTO `pay_moneychange` VALUES ('19', '2', '0.0000', '1.0000', '0.0000', '2018-06-08 11:28:01', '1', '0', '8', null, null, '', '自动解冻', '0');
INSERT INTO `pay_moneychange` VALUES ('20', '2', '0.0000', '1.0000', '0.0000', '2018-06-08 11:36:30', '1', '0', '8', null, null, '', '自动解冻', '0');
INSERT INTO `pay_moneychange` VALUES ('21', '2', '19191.0000', '1.0000', '19192.0000', '2018-06-08 12:07:36', '', '0', '3', null, null, '', '测试', '0');
INSERT INTO `pay_moneychange` VALUES ('22', '2', '19192.0000', '1.0000', '19193.0000', '2018-06-08 12:15:14', '1', '0', '7', null, null, null, '测试', '0');
INSERT INTO `pay_moneychange` VALUES ('23', '2', '19191.0000', '1.0000', '19192.0000', '2018-06-09 12:03:01', '', '0', '3', null, null, '', '测试冲正', '0');
INSERT INTO `pay_moneychange` VALUES ('24', '2', '19192.0000', '2.0000', '19194.0000', '2018-06-09 12:05:42', '', '0', '3', null, null, '', '测试【冲正周期\".2018-06-08】', '0');
INSERT INTO `pay_moneychange` VALUES ('25', '2', '19194.0000', '1.0000', '19195.0000', '2018-06-09 13:16:40', '1', '0', '7', null, null, null, '1', '0');
INSERT INTO `pay_moneychange` VALUES ('26', '2', '19193.0000', '1.0000', '19194.0000', '2018-06-09 14:08:38', '2', '0', '7', null, null, null, '测试', '0');
INSERT INTO `pay_moneychange` VALUES ('27', '2', '0.0000', '1.0000', '0.0000', '2018-06-09 14:32:06', null, null, '8', null, null, null, '手动冻结金额解冻', '0');
INSERT INTO `pay_moneychange` VALUES ('28', '2', '19193.0000', '2.0000', '19195.0000', '2018-06-09 14:59:17', '3', '0', '7', null, null, null, '11', '0');
INSERT INTO `pay_moneychange` VALUES ('29', '2', '0.0000', '2.0000', '0.0000', '2018-06-09 15:01:27', null, null, '8', null, null, null, '手动冻结金额解冻', '0');
INSERT INTO `pay_moneychange` VALUES ('30', '2', '19193.0000', '1.0000', '19194.0000', '2018-06-09 15:03:09', '4', '0', '7', null, null, null, '33', '0');
INSERT INTO `pay_moneychange` VALUES ('31', '2', '0.0000', '1.0000', '0.0000', '2018-06-09 15:04:56', null, null, '8', null, null, null, '手动冻结金额解冻', '0');
INSERT INTO `pay_moneychange` VALUES ('32', '2', '19193.0000', '2.0000', '19195.0000', '2018-06-09 15:05:08', '5', '0', '7', null, null, null, '2', '0');
INSERT INTO `pay_moneychange` VALUES ('33', '2', '0.0000', '2.0000', '0.0000', '2018-06-09 15:05:18', null, null, '8', null, null, null, '手动冻结金额解冻', '0');
INSERT INTO `pay_moneychange` VALUES ('34', '2', '19193.0000', '3.0000', '19196.0000', '2018-06-09 15:06:59', '6', '0', '7', null, null, null, '1', '0');
INSERT INTO `pay_moneychange` VALUES ('35', '2', '0.0000', '3.0000', '0.0000', '2018-06-09 15:07:10', null, null, '8', null, null, null, '手动冻结金额解冻', '0');
INSERT INTO `pay_moneychange` VALUES ('36', '2', '19193.0000', '11.0000', '19204.0000', '2018-06-09 15:09:40', '7', '0', '7', null, null, null, '111', '0');
INSERT INTO `pay_moneychange` VALUES ('43', '2', '19182.0000', '100.0000', '19282.0000', '2018-06-11 12:06:42', '24', '0', '12', null, null, '24', '商户代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('44', '2', '19282.0000', '100.0000', '19382.0000', '2018-06-11 12:06:42', '23', '0', '12', null, null, '23', '商户代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('45', '2', '19382.0000', '1.0000', '19383.0000', '2018-06-11 17:13:57', '', '0', '3', null, null, '', '11【冲正周期:2018-06-11】', '0');
INSERT INTO `pay_moneychange` VALUES ('46', '2', '19383.0000', '1.0000', '19384.0000', '2018-06-11 17:47:14', '', '0', '3', null, null, '', '1【冲正周期:2018-06-11】', '0');
INSERT INTO `pay_moneychange` VALUES ('47', '2', '19384.0000', '100.0000', '19484.0000', '2018-06-12 17:18:38', '1', '0', '11', null, null, '1', '结算驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('48', '2', '19484.0000', '100.0000', '19584.0000', '2018-06-12 17:53:02', '36', '0', '12', null, null, '36', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('49', '2', '19584.0000', '100.0000', '19684.0000', '2018-06-12 17:55:31', '36', '0', '12', null, null, '36', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('50', '2', '19684.0000', '100.0000', '19784.0000', '2018-06-12 17:56:11', '36', '0', '12', null, null, '36', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('51', '2', '19784.0000', '100.0000', '19884.0000', '2018-06-15 10:10:30', '1', '0', '11', null, null, '1', '结算驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('52', '2', '19884.0000', '100.0000', '19784.0000', '2018-06-19 10:10:07', 'H0619742079993539', '0', '6', null, null, 'H0619742079993539', '2018-06-19 10:10:07委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('53', '2', '19784.0000', '100.0000', '19684.0000', '2018-06-19 10:11:00', 'H0619742604038068', '0', '6', null, null, 'H0619742604038068', '2018-06-19 10:11:00委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('54', '2', '19684.0000', '100.0000', '19584.0000', '2018-06-19 10:11:41', 'H0619743012378377', '0', '6', null, null, 'H0619743012378377', '2018-06-19 10:11:41委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('55', '4', '600.0000', '100.0000', '700.0000', '2018-06-19 11:50:39', '', '0', '3', null, null, '', '11【冲正周期:2018-06-19】', '0');
INSERT INTO `pay_moneychange` VALUES ('56', '2', '14.0000', '0.9920', '14.9900', '2018-06-19 14:59:29', '20180615191459515352', '907', '1', null, null, 'E2018061519145633082', 'E2018061519145633082订单充值,结算方式：t+1', '0');
INSERT INTO `pay_moneychange` VALUES ('57', '3', '600.0000', '0.0030', '600.0030', '2018-06-19 14:59:29', '20180615191459515352', '907', '9', '2', '1', 'tx20180619145929', null, '0');
INSERT INTO `pay_moneychange` VALUES ('58', '2', '19584.0000', '100.1000', '19483.9000', '2018-06-19 15:45:51', 'H0619943515169736', '0', '6', null, null, 'H0619943515169736', '2018-06-19 15:45:51委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('59', '2', '19483.9000', '100.1000', '19383.8000', '2018-06-19 15:48:15', 'H0619944954648462', '0', '6', null, null, 'H0619944954648462', '2018-06-19 15:48:15委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('60', '2', '19383.8000', '1111.0000', '20494.8000', '2018-06-19 16:02:34', '', '0', '3', null, null, '', '1【冲正周期:】', '0');
INSERT INTO `pay_moneychange` VALUES ('61', '2', '20494.8000', '1.0000', '20495.8000', '2018-06-19 16:06:11', '', '0', '3', null, null, '', '1【冲正周期:】', '0');
INSERT INTO `pay_moneychange` VALUES ('62', '2', '20495.8000', '1.0000', '20496.8000', '2018-06-19 16:07:33', '', '0', '3', null, null, '', '1【冲正周期:2018-06-19】', '0');
INSERT INTO `pay_moneychange` VALUES ('63', '2', '20496.8000', '100.0000', '20396.8000', '2018-06-19 18:52:17', 'H0619055371166854', '0', '6', null, null, 'H0619055371166854', '2018-06-19 18:52:17委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('64', '2', '20396.8000', '10.0000', '20386.8000', '2018-06-19 18:52:17', 'H0619055371166854', '0', '14', null, null, 'H0619055371166854', '2018-06-19 18:52:17委托提现扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('65', '2', '20396.8000', '100.0000', '20496.8000', '2018-06-19 18:57:08', '42', '0', '12', null, null, '42', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('66', '2', '20496.8000', '100.0000', '20396.8000', '2018-06-19 19:00:45', 'H0619060459590870', '0', '6', null, null, 'H0619060459590870', '2018-06-19 19:00:45委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('67', '2', '20396.8000', '10.0000', '20386.8000', '2018-06-19 19:00:45', 'H0619060459590870', '0', '14', null, null, 'H0619060459590870', '2018-06-19 19:00:45委托提现扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('68', '2', '20396.8000', '100.0000', '20496.8000', '2018-06-19 19:01:51', '43', '0', '12', null, null, '43', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('69', '2', '20496.8000', '10.0000', '20506.8000', '2018-06-19 19:01:51', '43', '0', '15', null, null, '43', '结算驳回退回手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('70', '2', '20506.8000', '100.0000', '20406.8000', '2018-06-19 19:06:12', 'H0619063721985868', '0', '6', null, null, 'H0619063721985868', '2018-06-19 19:06:12委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('71', '2', '20406.8000', '10.0000', '20396.8000', '2018-06-19 19:06:12', 'H0619063721985868', '0', '14', null, null, 'H0619063721985868', '2018-06-19 19:06:12委托提现扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('74', '2', '20406.8000', '100.0000', '20506.8000', '2018-06-19 19:07:35', '44', '0', '12', null, null, '44', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('75', '2', '20506.8000', '10.0000', '20516.8000', '2018-06-19 19:07:35', '44', '0', '15', null, null, '44', '结算驳回退回手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('76', '2', '20516.8000', '100.0000', '20416.8000', '2018-06-19 19:08:18', 'H0619064980413981', '0', '6', null, null, 'H0619064980413981', '2018-06-19 19:08:18委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('77', '2', '20416.8000', '10.0000', '20406.8000', '2018-06-19 19:08:18', 'H0619064980413981', '0', '14', null, null, 'H0619064980413981', '2018-06-19 19:08:18委托提现扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('78', '2', '20416.8000', '100.0000', '20516.8000', '2018-06-19 19:08:40', '45', '0', '12', null, null, '45', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('79', '2', '20516.8000', '10.0000', '20526.8000', '2018-06-19 19:08:40', '45', '0', '15', null, null, '45', '结算驳回退回手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('80', '2', '20526.8000', '100.0000', '20426.8000', '2018-06-19 19:12:15', 'H0619067357067854', '0', '6', null, null, 'H0619067357067854', '2018-06-19 19:12:15委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('81', '2', '20426.8000', '100.0000', '20526.8000', '2018-06-19 19:12:35', '46', '0', '12', null, null, '46', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('82', '2', '20526.8000', '100.0000', '20426.8000', '2018-06-19 19:13:32', 'H0619068120771385', '0', '6', null, null, 'H0619068120771385', '2018-06-19 19:13:32委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('83', '2', '20426.8000', '100.0000', '20526.8000', '2018-06-22 11:38:37', '34', '0', '12', null, null, '34', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('84', '2', '20526.8000', '100.0000', '20626.8000', '2018-06-22 11:38:37', '33', '0', '12', null, null, '33', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('85', '2', '20626.8000', '100.1000', '20726.9000', '2018-06-25 10:21:00', '41', '0', '12', null, null, '41', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('86', '2', '20726.9000', '100.1000', '20827.0000', '2018-06-25 10:21:00', '40', '0', '12', null, null, '40', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('87', '2', '20827.0000', '100.0000', '20727.0000', '2018-06-28 10:06:43', 'H0628516032326746', '0', '6', null, null, 'H0628516032326746', '2018-06-28 10:06:43提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('88', '2', '20727.0000', '100.0000', '20627.0000', '2018-06-28 10:18:38', 'H0628523185113858', '0', '6', null, null, 'H0628523185113858', '2018-06-28 10:18:38委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('89', '2', '20627.0000', '100.0000', '20527.0000', '2018-06-29 10:22:54', 'H0629389743667787', '0', '6', null, null, 'H0629389743667787', '2018-06-29 10:22:54委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('90', '2', '20527.0000', '10.0000', '20517.0000', '2018-06-29 10:22:54', 'H0629389743667787', '0', '14', null, null, 'H0629389743667787', '2018-06-29 10:22:54委托提现扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('91', '2', '20527.0000', '100.0000', '20427.0000', '2018-06-29 10:25:15', 'H0629391156007288', '0', '6', null, null, 'H0629391156007288', '2018-06-29 10:25:15委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('92', '2', '20427.0000', '10.0000', '20417.0000', '2018-06-29 10:25:15', 'H0629391156007288', '0', '14', null, null, 'H0629391156007288', '2018-06-29 10:25:15委托提现扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('93', '2', '20427.0000', '100.0000', '20327.0000', '2018-06-29 10:34:57', 'H0629396970760452', '0', '6', null, null, 'H0629396970760452', '2018-06-29 10:34:57委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('94', '2', '20327.0000', '10.0000', '20317.0000', '2018-06-29 10:34:57', 'H0629396970760452', '0', '14', null, null, 'H0629396970760452', '2018-06-29 10:34:57委托提现扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('95', '2', '20317.0000', '100.0000', '20417.0000', '2018-06-29 11:55:28', '2', '0', '11', null, null, '2', '结算驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('96', '2', '20417.0000', '100.0000', '20317.0000', '2018-06-30 10:31:49', 'H0630259092587647', '0', '6', null, null, 'H0630259092587647', '2018-06-30 10:31:49提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('97', '2', '20317.0000', '200.0000', '20117.0000', '2018-06-30 10:31:59', 'H0630259192504148', '0', '6', null, null, 'H0630259192504148', '2018-06-30 10:31:59提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('98', '2', '20117.0000', '200.0000', '20317.0000', '2018-06-30 10:32:26', '4', '0', '11', null, null, '4', '结算驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('99', '2', '20317.0000', '100.0000', '20417.0000', '2018-06-30 10:32:26', '3', '0', '11', null, null, '3', '结算驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('100', '2', '20417.0000', '100.0000', '20317.0000', '2018-06-30 10:33:19', 'H0630259994408760', '0', '6', null, null, 'H0630259994408760', '2018-06-30 10:33:19提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('101', '2', '20317.0000', '100.0000', '20417.0000', '2018-06-30 10:33:29', '5', '0', '11', null, null, '5', '结算驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('102', '2', '20417.0000', '100.0000', '20317.0000', '2018-06-30 10:33:50', 'H0630260306931630', '0', '6', null, null, 'H0630260306931630', '2018-06-30 10:33:50委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('103', '2', '20317.0000', '100.0000', '20417.0000', '2018-06-30 10:34:19', '52', '0', '12', null, null, '52', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('104', '2', '20417.0000', '100.0000', '20517.0000', '2018-06-30 10:34:19', '49', '0', '12', null, null, '49', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('105', '2', '20517.0000', '10.0000', '20527.0000', '2018-06-30 10:34:19', '49', '0', '15', null, null, '49', '结算驳回退回手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('106', '2', '20527.0000', '100.0000', '20627.0000', '2018-06-30 10:34:19', '48', '0', '12', null, null, '48', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('107', '2', '20627.0000', '100.0000', '20527.0000', '2018-07-05 16:57:03', 'H0705810237844271', '0', '6', null, null, 'H0705810237844271', '2018-07-05 16:57:03提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('108', '2', '20527.0000', '100.0000', '20427.0000', '2018-07-05 16:57:48', 'H0705810688939812', '0', '6', null, null, 'H0705810688939812', '2018-07-05 16:57:48提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('109', '2', '20427.0000', '100.0000', '20317.0000', '2018-07-05 17:01:12', 'H0705812722150395', '0', '6', null, null, 'H0705812722150395', '2018-07-05 17:01:12提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('110', '2', '20327.0000', '10.0000', '20307.0000', '2018-07-05 17:01:12', 'H0705812722150395', '0', '16', null, null, 'H0705812722150395', '2018-07-05 17:01:12手动结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('111', '2', '20327.0000', '100.0000', '20427.0000', '2018-07-05 17:02:10', '8', '0', '11', null, null, '8', '结算驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('112', '2', '20427.0000', '10.0000', '20437.0000', '2018-07-05 17:02:10', '8', '0', '17', null, null, '8', '手动结算驳回退回手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('113', '2', '20337.0000', '10.0000', '20327.0000', '2018-07-05 17:07:21', 'H0705816414725453', '0', '14', null, null, 'H0705816414725453', '2018-07-05 17:07:21代付结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('114', '2', '20437.0000', '100.0000', '20337.0000', '2018-07-05 17:07:21', 'H0705816414725453', '0', '6', null, null, 'H0705816414725453', '2018-07-05 17:07:21委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('115', '2', '20327.0000', '100.0000', '20227.0000', '2018-07-05 17:09:06', 'H0705817466618089', '0', '6', null, null, 'H0705817466618089', '2018-07-05 17:09:06委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('116', '2', '20227.0000', '10.0000', '20217.0000', '2018-07-05 17:09:06', 'H0705817466618089', '0', '14', null, null, 'H0705817466618089', '2018-07-05 17:09:06代付结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('117', '2', '20217.0000', '100.0000', '20317.0000', '2018-07-05 17:09:29', '54', '0', '12', null, null, '54', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('118', '2', '20317.0000', '10.0000', '20327.0000', '2018-07-05 17:09:29', '54', '0', '15', null, null, '54', '代付结算驳回退回手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('119', '2', '20327.0000', '100.0000', '20227.0000', '2018-07-05 17:13:30', 'H0705820102870986', '0', '6', null, null, 'H0705820102870986', '2018-07-05 17:13:30委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('120', '2', '20227.0000', '10.0000', '20217.0000', '2018-07-05 17:13:30', 'H0705820102870986', '0', '16', null, null, 'H0705820102870986', '2018-07-05 17:13:30手动结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('121', '2', '20217.0000', '100.0000', '20107.0000', '2018-07-10 19:55:45', 'H0710237451453410', '0', '6', null, null, 'H0710237451453410', '2018-07-10 19:55:45提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('122', '2', '20117.0000', '10.0000', '20097.0000', '2018-07-10 19:55:45', 'H0710237451453410', '0', '16', null, null, 'H0710237451453410', '2018-07-10 19:55:45手动结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('123', '2', '20117.0000', '100.0000', '20007.0000', '2018-07-10 19:56:26', 'H0710237869299440', '0', '6', null, null, 'H0710237869299440', '2018-07-10 19:56:26提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('124', '2', '20017.0000', '10.0000', '19997.0000', '2018-07-10 19:56:26', 'H0710237869299440', '0', '16', null, null, 'H0710237869299440', '2018-07-10 19:56:26手动结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('125', '2', '20017.0000', '100.0000', '19907.0000', '2018-07-10 19:59:20', 'H0710239606666668', '0', '6', null, null, 'H0710239606666668', '2018-07-10 19:59:20提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('126', '2', '19917.0000', '10.0000', '19897.0000', '2018-07-10 19:59:20', 'H0710239606666668', '0', '16', null, null, 'H0710239606666668', '2018-07-10 19:59:20手动结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('127', '2', '19917.0000', '100.0000', '19807.0000', '2018-07-10 19:59:20', 'H0710239609250431', '0', '6', null, null, 'H0710239609250431', '2018-07-10 19:59:20提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('128', '2', '19817.0000', '10.0000', '19797.0000', '2018-07-10 19:59:20', 'H0710239609250431', '0', '16', null, null, 'H0710239609250431', '2018-07-10 19:59:20手动结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('129', '2', '19817.0000', '100.0000', '19707.0000', '2018-07-10 20:04:01', 'H0710242414663724', '0', '6', null, null, 'H0710242414663724', '2018-07-10 20:04:01提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('130', '2', '19717.0000', '10.0000', '19697.0000', '2018-07-10 20:04:01', 'H0710242414663724', '0', '16', null, null, 'H0710242414663724', '2018-07-10 20:04:01手动结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('131', '2', '19717.0000', '100.0000', '19607.0000', '2018-07-10 20:04:25', 'H0710242657679153', '0', '6', null, null, 'H0710242657679153', '2018-07-10 20:04:25提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('132', '2', '19617.0000', '10.0000', '19597.0000', '2018-07-10 20:04:25', 'H0710242657679153', '0', '16', null, null, 'H0710242657679153', '2018-07-10 20:04:25手动结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('133', '2', '19617.0000', '100.0000', '19517.0000', '2018-07-10 20:08:53', 'H0710245337763971', '0', '10', null, null, 'H0710245337763971', '2018-07-10 20:08:53委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('134', '2', '19517.0000', '10.0000', '19507.0000', '2018-07-10 20:08:53', 'H0710245337763971', '0', '14', null, null, 'H0710245337763971', '2018-07-10 20:08:53代付结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('135', '2', '20000.0000', '100.0000', '19890.0000', '2018-07-12 17:33:20', 'H0712880001260774', '0', '6', null, null, 'H0712880001260774', '2018-07-12 17:33:20提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('136', '2', '19900.0000', '10.0000', '19880.0000', '2018-07-12 17:33:20', 'H0712880001260774', '0', '16', null, null, 'H0712880001260774', '2018-07-12 17:33:20手动结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('137', '2', '19900.0000', '100.0000', '19800.0000', '2018-07-12 18:08:24', 'H0712901040126824', '0', '10', null, null, 'H0712901040126824', '2018-07-12 18:08:24委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('138', '2', '19800.0000', '10.0000', '19790.0000', '2018-07-12 18:08:24', 'H0712901040126824', '0', '14', null, null, 'H0712901040126824', '2018-07-12 18:08:24代付结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('139', '2', '19790.0000', '100.0000', '19890.0000', '2018-07-19 11:33:51', '33', '0', '12', null, null, '33', '商户代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('140', '2', '19890.0000', '100.0000', '19790.0000', '2018-07-28 14:35:49', 'H0728597492944374', '0', '6', null, null, 'H0728597492944374', '2018-07-28 14:35:49提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('141', '2', '19790.0000', '0.0100', '19789.9900', '2018-08-16 14:59:31', '20180531115756529898', '904', '7', null, null, '20180531115756529898', '手动冻结订单', '0');
INSERT INTO `pay_moneychange` VALUES ('142', '2', '19789.9900', '0.9920', '19790.9820', '2018-08-16 15:00:50', '20180615191459515352', '907', '8', null, null, '20180615191459515352', '手动解冻订单', '0');
INSERT INTO `pay_moneychange` VALUES ('143', '2', '19790.9820', '0.0100', '19790.9920', '2018-08-24 16:58:52', '57', '0', '12', null, null, '57', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('144', '2', '19790.9920', '100.0000', '19690.9920', '2018-08-28 16:47:39', 'H0828460590624913', '0', '10', null, null, 'H0828460590624913', '2018-08-28 16:47:39委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('145', '2', '19690.9920', '5.0000', '19685.9920', '2018-08-28 16:47:39', 'H0828460590624913', '0', '14', null, null, 'H0828460590624913', '2018-08-28 16:47:39代付结算扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('146', '2', '19685.9920', '100.0000', '19585.9920', '2018-08-28 16:51:57', 'H0828463177302237', '0', '10', null, null, 'H0828463177302237', '2018-08-28 16:51:57委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('147', '2', '19580.9920', '100.0000', '19480.9920', '2018-08-28 16:51:57', 'H0828463177313788', '0', '10', null, null, 'H0828463177313788', '2018-08-28 16:51:57委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('148', '2', '19475.9920', '100.0000', '19375.9920', '2018-08-28 16:51:57', 'H0828463177330571', '0', '10', null, null, 'H0828463177330571', '2018-08-28 16:51:57委托提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('149', '2', '19585.9920', '5.0000', '19580.9920', '2018-08-28 16:51:57', 'H0828463177302237', '0', '14', null, null, 'H0828463177302237', '2018-08-28 16:51:57委托提现扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('150', '2', '19480.9920', '5.0000', '19475.9920', '2018-08-28 16:51:57', 'H0828463177313788', '0', '14', null, null, 'H0828463177313788', '2018-08-28 16:51:57委托提现扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('151', '2', '19375.9920', '5.0000', '19370.9920', '2018-08-28 16:51:57', 'H0828463177330571', '0', '14', null, null, 'H0828463177330571', '2018-08-28 16:51:57委托提现扣除手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('152', '2', '19370.9920', '100.0000', '19470.9920', '2018-09-03 16:35:44', '61', '0', '12', null, null, '61', '代付驳回', '0');
INSERT INTO `pay_moneychange` VALUES ('153', '2', '19470.9920', '5.0000', '19475.9920', '2018-09-03 16:35:44', '61', '0', '15', null, null, '61', '代付结算驳回退回手续费', '0');
INSERT INTO `pay_moneychange` VALUES ('154', '2', '19475.9920', '19475.0000', '0.9920', '2018-09-06 20:40:40', 'H0906376404742720', '0', '6', null, null, 'H0906376404742720', '2018-09-06 20:40:40提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('155', '2', '20000.9920', '20000.0000', '0.9920', '2018-09-06 20:44:27', 'H0906378676451395', '0', '6', null, null, 'H0906378676451395', '2018-09-06 20:44:27提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('156', '2', '200.9920', '200.0000', '0.9920', '2018-09-06 20:48:08', 'H0906380884014433', '0', '6', null, null, 'H0906380884014433', '2018-09-06 20:48:08提现操作', '0');
INSERT INTO `pay_moneychange` VALUES ('157', '2', '200.9920', '200.0000', '0.9920', '2018-09-06 20:49:22', 'H0906381620744481', '0', '6', null, null, 'H0906381620744481', '2018-09-06 20:49:22提现操作', '0');

-- ----------------------------
-- Table structure for pay_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_order`;
CREATE TABLE `pay_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pay_memberid` varchar(100) NOT NULL COMMENT '商户编号',
  `pay_orderid` varchar(100) NOT NULL COMMENT '系统订单号',
  `pay_amount` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000',
  `pay_poundage` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000',
  `pay_actualamount` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000',
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
) ENGINE=MyISAM AUTO_INCREMENT=734 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_order
-- ----------------------------
INSERT INTO `pay_order` VALUES ('1', '10002', '20180402173845535055', '100.0000', '0.8000', '99.2000', '1522661925', '1522661985', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdquickpay', '衫德快捷支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402173840733966', '0', '18776150', '', '', '0', '0', 'Sdquickpay', '衫德快捷支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '225', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('2', '10002', '20180402173904565553', '100.0000', '0.8000', '99.2000', '1522661944', '1522662004', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdquickpay', '衫德快捷支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402173840733966', '0', '18776150', '', '', '0', '0', 'Sdquickpay', '衫德快捷支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '225', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('3', '10002', '20180402175630101545', '100.0000', '0.8000', '99.2000', '1522662990', '1522663050', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdquickpay', '衫德快捷支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402175626942047', '0', '18776150', '', '', '0', '0', 'Sdquickpay', '衫德快捷支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '225', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('4', '10002', '20180402175924991019', '100.0000', '0.8000', '99.2000', '1522663164', '1522663224', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdquickpay', '衫德快捷支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402175922673239', '0', '18776150', '', '', '0', '0', 'Sdquickpay', '衫德快捷支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '225', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('5', '10002', '20180402180708991001', '100.0000', '0.8000', '99.2000', '1522663628', '1522663688', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdquickpay', '衫德快捷支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402180706546951', '0', '18776150', '', '', '0', '0', 'Sdquickpay', '衫德快捷支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '225', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('6', '10002', '20180402181220524856', '100.0000', '0.8000', '99.2000', '1522663940', '1522664000', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdquickpay', '衫德快捷支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402181217619076', '0', '18776150', '', '', '0', '0', 'Sdquickpay', '衫德快捷支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '225', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('7', '10002', '20180402181417575598', '100.0000', '0.8000', '99.2000', '1522664057', '1522664117', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdquickpay', '衫德快捷支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402181415889752', '0', '18776150', '', '', '0', '0', 'Sdquickpay', '衫德快捷支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '225', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('8', '10002', '20180402184358101541', '100.0000', '0.8000', '99.2000', '1522665838', '1522665898', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdquickpay', '衫德快捷支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402182022880194', '0', '18776150', '', '', '0', '0', 'Sdquickpay', '衫德快捷支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '225', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('9', '10002', '20180402194903102499', '100.0000', '0.8000', '99.2000', '1522669743', '1522669803', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402194900758740', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('10', '10002', '20180402194948994852', '100.0000', '0.8000', '99.2000', '1522669788', '1522669848', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402194945350296', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('11', '10002', '20180402195046544999', '100.0000', '0.8000', '99.2000', '1522669846', '1522669906', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402195043795846', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('12', '10002', '20180402205651515752', '100.0000', '0.8000', '99.2000', '1522673811', '1522673871', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402205649932269', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('13', '10002', '20180402205950545448', '100.0000', '0.8000', '99.2000', '1522673990', '1522674050', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402205947634622', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('14', '10002', '20180402210420529849', '100.0000', '0.8000', '99.2000', '1522674260', '1522674320', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402210416362326', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('15', '10002', '20180402210949100579', '100.0000', '0.8000', '99.2000', '1522674589', '1522674649', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402210943433078', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('16', '10002', '20180402211310545650', '100.0000', '0.8000', '99.2000', '1522674790', '1522674850', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402211307993930', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('17', '10002', '20180402213327555554', '100.0000', '0.8000', '99.2000', '1522676007', '1522676067', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402213300646130', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('18', '10002', '20180402213835985754', '100.0000', '0.8000', '99.2000', '1522676315', '1522676375', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402213831972753', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('19', '10002', '20180402214555515548', '100.0000', '0.8000', '99.2000', '1522676755', '1522676815', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402214552359167', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('20', '10002', '20180402214907515410', '100.0000', '0.8000', '99.2000', '1522676947', '1522677007', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180402214714250402', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('21', '10002', '20180404110443985348', '100.0000', '0.8000', '99.2000', '1522811083', '1522811143', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180404110439766787', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('22', '10002', '20180404110543554955', '100.0000', '0.8000', '99.2000', '1522811143', '1522811203', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180404110540966793', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('23', '10002', '20180404110811985010', '100.0000', '0.8000', '99.2000', '1522811291', '1522811351', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180404110804264767', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('24', '10002', '20180404113112485450', '100.0000', '0.8000', '99.2000', '1522812672', '1522812732', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180404113109309921', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('25', '10002', '20180404113356524999', '100.0000', '0.8000', '99.2000', '1522812836', '1522812896', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180404113352698699', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('26', '10002', '20180404145554975752', '6.0000', '0.0500', '5.9500', '1522824954', '1522825014', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180404145552820785', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('27', '10002', '20180404145649491015', '10.0000', '0.0800', '9.9200', '1522825009', '1522825069', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180404145647235818', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('28', '10002', '20180404145702101100', '9.0000', '0.0700', '8.9300', '1522825022', '1522825082', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180404145700658654', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('29', '10002', '20180404145722504851', '10.1000', '0.0800', '10.0200', '1522825042', '1522825102', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180404145720266717', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('30', '10002', '20180404145734101994', '10.0100', '0.0800', '9.9300', '1522825054', '1522825114', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'Sdwgpay', '衫德网关支付', 'http://www.payapi.loc/demo/index1.php', 'E20180404145732526901', '0', '18776150', '', '', '0', '0', 'Sdwgpay', '衫德网关支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '226', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('31', '10002', '20180411174459989957', '100.0000', '0.8000', '99.2000', '1523439899', '1523439959', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180411174457534619', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(网银支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('32', '10002', '20180411174532995053', '100.0000', '0.8000', '99.2000', '1523439932', '1523439992', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180411174457534619', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(网银支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('33', '10002', '20180411174615555057', '100.0000', '0.8000', '99.2000', '1523439975', '1523440035', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180411174457534619', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(网银支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('34', '10002', '20180411175842501015', '100.0000', '0.8000', '99.2000', '1523440723', '1523440783', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180411174457534619', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(网银支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('35', '10002', '20180411181602505452', '100.0000', '0.8000', '99.2000', '1523441762', '1523441822', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'CvQuick', 'PAYCV快捷支付', 'http://www.payapi.loc/demo/index1.php', 'E20180411181559384902', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvQuick', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('36', '10002', '20180412115536564998', '1.0000', '0.0100', '0.9900', '1523505336', '1523505396', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115534286877', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvQuick', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('37', '10002', '20180412115617495050', '1.0000', '0.0100', '0.9900', '1523505377', '1523505437', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('38', '10002', '20180412115644994849', '1.0000', '0.0100', '0.9900', '1523505404', '1523505464', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('39', '10002', '20180412115656569910', '1.0000', '0.0100', '0.9900', '1523505416', '1523505476', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('40', '10002', '20180412115720481015', '1.0000', '0.0100', '0.9900', '1523505440', '1523505500', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('41', '10002', '20180412115826505349', '1.0000', '0.0100', '0.9900', '1523505506', '1523505566', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('42', '10002', '20180412115904565248', '1.0000', '0.0100', '0.9900', '1523505544', '1523505604', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('43', '10002', '20180412115905575656', '1.0000', '0.0100', '0.9900', '1523505545', '1523505605', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('44', '10002', '20180412115932525297', '1.0000', '0.0100', '0.9900', '1523505572', '1523505632', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('45', '10002', '20180412120008565251', '1.0000', '0.0100', '0.9900', '1523505608', '1523505668', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('46', '10002', '20180412120011985698', '1.0000', '0.0100', '0.9900', '1523505611', '1523505671', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('47', '10002', '20180412120012991015', '1.0000', '0.0100', '0.9900', '1523505612', '1523505672', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('48', '10002', '20180412120013100991', '1.0000', '0.0100', '0.9900', '1523505613', '1523505673', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('49', '10002', '20180412120014101985', '1.0000', '0.0100', '0.9900', '1523505614', '1523505674', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('50', '10002', '20180412120015102564', '1.0000', '0.0100', '0.9900', '1523505615', '1523505675', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('51', '10002', '20180412120016485198', '1.0000', '0.0100', '0.9900', '1523505616', '1523505676', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('52', '10002', '20180412120023555655', '1.0000', '0.0100', '0.9900', '1523505623', '1523505683', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120021947814', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('53', '10002', '20180412120045100535', '1.0000', '0.0100', '0.9900', '1523505645', '1523505705', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120021947814', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('54', '10002', '20180412120046101100', '1.0000', '0.0100', '0.9900', '1523505646', '1523505706', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120021947814', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('55', '10002', '20180412120056565097', '1.0000', '0.0100', '0.9900', '1523505656', '1523505716', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120021947814', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('56', '10002', '20180412120140525152', '1.0000', '0.0100', '0.9900', '1523505700', '1523505760', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120021947814', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('57', '10002', '20180412120141535399', '1.0000', '0.0100', '0.9900', '1523505701', '1523505761', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120021947814', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('58', '10002', '20180412120142545599', '1.0000', '0.0100', '0.9900', '1523505702', '1523505762', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120021947814', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('59', '10002', '20180412120143555650', '1.0000', '0.0100', '0.9900', '1523505703', '1523505763', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('60', '10002', '20180412120145579957', '1.0000', '0.0100', '0.9900', '1523505705', '1523505765', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('61', '10002', '20180412120147985198', '1.0000', '0.0100', '0.9900', '1523505707', '1523505767', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412115608323489', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('62', '10002', '20180412120514975410', '1.0000', '0.0100', '0.9900', '1523505914', '1523505974', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvBank', 'PAYCV网银支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120512296408', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(网银支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '227', '210', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('63', '10002', '20180412120555511024', '1.0000', '0.0100', '0.9900', '1523505956', '1523506016', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120553575515', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('64', '10002', '20180412120637100525', '1.0000', '0.0100', '0.9900', '1523505997', '1523506057', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120635487020', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('65', '10002', '20180412120729495049', '1.0000', '0.0100', '0.9900', '1523506049', '1523506109', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120635487020', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('66', '10002', '20180412120744485710', '1.0000', '0.0100', '0.9900', '1523506064', '1523506124', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120635487020', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('67', '10002', '20180412120804524998', '1.0000', '0.0100', '0.9900', '1523506084', '1523506144', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120635487020', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('68', '10002', '20180412120805535798', '1.0000', '0.0100', '0.9900', '1523506085', '1523506145', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120635487020', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('69', '10002', '20180412120808569810', '1.0000', '0.0100', '0.9900', '1523506088', '1523506148', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120806319644', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('70', '10002', '20180412120929574810', '1.0000', '0.0100', '0.9900', '1523506169', '1523506229', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://www.payapi.loc/demo4/index1.php', 'E20180412120926420114', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('71', '10002', '20180412121301100102', '1.0000', '0.0100', '0.9900', '1523506382', '1523506442', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://pay.rcywlkj.com/demo4/index1.php', 'E20180412121259552441', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('72', '10002', '20180412161610975598', '0.0100', '0.0000', '0.0100', '1523520970', '1523521030', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://pay.rcywlkj.com/demo4/index1.php', 'E20180412161608990511', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('73', '10002', '20180412162209495410', '0.1000', '0.0000', '0.1000', '1523521329', '1523521389', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://pay.rcywlkj.com/demo4/index1.php', 'E20180412162207192858', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('74', '10002', '20180412162520489810', '0.1000', '0.0000', '0.1000', '1523521520', '1523521580', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://pay.rcywlkj.com/demo4/index1.php', 'E20180412162518684606', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('75', '10002', '20180412162729491009', '1.0000', '0.0100', '0.9900', '1523521649', '1523521709', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'CvQuick', 'PAYCV快捷支付', 'http://pay.rcywlkj.com/demo4/index1.php', 'E20180412162726169449', '0', '10124', 'h0ecqvphc483ogk1lt8148jwrrkjnb0j', '', '0', '0', 'CvBank', 'PAYCV(D0快捷支付)', '0', '1234|456', '正式账号', '0.0000', '0.0000', '228', '211', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('76', '10002', '20180416151456481015', '100.0000', '0.8000', '99.2000', '1523862896', '1523862956', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'HxBank', '环迅网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180416151435932681', '0', '207231', 'Mo6HqQtlMv4j9hZwfRck7lVGSd8pG9C75ascLsjgVgw88Yv4v0kVEVpMmFcDESGMpyZuclb4p7HB2oAwXeAk9UYq0RsllfcwTAfpvROpC0jMLn9sJWlg9HMCxhhNpVrk', '', '0', '0', 'HxBank', '环迅网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '229', '212', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('77', '10002', '20180416154051515552', '100.0000', '0.8000', '99.2000', '1523864451', '1523864511', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'HxBank', '环迅网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180416154049288470', '0', '207231', 'Mo6HqQtlMv4j9hZwfRck7lVGSd8pG9C75ascLsjgVgw88Yv4v0kVEVpMmFcDESGMpyZuclb4p7HB2oAwXeAk9UYq0RsllfcwTAfpvROpC0jMLn9sJWlg9HMCxhhNpVrk', '2072310010', '0', '0', 'HxBank', '环迅网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '229', '212', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('78', '10002', '20180416154527559897', '100.0000', '0.8000', '99.2000', '1523864727', '1523864787', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'HxBank', '环迅网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180416154526219393', '0', '207231', 'Mo6HqQtlMv4j9hZwfRck7lVGSd8pG9C75ascLsjgVgw88Yv4v0kVEVpMmFcDESGMpyZuclb4p7HB2oAwXeAk9UYq0RsllfcwTAfpvROpC0jMLn9sJWlg9HMCxhhNpVrk', '2072310010', '0', '0', 'HxBank', '环迅网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '229', '212', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('79', '10002', '20180416164853535056', '100.0000', '0.8000', '99.2000', '1523868533', '1523868593', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'HxBank', '环迅网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180416154526219393', '0', '207231', 'Mo6HqQtlMv4j9hZwfRck7lVGSd8pG9C75ascLsjgVgw88Yv4v0kVEVpMmFcDESGMpyZuclb4p7HB2oAwXeAk9UYq0RsllfcwTAfpvROpC0jMLn9sJWlg9HMCxhhNpVrk', '2072310010', '0', '0', 'HxBank', '环迅网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '229', '212', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('80', '10002', '20180416180142545298', '0.1000', '0.0000', '0.1000', '1523872902', '1523872962', '907', 'http://6shun.zlaiaa.top:1818/demo/server.php', 'http://6shun.zlaiaa.top:1818/demo/page.php', '网银支付', '2', 'VIP基础服务', 'HxBank', '环迅网银支付', 'http://6shun.zlaiaa.top:1818/demo2/index1.php', 'E20180416180141395430', '0', '207231', 'Mo6HqQtlMv4j9hZwfRck7lVGSd8pG9C75ascLsjgVgw88Yv4v0kVEVpMmFcDESGMpyZuclb4p7HB2oAwXeAk9UYq0RsllfcwTAfpvROpC0jMLn9sJWlg9HMCxhhNpVrk', '2072310010', '0', '0', 'HxBank', '环迅网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '224', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('81', '10002', '20180425181309539799', '100.0000', '0.5000', '99.5000', '1524651189', '1524651249', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180425181102407562', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('82', '10002', '20180425181332999910', '100.0000', '0.5000', '99.5000', '1524651212', '1524651272', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180425181330165451', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('83', '10002', '20180426091113495155', '100.0000', '0.5000', '99.5000', '1524705073', '1524705133', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426090929499792', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('84', '10002', '20180426091333100531', '0.0100', '0.0000', '0.0100', '1524705213', '1524705273', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426091314520584', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('85', '10002', '20180426091439102975', '0.0100', '0.0000', '0.0100', '1524705279', '1524705339', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426091437305361', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('86', '10002', '20180426091457495499', '0.1000', '0.0000', '0.1000', '1524705297', '1524705357', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426091451590704', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('87', '10002', '20180426091511102971', '1.0000', '0.0100', '1.0000', '1524705311', '1524705371', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426091509480209', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('88', '10002', '20180426091521575154', '10.0000', '0.0500', '9.9500', '1524705321', '1524705381', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426091519656457', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('89', '10002', '20180426091702101549', '10.0000', '0.0500', '9.9500', '1524705422', '1524705482', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426091659736685', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('90', '10002', '20180426091711555349', '10.0000', '0.0500', '9.9500', '1524705431', '1524705491', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426091707453567', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('91', '10002', '20180426091821100579', '10.0000', '0.0500', '9.9500', '1524705501', '1524705561', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426091819877941', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('92', '10002', '20180426091848565748', '10.0000', '0.0500', '9.9500', '1524705528', '1524705588', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426091847906890', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('93', '10002', '20180426092555515053', '10.0000', '0.0500', '9.9500', '1524705955', '1524706015', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426092551387045', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('94', '10002', '20180426092616565710', '10.0000', '0.0500', '9.9500', '1524705976', '1524706036', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426092614186654', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('95', '10002', '20180426093413539749', '10.0000', '0.0500', '9.9500', '1524706453', '1524706513', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426093409510229', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('96', '10002', '20180426093506974910', '10.0000', '0.0500', '9.9500', '1524706506', '1524706566', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426093504328048', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('97', '10002', '20180426093722509710', '10.0000', '0.0500', '9.9500', '1524706642', '1524706702', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426093720672937', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('98', '10005', '20180426093849579851', '10.0000', '0.0500', '9.9500', '1524706729', '1524706789', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426093848395449', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('99', '10005', '20180426094029100100', '10.0000', '0.0500', '9.9500', '1524706829', '1524706889', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426094027747314', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('100', '10002', '20180426094058975151', '10.0000', '0.0500', '9.9500', '1524706858', '1524706918', '902', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '微信扫码支付', '2', 'Recharge', 'Qydwxscan', '奇易达微信扫码', 'http://www.payapi.loc/demo/index1.php', 'E20180426094056156881', '0', '2146', 'b47f0b57bfd74b51b38a54795fc0e84c', '', '0', '0', 'Qydwxscan', '奇易达微信扫码', '0', '1234|456', '友付', '0.0000', '0.0000', '230', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('101', '10002', '20180427122214541005', '10.0000', '0.0800', '9.9200', '1524802934', '1524802994', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427122111287619', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('102', '10002', '20180427130815102100', '10.0000', '0.0800', '9.9200', '1524805695', '1524805755', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427130811766101', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('103', '10002', '20180427132034509797', '10.0000', '0.0800', '9.9200', '1524806434', '1524806494', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427132030452661', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('104', '10002', '20180427132548995351', '10.0000', '0.0800', '9.9200', '1524806748', '1524806808', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427132544353234', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('105', '10002', '20180427154246545454', '10.0000', '0.0800', '9.9200', '1524814966', '1524815026', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427154241535415', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('106', '10006', '20180427154543555755', '10.0000', '0.0800', '9.9200', '1524815143', '1524815203', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427154539694442', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('107', '10006', '20180427192512564953', '10.0000', '0.0800', '9.9200', '1524828312', '1524828372', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427192509147598', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('108', '10002', '20180427192603984957', '10.0000', '0.0800', '9.9200', '1524828363', '1524828423', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427192600269464', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('109', '10002', '20180427192736565249', '10.0000', '0.0800', '9.9200', '1524828456', '1524828516', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427192635203353', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('110', '10002', '20180427193334101101', '10.0000', '0.0800', '9.9200', '1524828814', '1524828874', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427193331640884', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('111', '10002', '20180427194320565757', '10.0000', '0.0800', '9.9200', '1524829400', '1524829460', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427194316427117', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('112', '10002', '20180427194337579752', '10.0000', '0.0800', '9.9200', '1524829417', '1524829477', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427194334362957', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('113', '10002', '20180427205223555555', '10.0000', '0.0800', '9.9200', '1524833543', '1524833603', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427205219770028', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('114', '10003', '20180427210408569798', '10.0000', '0.0800', '9.9200', '1524834248', '1524834308', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427210406622097', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('115', '10003', '20180427210503102565', '10.0000', '0.0800', '9.9200', '1524834303', '1524834363', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427210501633743', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('116', '10003', '20180427210747514810', '10.0000', '0.0800', '9.9200', '1524834467', '1524834527', '907', 'http://www.payapi.loc/demo/server.php', 'http://www.payapi.loc/demo/page.php', '网银支付', '2', 'Recharge', 'KmBank', '快码网银支付', 'http://www.payapi.loc/demo/index1.php', 'E20180427210737919937', '0', '17296', '27c89d1f24d7f9a13391476a66f170f6', '', '0', '0', 'KmBank', '快码网银支付', '0', '1234|456', '正式账号', '0.0000', '0.0000', '231', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('378', '10003', '20180530191227981019', '100.0000', '0.5000', '99.5000', '1527678747', '1527678807', '902', 'http://www.zuyapi.loc/Pay_Charges_notify.php', 'http://www.zuyapi.loc/Pay_Charges_callback.php', '微信扫码支付', '2', '收款', 'WxSm', '微信扫码支付', 'http://www.zuyapi.loc/Pay_Charges_checkout.html', 'C20180530191227239361', '0', '', '', '', '0', '0', 'WxSm', '微信扫码支付-官方', '0', '', '微信扫码支付', '0.0000', '0.0000', '218', '199', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('379', '10003', '20180530193358549751', '111.0000', '0.0000', '111.0000', '1527680038', '1527680098', '903', 'http://www.zuyapi.loc/Pay_Charges_notify.php', 'http://www.zuyapi.loc/Pay_Charges_callback.php', '支付宝扫码支付', '2', '收款', 'Aliscan', '支付宝扫码', 'http://www.zuyapi.loc/Pay_Charges_checkout.html', 'C20180530193358592709', '0', '', '', '', '0', '0', 'Aliscan', '支付宝官方扫码', '0', 'fdgdfg', '支付宝扫码', '0.0000', '0.0000', '220', '201', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('380', '10002', '20180530193433575655', '22.0000', '0.0000', '22.0000', '1527680073', '1527680133', '904', 'http://www.zuyapi.loc/Pay_Charges_notify.php', 'http://www.zuyapi.loc/Pay_Charges_callback.php', '支付宝手机', '2', '收款', 'Aliwap', '支付宝H5', 'http://www.zuyapi.loc/Pay_Charges_checkout.html', 'C20180530193433972836', '0', '', '', '', '0', '0', 'Aliwap', '支付宝官方（WAP）', '0', '', '支付宝H5', '0.0000', '0.0000', '221', '202', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('381', '180596943', '20180530193442505299', '55.0000', '0.0000', '55.0000', '1527680082', '1527680142', '904', 'http://www.zuyapi.loc/Pay_Charges_notify.php', 'http://www.zuyapi.loc/Pay_Charges_callback.php', '支付宝手机', '2', '收款', 'Aliwap', '支付宝H5', 'http://www.zuyapi.loc/Pay_Charges_checkout.html', 'C20180530193442581942', '0', '', '', '', '0', '0', 'Aliwap', '支付宝官方（WAP）', '0', '', '支付宝H5', '0.0000', '0.0000', '221', '202', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('382', '180596943', '20180530235017574953', '100.0000', '4.0000', '96.0000', '1527695417', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '2', 'VIP基础服务', 'WxSm', '微信扫码支付', 'http://www.zuyapi.loc/demo/index1.php', 'E20180530235015435714', '0', '', '', '', '0', '0', 'WxSm', '微信扫码支付-官方', '0', '1234|456', '微信扫码支付', '0.0000', '0.0000', '218', '199', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('383', '10002', '20180531115508994810', '0.0100', '0.0000', '0.0100', '1527738908', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '2', 'VIP基础服务', 'AliwapOld', '支付宝WAP（老版）', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531115506988546', '0', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '0', '0', 'Aliwap', '支付宝官方（老版WAP）', '0', '1234|456', '2088131085175285', '0.0000', '0.0000', '224', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('384', '10002', '20180531115532525155', '0.0100', '0.0000', '0.0100', '1527738932', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '2', 'VIP基础服务', 'AliwapOld', '支付宝WAP（老版）', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531115530485263', '0', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '0', '0', 'Aliwap', '支付宝官方（老版WAP）', '0', '1234|456', '2088131085175285', '0.0000', '0.0000', '224', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('385', '10002', '20180531115556999810', '0.0100', '0.0000', '0.0100', '1527738956', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '2', 'VIP基础服务', 'AliwapOld', '支付宝WAP（老版）', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531115530485263', '0', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '0', '0', 'Aliwap', '支付宝官方（老版WAP）', '0', '1234|456', '2088131085175285', '0.0000', '0.0000', '224', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('386', '10002', '20180531115604525152', '0.0100', '0.0000', '0.0100', '1527738964', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '2', 'VIP基础服务', 'AliwapOld', '支付宝WAP（老版）', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531115602484356', '0', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '0', '0', 'Aliwap', '支付宝官方（老版WAP）', '0', '1234|456', '2088131085175285', '0.0000', '0.0000', '224', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('387', '10002', '20180531115619515799', '0.0100', '0.0000', '0.0100', '1527738979', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '2', 'VIP基础服务', 'AliwapOld', '支付宝WAP（老版）', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531115618217059', '0', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '0', '0', 'Aliwap', '支付宝官方（老版WAP）', '0', '1234|456', '2088131085175285', '0.0000', '0.0000', '224', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('388', '10002', '20180531115703102515', '0.0100', '0.0000', '0.0100', '1527739023', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '2', 'VIP基础服务', 'AliwapOld', '支付宝WAP（老版）', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531115701262597', '0', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '0', '0', 'Aliwap', '支付宝官方（老版WAP）', '0', '1234|456', '2088131085175285', '0.0000', '0.0000', '224', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('389', '10002', '20180531115724525048', '0.0100', '0.0000', '0.0100', '1527739044', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '2', 'VIP基础服务', 'AliwapOld', '支付宝WAP（老版）', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531115722596252', '0', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '0', '0', 'Aliwap', '支付宝官方（老版WAP）', '0', '1234|456', '2088131085175285', '0.0000', '0.0000', '224', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('390', '10002', '20180531115730975098', '0.0100', '0.0000', '0.0100', '1527739050', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '2', 'VIP基础服务', 'AliwapOld', '支付宝WAP（老版）', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531115722596252', '0', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '0', '0', 'Aliwap', '支付宝官方（老版WAP）', '0', '1234|456', '2088131085175285', '0.0000', '0.0000', '224', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('391', '10002', '20180531115748995551', '0.0100', '0.0000', '0.0100', '1527739068', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '2', 'VIP基础服务', 'AliwapOld', '支付宝WAP（老版）', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531115722596252', '0', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '0', '0', 'Aliwap', '支付宝官方（老版WAP）', '0', '1234|456', '2088131085175285', '0.0000', '0.0000', '224', '208', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('392', '10002', '20180531115756529898', '0.0100', '0.0000', '0.0100', '1527739076', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '2', 'VIP基础服务', 'AliwapOld', '支付宝WAP（老版）', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531115752680902', '0', '2088131085175285', 'tp7msh810uw5p2jga2bcmrub63ldydob', 'yeah198800@126.com', '0', '0', 'Aliwap', '支付宝官方（老版WAP）', '0', '1234|456', '2088131085175285', '0.0000', '0.0000', '224', '208', '1', '11', '1');
INSERT INTO `pay_order` VALUES ('393', '180596943', '20180531152815102100', '100.0000', '0.0000', '100.0000', '1527751695', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531152813227139', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('394', '180596943', '20180531153103554910', '100.0000', '0.0000', '100.0000', '1527751863', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531153101110519', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('395', '180596943', '20180531153113495157', '100.0000', '0.0000', '100.0000', '1527751873', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531153110892224', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('396', '180596943', '20180531153144489853', '100.0000', '0.0000', '100.0000', '1527751904', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531153143568319', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('397', '180596943', '20180531153336489853', '100.0000', '0.0000', '100.0000', '1527752016', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531153335222744', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('398', '180596943', '20180531153519555252', '100.0000', '0.0000', '100.0000', '1527752119', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531153517137243', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('399', '180596943', '20180531153756529810', '100.0000', '0.0000', '100.0000', '1527752276', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531153755585430', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('400', '180596943', '20180531153807102535', '100.0000', '0.0000', '100.0000', '1527752287', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531153755585430', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('401', '180596943', '20180531161941100575', '100.0000', '0.0000', '100.0000', '1527754781', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531161939593725', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('402', '180596943', '20180531162002505510', '100.0000', '0.0000', '100.0000', '1527754802', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531162001335409', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '1');
INSERT INTO `pay_order` VALUES ('403', '180596943', '20180531163932525048', '100.0000', '0.0000', '100.0000', '1527755972', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'LzfBank', '乐支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E20180531163929856518', '0', '10003', '261b49f58832cb5447420e7bc9b977e0', '', '0', '0', 'LzfBank', '乐支付（网银）', '0', '1234|456', '10003', '0.0000', '0.0000', '225', '209', '1', '11', '1');
INSERT INTO `pay_order` VALUES ('689', '10002', '20180901192157535199', '0.0100', '0.0001', '0.0099', '1535800917', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Meizi50Bank', '捷易付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018090119215389892', '0', 'BOSS88882018083110001352', '9a7315f3063344f68980437ac2bcb5bc', '', '0', '0', 'Meizi50Bank', '捷易付网银支付', '0', '1234|456', 'BOSS88882018083110001352', '0.0000', '0.0000', '252', '235', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('455', '10002', '20180615172531981009', '0.0100', '0.0001', '0.0099', '1529054731', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517252869658', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('456', '10002', '20180615172552485648', '1.0000', '0.0080', '0.9920', '1529054752', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517254826108', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('457', '10002', '20180615172600565349', '10.0000', '0.0800', '9.9200', '1529054760', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517255587777', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('458', '10002', '20180615172617571005', '0.0100', '0.0001', '0.0099', '1529054777', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517261419577', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('459', '10002', '20180615172634975110', '0.0100', '0.0001', '0.0099', '1529054794', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517263210911', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('460', '10002', '20180615172653100529', '0.0100', '0.0001', '0.0099', '1529054813', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517263210911', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('461', '10002', '20180615172655102101', '0.0100', '0.0001', '0.0099', '1529054815', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517263210911', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('462', '10002', '20180615172700525052', '0.0100', '0.0001', '0.0099', '1529054820', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517265681424', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('463', '10002', '20180615172705579910', '1.0000', '0.0080', '0.9920', '1529054825', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517270238872', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('464', '10002', '20180615172713494854', '10.0000', '0.0800', '9.9200', '1529054833', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517270819882', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('465', '10002', '20180615172938505354', '1.0000', '0.0080', '0.9920', '1529054978', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517293457779', '0', '100204', '91EF44B3DC38C78B4DC7A27721587319', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '100204', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('466', '10002', '20180615173509100564', '0.0100', '0.0001', '0.0099', '1529055309', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517350788879', '0', '2', '893701E6A0C5EB903BFF6A12818ED9E0', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '测试账号', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('467', '10002', '20180615173516524949', '1.0000', '0.0080', '0.9920', '1529055316', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517350788879', '0', '2', '893701E6A0C5EB903BFF6A12818ED9E0', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '测试账号', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('468', '10002', '20180615173529495497', '10.0000', '0.0800', '9.9200', '1529055329', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517350788879', '0', '2', '893701E6A0C5EB903BFF6A12818ED9E0', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '测试账号', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('469', '10002', '20180615173534541015', '10.0000', '0.0800', '9.9200', '1529055334', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Htbank', '汇通网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061517350788879', '0', '2', '893701E6A0C5EB903BFF6A12818ED9E0', '', '0', '0', 'Htbank', '汇通网关支付', '0', '1234|456', '测试账号', '0.0000', '0.0000', '229', '213', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('470', '10002', '20180615182557539997', '0.0100', '0.0001', '0.0099', '1529058357', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061518255436759', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('471', '10002', '20180615184443984957', '0.0100', '0.0001', '0.0099', '1529059483', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061518444093751', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('472', '10002', '20180615185604525410', '1.0000', '0.0080', '0.9920', '1529060164', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061518560149828', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('473', '10002', '20180615190355985398', '0.0100', '0.0001', '0.0099', '1529060635', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519035297962', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('474', '10002', '20180615190417499710', '2.0000', '0.0160', '1.9840', '1529060657', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519041481872', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('475', '10002', '20180615190500995498', '0.0100', '0.0001', '0.0099', '1529060700', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519045824397', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('476', '10002', '20180615190549100519', '2.0000', '0.0160', '1.9840', '1529060749', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519054624180', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('477', '10002', '20180615190617579748', '2.0000', '0.0160', '1.9840', '1529060777', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519061417141', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('478', '10002', '20180615190706979799', '2.0000', '0.0160', '1.9840', '1529060826', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519070119467', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('479', '10002', '20180615190956525048', '2.0000', '0.0160', '1.9840', '1529060996', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519095177873', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('480', '10002', '20180615191034975798', '0.0100', '0.0001', '0.0099', '1529061034', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519103279881', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('481', '10002', '20180615191041495651', '2.0000', '0.0160', '1.9840', '1529061041', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519103620621', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('482', '10002', '20180615191107984910', '0.0100', '0.0001', '0.0100', '1529061067', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'Rzfwxscan', '睿支付微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519110345367', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfwxscan', '睿支付微信扫码', '0', '1234|456', '100000057', '0.0000', '0.0030', '228', '212', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('483', '10002', '20180615191121575350', '0.0100', '0.0001', '0.0100', '1529061081', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'Rzfwxscan', '睿支付微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519111921958', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfwxscan', '睿支付微信扫码', '0', '1234|456', '100000057', '0.0000', '0.0030', '228', '212', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('484', '10002', '20180615191206545557', '0.0100', '0.0001', '0.0100', '1529061126', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'Rzfwxscan', '睿支付微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519120450871', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfwxscan', '睿支付微信扫码', '0', '1234|456', '100000057', '0.0000', '0.0030', '228', '212', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('485', '10002', '20180615191227981011', '0.0100', '0.0001', '0.0100', '1529061148', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'Rzfwxscan', '睿支付微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519122658032', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfwxscan', '睿支付微信扫码', '0', '1234|456', '100000057', '0.0000', '0.0030', '228', '212', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('486', '10002', '20180615191324525255', '0.0100', '0.0001', '0.0099', '1529061204', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519132214617', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('487', '10002', '20180615191335102545', '3.0000', '0.0240', '2.9760', '1529061215', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519133251698', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('488', '10002', '20180615191415559753', '0.0100', '0.0001', '0.0099', '1529061255', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519141348075', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('489', '10002', '20180615191434974848', '1.0000', '0.0080', '0.9920', '1529061274', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519143098786', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('490', '10002', '20180615191459515352', '1.0000', '0.0080', '0.9920', '1529061299', '1529391569', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '2', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018061519145633082', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '2');
INSERT INTO `pay_order` VALUES ('491', '10002', '20180620113354505749', '2.0000', '0.0160', '1.9840', '1529465634', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062011334476005', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('492', '10002', '20180620113959102100', '1.0000', '0.0080', '0.9920', '1529465999', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062011351690798', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('493', '10002', '20180620140726101495', '1.0000', '0.0080', '0.9920', '1529474846', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Rzfbank', '睿支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062011410097517', '0', '100000057', 'eS9xWlY1bkQ2ajFQV0FDT2VsbUhtZz09', '', '0', '0', 'Rzfbank', '睿支付网银支付', '0', '1234|456', '100000057', '0.0000', '0.0000', '230', '214', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('494', '10002', '20180620145958101491', '0.0100', '0.0001', '0.0099', '1529477998', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Swzfbank', '思维支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062014595671430', '0', '10887', 'c1c4f8ae34a86f217b7e791c6c06187e677bec75', '', '0', '0', 'Swzfbank', '思维支付网银支付', '0', '1234|456', '10887', '0.0000', '0.0000', '231', '215', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('495', '10002', '20180620150022549810', '0.0100', '0.0001', '0.0099', '1529478022', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Swzfbank', '思维支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015002054519', '0', '10887', 'c1c4f8ae34a86f217b7e791c6c06187e677bec75', '', '0', '0', 'Swzfbank', '思维支付网银支付', '0', '1234|456', '10887', '0.0000', '0.0000', '231', '215', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('496', '10002', '20180620151106975756', '0.0100', '0.0001', '0.0099', '1529478666', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Swzfbank', '思维支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015110450330', '0', '10887', 'c1c4f8ae34a86f217b7e791c6c06187e677bec75', '', '0', '0', 'Swzfbank', '思维支付网银支付', '0', '1234|456', '10887', '0.0000', '0.0000', '231', '215', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('497', '10002', '20180620151256569998', '0.0100', '0.0001', '0.0099', '1529478776', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Swzfbank', '思维支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015125592424', '0', '10887', 'c1c4f8ae34a86f217b7e791c6c06187e677bec75', '', '0', '0', 'Swzfbank', '思维支付网银支付', '0', '1234|456', '10887', '0.0000', '0.0000', '231', '215', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('498', '10002', '20180620153238544951', '0.0100', '0.0001', '0.0100', '1529479958', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015315061127', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('499', '10002', '20180620153302101495', '0.0100', '0.0001', '0.0100', '1529479982', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015324120744', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('500', '10002', '20180620153330975497', '0.0100', '0.0001', '0.0099', '1529480010', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Swzfbank', '思维支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015332894407', '0', '10887', 'c1c4f8ae34a86f217b7e791c6c06187e677bec75', '', '0', '0', 'Swzfbank', '思维支付网银支付', '0', '1234|456', '10887', '0.0000', '0.0000', '231', '215', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('501', '10002', '20180620153334101975', '0.0100', '0.0001', '0.0100', '1529480014', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015333392499', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('502', '10002', '20180620153425495697', '0.0100', '0.0001', '0.0100', '1529480065', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015333392499', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('503', '10002', '20180620153427515597', '0.0100', '0.0001', '0.0100', '1529480067', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015333392499', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('504', '10002', '20180620153431551011', '0.0100', '0.0001', '0.0100', '1529480071', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015342925303', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('505', '10002', '20180620153447555352', '0.0100', '0.0001', '0.0100', '1529480087', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015344416306', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('506', '10002', '20180620154445100985', '0.0100', '0.0001', '0.0100', '1529480685', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'VIP基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062015444494998', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('507', '10002', '20180620191401575556', '1.0000', '0.0000', '1.0000', '1529493241', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo_old/index1.php', 'E20180620191354682714', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('508', '10002', '20180620191424485297', '1.0000', '0.0000', '1.0000', '1529493264', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo_old/index1.php', 'E20180620191354682714', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('509', '10002', '20180620191544485250', '1.0000', '0.0000', '1.0000', '1529493344', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo_old/index1.php', 'E20180620191354682714', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('510', '10002', '20180620191549535752', '100.0000', '0.0000', '100.0000', '1529493349', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo_old/index1.php', 'E20180620191547996841', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('511', '10002', '20180620191613100485', '100.0000', '0.0000', '100.0000', '1529493373', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo_old/index1.php', 'E20180620191559504983', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('512', '10002', '20180621092523515654', '100.0000', '0.0000', '100.0000', '1529544323', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo_old/index1.php', 'E20180621092502185638', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('513', '10002', '20180621093007102565', '100.0000', '0.0000', '100.0000', '1529544607', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo_old/index1.php', 'E20180621093005314865', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('514', '10002', '20180621093442505555', '100.0000', '0.0000', '100.0000', '1529544882', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo_old/index1.php', 'E20180621093440801779', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('515', '10002', '20180621093613100531', '1.0000', '0.0000', '1.0000', '1529544973', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo_old/index1.php', 'E20180621093604585925', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('516', '10002', '20180622104452521019', '0.0100', '0.0001', '0.0099', '1529635492', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'Swzfbank', '思维支付网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062210444920956', '0', '10887', 'c1c4f8ae34a86f217b7e791c6c06187e677bec75', '', '0', '0', 'Swzfbank', '思维支付网银支付', '0', '1234|456', '10887', '0.0000', '0.0000', '231', '215', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('517', '10002', '20180622190230541015', '0.0100', '0.0000', '0.0100', '1529665350', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062219022624773', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('518', '10002', '20180622190236995299', '1.0000', '0.0000', '1.0000', '1529665356', '0', '908', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', 'QQ扫码支付', '0', 'VIP基础服务', 'DlmQqSm', '多来米QQ扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062219022624773', '0', 'B1000017', '24d76f03cd11f7c0798d28a52a2557e2', '', '0', '0', 'DlmQqSm', '多来米（QQ扫码）', '0', '1234|456', 'B1000017', '0.0000', '0.0000', '233', '217', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('519', '10002', '20180625172504485056', '0.0100', '0.0001', '0.0099', '1529918704', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062517250165027', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('520', '10002', '20180625172558541005', '0.0100', '0.0001', '0.0099', '1529918758', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062517255742645', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('521', '10002', '20180625172604995610', '0.0100', '0.0001', '0.0099', '1529918764', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062517260195119', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('522', '10002', '20180625172634974851', '0.0100', '0.0001', '0.0099', '1529918794', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062517263239503', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('523', '10002', '20180625172645535252', '0.0100', '0.0001', '0.0099', '1529918805', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062517263239503', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('524', '10002', '20180625173149539852', '0.0100', '0.0001', '0.0099', '1529919109', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062517314886464', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('525', '10002', '20180625173218509952', '0.0100', '0.0001', '0.0099', '1529919138', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062517321764569', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('526', '10002', '20180625173307519797', '0.0100', '0.0001', '0.0099', '1529919187', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062517330698574', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('527', '10002', '20180625182801491005', '0.0100', '0.0001', '0.0099', '1529922481', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062518275211381', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('528', '10002', '20180625183153571011', '0.0100', '0.0001', '0.0099', '1529922714', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062518314960899', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('529', '10002', '20180625183232485498', '0.0100', '0.0001', '0.0099', '1529922752', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062518323056842', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('530', '10002', '20180628162738975799', '0.0100', '0.0001', '0.0099', '1530174458', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'VIP基础服务', 'KxBank', '开心支付网银', 'http://www.zuyapi.loc/demo/index1.php', 'E2018062816273536295', '0', '285670000001', 'BD4BAB2B56CD496DB8224A00C394FB71', '', '0', '0', 'KxBank', '开心支付网银', '0', '1234|456', '285670000001', '0.0000', '0.0000', '234', '218', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('531', '10002', '20180704103241575549', '0.0100', '0.0001', '0.0099', '1530671561', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Rzfkj', '睿支付银联快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018070410323896695', '0', '100000047', 'WVdtZ1lFMW5UNjNiZEQ3VmVjRGUydz09', '', '0', '0', 'Rzfkj', '睿支付银联快捷', '0', '1234|456', '100000047', '0.0000', '0.0000', '235', '219', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('532', '10002', '20180704105928489856', '0.0100', '0.0001', '0.0099', '1530673168', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Rzfkj', '睿支付银联快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018070410592385418', '0', '100000047', 'WVdtZ1lFMW5UNjNiZEQ3VmVjRGUydz09', '', '0', '0', 'Rzfkj', '睿支付银联快捷', '0', '1234|456', '100000047', '0.0000', '0.0000', '235', '219', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('533', '10002', '20180704105933539854', '0.1000', '0.0008', '0.0992', '1530673173', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Rzfkj', '睿支付银联快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018070410593036724', '0', '100000047', 'WVdtZ1lFMW5UNjNiZEQ3VmVjRGUydz09', '', '0', '0', 'Rzfkj', '睿支付银联快捷', '0', '1234|456', '100000047', '0.0000', '0.0000', '235', '219', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('534', '10002', '20180704172000485248', '0.0100', '0.0001', '0.0100', '1530696000', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018070417195642371', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('535', '10002', '20180704172008565048', '0.0100', '0.0001', '0.0099', '1530696008', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Rzfkj', '睿支付银联快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018070417195642371', '0', '100000047', 'WVdtZ1lFMW5UNjNiZEQ3VmVjRGUydz09', '', '0', '0', 'Rzfkj', '睿支付银联快捷', '0', '1234|456', '100000047', '0.0000', '0.0000', '235', '219', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('536', '10002', '20180710153200489748', '0.0100', '0.0001', '0.0099', '1531207920', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Rzfkj', '睿支付银联快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071015315767428', '0', '100000047', 'WVdtZ1lFMW5UNjNiZEQ3VmVjRGUydz09', '', '0', '0', 'Rzfkj', '睿支付银联快捷', '0', '1234|456', '100000047', '0.0000', '0.0000', '235', '219', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('537', '10002', '20180710190416484950', '0.0100', '0.0001', '0.0099', '1531220656', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071019041340726', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('538', '10002', '20180710191637539997', '100.0000', '0.8000', '99.2000', '1531221397', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071019163229506', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('539', '10002', '20180710191719102101', '100.0000', '0.8000', '99.2000', '1531221439', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071019171616918', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('540', '10002', '20180710191811519953', '100.0000', '0.8000', '99.2000', '1531221491', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071019180870191', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('541', '10002', '20180710191841495010', '100.0000', '0.8000', '99.2000', '1531221521', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071019183725677', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('542', '10002', '20180710194659514899', '100.0000', '0.8000', '99.2000', '1531223219', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071019190192740', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('543', '10002', '20180711104412995154', '100.0000', '0.8000', '99.2000', '1531277052', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071110440716061', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('544', '10002', '20180711114328485398', '0.0100', '0.0001', '0.0099', '1531280608', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071111423649325', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('545', '10002', '20180718162015102504', '0.0100', '0.0001', '0.0099', '1531902015', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071816200910277', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('546', '10002', '20180718162639102485', '0.0100', '0.0001', '0.0099', '1531902399', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'WftWxSm', '威富通微信扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071816200910277', '0', '102545570975', '', '', '0', '0', 'WftWxSm', '威富通支付（微信扫码）', '0', '1234|456', '102545570975', '0.0000', '0.0000', '232', '216', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('547', '10002', '20180719100028995799', '0.0100', '0.0001', '0.0099', '1531965628', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071910002213850', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('548', '10002', '20180719100136484897', '0.0100', '0.0001', '0.0099', '1531965696', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071910002213850', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('549', '10002', '20180719103208569848', '0.0100', '0.0001', '0.0099', '1531967528', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071910002213850', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('550', '10002', '20180719103222545510', '0.0100', '0.0001', '0.0099', '1531967542', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071910002213850', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('551', '10002', '20180719103515524848', '0.0100', '0.0001', '0.0099', '1531967716', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071910351444571', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('552', '10002', '20180719103526101495', '0.0100', '0.0001', '0.0099', '1531967726', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071910352438174', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('553', '10002', '20180719104502101975', '0.0100', '0.0001', '0.0099', '1531968302', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071910450050451', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('554', '10002', '20180719104726101495', '0.0100', '0.0001', '0.0099', '1531968446', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018071910472394935', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('555', '10002', '20180723185242979710', '0.0100', '0.0001', '0.0099', '1532343162', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'MqyWxSm', '免签约微信', 'http://www.zuyapi.loc/demo/index1.php', 'E2018072318504995632', '0', '3576974449', '10191', 'b0b6caec665e71c7b45a272fa1ec2a65', '0', '0', 'MqyWxSm', '免签约（微信扫码）', '0', '1234|456', '3576974449', '0.0000', '0.0000', '238', '221', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('556', '10002', '20180723185532525057', '0.0100', '0.0001', '0.0099', '1532343332', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'MqyWxSm', '免签约微信', 'http://www.zuyapi.loc/demo/index1.php', 'E2018072318552932230', '0', '3576974449', '10191', 'b0b6caec665e71c7b45a272fa1ec2a65', '0', '0', 'MqyWxSm', '免签约（微信扫码）', '0', '1234|456', '3576974449', '0.0000', '0.0000', '238', '221', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('557', '10002', '20180723185835981005', '0.0100', '0.0001', '0.0099', '1532343515', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'MqyWxSm', '免签约微信', 'http://www.zuyapi.loc/demo/index1.php', 'E2018072318583362380', '0', '10191', 'b0b6caec665e71c7b45a272fa1ec2a65', '', '0', '0', 'MqyWxSm', '免签约（微信扫码）', '0', '1234|456', '3576974449', '0.0000', '0.0000', '238', '221', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('558', '10002', '20180723190236995710', '0.0100', '0.0001', '0.0099', '1532343756', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'MqyWxSm', '免签约微信', 'http://www.zuyapi.loc/demo/index1.php', 'E2018072319023321780', '0', '10191', 'b0b6caec665e71c7b45a272fa1ec2a65', 'B1', '0', '0', 'MqyWxSm', '免签约（微信扫码）', '0', '1234|456', '3576974449', '0.0000', '0.0000', '238', '221', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('559', '10002', '20180727192903102565', '0.0100', '0.0001', '0.0099', '1532690943', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'GmAliScan', '固码支付宝扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018072719274344417', '0', '', 'HTTPS://QR.ALIPAY.COM/FKX02713M2ZHLUHJL00ECC', '', '0', '0', 'GmAliScan', '固码支付宝扫码', '0', '1234|456', '固码1', '0.0000', '0.0000', '239', '222', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('560', '10002', '20180802194615555110', '0.0100', '0.0000', '0.0100', '1533210375', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219461192683', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('561', '10002', '20180802194805539754', '0.0100', '0.0000', '0.0100', '1533210485', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219480359325', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('562', '10002', '20180802194822549857', '0.0100', '0.0000', '0.0100', '1533210502', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219481989332', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('563', '10002', '20180802194851511015', '0.0100', '0.0000', '0.0100', '1533210531', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219484938756', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('564', '10002', '20180802194904489852', '0.0100', '0.0000', '0.0100', '1533210544', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219490267999', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('565', '10002', '20180802194914975355', '0.0100', '0.0000', '0.0100', '1533210554', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219491156290', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('566', '10002', '20180802194946979952', '0.0100', '0.0000', '0.0100', '1533210586', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219494486176', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('567', '10002', '20180802195016565149', '0.0100', '0.0000', '0.0100', '1533210616', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219501342541', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('568', '10002', '20180802195036999753', '0.0100', '0.0000', '0.0100', '1533210636', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219503369680', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('569', '10002', '20180802195047551005', '0.0100', '0.0000', '0.0100', '1533210647', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219504586953', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('570', '10002', '20180802195650509755', '0.0100', '0.0000', '0.0100', '1533211010', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219564859394', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('571', '10002', '20180802195745579952', '0.0100', '0.0000', '0.0100', '1533211065', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080219574378922', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('572', '10002', '20180802200206101100', '0.0100', '0.0000', '0.0100', '1533211326', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220020455546', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('573', '10002', '20180802200622101569', '0.0100', '0.0000', '0.0100', '1533211582', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220061982240', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('574', '10002', '20180802200732529851', '0.0100', '0.0000', '0.0100', '1533211652', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220073165225', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('575', '10002', '20180802201109100545', '0.0100', '0.0000', '0.0100', '1533211869', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220110627276', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('576', '10002', '20180802201315985110', '0.0100', '0.0000', '0.0100', '1533211995', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220131293636', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('577', '10002', '20180802201449575099', '0.0100', '0.0001', '0.0099', '1533212089', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220144320019', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('578', '10002', '20180802201454102484', '0.0100', '0.0000', '0.0100', '1533212095', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220145214515', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('579', '10002', '20180802201542101509', '0.0100', '0.0000', '0.0100', '1533212142', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220153669208', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('580', '10002', '20180802201950545554', '0.0100', '0.0000', '0.0100', '1533212390', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('581', '10002', '20180802202246545153', '0.0100', '0.0000', '0.0100', '1533212566', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('582', '10002', '20180802202553495057', '0.0100', '0.0000', '0.0100', '1533212753', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('583', '10002', '20180802202830101559', '0.0100', '0.0000', '0.0100', '1533212910', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('584', '10002', '20180802202852529910', '0.0100', '0.0000', '0.0100', '1533212932', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('585', '10002', '20180802202926549748', '0.0100', '0.0000', '0.0100', '1533212966', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('586', '10002', '20180802203050971001', '0.0100', '0.0000', '0.0100', '1533213050', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('587', '10002', '20180802203059511001', '0.0100', '0.0000', '0.0100', '1533213059', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('588', '10002', '20180802203100521011', '0.0100', '0.0000', '0.0100', '1533213061', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('589', '10002', '20180802203218509948', '0.0100', '0.0000', '0.0100', '1533213138', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('590', '10002', '20180802203318101545', '0.0100', '0.0000', '0.0100', '1533213198', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('591', '10002', '20180802203321495498', '0.0100', '0.0000', '0.0100', '1533213201', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('592', '10002', '20180802203323519951', '0.0100', '0.0000', '0.0100', '1533213203', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('593', '10002', '20180802203325531005', '0.0100', '0.0000', '0.0100', '1533213205', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('594', '10002', '20180802203327559750', '0.0100', '0.0000', '0.0100', '1533213207', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('595', '10002', '20180802203328569899', '0.0100', '0.0000', '0.0100', '1533213208', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('596', '10002', '20180802203330975448', '0.0100', '0.0000', '0.0100', '1533213210', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220194877280', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('597', '10002', '20180802203337495649', '0.0100', '0.0000', '0.0100', '1533213217', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220333434178', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('598', '10002', '20180802204350541005', '0.0100', '0.0000', '0.0100', '1533213830', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220434885588', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('599', '10002', '20180802205102545197', '0.0100', '0.0000', '0.0100', '1533214262', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220505998857', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('600', '10002', '20180802205136565651', '0.0100', '0.0000', '0.0100', '1533214296', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220513339572', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('601', '10002', '20180802205237531015', '0.0100', '0.0000', '0.0100', '1533214357', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080220523513749', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('602', '10002', '20180803100704565549', '0.0100', '0.0000', '0.0100', '1533262024', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080310070218654', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('603', '10002', '20180803100712485753', '0.0100', '0.0000', '0.0100', '1533262032', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080310070218654', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('604', '10002', '20180803100818505799', '0.0100', '0.0000', '0.0100', '1533262098', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080310081693103', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('605', '10002', '20180803101048561019', '0.0100', '0.0000', '0.0100', '1533262248', '0', '904', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝手机', '0', 'Vip基础服务', 'DyAliwap', '独依支付（支付宝H5）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080310104789513', '0', 'M000037', '', '', '0', '0', 'DyAliwap', '独依支付（支付宝H5）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '240', '223', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('606', '10002', '20180803141942101100', '0.0100', '0.0001', '0.0099', '1533277182', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'DyBank', '独依支付（网关支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080314194019212', '0', 'M000037', '', '', '0', '0', 'DyBank', '独依支付（网关支付）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '241', '224', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('607', '10002', '20180803142747515510', '0.0100', '0.0001', '0.0099', '1533277667', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'DyBank', '独依支付（网关支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080314274437441', '0', 'M000037', '', '', '0', '0', 'DyBank', '独依支付（网关支付）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '241', '224', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('608', '10002', '20180803181045539848', '0.0100', '0.0001', '0.0099', '1533291045', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'DyBank', '独依支付（网关支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080318103750218', '0', 'M000037', '', '', '0', '0', 'DyBank', '独依支付（网关支付）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '241', '224', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('609', '10002', '20180803182403511005', '0.0100', '0.0001', '0.0099', '1533291843', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'DyBank', '独依支付（网关支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018080318233988892', '0', 'M000037', '', '', '0', '0', 'DyBank', '独依支付（网关支付）', '0', '1234|456', 'M000037', '0.0000', '0.0000', '241', '224', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('610', '10002', '20180814200828995355', '0.0100', '0.0001', '0.0099', '1534248508', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081420081919536', '0', '80000104', '1234567890123456', '100006700000107', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '80000104', '0.0000', '0.0000', '242', '226', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('611', '10002', '20180814200848484857', '0.0100', '0.0001', '0.0099', '1534248528', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081420081919536', '0', '80000104', '1234567890123456', '100006700000107', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '80000104', '0.0000', '0.0000', '242', '226', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('612', '10002', '20180814201119555353', '0.0100', '0.0001', '0.0099', '1534248679', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081420081919536', '0', '80000104', '1234567890123456', '100006700000107', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '80000104', '0.0000', '0.0000', '242', '226', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('613', '10002', '20180814201142101985', '0.0100', '0.0001', '0.0099', '1534248702', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081420081919536', '0', '80000104', '1234567890123456', '100006700000107', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '80000104', '0.0000', '0.0000', '242', '226', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('614', '10002', '20180814201251515710', '0.0100', '0.0001', '0.0099', '1534248771', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081420081919536', '0', '80000104', '1234567890123456', '100006700000107', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '80000104', '0.0000', '0.0000', '242', '226', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('615', '10002', '20180814201303102569', '0.0100', '0.0001', '0.0099', '1534248783', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081420081919536', '0', '80000104', '1234567890123456', '100006700000107', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '80000104', '0.0000', '0.0000', '242', '226', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('616', '10002', '20180814201558101555', '0.0100', '0.0001', '0.0099', '1534248958', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081420155594624', '0', '80000104', '1234567890123456', '100006700000107', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '80000104', '0.0000', '0.0000', '242', '226', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('617', '10002', '20180814201627989854', '0.0100', '0.0001', '0.0099', '1534248987', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081420155594624', '0', '80000104', '1234567890123456', '100006700000107', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '80000104', '0.0000', '0.0000', '242', '226', '0', '11', '0');
INSERT INTO `pay_order` VALUES ('618', '10002', '20180816192727102574', '0.0100', '0.0001', '0.0099', '1534418847', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081619272359312', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('619', '10002', '20180816192802505354', '0.0100', '0.0001', '0.0099', '1534418882', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081619275916616', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('620', '10002', '20180816193153575357', '0.0100', '0.0001', '0.0099', '1534419113', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081619314918747', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('621', '10002', '20180816193551559748', '0.0100', '0.0001', '0.0099', '1534419351', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081619354854412', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('622', '10002', '20180816193734101985', '0.0100', '0.0001', '0.0099', '1534419454', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081619373034046', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('623', '10002', '20180816193745575456', '1.0000', '0.0080', '0.9920', '1534419465', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081619374161987', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('624', '10002', '20180816194011981011', '100.0000', '0.8000', '99.2000', '1534419612', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081619390371995', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('625', '10002', '20180818182801499751', '1.0000', '0.0100', '0.9900', '1534588081', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'GmAliScan', '固码支付宝扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818275946771', '0', '', 'HTTPS://QR.ALIPAY.COM/FKX02713M2ZHLUHJL00ECC', '', '0', '0', 'GmAliScan', '固码支付宝扫码', '0', '1234|456', '固码1', '0.0000', '0.0000', '239', '222', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('626', '10002', '20180818184746504955', '1.0000', '0.0100', '0.9900', '1534589266', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'GmAliScan', '固码支付宝扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818474141841', '0', '', 'HTTPS://QR.ALIPAY.COM/FKX02713M2ZHLUHJL00ECC', '', '0', '0', 'GmAliScan', '固码支付宝扫码', '0', '1234|456', '固码1', '0.0000', '0.0000', '239', '222', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('627', '10002', '20180818185424489752', '1.0000', '0.0000', '1.0000', '1534589664', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818542240289', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('628', '10002', '20180818185803985249', '1.0000', '0.0000', '1.0000', '1534589883', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818575997690', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('629', '10002', '20180818185808485510', '1.0000', '0.0000', '1.0000', '1534589888', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818580518536', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('630', '10002', '20180818185813535510', '1.0000', '0.0000', '1.0000', '1534589893', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818581168746', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('631', '10002', '20180818185817571015', '1.0000', '0.0000', '1.0000', '1534589897', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818581550259', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('632', '10002', '20180818185822101494', '1.0000', '0.0000', '1.0000', '1534589902', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818581941868', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('633', '10002', '20180818185827511014', '1.0000', '0.0000', '1.0000', '1534589907', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Gtzfkj', '国通支付快捷', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818582359614', '0', '152773671732458', '86964121f3hfe4fd9bba395df10f8591ca', '', '0', '0', 'Gtzfkj', '国通支付快捷', '0', '1234|456', '152773671732458', '0.0000', '0.0000', '237', '220', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('634', '10002', '20180818185832565053', '1.0000', '0.0000', '1.0000', '1534589912', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818582929360', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('635', '10002', '20180818185906979899', '1.0000', '0.0080', '0.9920', '1534589946', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818590465541', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('636', '10002', '20180818185911102975', '1.0000', '0.0080', '0.9920', '1534589951', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'KmcBank', '凯美晨网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018081818590948229', '0', '88000074', 'gmr2uy4mr76hak7f', '100014200000001', '0', '0', 'KmcBank', '凯美晨网关支付', '0', '1234|456', '88000074', '0.0000', '0.0000', '242', '226', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('637', '10002', '20180821180140525797', '1.0000', '0.0050', '0.9950', '1534845700', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HeyWxSm', 'Hey（微信扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082118012818330', '0', '80086000602', '5Udh82Zunuf6528i9ko5B76A3q448Spum14S404r03PSi131slH837V3xtgt', '', '0', '0', 'HeyWxSm', 'Hey（微信扫码）', '0', '1234|456', '80086000602', '0.0000', '0.0000', '243', '227', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('638', '10002', '20180821180408564856', '1.0000', '0.0100', '0.9900', '1534845848', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'GmAliScan', '固码支付宝扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082118040455634', '0', '', 'HTTPS://QR.ALIPAY.COM/FKX02713M2ZHLUHJL00ECC', '', '0', '0', 'GmAliScan', '固码支付宝扫码', '0', '1234|456', '固码1', '0.0000', '0.0000', '239', '222', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('639', '10002', '20180821180413100489', '1.0000', '0.0050', '0.9950', '1534845853', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HeyWxSm', 'Hey（微信扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082118040918783', '0', '80086000602', '5Udh82Zunuf6528i9ko5B76A3q448Spum14S404r03PSi131slH837V3xtgt', '', '0', '0', 'HeyWxSm', 'Hey（微信扫码）', '0', '1234|456', '80086000602', '0.0000', '0.0000', '243', '227', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('640', '10002', '20180821180456565456', '1.0000', '0.0050', '0.9950', '1534845896', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HeyWxSm', 'Hey（微信扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082118045255648', '0', '80086000602', '5Udh82Zunuf6528i9ko5B76A3q448Spum14S404r03PSi131slH837V3xtgt', '', '0', '0', 'HeyWxSm', 'Hey（微信扫码）', '0', '1234|456', '80086000602', '0.0000', '0.0000', '243', '227', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('641', '10002', '20180821193825491001', '1.0000', '0.0050', '0.9950', '1534851505', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'TonglianWxSm', '通联（微信扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082119381696794', '0', '990440153996000', '43df939f1e7f5c6909b3f4b63f893994', '00000000', '0', '0', 'TonglianWxSm', '通联（微信扫码）', '0', '1234|456', '990440153996000', '0.0000', '0.0000', '244', '228', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('642', '10002', '20180821193948524954', '1.0000', '0.0050', '0.9950', '1534851588', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'TonglianWxSm', '通联（微信扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082119394241876', '0', '990581007426001', 'allinpay888', '00000051', '0', '0', 'TonglianWxSm', '通联（微信扫码）', '0', '1234|456', '990581007426001', '0.0000', '0.0000', '244', '228', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('643', '10002', '20180821194020525398', '1.0000', '0.0050', '0.9950', '1534851620', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'TonglianWxSm', '通联（微信扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082119401352684', '0', '990581007426001', 'allinpay888', '00000051', '0', '0', 'TonglianWxSm', '通联（微信扫码）', '0', '1234|456', '990581007426001', '0.0000', '0.0000', '244', '228', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('644', '10002', '20180821194102101991', '1.0000', '0.0050', '0.9950', '1534851662', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'TonglianWxSm', '通联（微信扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082119405945043', '0', '990581007426001', 'allinpay888', '00000051', '0', '0', 'TonglianWxSm', '通联（微信扫码）', '0', '1234|456', '990581007426001', '0.0000', '0.0000', '244', '228', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('645', '10002', '20180821194306975199', '1.0000', '0.0050', '0.9950', '1534851786', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'TonglianWxSm', '通联（微信扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082119430185069', '0', '990581007426001', 'allinpay888', '00000051', '0', '0', 'TonglianWxSm', '通联（微信扫码）', '0', '1234|456', '990581007426001', '0.0000', '0.0000', '244', '228', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('646', '10002', '20180821194347519997', '1.0000', '0.0050', '0.9950', '1534851827', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'TonglianWxSm', '通联（微信扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082119434413381', '0', '990581007426001', 'allinpay888', '00000051', '0', '0', 'TonglianWxSm', '通联（微信扫码）', '0', '1234|456', '990581007426001', '0.0000', '0.0000', '244', '228', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('647', '10002', '20180821194354971015', '1.0000', '0.0050', '0.9950', '1534851834', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'TonglianWxSm', '通联（微信扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082119434413381', '0', '990581007426001', 'allinpay888', '00000051', '0', '0', 'TonglianWxSm', '通联（微信扫码）', '0', '1234|456', '990581007426001', '0.0000', '0.0000', '244', '228', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('648', '10002', '20180824201036995757', '1.0000', '0.0080', '0.9920', '1535112636', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'XbpBank', '星宝-网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420102713724', '0', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '0', '0', 'XbpBank', '星宝-网关支付', '0', '1234|456', '20000046', '0.0000', '0.0000', '246', '229', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('649', '10002', '20180824201337495249', '1.0000', '0.0080', '0.9920', '1535112817', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'XbpBank', '星宝-网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420133327987', '0', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '0', '0', 'XbpBank', '星宝-网关支付', '0', '1234|456', '20000046', '0.0000', '0.0000', '246', '229', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('650', '10002', '20180824201552565310', '1.0000', '0.0080', '0.9920', '1535112952', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'XbpBank', '星宝-网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420154796248', '0', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '0', '0', 'XbpBank', '星宝-网关支付', '0', '1234|456', '20000046', '0.0000', '0.0000', '245', '229', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('651', '10002', '20180824201621535710', '1.0000', '0.0080', '0.9920', '1535112981', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'XbpBank', '星宝-网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420154796248', '0', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '0', '0', 'XbpBank', '星宝-网关支付', '0', '1234|456', '20000046', '0.0000', '0.0000', '246', '229', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('652', '10002', '20180824201647102499', '1.0000', '0.0080', '0.9920', '1535113007', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'XbpBank', '星宝-网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420164353143', '0', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '0', '0', 'XbpBank', '星宝-网关支付', '0', '1234|456', '20000046', '0.0000', '0.0000', '246', '229', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('653', '10002', '20180824201716994854', '1.0000', '0.0080', '0.9920', '1535113036', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'XbpBank', '星宝-网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420171248394', '0', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '0', '0', 'XbpBank', '星宝-网关支付', '0', '1234|456', '20000046', '0.0000', '0.0000', '246', '229', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('654', '10002', '20180824202610505353', '1.0000', '0.0080', '0.9920', '1535113570', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'XbpBank', '星宝-网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420260639685', '0', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '0', '0', 'XbpBank', '星宝-网关支付', '0', '1234|456', '20000046', '0.0000', '0.0000', '245', '229', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('655', '10002', '20180824203204525054', '1.0000', '0.0080', '0.9920', '1535113924', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'XbpBank', '星宝-网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420315972152', '0', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '0', '0', 'XbpBank', '星宝-网关支付', '0', '1234|456', '20000046', '0.0000', '0.0000', '246', '229', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('656', '10002', '20180824203224569855', '1.0000', '0.0080', '0.9920', '1535113944', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'XbpBank', '星宝-网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420322150827', '0', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '0', '0', 'XbpBank', '星宝-网关支付', '0', '1234|456', '20000046', '0.0000', '0.0000', '246', '229', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('657', '10002', '20180824205801574999', '1.0000', '0.0000', '1.0000', '1535115481', '0', '912', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '银联扫码', '0', 'Vip基础服务', 'HeyYlSm', 'Hey（银联扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420575725383', '0', '80086000602', '5Udh82Zunuf6528i9ko5B76A3q448Spum14S404r03PSi131slH837V3xtgt', '', '0', '0', 'HeyYlSm', 'Hey（银联扫码）', '0', '1234|456', '80086000602', '0.0000', '0.0000', '247', '230', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('658', '10002', '20180824205846545252', '1.0000', '0.0080', '0.9920', '1535115526', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'XbpBank', '星宝-网关支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082420584133529', '0', '20000046', '32a3e16c7a9e4933a14259e65fbdaea9', '', '0', '0', 'XbpBank', '星宝-网关支付', '0', '1234|456', '20000046', '0.0000', '0.0000', '245', '229', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('659', '10002', '20180828171123984854', '1.0000', '0.0050', '0.9950', '1535447483', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HaixiaWxSm', '海峡银行（微信扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817103553544', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaWxSm', '海峡银行（微信扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '248', '231', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('660', '10002', '20180828171308524856', '1.0000', '0.0050', '0.9950', '1535447588', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HaixiaWxSm', '海峡银行（微信扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817130425595', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaWxSm', '海峡银行（微信扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '248', '231', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('661', '10002', '20180828171632485356', '1.0000', '0.0050', '0.9950', '1535447792', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HaixiaWxSm', '海峡银行（微信扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817162636584', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaWxSm', '海峡银行（微信扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '248', '231', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('662', '10002', '20180828171735102100', '1.0000', '0.0050', '0.9950', '1535447855', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HaixiaWxSm', '海峡银行（微信扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817173274237', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaWxSm', '海峡银行（微信扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '248', '231', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('663', '10002', '20180828171744564955', '1.0000', '0.0050', '0.9950', '1535447864', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HaixiaWxSm', '海峡银行（微信扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817174031371', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaWxSm', '海峡银行（微信扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '248', '231', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('664', '10002', '20180828171840485110', '1.0000', '0.0050', '0.9950', '1535447920', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HaixiaWxSm', '海峡银行（微信扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817183582581', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaWxSm', '海峡银行（微信扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '248', '231', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('665', '10002', '20180828171855102529', '1.0000', '0.0050', '0.9950', '1535447935', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HaixiaWxSm', '海峡银行（微信扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817185266192', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaWxSm', '海峡银行（微信扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '248', '231', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('666', '10002', '20180828173225575110', '1.0000', '0.0000', '1.0000', '1535448745', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Aliscan', '支付宝扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817322298003', '0', '', '', '', '0', '0', 'Aliscan', '支付宝官方扫码', '0', '1234|456', '支付宝扫码', '0.0000', '0.0000', '220', '201', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('667', '10002', '20180828173230101529', '1.0000', '0.0050', '0.9950', '1535448750', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HaixiaWxSm', '海峡银行（微信扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817322720810', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaWxSm', '海峡银行（微信扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '248', '231', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('668', '10002', '20180828173240565552', '1.0000', '0.0050', '0.9950', '1535448760', '0', '902', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '微信扫码支付', '0', 'Vip基础服务', 'HaixiaWxSm', '海峡银行（微信扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817323697256', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaWxSm', '海峡银行（微信扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '248', '231', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('669', '10002', '20180828173314975249', '1.0000', '0.0000', '1.0000', '1535448794', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Aliscan', '支付宝扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817330811999', '0', '', '', '', '0', '0', 'Aliscan', '支付宝官方扫码', '0', '1234|456', '支付宝扫码', '0.0000', '0.0000', '220', '201', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('670', '10002', '20180828173508991001', '1.0000', '0.0000', '1.0000', '1535448908', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Aliscan', '支付宝扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817350535922', '0', '', '', '', '0', '0', 'Aliscan', '支付宝官方扫码', '0', '1234|456', '支付宝扫码', '0.0000', '0.0000', '220', '201', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('671', '10002', '20180828173548525152', '1.0000', '0.0000', '1.0000', '1535448948', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Aliscan', '支付宝扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817351194852', '0', '', '', '', '0', '0', 'Aliscan', '支付宝官方扫码', '0', '1234|456', '支付宝扫码', '0.0000', '0.0000', '220', '201', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('672', '10002', '20180828173607554955', '1.0000', '0.0000', '1.0000', '1535448967', '0', null, 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', null, '0', 'Vip基础服务', 'Aliscan', '支付宝扫码', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817360325685', '0', '', '', '', '0', '0', 'Aliscan', '支付宝官方扫码', '0', '1234|456', '支付宝扫码', '0.0000', '0.0000', '220', '201', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('673', '10002', '20180828173647102515', '1.0000', '0.0100', '0.9900', '1535449007', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817364499843', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '249', '232', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('674', '10002', '20180828173729575210', '1.0000', '0.0100', '0.9900', '1535449049', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817372556307', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '249', '232', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('675', '10002', '20180828173835985051', '1.0000', '0.0100', '0.9900', '1535449115', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817383156087', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '249', '232', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('676', '10002', '20180828174244525049', '1.0000', '0.0100', '0.9900', '1535449364', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817424035010', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '249', '232', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('677', '10002', '20180828174314509852', '1.0000', '0.0100', '0.9900', '1535449394', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018082817431144513', '0', '196', 'c0eeb80b02fec0d51372233852d92d0e', '', '0', '0', 'HaixiaAliSm', '海峡银行（支付宝扫码支付）', '0', '1234|456', '196', '0.0000', '0.0000', '249', '232', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('678', '10002', '20180831131104564910', '1.0000', '0.0080', '0.9920', '1535692264', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'ShouBeiBank', '收呗网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018083113110190246', '0', 'apitest', '91dd20e362dc423cae5baa7a4ec8b996', '', '0', '0', 'ShouBeiBank', '收呗网银支付', '0', '1234|456', 'apitest', '0.0000', '0.0000', '250', '233', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('679', '10002', '20180831131608565254', '1.0000', '0.0080', '0.9920', '1535692568', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'ShouBeiBank', '收呗网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018083113160170661', '0', 'apitest', '91dd20e362dc423cae5baa7a4ec8b996', '', '0', '0', 'ShouBeiBank', '收呗网银支付', '0', '1234|456', 'apitest', '0.0000', '0.0000', '250', '233', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('680', '10002', '20180831175816564910', '1.0000', '0.0080', '0.9920', '1535709496', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'ShouBeiBank', '收呗网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018083117581110634', '0', 'apitest', '91dd20e362dc423cae5baa7a4ec8b996', '', '0', '0', 'ShouBeiBank', '收呗网银支付', '0', '1234|456', 'apitest', '0.0000', '0.0000', '250', '233', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('681', '10002', '20180901105450975256', '1.0000', '0.0100', '0.9900', '1535770490', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'SkmAliSm', '收款码（支付宝扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018090110543942198', '0', '11201808311511025', '', '', '0', '0', 'SkmAliSm', '收款码（支付宝扫码）', '0', '1234|456', '11201808311511025', '0.0000', '0.0000', '251', '234', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('682', '10002', '20180901105513495610', '1.0000', '0.0100', '0.9900', '1535770513', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'SkmAliSm', '收款码（支付宝扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018090110550860825', '0', '11201808311511025', '', '', '0', '0', 'SkmAliSm', '收款码（支付宝扫码）', '0', '1234|456', '11201808311511025', '0.0000', '0.0000', '251', '234', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('683', '10002', '20180901105633499850', '1.0000', '0.0100', '0.9900', '1535770593', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'SkmAliSm', '收款码（支付宝扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018090110563147479', '0', '11201808311511025', '', '', '0', '0', 'SkmAliSm', '收款码（支付宝扫码）', '0', '1234|456', '11201808311511025', '0.0000', '0.0000', '251', '234', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('684', '10002', '20180901105659985097', '1.0000', '0.0100', '0.9900', '1535770619', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'SkmAliSm', '收款码（支付宝扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018090110565516789', '0', '11201808311511025', '', '', '0', '0', 'SkmAliSm', '收款码（支付宝扫码）', '0', '1234|456', '11201808311511025', '0.0000', '0.0000', '251', '234', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('685', '10002', '20180901105730975410', '1.0000', '0.0100', '0.9900', '1535770650', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'SkmAliSm', '收款码（支付宝扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018090110572837023', '0', '11201808311511025', '', '', '0', '0', 'SkmAliSm', '收款码（支付宝扫码）', '0', '1234|456', '11201808311511025', '0.0000', '0.0000', '251', '234', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('686', '10002', '20180901105951555250', '1.0000', '0.0100', '0.9900', '1535770791', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'SkmAliSm', '收款码（支付宝扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018090110594797717', '0', '11201808311511025', '', '', '0', '0', 'SkmAliSm', '收款码（支付宝扫码）', '0', '1234|456', '11201808311511025', '0.0000', '0.0000', '251', '234', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('687', '10002', '20180901110002505656', '1.0000', '0.0100', '0.9900', '1535770802', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'SkmAliSm', '收款码（支付宝扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018090110595977137', '0', '11201808311511025', '', '', '0', '0', 'SkmAliSm', '收款码（支付宝扫码）', '0', '1234|456', '11201808311511025', '0.0000', '0.0000', '251', '234', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('688', '10002', '20180901110104485050', '0.0100', '0.0001', '0.0099', '1535770864', '0', '903', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '支付宝扫码支付', '0', 'Vip基础服务', 'SkmAliSm', '收款码（支付宝扫码）', 'http://www.zuyapi.loc/demo/index1.php', 'E2018090111010229967', '0', '11201808311511025', '', '', '0', '0', 'SkmAliSm', '收款码（支付宝扫码）', '0', '1234|456', '11201808311511025', '0.0000', '0.0000', '251', '234', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('690', '10002', '20180914180122501005', '0.0100', '0.0001', '0.0099', '1536919282', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418003896734', '0', '001027', 'MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAL+R6ixBbZMAU/I/kirFByPI12DHMrmRA9xGaDS+tCyVKIhOI1G6eqyEp8tZ8YzoB7RpPgULABkd233bV1UFZoicW1/sfmV0CHxWsIKi3kOKrpI80IfturvP59jZMpV3UBHfAfguiWWAzSbwFeCBTjz8AVls4hW+r5VmH8SYs5IPAgMBAAECgYEAuqaC0SfWiTnykL9bvQxHjpgrMYIkbCVc64w2D94XUrDp0xS+2OymhdyiWEGEVlPk3eUEpok3SUGMEC5cAtzGLnjG+XhVuOnmKFtJ1C5P3F5swLWPzpr32j8gXLLB7rYp61Vilca1NcrHAUPOa4jtYYsvAZBMS+1FvVHoVisXncECQQDlmr+Wf3DcfkyQUbjAo86ZkBBcb4IVcG/KWh4BwxooYHmYA518PSDO9+NE4xL3DWOfpe0zM1zggtEAXHQSm4vxAkEA1ZfP', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('691', '10002', '20180914180156525456', '0.0100', '0.0001', '0.0099', '1536919316', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418003896734', '0', '001027', 'MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAL+R6ixBbZMAU/I/kirFByPI12DHMrmRA9xGaDS+tCyVKIhOI1G6eqyEp8tZ8YzoB7RpPgULABkd233bV1UFZoicW1/sfmV0CHxWsIKi3kOKrpI80IfturvP59jZMpV3UBHfAfguiWWAzSbwFeCBTjz8AVls4hW+r5VmH8SYs5IPAgMBAAECgYEAuqaC0SfWiTnykL9bvQxHjpgrMYIkbCVc64w2D94XUrDp0xS+2OymhdyiWEGEVlPk3eUEpok3SUGMEC5cAtzGLnjG+XhVuOnmKFtJ1C5P3F5swLWPzpr32j8gXLLB7rYp61Vilca1NcrHAUPOa4jtYYsvAZBMS+1FvVHoVisXncECQQDlmr+Wf3DcfkyQUbjAo86ZkBBcb4IVcG/KWh4BwxooYHmYA518PSDO9+NE4xL3DWOfpe0zM1zggtEAXHQSm4vxAkEA1ZfP', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('692', '10002', '20180914180323989753', '0.0100', '0.0001', '0.0099', '1536919403', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418032190980', '0', '001027', 'MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAL+R6ixBbZMAU/I/kirFByPI12DHMrmRA9xGaDS+tCyVKIhOI1G6eqyEp8tZ8YzoB7RpPgULABkd233bV1UFZoicW1/sfmV0CHxWsIKi3kOKrpI80IfturvP59jZMpV3UBHfAfguiWWAzSbwFeCBTjz8AVls4hW+r5VmH8SYs5IPAgMBAAECgYEAuqaC0SfWiTnykL9bvQxHjpgrMYIkbCVc64w2D94XUrDp0xS+2OymhdyiWEGEVlPk3eUEpok3SUGMEC5cAtzGLnjG+XhVuOnmKFtJ1C5P3F5swLWPzpr32j8gXLLB7rYp61Vilca1NcrHAUPOa4jtYYsvAZBMS+1FvVHoVisXncECQQDlmr+Wf3DcfkyQUbjAo86ZkBBcb4IVcG/KWh4BwxooYHmYA518PSDO9+NE4xL3DWOfpe0zM1zggtEAXHQSm4vxAkEA1ZfP', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('693', '10002', '20180914180341100555', '0.0100', '0.0001', '0.0099', '1536919421', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418033988728', '0', '001027', 'MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAL+R6ixBbZMAU/I/kirFByPI12DHMrmRA9xGaDS+tCyVKIhOI1G6eqyEp8tZ8YzoB7RpPgULABkd233bV1UFZoicW1/sfmV0CHxWsIKi3kOKrpI80IfturvP59jZMpV3UBHfAfguiWWAzSbwFeCBTjz8AVls4hW+r5VmH8SYs5IPAgMBAAECgYEAuqaC0SfWiTnykL9bvQxHjpgrMYIkbCVc64w2D94XUrDp0xS+2OymhdyiWEGEVlPk3eUEpok3SUGMEC5cAtzGLnjG+XhVuOnmKFtJ1C5P3F5swLWPzpr32j8gXLLB7rYp61Vilca1NcrHAUPOa4jtYYsvAZBMS+1FvVHoVisXncECQQDlmr+Wf3DcfkyQUbjAo86ZkBBcb4IVcG/KWh4BwxooYHmYA518PSDO9+NE4xL3DWOfpe0zM1zggtEAXHQSm4vxAkEA1ZfP', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('694', '10002', '20180914180401491005', '0.0100', '0.0001', '0.0099', '1536919441', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAL+R6ixBbZMAU/I/kirFByPI12DHMrmRA9xGaDS+tCyVKIhOI1G6eqyEp8tZ8YzoB7RpPgULABkd233bV1UFZoicW1/sfmV0CHxWsIKi3kOKrpI80IfturvP59jZMpV3UBHfAfguiWWAzSbwFeCBTjz8AVls4hW+r5VmH8SYs5IPAgMBAAECgYEAuqaC0SfWiTnykL9bvQxHjpgrMYIkbCVc64w2D94XUrDp0xS+2OymhdyiWEGEVlPk3eUEpok3SUGMEC5cAtzGLnjG+XhVuOnmKFtJ1C5P3F5swLWPzpr32j8gXLLB7rYp61Vilca1NcrHAUPOa4jtYYsvAZBMS+1FvVHoVisXncECQQDlmr+Wf3DcfkyQUbjAo86ZkBBcb4IVcG/KWh4BwxooYHmYA518PSDO9+NE4xL3DWOfpe0zM1zggtEAXHQSm4vxAkEA1ZfP', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('695', '10002', '20180914180411989949', '0.0100', '0.0001', '0.0099', '1536919451', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAL+R6ixBbZMAU/I/kirFByPI12DHMrmRA9xGaDS+tCyVKIhOI1G6eqyEp8tZ8YzoB7RpPgULABkd233bV1UFZoicW1/sfmV0CHxWsIKi3kOKrpI80IfturvP59jZMpV3UBHfAfguiWWAzSbwFeCBTjz8AVls4hW+r5VmH8SYs5IPAgMBAAECgYEAuqaC0SfWiTnykL9bvQxHjpgrMYIkbCVc64w2D94XUrDp0xS+2OymhdyiWEGEVlPk3eUEpok3SUGMEC5cAtzGLnjG+XhVuOnmKFtJ1C5P3F5swLWPzpr32j8gXLLB7rYp61Vilca1NcrHAUPOa4jtYYsvAZBMS+1FvVHoVisXncECQQDlmr+Wf3DcfkyQUbjAo86ZkBBcb4IVcG/KWh4BwxooYHmYA518PSDO9+NE4xL3DWOfpe0zM1zggtEAXHQSm4vxAkEA1ZfP', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('696', '10002', '20180914180655102555', '0.0100', '0.0001', '0.0099', '1536919615', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICXgIBAAKBgQC/keosQW2TAFPyP5IqxQcjyNdgxzK5kQPcRmg0vrQslSiITiNRunqshKfLWfGM6Ae0aT4FCwAZHdt921dVBWaInFtf7H5ldAh8VrCCot5Diq6SPNCH7bq7z+fY2TKVd1AR3wH4LollgM0m8BXggU48/AFZbOIVvq+VZh/EmLOSDwIDAQABAoGBALqmgtEn1ok58pC/W70MR46YKzGCJGwlXOuMNg/eF1Kw6dMUvtjspoXcolhBhFZT5N3lBKaJN0lBjBAuXALcxi54xvl4Vbjp5ihbSdQuT9xebMC1j86a99o/IFyywe62KetVYpXGtTXKxwFDzmuI7WGLLwGQTEvtRb1R6FYrF53BAkEA5Zq/ln9w3H5MkFG4wKPOmZAQXG+CFXBvyloeAcMaKGB5mAOdfD0gzvfjROMS9w1jn6XtMzNc4ILRAFx0EpuL8QJBANWXz+1gYXUzf/XEAXEfRaYagnoB5KVjZblzGAJ1', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('697', '10002', '20180914180711102515', '0.0100', '0.0001', '0.0099', '1536919631', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICXgIBAAKBgQC/keosQW2TAFPyP5IqxQcjyNdgxzK5kQPcRmg0vrQslSiITiNRunqshKfLWfGM6Ae0aT4FCwAZHdt921dVBWaInFtf7H5ldAh8VrCCot5Diq6SPNCH7bq7z+fY2TKVd1AR3wH4LollgM0m8BXggU48/AFZbOIVvq+VZh/EmLOSDwIDAQABAoGBALqmgtEn1ok58pC/W70MR46YKzGCJGwlXOuMNg/eF1Kw6dMUvtjspoXcolhBhFZT5N3lBKaJN0lBjBAuXALcxi54xvl4Vbjp5ihbSdQuT9xebMC1j86a99o/IFyywe62KetVYpXGtTXKxwFDzmuI7WGLLwGQTEvtRb1R6FYrF53BAkEA5Zq/ln9w3H5MkFG4wKPOmZAQXG+CFXBvyloeAcMaKGB5mAOdfD0gzvfjROMS9w1jn6XtMzNc4ILRAFx0EpuL8QJBANWXz+1gYXUzf/XEAXEfRaYagnoB5KVjZblzGAJ1', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('698', '10002', '20180914180725100535', '0.0100', '0.0001', '0.0099', '1536919645', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICXgIBAAKBgQC/keosQW2TAFPyP5IqxQcjyNdgxzK5kQPcRmg0vrQslSiITiNRunqshKfLWfGM6Ae0aT4FCwAZHdt921dVBWaInFtf7H5ldAh8VrCCot5Diq6SPNCH7bq7z+fY2TKVd1AR3wH4LollgM0m8BXggU48/AFZbOIVvq+VZh/EmLOSDwIDAQABAoGBALqmgtEn1ok58pC/W70MR46YKzGCJGwlXOuMNg/eF1Kw6dMUvtjspoXcolhBhFZT5N3lBKaJN0lBjBAuXALcxi54xvl4Vbjp5ihbSdQuT9xebMC1j86a99o/IFyywe62KetVYpXGtTXKxwFDzmuI7WGLLwGQTEvtRb1R6FYrF53BAkEA5Zq/ln9w3H5MkFG4wKPOmZAQXG+CFXBvyloeAcMaKGB5mAOdfD0gzvfjROMS9w1jn6XtMzNc4ILRAFx0EpuL8QJBANWXz+1gYXUzf/XEAXEfRaYagnoB5KVjZblzGAJ1', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('699', '10002', '20180914180811989955', '0.0100', '0.0001', '0.0099', '1536919691', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICXgIBAAKBgQC/keosQW2TAFPyP5IqxQcjyNdgxzK5kQPcRmg0vrQslSiITiNRunqshKfLWfGM6Ae0aT4FCwAZHdt921dVBWaInFtf7H5ldAh8VrCCot5Diq6SPNCH7bq7z+fY2TKVd1AR3wH4LollgM0m8BXggU48/AFZbOIVvq+VZh/EmLOSDwIDAQABAoGBALqmgtEn1ok58pC/W70MR46YKzGCJGwlXOuMNg/eF1Kw6dMUvtjspoXcolhBhFZT5N3lBKaJN0lBjBAuXALcxi54xvl4Vbjp5ihbSdQuT9xebMC1j86a99o/IFyywe62KetVYpXGtTXKxwFDzmuI7WGLLwGQTEvtRb1R6FYrF53BAkEA5Zq/ln9w3H5MkFG4wKPOmZAQXG+CFXBvyloeAcMaKGB5mAOdfD0gzvfjROMS9w1jn6XtMzNc4ILRAFx0EpuL8QJBANWXz+1gYXUzf/XEAXEfRaYagnoB5KVjZblzGAJ1', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('700', '10002', '20180914180829100519', '0.0100', '0.0001', '0.0099', '1536919709', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICXgIBAAKBgQC/keosQW2TAFPyP5IqxQcjyNdgxzK5kQPcRmg0vrQslSiITiNRunqshKfLWfGM6Ae0aT4FCwAZHdt921dVBWaInFtf7H5ldAh8VrCCot5Diq6SPNCH7bq7z+fY2TKVd1AR3wH4LollgM0m8BXggU48/AFZbOIVvq+VZh/EmLOSDwIDAQABAoGBALqmgtEn1ok58pC/W70MR46YKzGCJGwlXOuMNg/eF1Kw6dMUvtjspoXcolhBhFZT5N3lBKaJN0lBjBAuXALcxi54xvl4Vbjp5ihbSdQuT9xebMC1j86a99o/IFyywe62KetVYpXGtTXKxwFDzmuI7WGLLwGQTEvtRb1R6FYrF53BAkEA5Zq/ln9w3H5MkFG4wKPOmZAQXG+CFXBvyloeAcMaKGB5mAOdfD0gzvfjROMS9w1jn6XtMzNc4ILRAFx0EpuL8QJBANWXz+1gYXUzf/XEAXEfRaYagnoB5KVjZblzGAJ1', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('701', '10002', '20180914180927554948', '0.0100', '0.0001', '0.0099', '1536919767', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICXgIBAAKBgQC/keosQW2TAFPyP5IqxQcjyNdgxzK5kQPcRmg0vrQslSiITiNRunqshKfLWfGM6Ae0aT4FCwAZHdt921dVBWaInFtf7H5ldAh8VrCCot5Diq6SPNCH7bq7z+fY2TKVd1AR3wH4LollgM0m8BXggU48/AFZbOIVvq+VZh/EmLOSDwIDAQABAoGBALqmgtEn1ok58pC/W70MR46YKzGCJGwlXOuMNg/eF1Kw6dMUvtjspoXcolhBhFZT5N3lBKaJN0lBjBAuXALcxi54xvl4Vbjp5ihbSdQuT9xebMC1j86a99o/IFyywe62KetVYpXGtTXKxwFDzmuI7WGLLwGQTEvtRb1R6FYrF53BAkEA5Zq/ln9w3H5MkFG4wKPOmZAQXG+CFXBvyloeAcMaKGB5mAOdfD0gzvfjROMS9w1jn6XtMzNc4ILRAFx0EpuL8QJBANWXz+1gYXUzf/XEAXEfRaYagnoB5KVjZblzGAJ1', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('702', '10002', '20180914180942545252', '0.0100', '0.0001', '0.0099', '1536919782', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICXgIBAAKBgQC/keosQW2TAFPyP5IqxQcjyNdgxzK5kQPcRmg0vrQslSiITiNRunqshKfLWfGM6Ae0aT4FCwAZHdt921dVBWaInFtf7H5ldAh8VrCCot5Diq6SPNCH7bq7z+fY2TKVd1AR3wH4LollgM0m8BXggU48/AFZbOIVvq+VZh/EmLOSDwIDAQABAoGBALqmgtEn1ok58pC/W70MR46YKzGCJGwlXOuMNg/eF1Kw6dMUvtjspoXcolhBhFZT5N3lBKaJN0lBjBAuXALcxi54xvl4Vbjp5ihbSdQuT9xebMC1j86a99o/IFyywe62KetVYpXGtTXKxwFDzmuI7WGLLwGQTEvtRb1R6FYrF53BAkEA5Zq/ln9w3H5MkFG4wKPOmZAQXG+CFXBvyloeAcMaKGB5mAOdfD0gzvfjROMS9w1jn6XtMzNc4ILRAFx0EpuL8QJBANWXz+1gYXUzf/XEAXEfRaYagnoB5KVjZblzGAJ1', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('703', '10002', '20180914181017571019', '0.0100', '0.0001', '0.0099', '1536919817', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICXgIBAAKBgQC/keosQW2TAFPyP5IqxQcjyNdgxzK5kQPcRmg0vrQslSiITiNRunqshKfLWfGM6Ae0aT4FCwAZHdt921dVBWaInFtf7H5ldAh8VrCCot5Diq6SPNCH7bq7z+fY2TKVd1AR3wH4LollgM0m8BXggU48/AFZbOIVvq+VZh/EmLOSDwIDAQABAoGBALqmgtEn1ok58pC/W70MR46YKzGCJGwlXOuMNg/eF1Kw6dMUvtjspoXcolhBhFZT5N3lBKaJN0lBjBAuXALcxi54xvl4Vbjp5ihbSdQuT9xebMC1j86a99o/IFyywe62KetVYpXGtTXKxwFDzmuI7WGLLwGQTEvtRb1R6FYrF53BAkEA5Zq/ln9w3H5MkFG4wKPOmZAQXG+CFXBvyloeAcMaKGB5mAOdfD0gzvfjROMS9w1jn6XtMzNc4ILRAFx0EpuL8QJBANWXz+1gYXUzf/XEAXEfRaYagnoB5KVjZblzGAJ1', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('704', '10002', '20180914181028524853', '0.0100', '0.0001', '0.0099', '1536919828', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418035884822', '0', '001027', 'MIICXgIBAAKBgQC/keosQW2TAFPyP5IqxQcjyNdgxzK5kQPcRmg0vrQslSiITiNRunqshKfLWfGM6Ae0aT4FCwAZHdt921dVBWaInFtf7H5ldAh8VrCCot5Diq6SPNCH7bq7z+fY2TKVd1AR3wH4LollgM0m8BXggU48/AFZbOIVvq+VZh/EmLOSDwIDAQABAoGBALqmgtEn1ok58pC/W70MR46YKzGCJGwlXOuMNg/eF1Kw6dMUvtjspoXcolhBhFZT5N3lBKaJN0lBjBAuXALcxi54xvl4Vbjp5ihbSdQuT9xebMC1j86a99o/IFyywe62KetVYpXGtTXKxwFDzmuI7WGLLwGQTEvtRb1R6FYrF53BAkEA5Zq/ln9w3H5MkFG4wKPOmZAQXG+CFXBvyloeAcMaKGB5mAOdfD0gzvfjROMS9w1jn6XtMzNc4ILRAFx0EpuL8QJBANWXz+1gYXUzf/XEAXEfRaYagnoB5KVjZblzGAJ1', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('705', '10002', '20180914181726549998', '0.0100', '0.0001', '0.0099', '1536920246', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418172230305', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('706', '10002', '20180914181745575157', '0.0100', '0.0001', '0.0099', '1536920265', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418174217047', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('707', '10002', '20180914181828521025', '0.0100', '0.0001', '0.0099', '1536920309', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418174217047', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('708', '10002', '20180914182345504848', '0.0100', '0.0001', '0.0099', '1536920626', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418234357955', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('709', '10002', '20180914182402504898', '0.0100', '0.0001', '0.0099', '1536920642', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418235961171', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('710', '10002', '20180914182419515355', '0.0100', '0.0001', '0.0099', '1536920659', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418241686511', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('711', '10002', '20180914182549100549', '0.0100', '0.0001', '0.0099', '1536920749', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418241686511', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('712', '10002', '20180914182635984851', '0.0100', '0.0001', '0.0099', '1536920795', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418241686511', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('713', '10002', '20180914182655102101', '0.0100', '0.0001', '0.0099', '1536920816', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418241686511', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('714', '10002', '20180914182753571005', '0.0100', '0.0001', '0.0099', '1536920873', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418241686511', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('715', '10002', '20180914182822541005', '0.0100', '0.0001', '0.0099', '1536920902', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418241686511', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('716', '10002', '20180914183006101995', '0.0100', '0.0001', '0.0099', '1536921006', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418241686511', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('717', '10002', '20180914183016565454', '0.0100', '0.0001', '0.0099', '1536921016', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418241686511', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('718', '10002', '20180914183025491015', '0.0100', '0.0001', '0.0099', '1536921025', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418241686511', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('719', '10002', '20180914183053100555', '0.0100', '0.0001', '0.0099', '1536921053', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418305122911', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('720', '10002', '20180914183134545497', '0.0100', '0.0001', '0.0099', '1536921094', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418305122911', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('721', '10002', '20180914183145495397', '0.0100', '0.0001', '0.0099', '1536921105', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418305122911', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('722', '10002', '20180914183202505656', '0.0100', '0.0001', '0.0099', '1536921122', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418305122911', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('723', '10002', '20180914183213100531', '0.0100', '0.0001', '0.0099', '1536921133', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418305122911', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('724', '10002', '20180914183215102499', '0.0100', '0.0001', '0.0099', '1536921135', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418305122911', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('725', '10002', '20180914183621535254', '0.0100', '0.0001', '0.0099', '1536921381', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418305122911', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('726', '10002', '20180914183628994950', '0.0100', '0.0001', '0.0099', '1536921388', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418362546007', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('727', '10002', '20180914183749100995', '1.0000', '0.0080', '0.9920', '1536921469', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418372333876', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('728', '10002', '20180914184003515799', '100.0000', '0.8000', '99.2000', '1536921603', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418395647402', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('729', '10002', '20180914184245534950', '0.0100', '0.0001', '0.0099', '1536921765', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418424299978', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('730', '10002', '20180914184253100991', '1.0000', '0.0080', '0.9920', '1536921773', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091418424763113', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('731', '10002', '20180915160459981005', '0.0100', '0.0001', '0.0099', '1536998699', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091516044864637', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('732', '10002', '20180915204022541005', '0.0100', '0.0001', '0.0099', '1537015222', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091520401884693', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');
INSERT INTO `pay_order` VALUES ('733', '10002', '20180915204030101495', '1.0000', '0.0080', '0.9920', '1537015230', '0', '907', 'http://www.zuyapi.loc/demo/server.php', 'http://www.zuyapi.loc/demo/page.php', '网银支付', '0', 'Vip基础服务', 'BwmBank', 'BWMPAY网银支付', 'http://www.zuyapi.loc/demo/index1.php', 'E2018091520401884693', '0', '001027', '', '13067410260', '0', '0', 'BwmBank', 'BWMPAY网银支付', '0', '1234|456', '001027', '0.0000', '0.0000', '253', '236', '1', '11', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='代付通道表';

-- ----------------------------
-- Records of pay_pay_for_another
-- ----------------------------
INSERT INTO `pay_pay_for_another` VALUES ('11', 'Ans', '爱农T0(承德向友)', '929080095023568', '', '', 'yVKWScFvy6a8UFKjC8BtR4p3UkDw4YHD', '', '', 'http://remit.chinagpay.com/bas/BgTrans', 'http://remit.chinagpay.com/bas/BgTrans', '', '', '1521195102', '0', '0', '0.0000', '0');
INSERT INTO `pay_pay_for_another` VALUES ('12', 'Dwj', '80001爱农', 'OLP800001000001a', '800001', '', 'SwJw1FoE8C1EGA1JSNFxVFpVv', '', '', 'http://103.47.137.51:8092/posm/mercdfreq.tran?olpdat=', 'http://103.47.137.51:8092/posm/mercdfqry.tran?olpdat=', '', '', '1528871539', '0', '0', '0.0000', '0');
INSERT INTO `pay_pay_for_another` VALUES ('13', 'AnsT1', '爱农普通(承德向友)', '929080095023568', '', '', 'yVKWScFvy6a8UFKjC8BtR4p3UkDw4YHD', '', '', 'http://remit.chinagpay.com/bas/BgTrans', 'http://remit.chinagpay.com/bas/BgTrans', '', '', '1521296459', '0', '0', '0.0000', '0');
INSERT INTO `pay_pay_for_another` VALUES ('14', 'Ips', '环迅代付', '207231', '2072310010', '北京朝莱商贸有限公司', 'Mo6HqQtlMv4j9hZwfRck7lVGSd8pG9C75ascLsjgVgw88Yv4v0kVEVpMmFcDESGMpyZuclb4p7HB2oAwXeAk9UYq0RsllfcwTAfpvROpC0jMLn9sJWlg9HMCxhhNpVrk', 'KTYAr4jV', 'x6dwjkThGdMj4TVh075lNwag', 'https://merservice.ips.com.cn/pfas-merws/services/issued?wsdl', 'https://merservice.ips.com.cn/pfas-merws/services/issued?wsdl', '', '', '1524043515', '0', '0', '0.0000', '0');
INSERT INTO `pay_pay_for_another` VALUES ('15', 'IpsTransfer', '易收付', '207231', 'KTYAr4jV', 'x6dwjkThGdMj4TVh075lNwag', 'Mo6HqQtlMv4j9hZwfRck7lVGSd8pG9C75ascLsjgVgw88Yv4v0kVEVpMmFcDESGMpyZuclb4p7HB2oAwXeAk9UYq0RsllfcwTAfpvROpC0jMLn9sJWlg9HMCxhhNpVrk', '2072310010', '', 'https://ebp.ips.com.cn/fpms-access/action/trade/transfer.do', '', '', '', '1524728654', '0', '0', '0.0000', '0');
INSERT INTO `pay_pay_for_another` VALUES ('16', 'Dy', '独依代付', 'M000037', '', '', '', '', '', '', '', '', '', '1533346994', '1', '1', '0.0000', '0');

-- ----------------------------
-- Table structure for pay_platform_report
-- ----------------------------
DROP TABLE IF EXISTS `pay_platform_report`;
CREATE TABLE `pay_platform_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `initial_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '期初余额',
  `income_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '入金金额',
  `pay_wait_checked` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '出金待审核金额',
  `pay_success` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '出金成功金额',
  `pay_fail` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '出金失败金额',
  `income_profit` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '入金利润',
  `pay_profit` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '出金利润',
  `frozen_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '冻结金额',
  `merchant_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '商户实际到账金额',
  `platform_cost` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '平台成本',
  `platform_profit` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '平台利润',
  `end_profit` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '期末余额',
  `current_money` decimal(11,2) NOT NULL DEFAULT '0.00' COMMENT '当前余额',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '生成时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_platform_report
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
) ENGINE=MyISAM AUTO_INCREMENT=913 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_product
-- ----------------------------
INSERT INTO `pay_product` VALUES ('901', '微信公众号', 'WXJSAPI', '0', '2', '1', '1', '0', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('902', '微信扫码支付', 'WXSCAN', '0', '1', '1', '1', '199', '', '0.0050', '0.0070', '0.0040', '0.0060');
INSERT INTO `pay_product` VALUES ('903', '支付宝扫码支付', 'ALISCAN', '0', '3', '1', '1', '0', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('904', '支付宝手机', 'ALIWAP', '0', '4', '1', '1', '202', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('905', 'QQ手机支付', 'QQWAP', '1', '2', '0', '1', '0', '200:7', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('907', '网银支付', 'DBANK', '1', '5', '1', '1', '0', '220:1|226:1', '0.0030', '0.0050', '0.0020', '0.0020');
INSERT INTO `pay_product` VALUES ('908', 'QQ扫码支付', 'QSCAN', '0', '8', '1', '1', '203', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('909', '百度钱包', 'BAIDU', '0', '7', '0', '0', '0', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('910', '京东支付', 'JDPAY', '0', '9', '0', '0', '0', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('911', '快捷支付', 'QUICK', '0', '5', '1', '1', '0', '', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_product` VALUES ('912', '银联扫码', 'YLSCAN', '0', '13', '1', '1', '0', '', '0.0000', '0.0000', '0.0000', '0.0000');

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
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_product_user
-- ----------------------------
INSERT INTO `pay_product_user` VALUES ('46', '2', '907', '0', '1', '236', '');
INSERT INTO `pay_product_user` VALUES ('15', '2', '901', '0', '1', '200', '');
INSERT INTO `pay_product_user` VALUES ('16', '2', '902', '0', '1', '231', '');
INSERT INTO `pay_product_user` VALUES ('17', '2', '903', '0', '1', '234', '');
INSERT INTO `pay_product_user` VALUES ('18', '2', '904', '0', '1', '223', '');
INSERT INTO `pay_product_user` VALUES ('19', '2', '905', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('20', '6', '901', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('21', '6', '902', '0', '1', '207', '');
INSERT INTO `pay_product_user` VALUES ('22', '6', '903', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('23', '6', '904', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('24', '6', '905', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('25', '6', '907', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('26', '180586943', '901', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('27', '180586943', '902', '0', '1', '199', '');
INSERT INTO `pay_product_user` VALUES ('28', '180586943', '903', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('29', '180586943', '904', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('30', '180586943', '905', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('31', '180586943', '907', '0', '1', '209', '');
INSERT INTO `pay_product_user` VALUES ('32', '3', '901', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('33', '3', '902', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('34', '3', '903', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('35', '3', '904', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('36', '3', '905', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('37', '3', '907', '0', '1', '209', '');
INSERT INTO `pay_product_user` VALUES ('38', '4', '901', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('39', '4', '902', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('40', '4', '903', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('41', '4', '904', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('42', '4', '905', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('43', '4', '907', '0', '1', '209', '');
INSERT INTO `pay_product_user` VALUES ('44', '2', '908', '0', '1', '217', '');
INSERT INTO `pay_product_user` VALUES ('45', '2', '911', '0', '0', '0', '');
INSERT INTO `pay_product_user` VALUES ('47', '2', '912', '0', '1', '230', '');

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
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_reconciliation
-- ----------------------------
INSERT INTO `pay_reconciliation` VALUES ('1', '2', '0', '0', '0', '0.0000', '0.0000', '2018-06-03', '1528860656');
INSERT INTO `pay_reconciliation` VALUES ('2', '2', '0', '0', '0', '0.0000', '0.0000', '2018-06-02', '1528860656');
INSERT INTO `pay_reconciliation` VALUES ('3', '2', '0', '0', '0', '0.0000', '0.0000', '2018-06-01', '1528860656');
INSERT INTO `pay_reconciliation` VALUES ('4', '2', '10', '10', '10', '0.1000', '0.0000', '2018-05-31', '1528860656');
INSERT INTO `pay_reconciliation` VALUES ('5', '2', '1', '1', '1', '22.0000', '22.0000', '2018-05-30', '1528860656');
INSERT INTO `pay_reconciliation` VALUES ('6', '2', '0', '0', '0', '0.0000', '0.0000', '2018-05-29', '1528860656');
INSERT INTO `pay_reconciliation` VALUES ('7', '2', '0', '0', '0', '0.0000', '0.0000', '2018-05-28', '1528860656');
INSERT INTO `pay_reconciliation` VALUES ('8', '2', '0', '0', '0', '0.0000', '0.0000', '2018-05-27', '1528860656');
INSERT INTO `pay_reconciliation` VALUES ('9', '2', '0', '0', '0', '0.0000', '0.0000', '2018-05-26', '1528860656');
INSERT INTO `pay_reconciliation` VALUES ('10', '2', '0', '0', '0', '0.0000', '0.0000', '2018-05-25', '1528860656');
INSERT INTO `pay_reconciliation` VALUES ('11', '2', '0', '0', '0', null, null, '2018-06-13', '1528860667');
INSERT INTO `pay_reconciliation` VALUES ('12', '2', '0', '0', '0', null, null, '2018-06-12', '1528860667');
INSERT INTO `pay_reconciliation` VALUES ('13', '2', '0', '0', '0', null, null, '2018-06-11', '1528860667');
INSERT INTO `pay_reconciliation` VALUES ('14', '2', '0', '0', '0', null, null, '2018-06-10', '1528860667');
INSERT INTO `pay_reconciliation` VALUES ('15', '2', '0', '0', '0', '0.0000', '0.0000', '2018-06-09', '1528860667');
INSERT INTO `pay_reconciliation` VALUES ('16', '2', '0', '0', '0', '0.0000', '0.0000', '2018-06-08', '1528860667');
INSERT INTO `pay_reconciliation` VALUES ('17', '2', '0', '0', '0', '0.0000', '0.0000', '2018-06-07', '1528860667');
INSERT INTO `pay_reconciliation` VALUES ('18', '2', '0', '0', '0', '0.0000', '0.0000', '2018-06-06', '1528860667');
INSERT INTO `pay_reconciliation` VALUES ('19', '2', '0', '0', '0', '0.0000', '0.0000', '2018-06-05', '1528860667');
INSERT INTO `pay_reconciliation` VALUES ('20', '2', '0', '0', '0', '0.0000', '0.0000', '2018-06-04', '1528860667');
INSERT INTO `pay_reconciliation` VALUES ('21', '2', '0', '0', '0', '0.0000', '0.0000', '2017-08-27', '1528860681');
INSERT INTO `pay_reconciliation` VALUES ('22', '2', '0', '0', '0', null, null, '2018-05-24', '1528860819');
INSERT INTO `pay_reconciliation` VALUES ('23', '2', '0', '0', '0', null, null, '2018-05-23', '1528860819');
INSERT INTO `pay_reconciliation` VALUES ('24', '2', '0', '0', '0', null, null, '2018-05-22', '1528860819');
INSERT INTO `pay_reconciliation` VALUES ('25', '2', '0', '0', '0', null, null, '2018-05-21', '1528860819');
INSERT INTO `pay_reconciliation` VALUES ('26', '2', '0', '0', '0', null, null, '2018-05-20', '1528860819');
INSERT INTO `pay_reconciliation` VALUES ('27', '2', '0', '0', '0', null, null, '2018-05-19', '1528860819');
INSERT INTO `pay_reconciliation` VALUES ('28', '2', '0', '0', '0', null, null, '2018-05-18', '1528860819');
INSERT INTO `pay_reconciliation` VALUES ('29', '2', '0', '0', '0', null, null, '2018-05-17', '1528860819');
INSERT INTO `pay_reconciliation` VALUES ('30', '2', '0', '0', '0', null, null, '2018-05-16', '1528860819');
INSERT INTO `pay_reconciliation` VALUES ('31', '2', '0', '0', '0', null, null, '2018-05-15', '1528860819');
INSERT INTO `pay_reconciliation` VALUES ('32', '2', '0', '0', '0', null, null, '2018-06-19', '1529374873');
INSERT INTO `pay_reconciliation` VALUES ('33', '2', '0', '0', '0', null, null, '2018-06-18', '1529374873');
INSERT INTO `pay_reconciliation` VALUES ('34', '2', '0', '0', '0', null, null, '2018-06-17', '1529374873');
INSERT INTO `pay_reconciliation` VALUES ('35', '2', '0', '0', '0', null, null, '2018-06-16', '1529374873');
INSERT INTO `pay_reconciliation` VALUES ('36', '2', '36', '0', '36', '62.1800', null, '2018-06-15', '1529374873');
INSERT INTO `pay_reconciliation` VALUES ('37', '2', '0', '0', '0', null, null, '2018-06-14', '1529374873');
INSERT INTO `pay_reconciliation` VALUES ('38', '2', '0', '0', '0', null, null, '2018-06-29', '1530244162');
INSERT INTO `pay_reconciliation` VALUES ('39', '2', '1', '0', '1', '0.0100', null, '2018-06-28', '1530244162');
INSERT INTO `pay_reconciliation` VALUES ('40', '2', '0', '0', '0', null, null, '2018-06-27', '1530244162');
INSERT INTO `pay_reconciliation` VALUES ('41', '2', '0', '0', '0', null, null, '2018-06-26', '1530244162');
INSERT INTO `pay_reconciliation` VALUES ('42', '2', '11', '0', '11', '0.1100', null, '2018-06-25', '1530244162');
INSERT INTO `pay_reconciliation` VALUES ('43', '2', '0', '0', '0', null, null, '2018-06-24', '1530244162');
INSERT INTO `pay_reconciliation` VALUES ('44', '2', '0', '0', '0', null, null, '2018-06-23', '1530244162');
INSERT INTO `pay_reconciliation` VALUES ('45', '2', '3', '0', '3', '1.0200', null, '2018-06-22', '1530244162');
INSERT INTO `pay_reconciliation` VALUES ('46', '2', '4', '0', '4', '301.0000', null, '2018-06-21', '1530244162');
INSERT INTO `pay_reconciliation` VALUES ('47', '2', '21', '0', '21', '207.1300', null, '2018-06-20', '1530244162');
INSERT INTO `pay_reconciliation` VALUES ('48', '2', '0', '0', '0', null, null, '2018-07-26', '1532588460');
INSERT INTO `pay_reconciliation` VALUES ('49', '2', '0', '0', '0', null, null, '2018-07-25', '1532588460');
INSERT INTO `pay_reconciliation` VALUES ('50', '2', '0', '0', '0', null, null, '2018-07-24', '1532588460');
INSERT INTO `pay_reconciliation` VALUES ('51', '2', '4', '0', '4', '0.0400', null, '2018-07-23', '1532588460');
INSERT INTO `pay_reconciliation` VALUES ('52', '2', '0', '0', '0', null, null, '2018-07-22', '1532588460');
INSERT INTO `pay_reconciliation` VALUES ('53', '2', '0', '0', '0', null, null, '2018-07-21', '1532588460');
INSERT INTO `pay_reconciliation` VALUES ('54', '2', '0', '0', '0', null, null, '2018-07-20', '1532588461');
INSERT INTO `pay_reconciliation` VALUES ('55', '2', '8', '0', '8', '0.0800', null, '2018-07-19', '1532588461');
INSERT INTO `pay_reconciliation` VALUES ('56', '2', '2', '0', '2', '0.0200', null, '2018-07-18', '1532588461');
INSERT INTO `pay_reconciliation` VALUES ('57', '2', '0', '0', '0', null, null, '2018-07-17', '1532588461');
INSERT INTO `pay_reconciliation` VALUES ('58', '2', '0', '0', '0', null, null, '2018-07-28', '1532762246');
INSERT INTO `pay_reconciliation` VALUES ('59', '2', '1', '0', '1', '0.0100', null, '2018-07-27', '1532762246');
INSERT INTO `pay_reconciliation` VALUES ('60', '2', '0', '0', '0', null, null, '2018-08-16', '1534404828');
INSERT INTO `pay_reconciliation` VALUES ('61', '2', '0', '0', '0', null, null, '2018-08-15', '1534404829');
INSERT INTO `pay_reconciliation` VALUES ('62', '2', '8', '0', '8', '0.0800', null, '2018-08-14', '1534404829');
INSERT INTO `pay_reconciliation` VALUES ('63', '2', '0', '0', '0', null, null, '2018-08-13', '1534404829');
INSERT INTO `pay_reconciliation` VALUES ('64', '2', '0', '0', '0', null, null, '2018-08-12', '1534404829');
INSERT INTO `pay_reconciliation` VALUES ('65', '2', '0', '0', '0', null, null, '2018-08-11', '1534404829');
INSERT INTO `pay_reconciliation` VALUES ('66', '2', '0', '0', '0', null, null, '2018-08-10', '1534404829');
INSERT INTO `pay_reconciliation` VALUES ('67', '2', '0', '0', '0', null, null, '2018-08-09', '1534404829');
INSERT INTO `pay_reconciliation` VALUES ('68', '2', '0', '0', '0', null, null, '2018-08-08', '1534404829');
INSERT INTO `pay_reconciliation` VALUES ('69', '2', '0', '0', '0', null, null, '2018-08-07', '1534404829');
INSERT INTO `pay_reconciliation` VALUES ('70', '6', '0', '0', '0', null, null, '2018-08-16', '1534404839');
INSERT INTO `pay_reconciliation` VALUES ('71', '6', '0', '0', '0', null, null, '2018-08-15', '1534404839');
INSERT INTO `pay_reconciliation` VALUES ('72', '6', '0', '0', '0', null, null, '2018-08-14', '1534404839');
INSERT INTO `pay_reconciliation` VALUES ('73', '6', '0', '0', '0', null, null, '2018-08-13', '1534404840');
INSERT INTO `pay_reconciliation` VALUES ('74', '6', '0', '0', '0', null, null, '2018-08-12', '1534404840');
INSERT INTO `pay_reconciliation` VALUES ('75', '6', '0', '0', '0', null, null, '2018-08-11', '1534404840');
INSERT INTO `pay_reconciliation` VALUES ('76', '6', '0', '0', '0', null, null, '2018-08-10', '1534404840');
INSERT INTO `pay_reconciliation` VALUES ('77', '6', '0', '0', '0', null, null, '2018-08-09', '1534404840');
INSERT INTO `pay_reconciliation` VALUES ('78', '6', '0', '0', '0', null, null, '2018-08-08', '1534404840');
INSERT INTO `pay_reconciliation` VALUES ('79', '6', '0', '0', '0', null, null, '2018-08-07', '1534404840');
INSERT INTO `pay_reconciliation` VALUES ('80', '6', '0', '0', '0', null, null, '2018-05-08', '1534404852');
INSERT INTO `pay_reconciliation` VALUES ('81', '6', '0', '0', '0', null, null, '2018-05-07', '1534404852');
INSERT INTO `pay_reconciliation` VALUES ('82', '6', '0', '0', '0', null, null, '2018-05-06', '1534404852');
INSERT INTO `pay_reconciliation` VALUES ('83', '6', '0', '0', '0', null, null, '2018-05-05', '1534404852');
INSERT INTO `pay_reconciliation` VALUES ('84', '6', '0', '0', '0', null, null, '2018-05-04', '1534404852');
INSERT INTO `pay_reconciliation` VALUES ('85', '6', '0', '0', '0', null, null, '2018-05-03', '1534404852');
INSERT INTO `pay_reconciliation` VALUES ('86', '6', '0', '0', '0', null, null, '2018-05-02', '1534404852');
INSERT INTO `pay_reconciliation` VALUES ('87', '6', '0', '0', '0', null, null, '2018-05-01', '1534404852');
INSERT INTO `pay_reconciliation` VALUES ('88', '6', '0', '0', '0', null, null, '2018-04-30', '1534404852');
INSERT INTO `pay_reconciliation` VALUES ('89', '6', '0', '0', '0', null, null, '2018-04-29', '1534404852');
INSERT INTO `pay_reconciliation` VALUES ('90', '6', '0', '0', '0', null, null, '2018-06-27', '1534404855');
INSERT INTO `pay_reconciliation` VALUES ('91', '6', '0', '0', '0', null, null, '2018-06-26', '1534404855');
INSERT INTO `pay_reconciliation` VALUES ('92', '6', '0', '0', '0', null, null, '2018-06-25', '1534404855');
INSERT INTO `pay_reconciliation` VALUES ('93', '6', '0', '0', '0', null, null, '2018-06-24', '1534404855');
INSERT INTO `pay_reconciliation` VALUES ('94', '6', '0', '0', '0', null, null, '2018-06-23', '1534404855');
INSERT INTO `pay_reconciliation` VALUES ('95', '6', '0', '0', '0', null, null, '2018-06-22', '1534404855');
INSERT INTO `pay_reconciliation` VALUES ('96', '6', '0', '0', '0', null, null, '2018-06-21', '1534404855');
INSERT INTO `pay_reconciliation` VALUES ('97', '6', '0', '0', '0', null, null, '2018-06-20', '1534404855');
INSERT INTO `pay_reconciliation` VALUES ('98', '6', '0', '0', '0', null, null, '2018-06-19', '1534404855');
INSERT INTO `pay_reconciliation` VALUES ('99', '6', '0', '0', '0', null, null, '2018-06-18', '1534404855');
INSERT INTO `pay_reconciliation` VALUES ('100', '2', '0', '0', '0', null, null, '2018-09-07', '1536314362');
INSERT INTO `pay_reconciliation` VALUES ('101', '2', '0', '0', '0', null, null, '2018-09-06', '1536314362');
INSERT INTO `pay_reconciliation` VALUES ('102', '2', '0', '0', '0', null, null, '2018-09-05', '1536314362');
INSERT INTO `pay_reconciliation` VALUES ('103', '2', '0', '0', '0', null, null, '2018-09-04', '1536314362');
INSERT INTO `pay_reconciliation` VALUES ('104', '2', '0', '0', '0', null, null, '2018-09-03', '1536314362');
INSERT INTO `pay_reconciliation` VALUES ('105', '2', '0', '0', '0', null, null, '2018-09-02', '1536314362');
INSERT INTO `pay_reconciliation` VALUES ('106', '2', '9', '0', '9', '7.0200', null, '2018-09-01', '1536314362');
INSERT INTO `pay_reconciliation` VALUES ('107', '2', '3', '0', '3', '3.0000', null, '2018-08-31', '1536314362');
INSERT INTO `pay_reconciliation` VALUES ('108', '2', '0', '0', '0', null, null, '2018-08-30', '1536314362');
INSERT INTO `pay_reconciliation` VALUES ('109', '2', '0', '0', '0', null, null, '2018-08-29', '1536314362');
INSERT INTO `pay_reconciliation` VALUES ('110', '2', '0', '0', '0', null, null, '2018-09-12', '1536723304');
INSERT INTO `pay_reconciliation` VALUES ('111', '2', '0', '0', '0', null, null, '2018-09-11', '1536723304');
INSERT INTO `pay_reconciliation` VALUES ('112', '2', '0', '0', '0', null, null, '2018-09-10', '1536723304');
INSERT INTO `pay_reconciliation` VALUES ('113', '2', '0', '0', '0', null, null, '2018-09-09', '1536723304');
INSERT INTO `pay_reconciliation` VALUES ('114', '2', '0', '0', '0', null, null, '2018-09-08', '1536723304');
INSERT INTO `pay_reconciliation` VALUES ('115', '180586947', '0', '0', '0', null, null, '2018-09-12', '1536747202');
INSERT INTO `pay_reconciliation` VALUES ('116', '180586947', '0', '0', '0', null, null, '2018-09-11', '1536747202');
INSERT INTO `pay_reconciliation` VALUES ('117', '180586947', '0', '0', '0', null, null, '2018-09-10', '1536747202');
INSERT INTO `pay_reconciliation` VALUES ('118', '180586947', '0', '0', '0', null, null, '2018-09-09', '1536747202');
INSERT INTO `pay_reconciliation` VALUES ('119', '180586947', '0', '0', '0', null, null, '2018-09-08', '1536747202');
INSERT INTO `pay_reconciliation` VALUES ('120', '180586947', '0', '0', '0', null, null, '2018-09-07', '1536747202');
INSERT INTO `pay_reconciliation` VALUES ('121', '180586947', '0', '0', '0', null, null, '2018-09-06', '1536747202');
INSERT INTO `pay_reconciliation` VALUES ('122', '180586947', '0', '0', '0', null, null, '2018-09-05', '1536747202');
INSERT INTO `pay_reconciliation` VALUES ('123', '180586947', '0', '0', '0', null, null, '2018-09-04', '1536747202');
INSERT INTO `pay_reconciliation` VALUES ('124', '180586947', '0', '0', '0', null, null, '2018-09-03', '1536747202');
INSERT INTO `pay_reconciliation` VALUES ('125', '180586950', '0', '0', '0', null, null, '2018-09-12', '1536747290');
INSERT INTO `pay_reconciliation` VALUES ('126', '2', '41', '0', '41', '102.3800', null, '2018-09-14', '1536893494');
INSERT INTO `pay_reconciliation` VALUES ('127', '2', '0', '0', '0', null, null, '2018-09-13', '1536893494');
INSERT INTO `pay_reconciliation` VALUES ('128', '2', '0', '0', '0', null, null, '2018-09-15', '1536984514');

-- ----------------------------
-- Table structure for pay_redo_order
-- ----------------------------
DROP TABLE IF EXISTS `pay_redo_order`;
CREATE TABLE `pay_redo_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作管理员',
  `money` decimal(11,4) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：增加 2：减少',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '冲正备注',
  `date` datetime NOT NULL COMMENT '冲正周期',
  `ctime` int(11) NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_redo_order
-- ----------------------------
INSERT INTO `pay_redo_order` VALUES ('1', '2', '1', '1.0000', '1', '测试冲正', '2018-06-09 00:00:00', '1528516981');
INSERT INTO `pay_redo_order` VALUES ('2', '2', '1', '2.0000', '1', '测试【冲正周期\".2018-06-08】', '2018-06-08 00:00:00', '1528517142');
INSERT INTO `pay_redo_order` VALUES ('3', '2', '1', '1.0000', '1', '11【冲正周期:2018-06-11】', '2018-06-11 00:00:00', '1528708437');
INSERT INTO `pay_redo_order` VALUES ('4', '2', '1', '1.0000', '1', '1【冲正周期:2018-06-11】', '2018-06-11 00:00:00', '1528710434');
INSERT INTO `pay_redo_order` VALUES ('5', '4', '1', '100.0000', '1', '11【冲正周期:2018-06-19】', '2018-06-19 00:00:00', '1529380239');
INSERT INTO `pay_redo_order` VALUES ('6', '2', '1', '1111.0000', '1', '1【冲正周期:】', '0000-00-00 00:00:00', '1529395354');
INSERT INTO `pay_redo_order` VALUES ('7', '2', '1', '1.0000', '1', '1【冲正周期:】', '0000-00-00 00:00:00', '1529395571');
INSERT INTO `pay_redo_order` VALUES ('8', '2', '1', '1.0000', '1', '1【冲正周期:2018-06-19】', '2018-06-19 00:00:00', '1529395653');

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
INSERT INTO `pay_sms` VALUES ('3', 'LTAIRR5X8fMzp3do', 'Ku8NjuKhx9N6igyaHYstZFsc8GplwV', '德兴支付', '0', null, '0', 'aliyun', '1', '11');

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
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_sms_template
-- ----------------------------
INSERT INTO `pay_sms_template` VALUES ('3', '修改支付密码', '11', 'editPayPassword', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1512202260');
INSERT INTO `pay_sms_template` VALUES ('4', '修改登录密码', '11', 'editPassword', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1512190115');
INSERT INTO `pay_sms_template` VALUES ('5', '异地登录', 'SMS_111795375', 'loginWarning', '您的账号于${time}登录异常，异常登录地址：${address}，如非本人操纵，请及时修改账号密码。', '1512202260');
INSERT INTO `pay_sms_template` VALUES ('6', '申请结算', 'SMS_111795375', 'clearing', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1512202260');
INSERT INTO `pay_sms_template` VALUES ('7', '委托结算', 'SMS_111795375', 'entrusted', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1512202260');
INSERT INTO `pay_sms_template` VALUES ('8', '绑定手机', 'SMS_119087905', 'bindMobile', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1514534290');
INSERT INTO `pay_sms_template` VALUES ('9', '更新手机', 'SMS_119087905', 'editMobile', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1514535688');
INSERT INTO `pay_sms_template` VALUES ('10', '更新银行卡 ', 'SMS_119087905 ', 'addBankcardSend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1514535688');
INSERT INTO `pay_sms_template` VALUES ('11', '修改个人资料', 'SMS_119087905', 'saveProfile', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('12', '绑定管理员手机号码', 'SMS_119087905', 'adminbindMobile', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('13', '修改管理员手机号码', 'SMS_119087905', 'admineditMobile', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('14', '批量删除订单', 'SMS_119087905', 'delOrderSend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('15', '解绑谷歌身份验证器', 'SMS_119087905', 'unbindGoogle', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('16', '设置订单为已支付', 'SMS_119087905', 'setOrderPaidSend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('17', '清理数据', 'SMS_119087905', 'clearDataSend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('18', '增加/减少余额（冲正）', 'SMS_119087905', 'adjustUserMoneySend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('19', '提交代付', 'SMS_119087905', 'submitDfSend', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('21', '商户登录', 'SMS_119087905', 'userLogin', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('20', '测试短信', 'SMS_119087905', 'test', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('22', '管理员登录', 'SMS_119087905', 'adminLogin', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');
INSERT INTO `pay_sms_template` VALUES ('23', '系统配置', 'SMS_119087905', 'sysconfig', '您的验证码为：${code} ，您正在进行重要操作，该验证码 5 分钟内有效，请勿泄露于他人。', '1527670734');

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
INSERT INTO `pay_template` VALUES ('3', '模板二', 'view2', '1', '0', '1524623473', '模板二');
INSERT INTO `pay_template` VALUES ('4', '模板三', 'view3', '0', '0', '1524623494', '模板三');

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
  `auto_df_max_sum` int(11) NOT NULL DEFAULT '0' COMMENT '自动代付商户每天最大总金额',
  `tk_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IND_UID` (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_tikuanconfig
-- ----------------------------
INSERT INTO `pay_tikuanconfig` VALUES ('28', '1', '100.00', '100000.00', '100000.00', '20', '1', '0', '200.00', '1', '1', '0', '2', '5', '1', '1', '3', '2000000.00', '0', '10000.00', '00:00', '23:58', '0', '0', '1');
INSERT INTO `pay_tikuanconfig` VALUES ('29', '2', '100.00', '10000.00', '100000.00', '20', '0', '0', '0.00', '1', '1', '0', '2', '10', '0', '0', '0', '0.00', '0', '0.00', '', '', '0', '0', '0');
INSERT INTO `pay_tikuanconfig` VALUES ('30', '0', '0.00', '0.00', '0.00', '0', '0', '0', '0.00', '0', '0', '0', null, null, '0', '0', '0', '0.00', '0', '0.00', '', '', '0', '0', '0');

-- ----------------------------
-- Table structure for pay_tikuanholiday
-- ----------------------------
DROP TABLE IF EXISTS `pay_tikuanholiday`;
CREATE TABLE `pay_tikuanholiday` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `datetime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '排除日期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='排除节假日';

-- ----------------------------
-- Records of pay_tikuanholiday
-- ----------------------------
INSERT INTO `pay_tikuanholiday` VALUES ('5', '1503676800');
INSERT INTO `pay_tikuanholiday` VALUES ('6', '1503763200');
INSERT INTO `pay_tikuanholiday` VALUES ('8', '1504281600');
INSERT INTO `pay_tikuanholiday` VALUES ('9', '1504368000');
INSERT INTO `pay_tikuanholiday` VALUES ('10', '1536163200');
INSERT INTO `pay_tikuanholiday` VALUES ('11', '1536681600');
INSERT INTO `pay_tikuanholiday` VALUES ('12', '1536768000');
INSERT INTO `pay_tikuanholiday` VALUES ('13', '1536508800');
INSERT INTO `pay_tikuanholiday` VALUES ('14', '1538150400');
INSERT INTO `pay_tikuanholiday` VALUES ('15', '1538582400');

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
  `tkmoney` decimal(10,4) NOT NULL DEFAULT '0.0000',
  `sxfmoney` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000',
  `money` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000',
  `t` int(4) NOT NULL DEFAULT '1',
  `payapiid` int(11) NOT NULL DEFAULT '0',
  `memo` text COMMENT '备注',
  `tk_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_tklist
-- ----------------------------
INSERT INTO `pay_tklist` VALUES ('1', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-05-30 10:11:21', '2018-06-15 10:10:30', '3', '100.0000', '5.0000', '95.0000', '0', '0', null, '0');
INSERT INTO `pay_tklist` VALUES ('2', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-06-28 10:06:43', '2018-06-29 11:55:28', '3', '100.0000', '10.0000', '90.0000', '1', '0', null, '0');
INSERT INTO `pay_tklist` VALUES ('3', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-06-30 10:31:49', '2018-06-30 10:32:26', '3', '100.0000', '10.0000', '90.0000', '1', '0', null, '0');
INSERT INTO `pay_tklist` VALUES ('4', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-06-30 10:31:59', '2018-06-30 10:32:26', '3', '200.0000', '10.0000', '190.0000', '1', '0', null, '0');
INSERT INTO `pay_tklist` VALUES ('5', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-06-30 10:33:19', '2018-06-30 10:33:29', '3', '100.0000', '10.0000', '90.0000', '1', '0', null, '0');
INSERT INTO `pay_tklist` VALUES ('6', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-05 16:57:03', null, '0', '100.0000', '10.0000', '90.0000', '1', '0', null, '0');
INSERT INTO `pay_tklist` VALUES ('7', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-05 16:57:48', null, '0', '100.0000', '10.0000', '90.0000', '1', '0', null, '0');
INSERT INTO `pay_tklist` VALUES ('8', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-05 17:01:12', '2018-07-05 17:02:10', '3', '100.0000', '10.0000', '90.0000', '1', '0', '测试', '1');
INSERT INTO `pay_tklist` VALUES ('9', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-10 19:55:45', null, '0', '100.0000', '10.0000', '90.0000', '1', '0', null, '1');
INSERT INTO `pay_tklist` VALUES ('10', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-10 19:56:26', null, '0', '100.0000', '10.0000', '90.0000', '1', '0', null, '1');
INSERT INTO `pay_tklist` VALUES ('11', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-10 19:59:20', null, '0', '100.0000', '10.0000', '90.0000', '1', '0', null, '1');
INSERT INTO `pay_tklist` VALUES ('12', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-10 19:59:20', null, '0', '100.0000', '10.0000', '90.0000', '1', '0', null, '1');
INSERT INTO `pay_tklist` VALUES ('13', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-10 20:04:01', null, '0', '100.0000', '10.0000', '90.0000', '1', '0', null, '1');
INSERT INTO `pay_tklist` VALUES ('14', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-10 20:04:25', null, '0', '100.0000', '10.0000', '90.0000', '1', '0', null, '1');
INSERT INTO `pay_tklist` VALUES ('15', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-12 17:33:20', null, '0', '100.0000', '10.0000', '90.0000', '1', '0', null, '1');
INSERT INTO `pay_tklist` VALUES ('16', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-28 14:35:49', null, '0', '100.0000', '10.0000', '90.0000', '0', '0', null, '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='商户通道费率';

-- ----------------------------
-- Records of pay_userrate
-- ----------------------------
INSERT INTO `pay_userrate` VALUES ('21', '2', '907', '0.0080', '0.0150', '0.0080', '0.0150');
INSERT INTO `pay_userrate` VALUES ('22', '2', '901', '0.0050', '0.0080', '0.0010', '0.0080');
INSERT INTO `pay_userrate` VALUES ('23', '2', '902', '0.0050', '0.0080', '0.0060', '0.0080');
INSERT INTO `pay_userrate` VALUES ('24', '3', '901', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('25', '3', '902', '0.0300', '0.0000', '0.0300', '0.0000');
INSERT INTO `pay_userrate` VALUES ('26', '3', '903', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('27', '3', '904', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('28', '3', '907', '0.0050', '0.0050', '0.0050', '0.0050');
INSERT INTO `pay_userrate` VALUES ('29', '4', '901', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('30', '4', '902', '0.0600', '0.0000', '0.0600', '0.0000');
INSERT INTO `pay_userrate` VALUES ('31', '4', '903', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('32', '4', '904', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('33', '4', '907', '0.0060', '0.9000', '0.2000', '0.0110');
INSERT INTO `pay_userrate` VALUES ('34', '5', '901', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('35', '5', '902', '0.0900', '0.0000', '0.0900', '0.0000');
INSERT INTO `pay_userrate` VALUES ('36', '5', '903', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('37', '5', '904', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('38', '5', '907', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('39', '6', '901', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('40', '6', '902', '0.1000', '0.0000', '0.1000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('41', '6', '903', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('42', '6', '904', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('43', '6', '907', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('44', '2', '903', '0.0100', '0.0120', '0.0010', '0.0090');
INSERT INTO `pay_userrate` VALUES ('45', '2', '904', '0.0030', '0.0040', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('46', '2', '908', '0.0030', '0.0050', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('47', '2', '911', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('48', '180586950', '901', '0.0000', '0.0000', '9.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('49', '180586950', '902', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('50', '180586950', '903', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('51', '180586950', '904', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('52', '180586950', '907', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('53', '180586950', '908', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('54', '180586950', '911', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('55', '180586950', '912', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `pay_userrate` VALUES ('56', '2', '912', '0.0000', '0.0000', '0.0000', '0.0000');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='用户指定指账号';

-- ----------------------------
-- Records of pay_user_channel_account
-- ----------------------------
INSERT INTO `pay_user_channel_account` VALUES ('1', '2', '219,236,233,240,247,248,251', '0');

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
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_user_code
-- ----------------------------
INSERT INTO `pay_user_code` VALUES ('6', '0', '10719', 'demouser', '551882927@qq.com', null, '0', '1536748310', null, '1536748910');
INSERT INTO `pay_user_code` VALUES ('7', '0', '27888', 'demouser', '551882927@qq.com', null, '0', '1536748385', null, '1536748985');
INSERT INTO `pay_user_code` VALUES ('8', '0', '87964', 'demouser', '551882927@qq.com', null, '0', '1536748992', null, '1536749592');

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
) ENGINE=InnoDB AUTO_INCREMENT=279 DEFAULT CHARSET=utf8 COMMENT='用户操作日志表';

-- ----------------------------
-- Records of pay_user_log
-- ----------------------------
INSERT INTO `pay_user_log` VALUES ('1', '127.0.0.1', 'user/withdrawal/index', '2', 'demouser', '查看结算记录', '1', '查看结算记录', '2018-09-13 11:57:32');
INSERT INTO `pay_user_log` VALUES ('2', '127.0.0.1', 'user/withdrawal/check', '2', 'demouser', '查看商户代付页面', '1', '查看商户代付页面', '2018-09-13 12:19:46');
INSERT INTO `pay_user_log` VALUES ('3', '127.0.0.1', 'user/withdrawal/showdf', '2', 'demouser', '查看商户代付页面', '1', '查看商户代付页面', '2018-09-13 12:19:50');
INSERT INTO `pay_user_log` VALUES ('4', '127.0.0.1', 'user/withdrawal/dfpass', '2', 'demouser', '查看商户代付详情', '1', 'ID：39', '2018-09-13 12:21:21');
INSERT INTO `pay_user_log` VALUES ('5', '127.0.0.1', 'user/withdrawal/check', '2', 'demouser', '查看商户代付页面', '1', '查看商户代付页面', '2018-09-13 14:10:19');
INSERT INTO `pay_user_log` VALUES ('6', '127.0.0.1', 'user/withdrawal/payment', '2', 'demouser', '查看代付记录', '1', '查看代付记录', '2018-09-13 14:10:33');
INSERT INTO `pay_user_log` VALUES ('7', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '查看代付申请页面', '1', '查看代付申请页面', '2018-09-13 14:10:35');
INSERT INTO `pay_user_log` VALUES ('8', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-13 14:10:38');
INSERT INTO `pay_user_log` VALUES ('9', '127.0.0.1', 'user/withdrawal/check', '2', 'demouser', '查看商户代付页面', '1', '查看商户代付页面', '2018-09-13 14:12:39');
INSERT INTO `pay_user_log` VALUES ('10', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '访问代付申请页面', '2018-09-13 14:31:21');
INSERT INTO `pay_user_log` VALUES ('11', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问结算记录', '1', '访问结算记录', '2018-09-13 15:28:23');
INSERT INTO `pay_user_log` VALUES ('12', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-13 15:42:49');
INSERT INTO `pay_user_log` VALUES ('13', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问成功订单列表页面', '1', '访问成功订单订单列表页面', '2018-09-13 15:48:03');
INSERT INTO `pay_user_log` VALUES ('14', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问未支付订单列表页面', '1', '访问未支付订单订单列表页面', '2018-09-13 15:48:15');
INSERT INTO `pay_user_log` VALUES ('15', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问成功订单列表页面', '1', '访问成功订单订单列表页面', '2018-09-13 15:48:56');
INSERT INTO `pay_user_log` VALUES ('16', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问未支付订单列表页面', '1', '访问未支付订单订单列表页面', '2018-09-13 15:50:49');
INSERT INTO `pay_user_log` VALUES ('17', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问未支付订单列表页面', '1', '访问未支付订单订单列表页面', '2018-09-13 15:50:51');
INSERT INTO `pay_user_log` VALUES ('18', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问未支付订单列表页面', '1', '访问未支付订单订单列表页面', '2018-09-13 15:50:54');
INSERT INTO `pay_user_log` VALUES ('19', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问未支付订单列表页面', '1', '访问未支付订单订单列表页面', '2018-09-13 15:50:56');
INSERT INTO `pay_user_log` VALUES ('20', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-13 15:53:03');
INSERT INTO `pay_user_log` VALUES ('21', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问未支付订单列表页面', '1', '访问未支付订单订单列表页面', '2018-09-13 15:53:09');
INSERT INTO `pay_user_log` VALUES ('22', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问成功订单列表页面', '1', '访问成功订单订单列表页面', '2018-09-13 15:53:13');
INSERT INTO `pay_user_log` VALUES ('23', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-13 15:53:15');
INSERT INTO `pay_user_log` VALUES ('24', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问成功订单列表页面', '1', '访问成功订单订单列表页面', '2018-09-13 15:53:21');
INSERT INTO `pay_user_log` VALUES ('25', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-13 15:53:23');
INSERT INTO `pay_user_log` VALUES ('26', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-13 15:53:25');
INSERT INTO `pay_user_log` VALUES ('27', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-13 15:53:28');
INSERT INTO `pay_user_log` VALUES ('28', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-13 15:53:32');
INSERT INTO `pay_user_log` VALUES ('29', '127.0.0.1', 'user/channel/apidocumnet', '2', 'demouser', '查看通道费率', '1', '查看通道费率', '2018-09-13 16:25:49');
INSERT INTO `pay_user_log` VALUES ('30', '127.0.0.1', 'user/agent/invitecode', '3', 'ceishi_1', '访问邀请码列表', '1', '访问邀请码列表', '2018-09-13 16:31:51');
INSERT INTO `pay_user_log` VALUES ('31', '127.0.0.1', 'user/agent/addinvite', '3', 'ceishi_1', '访问添加邀请码页面', '1', '访问添加邀请码页面', '2018-09-13 16:31:53');
INSERT INTO `pay_user_log` VALUES ('32', '127.0.0.1', 'user/agent/member', '3', 'ceishi_1', '访问下级商户列表', '1', '访问下级商户列表', '2018-09-13 16:38:47');
INSERT INTO `pay_user_log` VALUES ('33', '127.0.0.1', 'user/agent/editstatus', '3', 'ceishi_1', '下级商户状态切换成功', '3', '用户ID：4，状态：', '2018-09-13 16:42:20');
INSERT INTO `pay_user_log` VALUES ('34', '127.0.0.1', 'user/agent/member', '3', 'ceishi_1', '访问下级商户列表', '1', '访问下级商户列表', '2018-09-13 16:58:20');
INSERT INTO `pay_user_log` VALUES ('35', '127.0.0.1', 'user/account/authorized', '3', 'ceishi_1', '访问邀请码列表', '1', '访问邀请码列表', '2018-09-13 16:58:42');
INSERT INTO `pay_user_log` VALUES ('36', '127.0.0.1', 'user/agent/member', '3', 'ceishi_1', '访问下级商户列表', '1', '访问下级商户列表', '2018-09-13 16:58:49');
INSERT INTO `pay_user_log` VALUES ('37', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-13 16:59:19');
INSERT INTO `pay_user_log` VALUES ('38', '127.0.0.1', 'user/account/frozenmoney', '2', 'demouser', '访问资金冻结明细页面', '1', '访问资金冻结明细页面', '2018-09-13 17:22:02');
INSERT INTO `pay_user_log` VALUES ('39', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-13 17:22:05');
INSERT INTO `pay_user_log` VALUES ('40', '127.0.0.1', 'user/withdrawal/check', '2', 'demouser', '访问商户代付页面', '1', '访问商户代付页面', '2018-09-13 17:22:07');
INSERT INTO `pay_user_log` VALUES ('41', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-13 17:22:12');
INSERT INTO `pay_user_log` VALUES ('42', '127.0.0.1', 'user/account/loginrecord', '2', 'demouser', '访问登录记录页面', '1', '访问登录记录页面', '2018-09-13 17:22:43');
INSERT INTO `pay_user_log` VALUES ('43', '127.0.0.1', 'user/account/authorized', '2', 'demouser', '访问商户认证页面', '1', '访问商户认证页面', '2018-09-13 17:22:44');
INSERT INTO `pay_user_log` VALUES ('44', '127.0.0.1', 'user/index/gonggao', '2', 'demouser', '访问公告列表', '1', '访问公告列表', '2018-09-13 17:51:56');
INSERT INTO `pay_user_log` VALUES ('45', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-13 17:51:59');
INSERT INTO `pay_user_log` VALUES ('46', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-13 18:04:55');
INSERT INTO `pay_user_log` VALUES ('47', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-13 18:07:37');
INSERT INTO `pay_user_log` VALUES ('48', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-13 18:08:33');
INSERT INTO `pay_user_log` VALUES ('49', '127.0.0.1', 'user/index/main', '180586949', 'mapeijian', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 02:48:37');
INSERT INTO `pay_user_log` VALUES ('50', '127.0.0.1', 'user/channel/index', '180586949', 'mapeijian', '查看通道费率', '1', '查看通道费率', '2018-09-14 02:48:42');
INSERT INTO `pay_user_log` VALUES ('51', '127.0.0.1', 'user/channel/index', '180586949', 'mapeijian', '查看通道费率', '1', '查看通道费率', '2018-09-14 02:49:26');
INSERT INTO `pay_user_log` VALUES ('52', '127.0.0.1', 'user/channel/index', '180586949', 'mapeijian', '查看通道费率', '1', '查看通道费率', '2018-09-14 02:49:59');
INSERT INTO `pay_user_log` VALUES ('53', '127.0.0.1', 'user/channel/index', '180586949', 'mapeijian', '查看通道费率', '1', '查看通道费率', '2018-09-14 02:56:33');
INSERT INTO `pay_user_log` VALUES ('54', '127.0.0.1', 'user/channel/index', '180586949', 'mapeijian', '查看通道费率', '1', '查看通道费率', '2018-09-14 02:56:53');
INSERT INTO `pay_user_log` VALUES ('55', '127.0.0.1', 'user/channel/index', '180586949', 'mapeijian', '查看通道费率', '1', '查看通道费率', '2018-09-14 02:58:17');
INSERT INTO `pay_user_log` VALUES ('56', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 09:31:36');
INSERT INTO `pay_user_log` VALUES ('57', '127.0.0.1', 'user/index/gonggao', '2', 'demouser', '访问公告列表', '1', '访问公告列表', '2018-09-14 09:31:41');
INSERT INTO `pay_user_log` VALUES ('58', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-14 09:31:43');
INSERT INTO `pay_user_log` VALUES ('59', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 10:44:30');
INSERT INTO `pay_user_log` VALUES ('60', '127.0.0.1', 'user/account/qrcode', '2', 'demouser', '访问收款二维码页面', '1', '访问收款二维码页面', '2018-09-14 10:45:10');
INSERT INTO `pay_user_log` VALUES ('61', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-14 10:45:19');
INSERT INTO `pay_user_log` VALUES ('62', '127.0.0.1', 'user/account/authorized', '2', 'demouser', '访问商户认证页面', '1', '访问商户认证页面', '2018-09-14 10:45:27');
INSERT INTO `pay_user_log` VALUES ('63', '127.0.0.1', 'user/index/gonggao', '2', 'demouser', '访问公告列表', '1', '访问公告列表', '2018-09-14 10:49:40');
INSERT INTO `pay_user_log` VALUES ('64', '127.0.0.1', 'user/index/showcontent', '2', 'demouser', '访问公告详情', '1', 'ID：14', '2018-09-14 10:49:42');
INSERT INTO `pay_user_log` VALUES ('65', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 10:51:04');
INSERT INTO `pay_user_log` VALUES ('66', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 10:51:17');
INSERT INTO `pay_user_log` VALUES ('67', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 10:51:20');
INSERT INTO `pay_user_log` VALUES ('68', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 10:51:22');
INSERT INTO `pay_user_log` VALUES ('69', '127.0.0.1', 'user/account/changerecord', '2', 'demouser', '访问资金变动记录页面', '1', '访问资金变动记录页面', '2018-09-14 10:51:31');
INSERT INTO `pay_user_log` VALUES ('70', '127.0.0.1', 'user/account/reconciliation', '2', 'demouser', '访问对账单页面', '1', '访问对账单页面', '2018-09-14 10:51:34');
INSERT INTO `pay_user_log` VALUES ('71', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 10:51:50');
INSERT INTO `pay_user_log` VALUES ('72', '127.0.0.1', 'user/channel/apidocumnet', '2', 'demouser', '查看API密钥', '1', '查看API密钥', '2018-09-14 10:51:53');
INSERT INTO `pay_user_log` VALUES ('73', '127.0.0.1', 'user/channel/index', '2', 'demouser', '查看通道费率', '1', '查看通道费率', '2018-09-14 10:51:57');
INSERT INTO `pay_user_log` VALUES ('74', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 10:59:17');
INSERT INTO `pay_user_log` VALUES ('75', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 10:59:24');
INSERT INTO `pay_user_log` VALUES ('76', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-14 10:59:30');
INSERT INTO `pay_user_log` VALUES ('77', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-14 10:59:37');
INSERT INTO `pay_user_log` VALUES ('78', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 10:59:41');
INSERT INTO `pay_user_log` VALUES ('79', '127.0.0.1', 'user/order/show', '2', 'demouser', '查看订单', '1', '查看订单，ID：689', '2018-09-14 10:59:44');
INSERT INTO `pay_user_log` VALUES ('80', '127.0.0.1', 'user/account/qrcode', '2', 'demouser', '访问收款二维码页面', '1', '访问收款二维码页面', '2018-09-14 10:59:51');
INSERT INTO `pay_user_log` VALUES ('81', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 10:59:55');
INSERT INTO `pay_user_log` VALUES ('82', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:00:18');
INSERT INTO `pay_user_log` VALUES ('83', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:00:21');
INSERT INTO `pay_user_log` VALUES ('84', '127.0.0.1', 'user/index/gonggao', '2', 'demouser', '访问公告列表', '1', '访问公告列表', '2018-09-14 11:00:35');
INSERT INTO `pay_user_log` VALUES ('85', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:17:58');
INSERT INTO `pay_user_log` VALUES ('86', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:23:40');
INSERT INTO `pay_user_log` VALUES ('87', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:24:36');
INSERT INTO `pay_user_log` VALUES ('88', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:27:41');
INSERT INTO `pay_user_log` VALUES ('89', '127.0.0.1', 'user/index/gonggao', '2', 'demouser', '访问公告列表', '1', '访问公告列表', '2018-09-14 11:27:48');
INSERT INTO `pay_user_log` VALUES ('90', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-14 11:28:00');
INSERT INTO `pay_user_log` VALUES ('91', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-14 11:28:06');
INSERT INTO `pay_user_log` VALUES ('92', '127.0.0.1', 'user/withdrawal/index', '2', 'demouser', '访问结算记录', '1', '访问结算记录', '2018-09-14 11:28:10');
INSERT INTO `pay_user_log` VALUES ('93', '127.0.0.1', 'user/withdrawal/check', '2', 'demouser', '访问商户代付页面', '1', '访问商户代付页面', '2018-09-14 11:28:16');
INSERT INTO `pay_user_log` VALUES ('94', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:35:58');
INSERT INTO `pay_user_log` VALUES ('95', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-14 11:36:06');
INSERT INTO `pay_user_log` VALUES ('96', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:36:49');
INSERT INTO `pay_user_log` VALUES ('97', '127.0.0.1', 'user/account/bankcard', '2', 'demouser', '访问银行卡列表页面', '1', '访问银行卡列表页面', '2018-09-14 11:36:57');
INSERT INTO `pay_user_log` VALUES ('98', '127.0.0.1', 'user/account/editpaypassword', '2', 'demouser', '访问修改支付密码页面', '1', '访问修改支付密码页面', '2018-09-14 11:37:03');
INSERT INTO `pay_user_log` VALUES ('99', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:37:45');
INSERT INTO `pay_user_log` VALUES ('100', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:38:15');
INSERT INTO `pay_user_log` VALUES ('101', '127.0.0.1', 'user/account/editpassword', '2', 'demouser', '访问修改登录密码页面', '1', '访问修改登录密码页面', '2018-09-14 11:39:13');
INSERT INTO `pay_user_log` VALUES ('102', '127.0.0.1', 'user/account/editpassword', '2', 'demouser', '访问修改登录密码页面', '1', '访问修改登录密码页面', '2018-09-14 11:39:36');
INSERT INTO `pay_user_log` VALUES ('103', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-14 11:40:26');
INSERT INTO `pay_user_log` VALUES ('104', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问成功订单列表页面', '1', '访问成功订单订单列表页面', '2018-09-14 11:41:02');
INSERT INTO `pay_user_log` VALUES ('105', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:42:05');
INSERT INTO `pay_user_log` VALUES ('106', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 11:42:11');
INSERT INTO `pay_user_log` VALUES ('107', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:44:14');
INSERT INTO `pay_user_log` VALUES ('108', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 11:44:23');
INSERT INTO `pay_user_log` VALUES ('109', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:49:33');
INSERT INTO `pay_user_log` VALUES ('110', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-14 11:49:40');
INSERT INTO `pay_user_log` VALUES ('111', '127.0.0.1', 'user/withdrawal/payment', '2', 'demouser', '访问代付记录', '1', '访问代付记录', '2018-09-14 11:49:45');
INSERT INTO `pay_user_log` VALUES ('112', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-14 11:49:53');
INSERT INTO `pay_user_log` VALUES ('113', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:50:14');
INSERT INTO `pay_user_log` VALUES ('114', '127.0.0.1', 'user/account/changerecord', '2', 'demouser', '访问资金变动记录页面', '1', '访问资金变动记录页面', '2018-09-14 11:50:20');
INSERT INTO `pay_user_log` VALUES ('115', '127.0.0.1', 'user/account/complaintsdeposit', '2', 'demouser', '访问保证金明细页面', '1', '访问保证金明细页面', '2018-09-14 11:50:24');
INSERT INTO `pay_user_log` VALUES ('116', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:50:30');
INSERT INTO `pay_user_log` VALUES ('117', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-14 11:50:36');
INSERT INTO `pay_user_log` VALUES ('118', '127.0.0.1', 'user/account/frozenmoney', '2', 'demouser', '访问资金冻结明细页面', '1', '访问资金冻结明细页面', '2018-09-14 11:50:44');
INSERT INTO `pay_user_log` VALUES ('119', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 11:51:02');
INSERT INTO `pay_user_log` VALUES ('120', '127.0.0.1', 'user/order/show', '2', 'demouser', '查看订单', '1', '查看订单，ID：682', '2018-09-14 11:51:14');
INSERT INTO `pay_user_log` VALUES ('121', '127.0.0.1', 'user/order/show', '2', 'demouser', '查看订单', '1', '查看订单，ID：679', '2018-09-14 11:53:33');
INSERT INTO `pay_user_log` VALUES ('122', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:53:57');
INSERT INTO `pay_user_log` VALUES ('123', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 11:54:04');
INSERT INTO `pay_user_log` VALUES ('124', '127.0.0.1', 'user/order/show', '2', 'demouser', '查看订单', '1', '查看订单，ID：679', '2018-09-14 11:54:14');
INSERT INTO `pay_user_log` VALUES ('125', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:54:26');
INSERT INTO `pay_user_log` VALUES ('126', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-14 11:54:34');
INSERT INTO `pay_user_log` VALUES ('127', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 11:54:42');
INSERT INTO `pay_user_log` VALUES ('128', '127.0.0.1', 'user/order/show', '2', 'demouser', '查看订单', '1', '查看订单，ID：684', '2018-09-14 11:54:46');
INSERT INTO `pay_user_log` VALUES ('129', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:58:44');
INSERT INTO `pay_user_log` VALUES ('130', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-14 11:58:50');
INSERT INTO `pay_user_log` VALUES ('131', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 11:58:56');
INSERT INTO `pay_user_log` VALUES ('132', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 11:59:02');
INSERT INTO `pay_user_log` VALUES ('133', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:00:57');
INSERT INTO `pay_user_log` VALUES ('134', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 12:01:04');
INSERT INTO `pay_user_log` VALUES ('135', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:01:18');
INSERT INTO `pay_user_log` VALUES ('136', '127.0.0.1', 'user/account/changerecord', '2', 'demouser', '访问资金变动记录页面', '1', '访问资金变动记录页面', '2018-09-14 12:01:24');
INSERT INTO `pay_user_log` VALUES ('137', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:01:42');
INSERT INTO `pay_user_log` VALUES ('138', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 12:01:48');
INSERT INTO `pay_user_log` VALUES ('139', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:02:20');
INSERT INTO `pay_user_log` VALUES ('140', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-14 12:02:27');
INSERT INTO `pay_user_log` VALUES ('141', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问成功订单列表页面', '1', '访问成功订单订单列表页面', '2018-09-14 12:02:33');
INSERT INTO `pay_user_log` VALUES ('142', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:02:40');
INSERT INTO `pay_user_log` VALUES ('143', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:02:58');
INSERT INTO `pay_user_log` VALUES ('144', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:03:29');
INSERT INTO `pay_user_log` VALUES ('145', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 12:03:37');
INSERT INTO `pay_user_log` VALUES ('146', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问手工补发订单列表页面', '1', '访问手工补发订单订单列表页面', '2018-09-14 12:03:58');
INSERT INTO `pay_user_log` VALUES ('147', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:05:22');
INSERT INTO `pay_user_log` VALUES ('148', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 12:05:28');
INSERT INTO `pay_user_log` VALUES ('149', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:05:46');
INSERT INTO `pay_user_log` VALUES ('150', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:07:25');
INSERT INTO `pay_user_log` VALUES ('151', '127.0.0.1', 'user/index/gonggao', '2', 'demouser', '访问公告列表', '1', '访问公告列表', '2018-09-14 12:07:35');
INSERT INTO `pay_user_log` VALUES ('152', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 12:07:39');
INSERT INTO `pay_user_log` VALUES ('153', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问未支付订单列表页面', '1', '访问未支付订单订单列表页面', '2018-09-14 12:07:43');
INSERT INTO `pay_user_log` VALUES ('154', '127.0.0.1', 'user/channel/apidocumnet', '2', 'demouser', '查看API密钥', '1', '查看API密钥', '2018-09-14 12:07:52');
INSERT INTO `pay_user_log` VALUES ('155', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:08:42');
INSERT INTO `pay_user_log` VALUES ('156', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 12:08:49');
INSERT INTO `pay_user_log` VALUES ('157', '127.0.0.1', 'user/order/show', '2', 'demouser', '查看订单', '1', '查看订单，ID：689', '2018-09-14 12:08:57');
INSERT INTO `pay_user_log` VALUES ('158', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:09:08');
INSERT INTO `pay_user_log` VALUES ('159', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 12:09:15');
INSERT INTO `pay_user_log` VALUES ('160', '127.0.0.1', 'user/order/show', '2', 'demouser', '查看订单', '1', '查看订单，ID：689', '2018-09-14 12:09:17');
INSERT INTO `pay_user_log` VALUES ('161', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问成功订单列表页面', '1', '访问成功订单订单列表页面', '2018-09-14 12:09:20');
INSERT INTO `pay_user_log` VALUES ('162', '127.0.0.1', 'user/order/show', '2', 'demouser', '查看订单', '1', '查看订单，ID：111', '2018-09-14 12:09:23');
INSERT INTO `pay_user_log` VALUES ('163', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:09:30');
INSERT INTO `pay_user_log` VALUES ('164', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:10:18');
INSERT INTO `pay_user_log` VALUES ('165', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:11:07');
INSERT INTO `pay_user_log` VALUES ('166', '127.0.0.1', 'user/account/changerecord', '2', 'demouser', '访问资金变动记录页面', '1', '访问资金变动记录页面', '2018-09-14 12:11:16');
INSERT INTO `pay_user_log` VALUES ('167', '127.0.0.1', 'user/account/complaintsdeposit', '2', 'demouser', '访问保证金明细页面', '1', '访问保证金明细页面', '2018-09-14 12:11:19');
INSERT INTO `pay_user_log` VALUES ('168', '127.0.0.1', 'user/account/frozenmoney', '2', 'demouser', '访问资金冻结明细页面', '1', '访问资金冻结明细页面', '2018-09-14 12:11:20');
INSERT INTO `pay_user_log` VALUES ('169', '127.0.0.1', 'user/account/reconciliation', '2', 'demouser', '访问对账单页面', '1', '访问对账单页面', '2018-09-14 12:11:21');
INSERT INTO `pay_user_log` VALUES ('170', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问手工补发订单列表页面', '1', '访问手工补发订单订单列表页面', '2018-09-14 12:11:24');
INSERT INTO `pay_user_log` VALUES ('171', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-14 12:11:26');
INSERT INTO `pay_user_log` VALUES ('172', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-14 12:11:29');
INSERT INTO `pay_user_log` VALUES ('173', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-14 12:11:30');
INSERT INTO `pay_user_log` VALUES ('174', '127.0.0.1', 'user/withdrawal/payment', '2', 'demouser', '访问代付记录', '1', '访问代付记录', '2018-09-14 12:11:32');
INSERT INTO `pay_user_log` VALUES ('175', '127.0.0.1', 'user/withdrawal/check', '2', 'demouser', '访问商户代付页面', '1', '访问商户代付页面', '2018-09-14 12:11:34');
INSERT INTO `pay_user_log` VALUES ('176', '127.0.0.1', 'user/account/changerecord', '2', 'demouser', '访问资金变动记录页面', '1', '访问资金变动记录页面', '2018-09-14 12:11:37');
INSERT INTO `pay_user_log` VALUES ('177', '127.0.0.1', 'user/account/channelfinance', '2', 'demouser', '访问通道分析页面', '1', '访问通道分析页面', '2018-09-14 12:11:39');
INSERT INTO `pay_user_log` VALUES ('178', '127.0.0.1', 'user/account/frozenmoney', '2', 'demouser', '访问资金冻结明细页面', '1', '访问资金冻结明细页面', '2018-09-14 12:11:41');
INSERT INTO `pay_user_log` VALUES ('179', '127.0.0.1', 'user/account/reconciliation', '2', 'demouser', '访问对账单页面', '1', '访问对账单页面', '2018-09-14 12:11:43');
INSERT INTO `pay_user_log` VALUES ('180', '127.0.0.1', 'user/account/reconciliation', '2', 'demouser', '访问对账单页面', '1', '访问对账单页面', '2018-09-14 12:11:46');
INSERT INTO `pay_user_log` VALUES ('181', '127.0.0.1', 'user/index/gonggao', '2', 'demouser', '访问公告列表', '1', '访问公告列表', '2018-09-14 12:11:52');
INSERT INTO `pay_user_log` VALUES ('182', '127.0.0.1', 'user/account/qrcode', '2', 'demouser', '访问收款二维码页面', '1', '访问收款二维码页面', '2018-09-14 12:11:54');
INSERT INTO `pay_user_log` VALUES ('183', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:11:57');
INSERT INTO `pay_user_log` VALUES ('184', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:13:32');
INSERT INTO `pay_user_log` VALUES ('185', '127.0.0.1', 'user/account/changerecord', '2', 'demouser', '访问资金变动记录页面', '1', '访问资金变动记录页面', '2018-09-14 12:13:37');
INSERT INTO `pay_user_log` VALUES ('186', '127.0.0.1', 'user/account/frozenmoney', '2', 'demouser', '访问资金冻结明细页面', '1', '访问资金冻结明细页面', '2018-09-14 12:13:40');
INSERT INTO `pay_user_log` VALUES ('187', '127.0.0.1', 'user/channel/index', '2', 'demouser', '查看通道费率', '1', '查看通道费率', '2018-09-14 12:16:23');
INSERT INTO `pay_user_log` VALUES ('188', '127.0.0.1', 'user/index/gonggao', '2', 'demouser', '访问公告列表', '1', '访问公告列表', '2018-09-14 12:19:48');
INSERT INTO `pay_user_log` VALUES ('189', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 12:19:50');
INSERT INTO `pay_user_log` VALUES ('190', '127.0.0.1', 'user/account/profile', '2', 'demouser', '访问编辑个人资料页面', '1', '访问编辑个人资料页面', '2018-09-14 12:19:55');
INSERT INTO `pay_user_log` VALUES ('191', '127.0.0.1', 'user/account/saveprofile', '2', 'demouser', '保存个人资料成功', '3', '保存个人资料成功', '2018-09-14 12:19:57');
INSERT INTO `pay_user_log` VALUES ('192', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-14 15:08:13');
INSERT INTO `pay_user_log` VALUES ('193', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-14 15:08:21');
INSERT INTO `pay_user_log` VALUES ('194', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 11:10:19');
INSERT INTO `pay_user_log` VALUES ('195', '127.0.0.1', 'user/account/google', '2', 'demouser', '访问绑定谷歌身份认证页面', '1', '访问绑定谷歌身份认证页面', '2018-09-15 11:10:22');
INSERT INTO `pay_user_log` VALUES ('196', '127.0.0.1', 'user/account/editgooglestatus', '2', 'demouser', '开启谷歌验证成功', '3', '开启谷歌验证成功', '2018-09-15 11:10:31');
INSERT INTO `pay_user_log` VALUES ('197', '127.0.0.1', 'user/account/google', '2', 'demouser', '访问绑定谷歌身份认证页面', '1', '访问绑定谷歌身份认证页面', '2018-09-15 11:10:33');
INSERT INTO `pay_user_log` VALUES ('198', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 11:47:30');
INSERT INTO `pay_user_log` VALUES ('199', '127.0.0.1', 'user/account/bankcard', '2', 'demouser', '访问银行卡列表页面', '1', '访问银行卡列表页面', '2018-09-15 11:47:34');
INSERT INTO `pay_user_log` VALUES ('200', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问添加银行卡页面', '1', '访问添加银行卡页面', '2018-09-15 11:47:36');
INSERT INTO `pay_user_log` VALUES ('201', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问添加银行卡页面', '1', '访问添加银行卡页面', '2018-09-15 11:48:47');
INSERT INTO `pay_user_log` VALUES ('202', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问添加银行卡页面', '1', '访问添加银行卡页面', '2018-09-15 11:48:58');
INSERT INTO `pay_user_log` VALUES ('203', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问添加银行卡页面', '1', '访问添加银行卡页面', '2018-09-15 11:49:21');
INSERT INTO `pay_user_log` VALUES ('204', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问添加银行卡页面', '1', '访问添加银行卡页面', '2018-09-15 11:50:34');
INSERT INTO `pay_user_log` VALUES ('205', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问添加银行卡页面', '1', '访问添加银行卡页面', '2018-09-15 11:50:46');
INSERT INTO `pay_user_log` VALUES ('206', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问添加银行卡页面', '1', '访问添加银行卡页面', '2018-09-15 11:51:19');
INSERT INTO `pay_user_log` VALUES ('207', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问添加银行卡页面', '1', '访问添加银行卡页面', '2018-09-15 11:51:51');
INSERT INTO `pay_user_log` VALUES ('208', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问编辑银行卡页面', '1', '访问编辑银行卡页面', '2018-09-15 11:52:12');
INSERT INTO `pay_user_log` VALUES ('209', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问编辑银行卡页面', '1', '访问编辑银行卡页面', '2018-09-15 11:53:05');
INSERT INTO `pay_user_log` VALUES ('210', '127.0.0.1', 'user/account/addbankcard', '2', 'demouser', '访问编辑银行卡页面', '1', '访问编辑银行卡页面', '2018-09-15 11:54:17');
INSERT INTO `pay_user_log` VALUES ('211', '127.0.0.1', 'user/channel/index', '2', 'demouser', '查看通道费率', '1', '查看通道费率', '2018-09-15 11:58:22');
INSERT INTO `pay_user_log` VALUES ('212', '127.0.0.1', 'user/account/channelfinance', '2', 'demouser', '访问通道分析页面', '1', '访问通道分析页面', '2018-09-15 11:58:28');
INSERT INTO `pay_user_log` VALUES ('213', '127.0.0.1', 'user/account/reconciliation', '2', 'demouser', '访问对账单页面', '1', '访问对账单页面', '2018-09-15 12:08:33');
INSERT INTO `pay_user_log` VALUES ('214', '127.0.0.1', 'user/account/reconciliation', '2', 'demouser', '访问对账单页面', '1', '访问对账单页面', '2018-09-15 12:08:40');
INSERT INTO `pay_user_log` VALUES ('215', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 14:48:27');
INSERT INTO `pay_user_log` VALUES ('216', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 14:48:58');
INSERT INTO `pay_user_log` VALUES ('217', '127.0.0.1', 'user/channel/index', '2', 'demouser', '查看通道费率', '1', '查看通道费率', '2018-09-15 14:50:20');
INSERT INTO `pay_user_log` VALUES ('218', '127.0.0.1', 'user/account/channelfinance', '2', 'demouser', '访问通道分析页面', '1', '访问通道分析页面', '2018-09-15 14:53:20');
INSERT INTO `pay_user_log` VALUES ('219', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问手工补发订单列表页面', '1', '访问手工补发订单订单列表页面', '2018-09-15 14:56:47');
INSERT INTO `pay_user_log` VALUES ('220', '127.0.0.1', 'user/channel/apidocumnet', '2', 'demouser', '查看API密钥', '1', '查看API密钥', '2018-09-15 14:56:51');
INSERT INTO `pay_user_log` VALUES ('221', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-15 14:56:55');
INSERT INTO `pay_user_log` VALUES ('222', '127.0.0.1', 'user/order/show', '2', 'demouser', '查看订单', '1', '查看订单，ID：730', '2018-09-15 14:56:58');
INSERT INTO `pay_user_log` VALUES ('223', '127.0.0.1', 'user/withdrawal/check', '2', 'demouser', '访问商户代付页面', '1', '访问商户代付页面', '2018-09-15 14:57:03');
INSERT INTO `pay_user_log` VALUES ('224', '127.0.0.1', 'user/withdrawal/showdf', '2', 'demouser', '访问商户代付详情', '1', 'ID：39', '2018-09-15 14:57:08');
INSERT INTO `pay_user_log` VALUES ('225', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 14:57:16');
INSERT INTO `pay_user_log` VALUES ('226', '127.0.0.1', 'user/withdrawal/index', '2', 'demouser', '访问结算记录', '1', '访问结算记录', '2018-09-15 14:57:19');
INSERT INTO `pay_user_log` VALUES ('227', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 14:57:32');
INSERT INTO `pay_user_log` VALUES ('228', '127.0.0.1', 'user/withdrawal/index', '2', 'demouser', '访问结算记录', '1', '访问结算记录', '2018-09-15 14:57:34');
INSERT INTO `pay_user_log` VALUES ('229', '127.0.0.1', 'user/withdrawal/payment', '2', 'demouser', '访问代付记录', '1', '访问代付记录', '2018-09-15 14:57:35');
INSERT INTO `pay_user_log` VALUES ('230', '127.0.0.1', 'user/withdrawal/index', '2', 'demouser', '访问结算记录', '1', '访问结算记录', '2018-09-15 14:57:37');
INSERT INTO `pay_user_log` VALUES ('231', '127.0.0.1', 'user/withdrawal/index', '2', 'demouser', '访问结算记录', '1', '访问结算记录', '2018-09-15 14:58:43');
INSERT INTO `pay_user_log` VALUES ('232', '127.0.0.1', 'user/withdrawal/payment', '2', 'demouser', '访问代付记录', '1', '访问代付记录', '2018-09-15 14:58:45');
INSERT INTO `pay_user_log` VALUES ('233', '127.0.0.1', 'user/withdrawal/check', '2', 'demouser', '访问商户代付页面', '1', '访问商户代付页面', '2018-09-15 14:58:51');
INSERT INTO `pay_user_log` VALUES ('234', '127.0.0.1', 'user/withdrawal/check', '2', 'demouser', '访问商户代付页面', '1', '访问商户代付页面', '2018-09-15 14:59:42');
INSERT INTO `pay_user_log` VALUES ('235', '127.0.0.1', 'user/withdrawal/payment', '2', 'demouser', '访问代付记录', '1', '访问代付记录', '2018-09-15 14:59:45');
INSERT INTO `pay_user_log` VALUES ('236', '127.0.0.1', 'user/withdrawal/index', '2', 'demouser', '访问结算记录', '1', '访问结算记录', '2018-09-15 15:04:31');
INSERT INTO `pay_user_log` VALUES ('237', '127.0.0.1', 'user/withdrawal/check', '2', 'demouser', '访问商户代付页面', '1', '访问商户代付页面', '2018-09-15 15:04:38');
INSERT INTO `pay_user_log` VALUES ('238', '127.0.0.1', 'user/withdrawal/payment', '2', 'demouser', '访问代付记录', '1', '访问代付记录', '2018-09-15 15:04:46');
INSERT INTO `pay_user_log` VALUES ('239', '127.0.0.1', 'user/index/gonggao', '2', 'demouser', '访问公告列表', '1', '访问公告列表', '2018-09-15 15:05:12');
INSERT INTO `pay_user_log` VALUES ('240', '127.0.0.1', 'user/account/qrcode', '2', 'demouser', '访问收款二维码页面', '1', '访问收款二维码页面', '2018-09-15 15:05:18');
INSERT INTO `pay_user_log` VALUES ('241', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 15:05:27');
INSERT INTO `pay_user_log` VALUES ('242', '127.0.0.1', 'user/index/main', '180586950', 'test2', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 16:10:57');
INSERT INTO `pay_user_log` VALUES ('243', '127.0.0.1', 'user/channel/index', '180586950', 'test2', '查看通道费率', '1', '查看通道费率', '2018-09-15 16:11:00');
INSERT INTO `pay_user_log` VALUES ('244', '127.0.0.1', 'user/channel/index', '180586950', 'test2', '查看通道费率', '1', '查看通道费率', '2018-09-15 16:11:44');
INSERT INTO `pay_user_log` VALUES ('245', '127.0.0.1', 'user/channel/index', '180586950', 'test2', '查看通道费率', '1', '查看通道费率', '2018-09-15 16:12:22');
INSERT INTO `pay_user_log` VALUES ('246', '127.0.0.1', 'user/channel/index', '180586950', 'test2', '查看通道费率', '1', '查看通道费率', '2018-09-15 16:13:08');
INSERT INTO `pay_user_log` VALUES ('247', '127.0.0.1', 'user/index/main', '3', 'ceishi_1', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 16:16:11');
INSERT INTO `pay_user_log` VALUES ('248', '127.0.0.1', 'user/order/index', '3', 'ceishi_1', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-15 16:16:15');
INSERT INTO `pay_user_log` VALUES ('249', '127.0.0.1', 'user/agent/member', '3', 'ceishi_1', '访问下级商户列表', '1', '访问下级商户列表', '2018-09-15 16:16:17');
INSERT INTO `pay_user_log` VALUES ('250', '127.0.0.1', 'user/agent/userrateedit', '3', 'ceishi_1', '访问下级商户费率设置页面', '1', 'ID：4', '2018-09-15 16:16:19');
INSERT INTO `pay_user_log` VALUES ('251', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 18:01:49');
INSERT INTO `pay_user_log` VALUES ('252', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-15 18:01:55');
INSERT INTO `pay_user_log` VALUES ('253', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:02:01');
INSERT INTO `pay_user_log` VALUES ('254', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-15 18:02:41');
INSERT INTO `pay_user_log` VALUES ('255', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:02:49');
INSERT INTO `pay_user_log` VALUES ('256', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:08:18');
INSERT INTO `pay_user_log` VALUES ('257', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:08:29');
INSERT INTO `pay_user_log` VALUES ('258', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:08:44');
INSERT INTO `pay_user_log` VALUES ('259', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:08:55');
INSERT INTO `pay_user_log` VALUES ('260', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-15 18:09:17');
INSERT INTO `pay_user_log` VALUES ('261', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:09:44');
INSERT INTO `pay_user_log` VALUES ('262', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:12:42');
INSERT INTO `pay_user_log` VALUES ('263', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:13:04');
INSERT INTO `pay_user_log` VALUES ('264', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:13:25');
INSERT INTO `pay_user_log` VALUES ('265', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:13:46');
INSERT INTO `pay_user_log` VALUES ('266', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-15 18:15:08');
INSERT INTO `pay_user_log` VALUES ('267', '127.0.0.1', 'user/withdrawal/clearing', '2', 'demouser', '访问结算申请页面', '1', '访问结算申请页面', '2018-09-15 18:15:29');
INSERT INTO `pay_user_log` VALUES ('268', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:15:34');
INSERT INTO `pay_user_log` VALUES ('269', '127.0.0.1', 'user/withdrawal/entrusted', '2', 'demouser', '访问代付申请页面', '1', 'EXCEL导入方式', '2018-09-15 18:15:35');
INSERT INTO `pay_user_log` VALUES ('270', '127.0.0.1', 'user/withdrawal/entrusted', '2', 'demouser', '访问代付申请页面', '1', 'EXCEL导入方式', '2018-09-15 18:15:56');
INSERT INTO `pay_user_log` VALUES ('271', '127.0.0.1', 'user/withdrawal/dfapply', '2', 'demouser', '访问代付申请页面', '1', '表单提交方式', '2018-09-15 18:16:02');
INSERT INTO `pay_user_log` VALUES ('272', '127.0.0.1', 'user/account/changerecord', '2', 'demouser', '访问资金变动记录页面', '1', '访问资金变动记录页面', '2018-09-15 18:27:36');
INSERT INTO `pay_user_log` VALUES ('273', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 20:28:02');
INSERT INTO `pay_user_log` VALUES ('274', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 20:37:25');
INSERT INTO `pay_user_log` VALUES ('275', '127.0.0.1', 'user/index/main', '2', 'demouser', '访问商户中心首页', '1', '访问商户中心首页', '2018-09-15 20:39:18');
INSERT INTO `pay_user_log` VALUES ('276', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问所有订单列表页面', '1', '访问所有订单订单列表页面', '2018-09-15 20:39:22');
INSERT INTO `pay_user_log` VALUES ('277', '127.0.0.1', 'user/order/index', '2', 'demouser', '访问未支付订单列表页面', '1', '访问未支付订单订单列表页面', '2018-09-15 20:39:25');
INSERT INTO `pay_user_log` VALUES ('278', '127.0.0.1', 'user/channel/apidocumnet', '2', 'demouser', '查看API密钥', '1', '查看API密钥', '2018-09-15 20:39:29');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COMMENT='交易配置';

-- ----------------------------
-- Records of pay_user_riskcontrol_config
-- ----------------------------
INSERT INTO `pay_user_riskcontrol_config` VALUES ('1', '0', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '1', '0', '1536919133', '0', 'i', '0', '', '0');
INSERT INTO `pay_user_riskcontrol_config` VALUES ('2', '2', '0.01', '10000.00', '0.00', '0.00', '0', '0', '0', '0', '0', '1535770844', '1529459042', 's', '0', '', '0');
INSERT INTO `pay_user_riskcontrol_config` VALUES ('3', '180586947', '0.00', '0.00', '0.00', '0.00', '0', '0', '0', '0', '0', '0', '1529460257', 's', '0', '', '1');

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
  `user_login_verify_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '用户登录二次验证类型 0：不进行二次验证， 1：短信验证 2：谷歌令牌验证',
  `admin_login_sms` tinyint(1) NOT NULL DEFAULT '0' COMMENT '管理员登录是否需要短信验证 0：不需要 1：需要',
  `max_auth_error_times` int(10) NOT NULL DEFAULT '5' COMMENT '验证错误最大次数',
  `auth_error_ban_time` int(10) NOT NULL DEFAULT '10' COMMENT '验证错误超限冻结时间（分钟）',
  `document_url` varchar(255) NOT NULL DEFAULT '' COMMENT '对接文档链接',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_websiteconfig
-- ----------------------------
INSERT INTO `pay_websiteconfig` VALUES ('1', 'api支付系统', 'www.zuyapi.loc', 'support@pay.com', '4001234456', '', 'manage', '沪ICP备12031756号', '', 'pay9', '1', '1', '1', '', '0d6de302cbc615de3b09463acea87662', '0', '5', ' ', '1', '0', '1', 'Uploads/logo/5b9cab4aeb876.png', '0', '1', '0', '0', '0', '5', '10', 'http://www.baidu.com');

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
  `tkmoney` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '提款金额',
  `sxfmoney` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '手续费',
  `money` decimal(10,4) unsigned NOT NULL DEFAULT '0.0000' COMMENT '实际到账',
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
  `auto_query_num` int(10) NOT NULL DEFAULT '0' COMMENT '自动查询次数',
  `channel_mch_id` varchar(50) NOT NULL DEFAULT '' COMMENT '通道商户号',
  `df_charge_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '扣除手续费方式，0：从到账金额里扣，1：从商户余额里扣',
  `transaction_id` varchar(50) NOT NULL DEFAULT '' COMMENT '上游订单号',
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `df_id` (`df_id`),
  KEY `orderid` (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pay_wttklist
-- ----------------------------
INSERT INTO `pay_wttklist` VALUES ('20', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-05-30 11:03:46', null, '0', '100.0000', '5.0000', '95.0000', '0', '0', null, '', ' ', '0', ' ', 'H0530494268984682', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '1', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('21', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-05-30 11:27:50', null, '0', '100.0000', '5.0000', '95.0000', '0', '0', null, '', ' ', '0', ' ', 'H0530508708137860', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '1', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('24', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-05-30 11:38:37', null, '0', '101.0000', '5.0000', '96.0000', '0', '0', null, '', ' ', '0', ' ', 'H0530515178959059', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '1', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('25', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-05-30 11:38:37', null, '0', '102.0000', '5.0000', '97.0000', '0', '0', null, '', ' ', '0', ' ', 'H0530515178975627', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '1', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('26', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-05-30 11:38:37', null, '0', '103.0000', '5.0000', '98.0000', '0', '0', null, '', ' ', '0', ' ', 'H0530515178985969', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '1', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('27', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-05-30 11:38:37', null, '0', '104.0000', '5.0000', '99.0000', '0', '0', null, '', ' ', '0', ' ', 'H0530515178996043', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '1', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('33', '2', '112121', '12121', '212121', '2121', '2121', '212121', '2018-06-01 13:27:20', '2018-06-22 11:38:37', '3', '100.0000', '5.0000', '95.0000', '0', '0', '参数错误，长度不正确（结算卡）', '', 'Dwj', '12', '80001爱农', 'H0601308400200127', '0.00', '0.0000', '0', '{\"lhh\":\"121\"}', '201806011322112911', '22', '0', '0', '0', '0', '0', 'OLP800001000001', '0', '');
INSERT INTO `pay_wttklist` VALUES ('34', '2', '234234', '23423', '23423', '234234234', '234', '43223', '2018-06-01 17:24:27', '2018-06-22 11:38:37', '3', '100.0000', '5.0000', '95.0000', '0', '0', '参数错误，长度不正确（结算卡）', '', 'Dwj', '12', '80001爱农', 'H0601450678889614', '0.00', '0.0000', '0', '{\"lhh\":\"4234\"}', '201806011724274583', '23', '0', '0', '0', '0', '0', 'OLP800001000001a', '0', '');
INSERT INTO `pay_wttklist` VALUES ('35', '2', '中国工商银行', '广州石牌支行', '23423', '马培坚', '234', '43223', '2018-06-01 17:26:42', '2018-06-11 12:06:42', '3', '100.0000', '5.0000', '95.0000', '0', '0', '', '', ' ', '0', ' ', 'H0601452020606953', '0.00', '0.0000', '0', '{\"lhh\":\"4234\"}', '201806011726412997', '24', '0', '0', '0', '0', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('36', '2', '112121', '12121', '212121', '2121', '2121', '212121', '2018-06-01 17:28:14', '2018-06-12 17:56:11', '4', '100.0000', '5.0000', '95.0000', '0', '0', '参数错误，长度不正确（结算卡）', '', 'Dwj', '12', '80001爱农', 'H0601452942112740', '0.00', '0.0000', '0', '{\"lhh\":\"121\"}', '201806011301195354', '4', '0', '0', '0', '0', '0', 'OLP800001000001a', '0', '');
INSERT INTO `pay_wttklist` VALUES ('37', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-06-19 10:10:07', null, '0', '100.0000', '5.0000', '95.0000', '1', '0', null, '', ' ', '0', ' ', 'H0619742079993539', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '1', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('38', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-06-19 10:11:00', null, '0', '100.0000', '10.0000', '90.0000', '1', '0', null, '', ' ', '0', ' ', 'H0619742604038068', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '1', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('39', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-06-19 10:11:41', null, '0', '100.0000', '5.0000', '95.0000', '0', '0', null, '', ' ', '0', ' ', 'H0619743012378377', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '1', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('40', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-06-19 15:45:51', '2018-06-25 10:21:00', '3', '100.1000', '10.0000', '0.0000', '1', '0', null, '', ' ', '0', ' ', 'H0619943515169736', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '0', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('41', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-06-19 15:48:15', '2018-06-25 10:21:00', '3', '100.1000', '10.0000', '90.1000', '1', '0', null, '', ' ', '0', ' ', 'H0619944954648462', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '0', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('42', '2', '1', '1', '1', '1', '1', '1', '2018-06-19 18:52:17', '2018-06-19 18:57:08', '3', '100.0000', '10.0000', '100.0000', '1', '0', '', '', ' ', '0', ' ', 'H0619055371166854', '0.00', '0.0000', '0', '{\"lhh\":\"1\"}', '201806191852168827', '25', '0', '0', '0', '0', '0', '', '1', '');
INSERT INTO `pay_wttklist` VALUES ('43', '2', '1', '1', '1', '1', '1', '1', '2018-06-19 19:00:45', '2018-06-19 19:01:51', '3', '100.0000', '10.0000', '100.0000', '1', '0', '', '', ' ', '0', ' ', 'H0619060459590870', '0.00', '0.0000', '0', '{\"lhh\":\"1\"}', '201806191900451071', '26', '0', '0', '0', '0', '0', '', '1', '');
INSERT INTO `pay_wttklist` VALUES ('44', '2', '1', '1', '1', '1', '1', '1', '2018-06-19 19:06:12', '2018-06-19 19:07:35', '3', '100.0000', '10.0000', '100.0000', '1', '0', '', '', ' ', '0', ' ', 'H0619063721985868', '0.00', '0.0000', '0', '{\"lhh\":\"1\"}', '201806191906119790', '27', '0', '0', '0', '0', '0', '', '1', '');
INSERT INTO `pay_wttklist` VALUES ('45', '2', '1', '1', '1', '1', '1', '1', '2018-06-19 19:08:18', '2018-06-19 19:08:40', '3', '100.0000', '10.0000', '100.0000', '1', '0', '', '', ' ', '0', ' ', 'H0619064980413981', '0.00', '0.0000', '0', '{\"lhh\":\"1\"}', '201806191908175000', '28', '0', '0', '0', '0', '0', '', '1', '');
INSERT INTO `pay_wttklist` VALUES ('46', '2', '1', '1', '1', '1', '1', '1', '2018-06-19 19:12:15', '2018-06-19 19:12:35', '3', '100.0000', '10.0000', '90.0000', '1', '0', '', '', ' ', '0', ' ', 'H0619067357067854', '0.00', '0.0000', '0', '{\"lhh\":\"1\"}', '201806191912154786', '32', '0', '0', '0', '0', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('47', '2', '1', '1', '1', '1', '1', '1', '2018-06-19 19:13:32', '2018-07-19 11:33:51', '3', '100.0000', '10.0000', '90.0000', '1', '0', '11', '', ' ', '0', ' ', 'H0619068120771385', '0.00', '0.0000', '0', '{\"lhh\":\"1\"}', '201806191913317717', '33', '0', '0', '0', '0', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('48', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东', '广州', '2018-06-28 10:18:38', '2018-06-30 10:34:19', '3', '100.0000', '10.0000', '90.0000', '1', '0', null, '[\"440582198705204311\",15815295199,\"102581001346\"]', ' ', '0', ' ', 'H0628523185113858', '0.00', '0.0000', '0', null, '', '0', '0', '0', '0', '0', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('49', '2', '234234', '2342', '23423', '234234', '23423', '234', '2018-06-29 10:22:54', '2018-06-30 10:34:19', '3', '100.0000', '10.0000', '100.0000', '1', '0', null, '', ' ', '0', ' ', 'H0629389743667787', '0.00', '0.0000', '0', '{\"lhh\":\"423\"}', '201806291022534278', '34', '0', '0', '0', '0', '0', '', '1', '');
INSERT INTO `pay_wttklist` VALUES ('50', '2', '234234', '2342', '23423', '234234', '23423', '234', '2018-06-29 10:25:15', '2018-06-29 10:25:15', '2', '100.0000', '10.0000', '100.0000', '1', '0', null, '', ' ', '0', ' ', 'H0629391156007288', '2.00', '0.0000', '0', '{\"lhh\":\"423\"}', '201806291024517591', '35', '0', '0', '0', '0', '0', '', '1', '');
INSERT INTO `pay_wttklist` VALUES ('51', '2', '234234', '2342', '23423', '234234', '23423', '234', '2018-06-29 10:34:57', '2018-06-29 10:34:57', '2', '100.0000', '10.0000', '100.0000', '1', '0', null, '', ' ', '0', ' ', 'H0629396970760452', '2.00', '0.0000', '0', '{\"lhh\":\"423\"}', '201806291034223932', '36', '0', '0', '0', '0', '0', '', '1', '');
INSERT INTO `pay_wttklist` VALUES ('52', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-06-30 10:33:50', '2018-06-30 10:34:19', '3', '100.0000', '10.0000', '90.0000', '1', '0', null, '', ' ', '0', ' ', 'H0630260306931630', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '0', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('53', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-05 17:07:21', null, '0', '100.0000', '10.0000', '0.0000', '1', '0', null, '', ' ', '0', ' ', 'H0705816414725453', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '1', '0', '', '1', '');
INSERT INTO `pay_wttklist` VALUES ('54', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-05 17:09:06', '2018-07-05 17:09:29', '3', '100.0000', '10.0000', '0.0000', '1', '0', '11', '', ' ', '0', ' ', 'H0705817466618089', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '0', '0', '', '1', '');
INSERT INTO `pay_wttklist` VALUES ('55', '2', '中国交通银行', '徐州支行', '6222620230003630000', '赵宇阳', '江苏', '徐州', '2018-07-05 17:13:30', null, '0', '100.0000', '10.0000', '0.0000', '1', '0', null, '[]', ' ', '0', ' ', 'H0705820102870986', '0.00', '0.0000', '0', null, '', '0', '0', '0', '0', '1', '0', '', '0', '');
INSERT INTO `pay_wttklist` VALUES ('56', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-10 20:08:53', null, '4', '100.0000', '10.0000', '0.0000', '1', '0', '错误：缺少银行编码', '', 'Dy', '16', '独依代付', 'H0710245337763971', '0.00', '0.0000', '0', '', '', '0', '0', '0', '0', '0', '0', 'M000037', '1', '');
INSERT INTO `pay_wttklist` VALUES ('57', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-07-12 18:08:24', '2018-08-24 16:58:53', '3', '0.0100', '0.0000', '0.0100', '1', '0', '测试 - 2018-08-24 16:58:53<br>错误：ERR004：【数据验证】商户密钥验证失败！<br>ssss<br>ssds-2018-08-24 16:19:10', '', 'Dy', '16', '独依代付', 'H0712901040126824', '0.00', '0.0000', '0', '{\"opnbnk\":\"ICBC\"}', '', '0', '0', '0', '0', '0', '0', 'M000037', '1', '');
INSERT INTO `pay_wttklist` VALUES ('58', '2', '中国工商银行', '广州石牌支行', '6212263602033031881', '马培坚', '广东省', '广州市', '2018-08-28 16:47:39', null, '4', '100.0000', '5.0000', '100.0000', '1', '0', '错误：缺少银行编码', '', 'Dy', '16', '独依代付', 'H0828460590624913', '0.00', '0.0000', '0', '', '', '0', '1', '1', '1535766467', '0', '0', 'M000037', '1', '');
INSERT INTO `pay_wttklist` VALUES ('59', '2', '中国交通银行', '徐州支行', '6222620230003610000', '赵宇阳', '江苏', '徐州', '2018-08-28 16:51:57', null, '4', '100.0000', '5.0000', '100.0000', '1', '0', '错误：缺少银行编码', '[\"350569198802152233\",\"B2CPAY\"]', 'Dy', '16', '独依代付', 'H0828463177302237', '0.00', '0.0000', '0', null, '', '0', '1', '1', '1535766467', '0', '0', 'M000037', '1', '');
INSERT INTO `pay_wttklist` VALUES ('60', '2', '中国工商银行', '萍乡支行', '6222620230003610000', '王明明', '江西', '萍乡', '2018-08-28 16:51:57', null, '4', '100.0000', '5.0000', '100.0000', '1', '0', '错误：缺少银行编码', '[\"350569198802152233\",\"B2CPAY\"]', 'Dy', '16', '独依代付', 'H0828463177313788', '0.00', '0.0000', '0', null, '', '0', '1', '1', '1535766467', '0', '0', 'M000037', '1', '');
INSERT INTO `pay_wttklist` VALUES ('61', '2', '中国农业银行', '苏州支行', '6222620230003610000', '李三', '江苏', '苏州', '2018-08-28 16:51:57', '2018-09-03 16:35:44', '3', '100.0000', '5.0000', '100.0000', '1', '0', '1 - 2018-09-03 16:35:44<br>错误：缺少银行编码', '[\"350569198802152233\",\"B2CPAY\"]', 'Dy', '16', '独依代付', 'H0828463177330571', '0.00', '0.0000', '0', null, '', '0', '1', '1', '1535785895', '0', '0', 'M000037', '1', '');
