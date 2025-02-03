CLASS z2ui5_cl_demo_app_048 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        title         TYPE string,
        value         TYPE string,
        descr         TYPE string,
        icon          TYPE string,
        info          TYPE string,
        highlight     TYPE string,
        wrapcharlimit TYPE i,
        selected      TYPE abap_bool,
        checkbox      TYPE abap_bool,
      END OF ty_row.

    DATA t_tab TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_048 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      DATA temp1 LIKE t_tab.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-title = 'entry_01'.
      temp2-info = 'Information'.
      temp2-descr = 'this is a description1 1234567890 1234567890'.
      temp2-icon = 'sap-icon://badge'.
      temp2-highlight = 'Information'.
      temp2-wrapcharlimit = '100'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry_02'.
      temp2-info = 'Success'.
      temp2-descr = 'this is a description2 1234567890 1234567890'.
      temp2-icon = 'sap-icon://favorite'.
      temp2-highlight = 'Success'.
      temp2-wrapcharlimit = '10'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry_03'.
      temp2-info = 'Warning'.
      temp2-descr = 'this is a description3 1234567890 1234567890'.
      temp2-icon = 'sap-icon://employee'.
      temp2-highlight = 'Warning'.
      temp2-wrapcharlimit = '100'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry_04'.
      temp2-info = 'Error'.
      temp2-descr = 'this is a description4 1234567890 1234567890'.
      temp2-icon = 'sap-icon://accept'.
      temp2-highlight = 'Error'.
      temp2-wrapcharlimit = '10'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry_05'.
      temp2-info = 'None'.
      temp2-descr = 'this is a description5 1234567890 1234567890'.
      temp2-icon = 'sap-icon://activities'.
      temp2-highlight = 'None'.
      temp2-wrapcharlimit = '10'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry_06'.
      temp2-info = 'Information'.
      temp2-descr = 'this is a description6 1234567890 1234567890'.
      temp2-icon = 'sap-icon://account'.
      temp2-highlight = 'Information'.
      temp2-wrapcharlimit = '100'.
      INSERT temp2 INTO TABLE temp1.
      t_tab = temp1.

    ENDIF.

    CASE client->get( )-event.
      WHEN 'EDIT'.
        DATA lv_row_title TYPE string.
        lv_row_title = client->get_event_arg( 1 ).
        client->message_box_display( `EDIT - ` && lv_row_title ).
      WHEN 'SELCHANGE'.
        DATA lt_sel LIKE t_tab.
        lt_sel = t_tab.
        DELETE lt_sel WHERE selected = abap_false.
        DATA temp3 LIKE LINE OF lt_sel.
        DATA temp4 LIKE sy-tabix.
        temp4 = sy-tabix.
        READ TABLE lt_sel INDEX 1 INTO temp3.
        sy-tabix = temp4.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        client->message_box_display( `SELECTION_CHANGED -` && temp3-title ).
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = z2ui5_cl_xml_view=>factory( )->shell(
        )->page(
            title           = 'abap2UI5 - List'
            navbuttonpress  = client->_event( 'BACK' )
              shownavbutton = abap_true
            )->header_content(
                  )->link(
                    text   = 'Demo'
                    target = '_blank'
                    href   = `https://twitter.com/abap2UI5/status/1657279838586109953`
                )->link(
      )->get_parent( ).

    DATA temp5 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp5.
    DATA temp6 LIKE LINE OF temp5.
    temp6-n = `title`.
    temp6-v = '{TITLE}'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = `description`.
    temp6-v = '{DESCR}'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = `icon`.
    temp6-v = '{ICON}'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = `iconInset`.
    temp6-v = 'false'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = `highlight`.
    temp6-v = '{HIGHLIGHT}'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = `info`.
    temp6-v = '{INFO}'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = `infoState`.
    temp6-v = '{HIGHLIGHT}'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = `infoStateInverted`.
    temp6-v = 'true'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'type'.
    temp6-v = `Detail`.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'wrapping'.
    temp6-v = `true`.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'wrapCharLimit'.
    temp6-v = `{WRAPCHARLIMIT}`.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'selected'.
    temp6-v = `{SELECTED}`.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'detailPress'.
    DATA temp7 TYPE string_table.
    CLEAR temp7.
    INSERT `${TITLE}` INTO TABLE temp7.
    INSERT `${DESCR}` INTO TABLE temp7.
    INSERT `${ICON}` INTO TABLE temp7.
    INSERT `${HIGHLIGHT}` INTO TABLE temp7.
    INSERT `${INFO}` INTO TABLE temp7.
    INSERT `${WRAPCHARLIMIT}` INTO TABLE temp7.
    INSERT `${SELECTED}` INTO TABLE temp7.
    temp6-v = client->_event( val = 'EDIT' t_arg = temp7 ).
    INSERT temp6 INTO TABLE temp5.
    page->list(
        headertext      = 'List Ouput'
        items           = client->_bind_edit( t_tab )
        mode            = `SingleSelectMaster`
        selectionchange = client->_event( 'SELCHANGE' )
      )->_generic(
         name      = `StandardListItem`
            t_prop = temp5 ).

    client->view_display( page->get_root( )->xml_get( ) ).

  ENDMETHOD.
ENDCLASS.
