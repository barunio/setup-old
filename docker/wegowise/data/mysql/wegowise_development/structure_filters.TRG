TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`%` TRIGGER pfki_structure_filters_benchmarcid_defaultrepor_reporttempla BEFORE INSERT ON structure_filters\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.benchmarc_id IS NULL, 0, 1) + IF(NEW.default_report_bookmark_id IS NULL, 0, 1) + IF(NEW.report_template_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END' 'CREATE DEFINER=`root`@`%` TRIGGER pfku_structure_filters_benchmarcid_defaultrepor_reporttempla BEFORE UPDATE ON structure_filters\n            FOR EACH ROW\n            BEGIN\n              IF(IF(NEW.benchmarc_id IS NULL, 0, 1) + IF(NEW.default_report_bookmark_id IS NULL, 0, 1) + IF(NEW.report_template_id IS NULL, 0, 1)) <> 1 THEN\n                SET NEW = \'Error\';\n              END IF;\n            END'
sql_modes=1441267744 1441267744
definers='root@%' 'root@%'
client_cs_names='utf8' 'utf8'
connection_cl_names='utf8_general_ci' 'utf8_general_ci'
db_cl_names='utf8_general_ci' 'utf8_general_ci'
created=160539967358 160539967360
