CLASS z2ui5_cl_demo_app_134 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        title TYPE string,
        value TYPE string,
        descr TYPE string,
        info  TYPE string,
      END OF ty_row.
    DATA t_tab TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.

    DATA mv_scrollupdate TYPE abap_bool.

    DATA check_initialized TYPE abap_bool.
    DATA field_01  TYPE string.
    DATA field_02 TYPE string.
    DATA focus_id TYPE string.
    DATA selstart TYPE string.
    DATA selend TYPE string.
    DATA update_focus TYPE abap_bool.

    DATA mt_scroll TYPE z2ui5_if_types=>ty_t_name_value.

  PROTECTED SECTION.
    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

    METHODS init
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_134 IMPLEMENTATION.


  METHOD display_view.

    DATA temp1 TYPE ty_row.
    CLEAR temp1.
    temp1-title = 'Peter'.
    temp1-value = 'red'.
    temp1-info = 'completed'.
    temp1-descr = 'this is a description'.
    DATA ls_row LIKE temp1.
    ls_row = temp1.
    DO 100 TIMES.
      INSERT ls_row INTO TABLE t_tab.
    ENDDO.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( )->shell( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->page(
        id             = 'id_page'
        title          = 'abap2ui5 - Scrolling (use Chrome to avoid incompatibilities)'
        navbuttonpress = client->_event( 'BACK' )
        shownavbutton  = abap_true ).

    page->_z2ui5( )->scrolling(
          setupdate = client->_bind_edit( mv_scrollupdate )
          items     = client->_bind_edit( mt_scroll ) ).

    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = page->table( sticky     = 'ColumnHeaders,HeaderToolbar'
                             headertext = 'Table with some entries'
                             items      = client->_bind( t_tab ) ).

    tab->columns(
        )->column( )->text( 'Title' )->get_parent(
        )->column( )->text( 'Color' )->get_parent(
        )->column( )->text( 'Info' )->get_parent(
        )->column( )->text( 'Description' ).

    tab->items( )->column_list_item( )->cells(
       )->text( '{TITLE}'
       )->text( '{VALUE}'
       )->text( '{INFO}'
      )->text( '{DESCR}' ).

    page->footer( )->overflow_toolbar(
         )->button( text  = 'Scroll Top'
                    press = client->_event( 'BUTTON_SCROLL_TOP' )
         )->button( text  = 'Scroll 500 up'
                    press = client->_event( 'BUTTON_SCROLL_UP' )
         )->button( text  = 'Scroll 500 down'
                    press = client->_event( 'BUTTON_SCROLL_DOWN' )
         )->button( text  = 'Scroll Bottom'
                    press = client->_event( 'BUTTON_SCROLL_BOTTOM' ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD init.

    field_01 = `this is a text`.
    field_02 = `this is another text`.
    selstart = `3`.
    selend = `7`.

    DATA temp2 TYPE z2ui5_if_types=>ty_s_name_value.
    CLEAR temp2.
    temp2-n = 'id_page'.
    INSERT temp2 INTO TABLE mt_scroll.
    display_view( client ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      init( client ).
      RETURN.
    ENDIF.

    client->message_toast_display( 'server roundtrip' ).
    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

      WHEN 'BUTTON_SCROLL_TOP'.
        CLEAR mt_scroll.
        DATA temp3 TYPE z2ui5_if_types=>ty_s_name_value.
        CLEAR temp3.
        temp3-n = 'id_page'.
        temp3-v = '0'.
        INSERT temp3 INTO TABLE mt_scroll.
        mv_scrollupdate = abap_true.
        client->view_model_update( ).

      WHEN 'BUTTON_SCROLL_UP'.

        DATA temp4 TYPE i.
        DATA temp1 LIKE LINE OF mt_scroll.
        DATA temp2 LIKE sy-tabix.
        temp2 = sy-tabix.
        READ TABLE mt_scroll WITH KEY n = 'id_page' INTO temp1.
        sy-tabix = temp2.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        temp4 = temp1-v.
        DATA lv_pos LIKE temp4.
        lv_pos = temp4.
        lv_pos = lv_pos - 500.
        IF lv_pos < 0.
          lv_pos = 0.
        ENDIF.
        FIELD-SYMBOLS <temp5> LIKE LINE OF mt_scroll.
        DATA temp6 LIKE sy-tabix.
        temp6 = sy-tabix.
        READ TABLE mt_scroll WITH KEY n = 'id_page' ASSIGNING <temp5>.
        sy-tabix = temp6.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        DATA temp5 TYPE string.
        temp5 = lv_pos.
        <temp5>-v = shift_left( shift_right( temp5 ) ).
        mv_scrollupdate = abap_true.
        client->view_model_update( ).

      WHEN 'BUTTON_SCROLL_DOWN'.

        DATA temp7 LIKE LINE OF mt_scroll.
        DATA temp8 LIKE sy-tabix.
        temp8 = sy-tabix.
        READ TABLE mt_scroll WITH KEY n = 'id_page' INTO temp7.
        sy-tabix = temp8.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        lv_pos = temp7-v.
        lv_pos = lv_pos + 500.
        IF lv_pos < 0.
          lv_pos = 0.
        ENDIF.
        FIELD-SYMBOLS <temp9> LIKE LINE OF mt_scroll.
        DATA temp10 LIKE sy-tabix.
        temp10 = sy-tabix.
        READ TABLE mt_scroll WITH KEY n = 'id_page' ASSIGNING <temp9>.
        sy-tabix = temp10.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        DATA temp9 TYPE string.
        temp9 = lv_pos.
        <temp9>-v = shift_left( shift_right( temp9 ) ).
        mv_scrollupdate = abap_true.
        client->view_model_update( ).

      WHEN 'BUTTON_SCROLL_BOTTOM'.
        CLEAR mt_scroll.
        DATA temp11 TYPE z2ui5_if_types=>ty_s_name_value.
        CLEAR temp11.
        temp11-n = 'id_page'.
        temp11-v = '99999'.
        INSERT temp11 INTO TABLE mt_scroll.
        mv_scrollupdate = abap_true.
        client->view_model_update( ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
