CLASS z2ui5_cl_demo_app_011 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        selkz    TYPE abap_bool,
        title    TYPE string,
        value    TYPE string,
        descr    TYPE string,
        icon     TYPE string,
        info     TYPE string,
        editable TYPE abap_bool,
        checkbox TYPE abap_bool,
      END OF ty_row.

    DATA t_tab TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
    DATA check_editable_active TYPE abap_bool.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.

    METHODS set_view.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_011 IMPLEMENTATION.


  METHOD set_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->shell(
        )->page(
                title           = 'abap2UI5 - Tables and editable'
                navbuttonpress  = client->_event( 'BACK' )
                  shownavbutton = abap_true ).

    DATA temp1 TYPE string.
    CASE check_editable_active.
      WHEN abap_true.
        temp1 = |display|.
      WHEN OTHERS.
        temp1 = |edit|.
    ENDCASE.
    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = page->table(
            items = client->_bind_edit( t_tab )
            mode  = 'MultiSelect'
        )->header_toolbar(
            )->overflow_toolbar(
                )->title( 'title of the table'
                )->button(
                    text  = 'test'
                    press = client->_event( 'BUTTON_TEST' )
                )->toolbar_spacer(
                )->button(
                    icon  = 'sap-icon://delete'
                    text  = 'delete selected row'
                    press = client->_event( 'BUTTON_DELETE' )
                )->button(
                    icon  = 'sap-icon://add'
                    text  = 'add'
                    press = client->_event( 'BUTTON_ADD' )
                )->button(
                    icon  = 'sap-icon://edit'
                    text  = temp1
                    press = client->_event( 'BUTTON_EDIT' )
        )->get_parent( )->get_parent( ).

    tab->columns(
        )->column(
            )->text( 'Title' )->get_parent(
        )->column(
            )->text( 'Color' )->get_parent(
        )->column(
            )->text( 'Info' )->get_parent(
        )->column(
            )->text( 'Description' )->get_parent(
        )->column(
            )->text( 'Checkbox' ).

    tab->items( )->column_list_item( selected = '{SELKZ}'
      )->cells(
          )->input( value   = '{TITLE}'
                    enabled = `{EDITABLE}`
          )->input( value   = '{VALUE}'
                    enabled = `{EDITABLE}`
          )->input( value   = '{INFO}'
                    enabled = `{EDITABLE}`
          )->input( value   = '{DESCR}'
                    enabled = `{EDITABLE}`
          )->checkbox( selected = '{CHECKBOX}'
                       enabled  = `{EDITABLE}` ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      check_editable_active = abap_false.
      DATA temp2 LIKE t_tab.
      CLEAR temp2.
      DATA temp3 LIKE LINE OF temp2.
      temp3-title = 'entry 01'.
      temp3-value = 'red'.
      temp3-info = 'completed'.
      temp3-descr = 'this is a description'.
      temp3-checkbox = abap_true.
      INSERT temp3 INTO TABLE temp2.
      temp3-title = 'entry 02'.
      temp3-value = 'blue'.
      temp3-info = 'completed'.
      temp3-descr = 'this is a description'.
      temp3-checkbox = abap_true.
      INSERT temp3 INTO TABLE temp2.
      temp3-title = 'entry 03'.
      temp3-value = 'green'.
      temp3-info = 'completed'.
      temp3-descr = 'this is a description'.
      temp3-checkbox = abap_true.
      INSERT temp3 INTO TABLE temp2.
      temp3-title = 'entry 04'.
      temp3-value = 'orange'.
      temp3-info = 'completed'.
      temp3-descr = ''.
      temp3-checkbox = abap_true.
      INSERT temp3 INTO TABLE temp2.
      temp3-title = 'entry 05'.
      temp3-value = 'grey'.
      temp3-info = 'completed'.
      temp3-descr = 'this is a description'.
      temp3-checkbox = abap_true.
      INSERT temp3 INTO TABLE temp2.
      INSERT temp3 INTO TABLE temp2.
      t_tab = temp2.

      set_view( ).
      RETURN.

    ENDIF.


    CASE client->get( )-event.

      WHEN 'BUTTON_EDIT'.
        DATA temp1 TYPE xsdboolean.
        temp1 = boolc( check_editable_active = abap_false ).
        check_editable_active = temp1.
        DATA temp4 LIKE LINE OF t_tab.
        DATA lr_tab LIKE REF TO temp4.
        LOOP AT t_tab REFERENCE INTO lr_tab.
          lr_tab->editable = check_editable_active.
        ENDLOOP.
        client->view_model_update( ).
      WHEN 'BUTTON_DELETE'.
        DELETE t_tab WHERE selkz = abap_true.
        client->view_model_update( ).
      WHEN 'BUTTON_ADD'.
        DATA temp5 TYPE z2ui5_cl_demo_app_011=>ty_row.
        CLEAR temp5.
        INSERT temp5 INTO TABLE t_tab.
        client->view_model_update( ).
      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
