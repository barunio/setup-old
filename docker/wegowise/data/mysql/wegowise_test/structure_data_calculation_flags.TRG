TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER pfki_structure_data_calculation_flags_apartme_buildin_develop BEFORE INSERT ON structure_data_calculation_flags\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.apartment_id IS NULL, 0, 1) + IF(NEW.building_id IS NULL, 0, 1) + IF(NEW.development_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END' 'CREATE DEFINER=`root`@`%` TRIGGER pfku_structure_data_calculation_flags_apartme_buildin_develop BEFORE UPDATE ON structure_data_calculation_flags\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.apartment_id IS NULL, 0, 1) + IF(NEW.building_id IS NULL, 0, 1) + IF(NEW.development_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END'
sql_modes=1441267744 1441267744
definers='root@%' 'root@%'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8_general_ci' 'utf8_general_ci'
created=161881190274 161881190275
