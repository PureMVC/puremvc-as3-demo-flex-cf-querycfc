/*
MySQL Data Transfer
Source Host: localhost
Source Database: flexcf
Target Host: localhost
Target Database: flexcf
Date: 17/10/2007 16:05:20
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for users
-- ----------------------------
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL auto_increment,
  `username` varchar(45) NOT NULL default '',
  `password` varchar(45) NOT NULL default '',
  PRIMARY KEY  USING BTREE (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `users` VALUES ('10', 'Steve', 'Grimmer');
INSERT INTO `users` VALUES ('5', 'Simon', 'Bailey');
INSERT INTO `users` VALUES ('12', 'Stefan', 'Richter');
