TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER pfki_trash_raw_data_compliancemeterid_meterid BEFORE INSERT ON trash_raw_data\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.compliance_meter_id IS NULL, 0, 1) + IF(NEW.meter_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END' 'CREATE DEFINER=`root`@`%` TRIGGER pfku_trash_raw_data_compliancemeterid_meterid BEFORE UPDATE ON trash_raw_data\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.compliance_meter_id IS NULL, 0, 1) + IF(NEW.meter_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END'
sql_modes=1441267744 1441267744
definers='root@%' 'root@%'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8_general_ci' 'utf8_general_ci'
created=161881190283 161881190284
