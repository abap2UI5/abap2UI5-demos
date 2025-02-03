CLASS z2ui5_cl_demo_app_169 DEFINITION PUBLIC.

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


CLASS z2ui5_cl_demo_app_169 IMPLEMENTATION.

  METHOD set_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->shell(
        )->page(
                title           = 'abap2UI5 - JSON Export ITAB'
                navbuttonpress  = client->_event( 'BACK' )
                  shownavbutton = abap_true ).

    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = page->table(
            items = client->_bind_edit( t_tab )
        )->header_toolbar(
            )->overflow_toolbar(
                )->title( 'title of the table'
                )->toolbar_spacer(
                )->button(
                    icon  = 'sap-icon://download'
                    text  = `JSON Export`
                    press = client->_event( 'EXPORT' )
        )->get_parent( )->get_parent( ).

    tab->columns(
        )->column(
            )->text( 'Title' )->get_parent(
        )->column(
            )->text( 'Color' )->get_parent(
        )->column(
            )->text( 'Info' )->get_parent(
        )->column(
            )->text( 'Description' ).

    tab->items( )->column_list_item(
      )->cells(
          )->input( value = '{TITLE}'
          )->input( value = '{VALUE}'
          )->input( value = '{INFO}'
          )->input( value = '{DESCR}' ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      check_editable_active = abap_false.
      DATA temp1 LIKE t_tab.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-title = 'entry 01'.
      temp2-value = 'red'.
      temp2-info = 'completed'.
      temp2-descr = 'this is a description'.
      temp2-checkbox = abap_true.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry 02'.
      temp2-value = 'blue'.
      temp2-info = 'completed'.
      temp2-descr = 'this is a description'.
      temp2-checkbox = abap_true.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry 03'.
      temp2-value = 'green'.
      temp2-info = 'completed'.
      temp2-descr = 'this is a description'.
      temp2-checkbox = abap_true.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry 04'.
      temp2-value = 'orange'.
      temp2-info = 'completed'.
      temp2-descr = ''.
      temp2-checkbox = abap_true.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry 05'.
      temp2-value = 'grey'.
      temp2-info = 'completed'.
      temp2-descr = 'this is a description'.
      temp2-checkbox = abap_true.
      INSERT temp2 INTO TABLE temp1.
      INSERT temp2 INTO TABLE temp1.
      t_tab = temp1.

      set_view( ).

    ENDIF.


    CASE client->get( )-event.

      WHEN 'EXPORT'.
        client->nav_app_call( z2ui5_cl_pop_itab_json_dl=>factory( t_tab ) ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
