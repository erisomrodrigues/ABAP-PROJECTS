*&---------------------------------------------------------------------*
*& Report zprg_structure_with_clear_eri
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zprg_structure_with_clear_eri.

DATA: BEGIN OF ls_struct,
        a,b,c,d,e,f,g,h,
      END OF ls_struct.

CLEAR:
 ls_struct WITH abap_true,
 ls_struct-a,
 ls_struct-b.

 cl_demo_output=>display( ls_struct ).
