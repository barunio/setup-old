TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER pfki_premium_report_templates_buildin_buildin_develop_userid BEFORE INSERT ON premium_report_templates\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.building_id IS NULL, 0, 1) + IF(NEW.building_upgrade_id IS NULL, 0, 1) + IF(NEW.development_id IS NULL, 0, 1) + IF(NEW.user_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END' 'CREATE DEFINER=`root`@`%` TRIGGER pfku_premium_report_templates_buildin_buildin_develop_userid BEFORE UPDATE ON premium_report_templates\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.building_id IS NULL, 0, 1) + IF(NEW.building_upgrade_id IS NULL, 0, 1) + IF(NEW.development_id IS NULL, 0, 1) + IF(NEW.user_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END'
sql_modes=1441267744 1441267744
definers='root@%' 'root@%'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8_general_ci' 'utf8_general_ci'
created=161881190254 161881190255
