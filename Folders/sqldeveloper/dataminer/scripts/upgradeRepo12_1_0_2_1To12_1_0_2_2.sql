ALTER session set current_schema = "ODMRSYS";

@@version.sql

DEFINE OLD_REPOSITORY_VERSION = '12.1.0.2.1'
DEFINE NEW_REPOSITORY_VERSION = '12.1.0.2.2'

EXECUTE dbms_output.put_line('Start repository upgrade from ' || '&OLD_REPOSITORY_VERSION' || ' to ' || '&NEW_REPOSITORY_VERSION' || '. ' || systimestamp);


DECLARE
  REPOS_VERSION VARCHAR2(30);
  DB_VER VARCHAR2(30);
BEGIN
  SELECT PROPERTY_STR_VALUE INTO REPOS_VERSION FROM ODMRSYS.ODMR$REPOSITORY_PROPERTIES WHERE PROPERTY_NAME = 'VERSION';
  SELECT VERSION INTO DB_VER FROM PRODUCT_COMPONENT_VERSION WHERE PRODUCT LIKE 'Oracle Database%' OR PRODUCT LIKE 'Personal Oracle Database %';
  IF ( repos_version = '&OLD_REPOSITORY_VERSION' ) THEN

    BEGIN
        EXECUTE IMMEDIATE 'ALTER TABLE ODMRSYS.ODMR$WF_LOG MODIFY JOB_NAME NULL';
        EXECUTE IMMEDIATE 'ALTER TABLE ODMRSYS.ODMR$WF_LOG MODIFY PROJ_NAME NULL';
        EXECUTE IMMEDIATE 'ALTER TABLE ODMRSYS.ODMR$WF_LOG MODIFY PROJ_ID NULL';
        EXECUTE IMMEDIATE 'ALTER TABLE ODMRSYS.ODMR$WF_LOG MODIFY WF_NAME NULL';
        EXECUTE IMMEDIATE 'ALTER TABLE ODMRSYS.ODMR$WF_LOG MODIFY WF_ID NULL';
        EXECUTE IMMEDIATE 'ALTER TABLE ODMRSYS.ODMR$WF_LOG MODIFY NODE_NAME NULL';
        EXECUTE IMMEDIATE 'ALTER TABLE ODMRSYS.ODMR$WF_LOG MODIFY NODE_ID NULL';
        
        EXECUTE IMMEDIATE 'ALTER TABLE ODMRSYS.ODMR$WF_LOG
        ADD CONSTRAINT WF_LOG_NOT_NULL CHECK ((PROJ_NAME||PROJ_ID||WF_NAME||WF_ID) IS NOT NULL)';
    END;

    EXECUTE IMMEDIATE 'INSERT INTO ODMRSYS.ODMR$REPOSITORY_PROPERTIES (PROPERTY_NAME, PROPERTY_NUM_VALUE, "COMMENT") VALUES (''THREAD_WAIT_TIME'', 5, ''When MAX_NUM_THREADS is reached, further Build process will be put on queue until parallel model build count < MAX_NUM_THREADS. This setting (in seconds) determines how often to check for parallel model build count.'')';
    EXECUTE IMMEDIATE 'INSERT INTO ODMRSYS.ODMR$REPOSITORY_PROPERTIES (PROPERTY_NAME, PROPERTY_NUM_VALUE, "COMMENT") VALUES (''MAX_THREAD_WAIT'', NULL, ''The timeout (in seconds) for Build process that has been put on queue. If NULL, no timeout will occur.'')';
    COMMIT;
    
    IF (DB_VER >= '11.2.0.4' ) THEN
      EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW ODMRSYS.ODMR_ALL_WF_CLAS_TEST_RESULTS
        AS SELECT * FROM (
        WITH "N$10001" AS (
          SELECT 
          P.USER_NAME, P.PROJECT_ID, P.PROJECT_NAME, X.WORKFLOW_ID, X.WORKFLOW_NAME,
          NODE_TYPE, NODE_ID, NODE_NAME, NODE_STATUS,
          MODEL_ID, MODEL_NAME, MODEL_STATUS, RESULT_CREATIONDATE, TEST_METRICS, CONFUSION_MATRIX,
          RESULT_TYPE, RESULT_NAME, ROC_AREA, TARGET_VALUE
            FROM ODMRSYS.ODMR$WORKFLOWS X, ODMRSYS.ODMR$PROJECTS P,
                 XMLTABLE(XMLNAMESPACES(DEFAULT ''http://xmlns.oracle.com/odmr11''),
                          ''/WorkflowProcess/Nodes/*''
                          PASSING X.WORKFLOW_DATA
                          COLUMNS NODE_TYPE  VARCHAR2(30) PATH ''name()'',
                                  NODE_ID    NUMBER  PATH ''@Id'',
                                  NODE_NAME  VARCHAR2(30)  PATH ''@Name'',
                                  NODE_STATUS VARCHAR2(10)  PATH ''@Status'',
                                  RESULTS XMLTYPE PATH ''Results/ClassificationResult'') XTAB,
                 XMLTABLE(XMLNAMESPACES(DEFAULT ''http://xmlns.oracle.com/odmr11''),
                          ''/ClassificationResult''
                          PASSING XTAB.RESULTS
                          COLUMNS MODEL_ID    NUMBER  PATH ''@ModelId'',
                                  MODEL_NAME  VARCHAR2(30)  PATH ''@Name'',
                                  MODEL_STATUS VARCHAR2(10)  PATH ''@Status'',
                                  RESULT_CREATIONDATE VARCHAR2(30)  PATH ''@CreationDate'',
                                  TEST_METRICS VARCHAR2(128)  PATH ''TestMetrics/@Name'',
                                  CONFUSION_MATRIX VARCHAR2(128)  PATH ''ConfusionMatrix/@Name'',
                                  RESULTS XMLTYPE PATH ''*'') XTAB2,
                 XMLTABLE(XMLNAMESPACES(DEFAULT ''http://xmlns.oracle.com/odmr11''),
                          ''/*/*''
                          PASSING XTAB2.RESULTS
                          COLUMNS RESULT_TYPE  VARCHAR2(30) PATH ''name()'',
                                  RESULT_NAME  VARCHAR2(128)  PATH ''@Name'',
                                  ROC_AREA        NUMBER  PATH ''@Area'',
                                  TARGET_VALUE VARCHAR2(4000)  PATH ''@TargetValue'')
          WHERE
            P.PROJECT_ID = X.PROJECT_ID (+)
        ),
        "N$10002" AS (
          SELECT DISTINCT
          USER_NAME, PROJECT_ID, PROJECT_NAME, WORKFLOW_ID, WORKFLOW_NAME,
          NODE_TYPE, NODE_ID, NODE_NAME, NODE_STATUS,
          MODEL_ID, MODEL_NAME, MODEL_STATUS, RESULT_CREATIONDATE, TEST_METRICS, CONFUSION_MATRIX
          FROM "N$10001"
        ),
        "N$10003" AS (
        SELECT WORKFLOW_ID, NODE_ID, MODEL_ID,
            CAST(COLLECT(DM_NESTED_CATEGORICAL(ID1, RESULT_STATS)) AS DM_NESTED_CATEGORICALS) LIFTS
            FROM
                (SELECT WORKFLOW_ID, NODE_ID, MODEL_ID, RESULT_TYPE,
                (TARGET_VALUE) ID1,
                STATS_MODE(RESULT_NAME) RESULT_STATS
                FROM "N$10001"  
                GROUP BY WORKFLOW_ID, NODE_ID , MODEL_ID, RESULT_TYPE, TARGET_VALUE HAVING RESULT_TYPE=''Lift'')
             GROUP BY WORKFLOW_ID, NODE_ID, MODEL_ID, RESULT_TYPE
        ),
        "N$10004" AS (
        SELECT WORKFLOW_ID, NODE_ID, MODEL_ID,
            CAST(COLLECT(DM_NESTED_CATEGORICAL(ID1, RESULT_STATS)) AS DM_NESTED_CATEGORICALS) ROCS
            FROM
                (SELECT WORKFLOW_ID, NODE_ID, MODEL_ID, RESULT_TYPE,
                (TARGET_VALUE) ID1,
                STATS_MODE(RESULT_NAME) RESULT_STATS
                FROM "N$10001"  
                GROUP BY WORKFLOW_ID, NODE_ID , MODEL_ID, RESULT_TYPE, TARGET_VALUE HAVING RESULT_TYPE=''ROC'')
             GROUP BY WORKFLOW_ID, NODE_ID, MODEL_ID, RESULT_TYPE
        ),
        "N$10005" AS (
        SELECT WORKFLOW_ID, NODE_ID, MODEL_ID,
            CAST(COLLECT(DM_NESTED_NUMERICAL(ID1, RESULT_STATS)) AS DM_NESTED_NUMERICALS) ROC_AREA
            FROM
                (SELECT WORKFLOW_ID, NODE_ID, MODEL_ID, RESULT_TYPE,
                (TARGET_VALUE) ID1,
                MAX(ROC_AREA) RESULT_STATS
                FROM "N$10001"  
                GROUP BY WORKFLOW_ID, NODE_ID , MODEL_ID, RESULT_TYPE, TARGET_VALUE HAVING RESULT_TYPE=''AreaUnderCurve'')
             GROUP BY WORKFLOW_ID, NODE_ID, MODEL_ID, RESULT_TYPE
        )
        SELECT
          A.USER_NAME, A.PROJECT_ID, A.PROJECT_NAME, A.WORKFLOW_ID, A.WORKFLOW_NAME,
          A.NODE_TYPE, A.NODE_ID, A.NODE_NAME, A.NODE_STATUS,
          A.MODEL_ID, A.MODEL_NAME, A.MODEL_STATUS, A.RESULT_CREATIONDATE, 
          A.TEST_METRICS, A.CONFUSION_MATRIX,
          B.LIFTS, C.ROCS, D.ROC_AREA
        FROM
          "N$10002" A, "N$10003" B, "N$10004" C, "N$10005" D
        WHERE A.WORKFLOW_ID = B.WORKFLOW_ID AND A.NODE_ID = B.NODE_ID AND A.MODEL_ID = B.MODEL_ID
        AND A.WORKFLOW_ID = C.WORKFLOW_ID AND A.NODE_ID = C.NODE_ID AND A.MODEL_ID = C.MODEL_ID
        AND A.WORKFLOW_ID = D.WORKFLOW_ID AND A.NODE_ID = D.NODE_ID AND A.MODEL_ID = D.MODEL_ID)';
  
      EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW ODMRSYS.ODMR_USER_WF_CLAS_TEST_RESULTS AS SELECT
          PROJECT_ID, 
          PROJECT_NAME, 
          WORKFLOW_ID, 
          WORKFLOW_NAME,
          NODE_TYPE, 
          NODE_ID, 
          NODE_NAME, 
          NODE_STATUS,
          MODEL_ID, 
          MODEL_NAME, 
          MODEL_STATUS, 
          RESULT_CREATIONDATE, 
          TEST_METRICS, 
          CONFUSION_MATRIX,
          LIFTS, 
          ROCS, 
          ROC_AREA
        FROM
          ODMRSYS.ODMR_ALL_WF_CLAS_TEST_RESULTS
        WHERE 
          ODMR_ALL_WF_CLAS_TEST_RESULTS.USER_NAME = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
      EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_WF_CLAS_TEST_RESULTS FOR ODMRSYS.ODMR_USER_WF_CLAS_TEST_RESULTS';
      EXECUTE IMMEDIATE 'GRANT SELECT ON ODMR_USER_WF_CLAS_TEST_RESULTS TO ODMRUSER';
      
      EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW ODMRSYS.ODMR_ALL_WF_REGR_TEST_RESULTS
        AS SELECT 
          P.USER_NAME, P.PROJECT_ID, P.PROJECT_NAME, X.WORKFLOW_ID, X.WORKFLOW_NAME,
          NODE_TYPE, NODE_ID, NODE_NAME, NODE_STATUS,
          MODEL_ID, MODEL_NAME, MODEL_STATUS, RESULT_CREATIONDATE, TEST_METRICS, RESIDUAL_PLOT
            FROM ODMRSYS.ODMR$WORKFLOWS X, ODMRSYS.ODMR$PROJECTS P,
                 XMLTABLE(XMLNAMESPACES(DEFAULT ''http://xmlns.oracle.com/odmr11''),
                          ''/WorkflowProcess/Nodes/*''
                          PASSING X.WORKFLOW_DATA
                          COLUMNS NODE_TYPE  VARCHAR2(30) PATH ''name()'',
                                  NODE_ID    NUMBER  PATH ''@Id'',
                                  NODE_NAME  VARCHAR2(30)  PATH ''@Name'',
                                  NODE_STATUS VARCHAR2(10)  PATH ''@Status'',
                                  RESULTS XMLTYPE PATH ''Results/RegressionResult'') XTAB,
                 XMLTABLE(XMLNAMESPACES(DEFAULT ''http://xmlns.oracle.com/odmr11''),
                          ''/RegressionResult''
                          PASSING XTAB.RESULTS
                          COLUMNS MODEL_ID    NUMBER  PATH ''@ModelId'',
                                  MODEL_NAME  VARCHAR2(30)  PATH ''@Name'',
                                  MODEL_STATUS VARCHAR2(10)  PATH ''@Status'',
                                  RESULT_CREATIONDATE VARCHAR2(30)  PATH ''@CreationDate'',
                                  TEST_METRICS VARCHAR2(128)  PATH ''TestMetrics/@Name'',
                                  RESIDUAL_PLOT VARCHAR2(128)  PATH ''ResidualPlot/@Name'') XTAB2
          WHERE
            P.PROJECT_ID = X.PROJECT_ID (+)';
  
      EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW ODMRSYS.ODMR_USER_WF_REGR_TEST_RESULTS
        AS SELECT 
          USER_NAME, 
          PROJECT_ID, 
          PROJECT_NAME, 
          WORKFLOW_ID, 
          WORKFLOW_NAME,
          NODE_TYPE, 
          NODE_ID, 
          NODE_NAME, 
          NODE_STATUS,
          MODEL_ID, 
          MODEL_NAME, 
          MODEL_STATUS, 
          RESULT_CREATIONDATE, 
          TEST_METRICS, 
          RESIDUAL_PLOT
        FROM 
          ODMRSYS.ODMR_ALL_WF_REGR_TEST_RESULTS
        WHERE 
          ODMR_ALL_WF_REGR_TEST_RESULTS.USER_NAME = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
      EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_WF_REGR_TEST_RESULTS FOR ODMRSYS.ODMR_USER_WF_REGR_TEST_RESULTS';
      EXECUTE IMMEDIATE 'GRANT SELECT ON ODMR_USER_WF_REGR_TEST_RESULTS TO ODMRUSER';
      
      EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW ODMRSYS.ODMR_ALL_WF_TEST_RESULTS
        AS SELECT 
          USER_NAME, PROJECT_ID, PROJECT_NAME, WORKFLOW_ID, WORKFLOW_NAME,
          NODE_TYPE, NODE_ID, NODE_NAME, NODE_STATUS,
          MODEL_ID, MODEL_NAME, MODEL_STATUS, RESULT_CREATIONDATE, 
          TEST_METRICS, CONFUSION_MATRIX,
          LIFTS, ROCS, ROC_AREA, NULL "RESIDUAL_PLOT"
        FROM
          ODMRSYS.ODMR_ALL_WF_CLAS_TEST_RESULTS
        UNION ALL
        SELECT 
          USER_NAME, PROJECT_ID, PROJECT_NAME, WORKFLOW_ID, WORKFLOW_NAME,
          NODE_TYPE, NODE_ID, NODE_NAME, NODE_STATUS,
          MODEL_ID, MODEL_NAME, MODEL_STATUS, RESULT_CREATIONDATE,
          TEST_METRICS, NULL "CONFUSION_MATRIX",
          NULL "LIFTS", NULL "ROCS", NULL "ROC_AREA", RESIDUAL_PLOT
        FROM
          ODMRSYS.ODMR_ALL_WF_REGR_TEST_RESULTS';
          
      EXECUTE IMMEDIATE 'CREATE OR REPLACE VIEW ODMRSYS.ODMR_USER_WF_TEST_RESULTS
        AS SELECT 
          PROJECT_ID, PROJECT_NAME, WORKFLOW_ID, WORKFLOW_NAME,
          NODE_TYPE, NODE_ID, NODE_NAME, NODE_STATUS,
          MODEL_ID, MODEL_NAME, MODEL_STATUS, RESULT_CREATIONDATE, 
          TEST_METRICS, CONFUSION_MATRIX,
          LIFTS, ROCS, ROC_AREA, NULL "RESIDUAL_PLOT"
        FROM
          ODMRSYS.ODMR_USER_WF_CLAS_TEST_RESULTS
        UNION ALL
        SELECT 
          PROJECT_ID, PROJECT_NAME, WORKFLOW_ID, WORKFLOW_NAME,
          NODE_TYPE, NODE_ID, NODE_NAME, NODE_STATUS,
          MODEL_ID, MODEL_NAME, MODEL_STATUS, RESULT_CREATIONDATE,
          TEST_METRICS, NULL "CONFUSION_MATRIX",
          NULL "LIFTS", NULL "ROCS", NULL "ROC_AREA", RESIDUAL_PLOT
        FROM
          ODMRSYS.ODMR_USER_WF_REGR_TEST_RESULTS';
      EXECUTE IMMEDIATE 'CREATE OR REPLACE PUBLIC SYNONYM ODMR_USER_WF_TEST_RESULTS FOR ODMRSYS.ODMR_USER_WF_TEST_RESULTS';
      EXECUTE IMMEDIATE 'GRANT SELECT ON ODMR_USER_WF_TEST_RESULTS TO ODMRUSER';      
    END IF;

    -- uptick the VERSION
    UPDATE ODMRSYS.ODMR$REPOSITORY_PROPERTIES SET PROPERTY_STR_VALUE = '&NEW_REPOSITORY_VERSION' WHERE PROPERTY_NAME = 'VERSION';
    COMMIT;  
    dbms_output.put_line('Repository version updated to ' || '&NEW_REPOSITORY_VERSION' || '.');
  ELSE
    dbms_output.put_line('Upgrade is not necessary.');
  END IF;
  EXCEPTION WHEN OTHERS THEN
   dbms_output.put_line('Failure during upgrade: '||DBMS_UTILITY.FORMAT_ERROR_STACK());
   RAISE;
END;
/

EXECUTE dbms_output.put_line('End repository upgrade from ' || '&OLD_REPOSITORY_VERSION' || ' to ' || '&NEW_REPOSITORY_VERSION' || '. ' || systimestamp);
