CREATE OR REPLACE FUNCTION STATS_APEX.F_DATE(v_date IN VARCHAR2) RETURN NUMBER IS
    v_date1 DATE;
BEGIN
    select to_timestamp(v_date,'MMDDYYYY HH:MI AM') into v_date1 from dual;
        RETURN 1;
    Exception WHEN Others THEN
        RETURN 0;
END;
/
