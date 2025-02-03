CLASS z2ui5_cl_demo_app_055 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        count    TYPE i,
        value    TYPE string,
        descr    TYPE string,
        icon     TYPE string,
        info     TYPE string,
        checkbox TYPE abap_bool,
      END OF ty_row.

    DATA t_tab TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.

    METHODS refresh_data.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_055 IMPLEMENTATION.


  METHOD refresh_data.

    DO 100 TIMES.
      DATA temp1 TYPE ty_row.
      CLEAR temp1.
      temp1-count = sy-index.
      temp1-value = 'red'.
      DATA temp2 TYPE z2ui5_cl_demo_app_055=>ty_row-info.
      IF sy-index < 50.
        temp2 = 'completed'.
      ELSE.
        temp2 = 'uncompleted'.
      ENDIF.
      temp1-info = temp2.
      temp1-descr = 'this is a description'.
      temp1-checkbox = abap_true.
      DATA ls_row LIKE temp1.
      ls_row = temp1.
      INSERT ls_row INTO TABLE t_tab.
    ENDDO.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.



  ENDMETHOD.
ENDCLASS.
