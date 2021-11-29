TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER pfki_meterings_apartmentid_areaid_buildingid_development BEFORE INSERT ON meterings\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.apartment_id IS NULL, 0, 1) + IF(NEW.area_id IS NULL, 0, 1) + IF(NEW.building_id IS NULL, 0, 1) + IF(NEW.development_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END' 'CREATE DEFINER=`root`@`%` TRIGGER pfku_meterings_apartmentid_areaid_buildingid_development BEFORE UPDATE ON meterings\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.apartment_id IS NULL, 0, 1) + IF(NEW.area_id IS NULL, 0, 1) + IF(NEW.building_id IS NULL, 0, 1) + IF(NEW.development_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END'
sql_modes=1441267744 1441267744
definers='root@%' 'root@%'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8_general_ci' 'utf8_general_ci'
created=160539967311 160539967312
