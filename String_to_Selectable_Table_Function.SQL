CREATE OR REPLACE FUNCTION STATS_APEX.string_to_selectable_table ( p_string   IN VARCHAR2,  p_delimiter  IN VARCHAR2 DEFAULT ':')  
    RETURN t_str_row_tab PIPELINED  
   AS  
    n_row NUMBER := 1 ;  
    v_str VARCHAR2(4000) ;  
   BEGIN     
    v_str := trim(regexp_substr(p_string, '[^'|| p_delimiter || ']+', 1, n_row) ) ;  
    WHILE ( v_str is not null )  
    LOOP  
      PIPE ROW ( v_str );  
      n_row := n_row + 1 ;  
      v_str := trim(regexp_substr(p_string, '[^'|| p_delimiter || ']+', 1, n_row) ) ;  
    END LOOP;  
    RETURN;  
 END string_to_selectable_table;
/
