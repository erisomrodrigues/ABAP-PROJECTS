DATA: lt_sel_tab TYPE TABLE OF rsparams.

INSERT: VALUE #( selname = 'P_OV'  kind = 'P' sign = 'I' option = 'EQ' low = i_ov       high = space ) INTO TABLE lt_sel_tab,
                VALUE #( selname = 'P_ID'  kind = 'P' sign = 'I' option = 'EQ' low = i_id       high = space ) INTO TABLE lt_sel_tab,
                VALUE #( selname = 'P_EXP' kind = 'P' sign = 'I' option = 'EQ' low = i_exp      high = space ) INTO TABLE lt_sel_tab,
                VALUE #( selname = 'P_JOB' kind = 'P' sign = 'I' option = 'EQ' low = lv_jobname high = space ) INTO TABLE lt_sel_tab.
