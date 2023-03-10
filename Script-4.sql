-- CONNECTION: name=PROD
-- New script in PROD.
-- Date: 23 de nov. de 2022
-- Time: 11:15:38
-- By Wesley

SELECT MEDICALRECORD
    , DOCUMENTTYPECODE
    , DOCUMENTNUMBER
    , PATIENTNAME
    , GENDER
    , BIRTHDATE
    , 'H2105' HOSPITALCODE
    , HOSPITALADMISSIONNUMBER
    , HOSPITALADMISSIONDATE
    , UNITCODE
    , UNITADMISSIONNUMBER
    , UNITADMISSIONDATETIME
    , BEDCODE
--    , UNITDISCHARGEDATETIME
    , DISCHARGECAUSE
    , HOSPITALDISCHARGEDATE
    , MEDICALDISCHARGEDATE
    , CREATEDATE
FROM V_INTEGRACAO_SCMI_X_EPIMED
    WHERE (HOSPITALDISCHARGEDATE IS NULL OR (cast(HOSPITALDISCHARGEDATE as timestamp)  > cast('NOW' as timestamp) - 5))
ORDER BY  HOSPITALDISCHARGEDATE asc , UNITADMISSIONDATETIME asc
