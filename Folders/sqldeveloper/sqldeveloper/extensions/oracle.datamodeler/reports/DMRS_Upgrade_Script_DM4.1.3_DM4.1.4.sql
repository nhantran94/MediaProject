-- Upgrade script for Reporting Schema from DM 4.1.3 (4.1.3.901) to DM 4.1.4 release or later

--==========ALTER TABLES==========
ALTER TABLE dmrs_schema_object ADD (model_ovid VARCHAR2 (36));
UPDATE dmrs_schema_object s SET s.model_ovid = (SELECT DISTINCT(t.model_ovid) FROM dmrs_tables t WHERE t.schema_ovid = s.schema_ovid);
UPDATE dmrs_schema_object s SET s.model_ovid = (SELECT DISTINCT(v.model_ovid) FROM dmrs_tableviews v WHERE v.schema_ovid = s.schema_ovid) WHERE s.model_ovid IS NULL;
UPDATE dmrs_schema_object s SET s.model_ovid = (SELECT DISTINCT(t.model_ovid) FROM dmrs_indexes i, dmrs_tables t WHERE i.container_ovid = t.ovid AND i.schema_ovid = s.schema_ovid) WHERE s.model_ovid IS NULL;

ALTER TABLE dmrs_diagram_elements ADD (Long_Name VARCHAR2 (256));
UPDATE dmrs_diagram_elements de SET de.long_name = (SELECT DECODE(t.schema_name, null, de.name, t.schema_name|| '.' || de.name) FROM dmrs_tables t WHERE t.ovid = de.ovid) WHERE de.type='Table';