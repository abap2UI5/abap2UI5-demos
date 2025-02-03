CLASS z2ui5_cl_demo_app_305 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.
    TYPES:
      BEGIN OF ty_row,
        title TYPE string,
        value TYPE string,
      END OF ty_row.
    DATA t_tab TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    METHODS set_view.

ENDCLASS.


CLASS z2ui5_cl_demo_app_305 IMPLEMENTATION.

  METHOD set_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->shell(
                    )->page(
                      title          = 'abap2UI5 - Tables and cell colors'
                      navbuttonpress = client->_event( 'BACK' )
                      shownavbutton  = abap_true ).

    page->_generic(
            name = `style`
            ns   = `html`
       )->_cc_plain_xml(
           `td:has([data-color="red"]){ `
        && `    background-color: red;`
        && `}`
        && ``
        && `td:has([data-color="green"]){`
        && `    background-color: green;`
        && `}`
        && ``
        && `td:has([data-color="blue"]){`
        && `    background-color: blue;`
        && `}`
        && ``
        && `td:has([data-color="orange"]){`
        && `    background-color: orange;`
        && `}`
        && ``
        && `td:has([data-color="grey"]){`
        && `    background-color: grey;`
        && `}`
        && ``
        && `td:has([data-color="yellow"]){`
        && `    background-color: yellow;`
        && `}` ).

    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = page->table(
            items = client->_bind_edit( t_tab )
            mode  = 'MultiSelect'
        )->header_toolbar(
            )->overflow_toolbar(
                )->title( 'change cell color'
        )->get_parent( )->get_parent( ).

    tab->columns(
        )->column(
            )->text( 'Title' )->get_parent(
        )->column(
            )->text( 'Color' )->get_parent( ).

    tab->items( )->column_list_item(
      )->cells(
        )->text( text = '{TITLE}'
          )->get(
            )->custom_data(
              )->core_custom_data( key        = 'color'
                                   value      = '{VALUE}'
                                   writetodom = abap_true
            )->get_parent(
          )->get_parent(
        )->input( value   = '{VALUE}'
                  enabled = abap_true ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->check_on_init( ) IS NOT INITIAL.
      DATA temp1 LIKE t_tab.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-title = 'entry 01'.
      temp2-value = 'red'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry 02'.
      temp2-value = 'blue'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry 03'.
      temp2-value = 'green'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry 04'.
      temp2-value = 'yellow'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry 05'.
      temp2-value = 'orange'.
      INSERT temp2 INTO TABLE temp1.
      temp2-title = 'entry 06'.
      temp2-value = 'grey'.
      INSERT temp2 INTO TABLE temp1.
      t_tab = temp1.

      set_view( ).
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
