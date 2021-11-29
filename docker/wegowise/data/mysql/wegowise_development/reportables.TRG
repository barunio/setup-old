TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER pfki_reportables_apartmenti_benchmarci_buildingid_developmen BEFORE INSERT ON reportables\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.apartment_id IS NULL, 0, 1) + IF(NEW.benchmarc_id IS NULL, 0, 1) + IF(NEW.building_id IS NULL, 0, 1) + IF(NEW.development_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END' 'CREATE DEFINER=`root`@`%` TRIGGER pfku_reportables_apartmenti_benchmarci_buildingid_developmen BEFORE UPDATE ON reportables\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.apartment_id IS NULL, 0, 1) + IF(NEW.benchmarc_id IS NULL, 0, 1) + IF(NEW.building_id IS NULL, 0, 1) + IF(NEW.development_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END'
sql_modes=1441267744 1441267744
definers='root@%' 'root@%'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8_general_ci' 'utf8_general_ci'
created=160539967342 160539967343
