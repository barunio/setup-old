TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER pfki_default_report_bookmarks_apar_buil_buil_deve_tagi_user BEFORE INSERT ON default_report_bookmarks\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.apartment_id IS NULL, 0, 1) + IF(NEW.building_id IS NULL, 0, 1) + IF(NEW.building_upgrade_id IS NULL, 0, 1) + IF(NEW.development_id IS NULL, 0, 1) + IF(NEW.tag_id IS NULL, 0, 1) + IF(NEW.user_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END' 'CREATE DEFINER=`root`@`%` TRIGGER pfku_default_report_bookmarks_apar_buil_buil_deve_tagi_user BEFORE UPDATE ON default_report_bookmarks\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.apartment_id IS NULL, 0, 1) + IF(NEW.building_id IS NULL, 0, 1) + IF(NEW.building_upgrade_id IS NULL, 0, 1) + IF(NEW.development_id IS NULL, 0, 1) + IF(NEW.tag_id IS NULL, 0, 1) + IF(NEW.user_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END'
sql_modes=1441267744 1441267744
definers='root@%' 'root@%'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8_general_ci' 'utf8_general_ci'
created=160539967301 160539967303
