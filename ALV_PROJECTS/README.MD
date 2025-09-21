
<img src="https://www.sap.com/content/dam/application/shared/logos/sap-logo-svg.svg" alt="SAP Logo" width="160" />

----
# 📚 ALV PROJECTS
## ALV Classicos

1. ALV simples com modulo de função [REUSE_ALV_LIST_DISPLAY](/ALV_PROJECTS/ALV/ZPROG_ALV_DISPLAY_ERI.ABAP) usando o catalogo de campos _REUSE_ALV_FIELDCATALOG_MERGE_.
2. ALV mais robusto com modulo de função [REUSE_ALV_GRID_DISPLAY](/ALV_PROJECTS/ALV/ZPROG_ALV_GRID_DISPLAY_ERI.ABAP), definindo manualmete o catalogo de campo.
3. ALV com modulo de função de catalogo de campos [REUSE_ALV_FIELDCATALOG_MERGE](/ALV_PROJECTS/ALV/ZPROG_ALV_FIELDCATALOG_MER_ERI.ABAP). Porém, alterando suas propriedades para exibir ALV com campos diferente
4. ALV com Hieraquia e ordenação com modulo de função [REUSE_ALV_HIERSEQ_LIST_DISPLAY](/ALV_PROJECTS/ALV/ZPROG_ALV_HIERSEQ_ERI.ABAP) usando duas tabelas internas para exibição.
5. Exibir ALV em bloco. Mostrando dois ALV em tela usando modulos de função [REUSE_ALV_BLOCK_LIST_INIT, REUSE_ALV_BLOCK_LIST_APPEND e REUSE_ALV_BLOCK_LIST_DISPLAY](/ALV_PROJECTS/ALV/ZPROG_ALV_BLOCK_ERI.ABAP)
6. ALV com campo *ERDAT* ordernado usando modulo de função [REUSE_ALV_GRID_DISPLAY](/ALV_PROJECTS/ALV/ZPROG_ALV_DISPLAY_SORT_ERI.ABAP) usando parametro *IT_SORT*.
7. Por filtro fixo no ALV pelo modulo de função [REUSE_ALV_GRID_DISPLAY](/ALV_PROJECTS/ALV/ZPROG_ALV_DISPLAY_FILTER_ERI.ABAP) usando parametro *IT_FILTER*.
8. Usando o parametro *IT_FILTER* do module de função [REUSE_ALV_GRID_DISPLAY](/ALV_PROJECTS/ALV/ZPROG1_ALV_DISPLAY_FILTER_ERI.ABAP) para aplicar fitros fixo com range e com exclusão.
9. Criando titulo no ALV usando modulo de função [REUSE_ALV_COMMENTARY_WRITE](/ALV_PROJECTS/ALV/ZPROG_ALV_TOP_OF_PAGE_ERI.ABAP) com parametros *I_CALLBACK_TOP_OF_PAGE* e *I_CALLBACK_PROGRAM* do *REUSE_ALV_GRID_DISPLAY*.
10. ALV com titulo de cabeçalho com número de linhas e valores inseridos sendo exibidos com modulo de função [REUSE_ALV_COMMENTARY_WRITE](/ALV_PROJECTS/ALV/ZPROG1_ALV_TOP_OF_PAGE_ERI.ABAP)

## ALV OOP

1. ALV simples com classes [CL_GUI_ALV_GRID, CL_GUI_CUSTOM_CONTAINER](/ALV_PROJECTS/ALV/ZPRG002_ALV_OOP_ERI.ABAP) e com catálogo de campos standard do modulo de função *LVC_FIELDCATALOG_MERGE*.
2. Alterando os campos do ALV usando [MODIFY e TRANSPORTING](/ALV_PROJECTS/ALV/ZPRG003_ALV_OOP_ERI.ABAP) mantendo o modulo de função *LVC_FIELDCATALOG_MERGE*.
3. Usando parametro *IT_SORT* do method [SET_TABLE_FOR_FIRST_DISPLAY](/ALV_PROJECTS/ALV/ZPRG004_ALV_OOP_ERI.ABAP) para ordernar ALV por coluna pré definida com *APPEND*.
3. Usando parametro *IT_FILTER* do method [SET_TABLE_FOR_FIRST_DISPLAY](/ALV_PROJECTS/ALV/ZPRG005_ALV_OOP_ERI.ABAP) para filtrar valores no ALV usando estrura de *RANGE*.
