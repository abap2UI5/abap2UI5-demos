CLASS z2ui5_cl_demo_app_144 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        title TYPE string,
        value TYPE string,
      END OF ty_row .

    TYPES temp1_23c3e7b34e TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
DATA t_tab TYPE temp1_23c3e7b34e .
    DATA check_initialized TYPE abap_bool.
    DATA client TYPE REF TO z2ui5_if_client.
    METHODS set_view.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_144 IMPLEMENTATION.


  METHOD set_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp10 TYPE xsdboolean.
    temp10 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
        )->page(
                title          = 'abap2UI5 - Binding Cell Level'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = temp10 ).


    DATA temp1 LIKE LINE OF t_tab.
    DATA lr_row LIKE REF TO temp1.
    LOOP AT t_tab REFERENCE INTO lr_row.
      DATA lv_tabix LIKE sy-tabix.
      lv_tabix = sy-tabix.
      page->input( value = client->_bind_edit( val = lr_row->title tab = t_tab tab_index = lv_tabix ) ).
      page->input( value = client->_bind_edit( val = lr_row->value tab = t_tab tab_index = lv_tabix ) ).
    ENDLOOP.

    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = page->table(
            items = client->_bind_edit( t_tab )
            mode  = 'MultiSelect'
        )->header_toolbar(
            )->overflow_toolbar(
                )->title( 'title of the table'
        )->get_parent( )->get_parent(
      )->columns(
        )->column( )->text( 'Title' )->get_parent(
        )->column( )->text( 'Value' )->get_parent( )->get_parent(
      )->items( )->column_list_item( selected = '{SELKZ}'
      )->cells(
          )->input( value = '{TITLE}'
          )->input( value = '{VALUE}' ).

    DATA temp2 LIKE LINE OF t_tab.
    DATA temp3 LIKE sy-tabix.
    temp3 = sy-tabix.
    READ TABLE t_tab INDEX 1 INTO temp2.
    sy-tabix = temp3.
    IF sy-subrc <> 0.
      ASSERT 1 = 0.
    ENDIF.
    page->input( value = client->_bind_edit( val = temp2-title tab = t_tab tab_index = 1 ) ).
    DATA temp4 LIKE LINE OF t_tab.
    DATA temp5 LIKE sy-tabix.
    temp5 = sy-tabix.
    READ TABLE t_tab INDEX 1 INTO temp4.
    sy-tabix = temp5.
    IF sy-subrc <> 0.
      ASSERT 1 = 0.
    ENDIF.
    page->input( value = client->_bind_edit( val = temp4-value tab = t_tab tab_index = 1 ) ).
    DATA temp6 LIKE LINE OF t_tab.
    DATA temp7 LIKE sy-tabix.
    temp7 = sy-tabix.
    READ TABLE t_tab INDEX 2 INTO temp6.
    sy-tabix = temp7.
    IF sy-subrc <> 0.
      ASSERT 1 = 0.
    ENDIF.
    page->input( value = client->_bind_edit( val = temp6-title tab = t_tab tab_index = 2 ) ).
    DATA temp8 LIKE LINE OF t_tab.
    DATA temp9 LIKE sy-tabix.
    temp9 = sy-tabix.
    READ TABLE t_tab INDEX 2 INTO temp8.
    sy-tabix = temp9.
    IF sy-subrc <> 0.
      ASSERT 1 = 0.
    ENDIF.
    page->input( value = client->_bind_edit( val = temp8-value tab = t_tab tab_index = 2 ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      DO 1 TIMES.
        DATA temp10 LIKE t_tab.
        CLEAR temp10.
        temp10 = t_tab.
        DATA temp11 LIKE LINE OF temp10.
        temp11-title = 'entry 01'.
        temp11-value = 'red'.
        INSERT temp11 INTO TABLE temp10.
        temp11-title = 'entry 02'.
        temp11-value = 'blue'.
        INSERT temp11 INTO TABLE temp10.
        t_tab = temp10.
      ENDDO.
      set_view( ).
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    client->view_model_update( ).

  ENDMETHOD.
ENDCLASS.
