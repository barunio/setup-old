TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER pfki_notifications_featurepos_meterstabi_supplycont_utilitylog BEFORE INSERT ON notifications\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.feature_post_id IS NULL, 0, 1) + IF(NEW.meter_stability_result_id IS NULL, 0, 1) + IF(NEW.supply_contract_id IS NULL, 0, 1) + IF(NEW.utility_login_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END' 'CREATE DEFINER=`root`@`%` TRIGGER pfku_notifications_featurepos_meterstabi_supplycont_utilitylog BEFORE UPDATE ON notifications\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.feature_post_id IS NULL, 0, 1) + IF(NEW.meter_stability_result_id IS NULL, 0, 1) + IF(NEW.supply_contract_id IS NULL, 0, 1) + IF(NEW.utility_login_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END'
sql_modes=1441267744 1441267744
definers='root@%' 'root@%'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8_general_ci' 'utf8_general_ci'
created=161881190242 161881190243
