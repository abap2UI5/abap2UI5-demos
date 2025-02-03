CLASS z2ui5_cl_demo_app_177 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        count      TYPE i,
        value      TYPE string,
        descr      TYPE string,
        icon       TYPE string,
        info       TYPE string,
        checkbox   TYPE abap_bool,
        percentage TYPE p LENGTH 5 DECIMALS 2,
        valuecolor TYPE string,
      END OF ty_row.

    TYPES temp1_bab4bac0ae TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
DATA t_tab TYPE temp1_bab4bac0ae.
    DATA check_initialized TYPE abap_bool.
    DATA check_ui5 TYPE abap_bool.
    DATA mv_key TYPE string.
    METHODS refresh_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_177 IMPLEMENTATION.


  METHOD refresh_data.

    DO 50 TIMES.
      DATA ls_row TYPE ty_row.
      ls_row-count = sy-index.
      ls_row-value = 'red'.
*        info = COND #( WHEN sy-index < 50 THEN 'completed' ELSE 'uncompleted' )
      ls_row-descr = 'this is a description'.
      ls_row-checkbox = abap_true.
*        percentage = COND #( WHEN sy-index <= 100 THEN sy-index ELSE '100' )
      ls_row-valuecolor = `Good`.
      INSERT ls_row INTO TABLE t_tab.
    ENDDO.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.



      check_initialized = abap_true.
      refresh_data( ).
    ENDIF.

    CASE client->get( )-event.

      WHEN 'SORT_ASCENDING'.
        SORT t_tab BY count ASCENDING.
        client->message_toast_display( 'sort ascending' ).

      WHEN 'SORT_DESCENDING'.
        SORT t_tab BY count DESCENDING.
        client->message_toast_display( 'sort descending' ).

      WHEN 'BUTTON_POST'.
        client->message_box_display( 'button post was pressed' ).

      WHEN 'MENU_DEFAULT'.
        client->message_box_display( 'menu default pressed' ).

      WHEN 'MENU_01'.
        client->message_box_display( 'menu 01 pressed' ).

      WHEN 'MENU_02'.
        client->message_box_display( 'menu 02 pressed' ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
        )->page(
            title          = 'abap2UI5 - Scroll Container with Table and Toolbar'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = page->scroll_container( height   = '70%'
                                        vertical = abap_true
        )->table(
            growing             = abap_true
            growingthreshold    = '20'
            growingscrolltoload = abap_true
            items               = client->_bind_edit( t_tab )
            sticky              = 'ColumnHeaders,HeaderToolbar' ).

    tab->header_toolbar(
        )->overflow_toolbar(
            )->title( 'title of the table'
            )->button(
                text  = 'letf side button'
                icon  = 'sap-icon://account'
                press = client->_event( 'BUTTON_SORT' )
            )->segmented_button( selected_key = mv_key
                )->items(
                    )->segmented_button_item(
                        key  = 'BLUE'
                        icon = 'sap-icon://accept'
                        text = 'blue'
                    )->segmented_button_item(
                        key  = 'GREEN'
                        icon = 'sap-icon://add-favorite'
                        text = 'green'
            )->get_parent( )->get_parent(
            )->toolbar_spacer(
            )->generic_tag(
                    arialabelledby = 'genericTagLabel'
                    text           = 'Project Cost'
                    design         = 'StatusIconHidden'
                    status         = 'Error'
                    class          = 'sapUiSmallMarginBottom'
                )->object_number(
                    state      = 'Error'
                    emphasized = 'false'
                    number     = '3.5M'
                    unit       = 'EUR'
            )->get_parent(
            )->toolbar_spacer(
            )->overflow_toolbar_toggle_button(
                icon  = 'sap-icon://sort-descending'
                press = client->_event( 'SORT_DESCENDING' )
            )->overflow_toolbar_toggle_button(
                icon  = 'sap-icon://sort-ascending'
                press = client->_event( 'SORT_ASCENDING' )

            )->overflow_toolbar_menu_button(
        text          = `Export`
        type          = `Transparent`
        tooltip       = `Export`
        defaultaction = client->_event( 'MENU_DEFAULT' )
        icon          = `sap-icon://share`
         buttonmode   = `Split`
      )->_generic( `menu` )->_generic( `Menu`
        )->menu_item(
            press = client->_event( 'MENU_01' )
            text  = `Export as PDF`
            icon  = `sap-icon://pdf-attachment`
      )->menu_item(
            press = client->_event( 'MENU_02' )
            text  = `Export to Excel`
            icon  = `sap-icon://excel-attachment` ).

    tab->columns(
        )->column(
            )->text( 'Color' )->get_parent(
        )->column(
            )->text( 'Info' )->get_parent(
        )->column(
            )->text( 'Description' )->get_parent(
        )->column(
            )->text( 'Checkbox' )->get_parent(
        )->column(
            )->text( 'Counter' )->get_parent(
        )->column(
            )->text( 'Radial Micro Chart' ).

    tab->items( )->column_list_item( )->cells(
       )->text( '{VALUE}'
       )->text( '{INFO}'
       )->text( '{DESCR}'
       )->checkbox( selected = '{CHECKBOX}'
                    enabled  = abap_false
       )->text( '{COUNT}'
       )->radial_micro_chart( size       = `Responsive`
                              height     = `35px`
                              percentage = `{PERCENTAGE}`
                              valuecolor = `{VALUECOLOR}` ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
