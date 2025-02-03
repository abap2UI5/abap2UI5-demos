CLASS z2ui5_cl_demo_app_003 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        title    TYPE string,
        value    TYPE string,
        descr    TYPE string,
        icon     TYPE string,
        info     TYPE string,
        selected TYPE abap_bool,
        checkbox TYPE abap_bool,
      END OF ty_row.

    TYPES temp1_dd5da6e718 TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
DATA t_tab TYPE temp1_dd5da6e718.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_003 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      DATA temp1 LIKE t_tab.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-title = 'row_01'.
      temp2-info = 'completed'.
      temp2-descr = 'this is a description'.
      temp2-icon = 'sap-icon://account'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'row_02'.
      temp2-info = 'incompleted'.
      temp2-descr = 'this is a description'.
      temp2-icon = 'sap-icon://account'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'row_03'.
      temp2-info = 'working'.
      temp2-descr = 'this is a description'.
      temp2-icon = 'sap-icon://account'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'row_04'.
      temp2-info = 'working'.
      temp2-descr = 'this is a description'.
      temp2-icon = 'sap-icon://account'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'row_05'.
      temp2-info = 'completed'.
      temp2-descr = 'this is a description'.
      temp2-icon = 'sap-icon://account'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'row_06'.
      temp2-info = 'completed'.
      temp2-descr = 'this is a description'.
      temp2-icon = 'sap-icon://account'.
      INSERT temp2 INTO TABLE temp1.
      t_tab = temp1.

      DATA view TYPE REF TO z2ui5_cl_xml_view.
      view = z2ui5_cl_xml_view=>factory( ).
      DATA page TYPE REF TO z2ui5_cl_xml_view.
      DATA temp5 TYPE xsdboolean.
      temp5 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
      page = view->shell(
          )->page(
              title           = 'abap2UI5 - List'
              navbuttonpress  = client->_event( 'BACK' )
                shownavbutton = temp5 ).

      page->list(
          headertext      = 'List Ouput'
          items           = client->_bind_edit( t_tab )
          mode            = `SingleSelectMaster`
          selectionchange = client->_event( 'SELCHANGE' )
          )->standard_list_item(
              title       = '{TITLE}'
              description = '{DESCR}'
              icon        = '{ICON}'
              info        = '{INFO}'
              press       = client->_event( 'TEST' )
              selected    = `{SELECTED}` ).

      client->view_display( view->stringify( ) ).

    ENDIF.

    CASE client->get( )-event.

      WHEN 'SELCHANGE'.
        DATA temp3 LIKE LINE OF t_tab.
        DATA temp4 LIKE sy-tabix.
        temp4 = sy-tabix.
        READ TABLE t_tab WITH KEY selected = abap_true INTO temp3.
        sy-tabix = temp4.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        client->message_box_display( `go to details for item ` && temp3-title ).

      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
