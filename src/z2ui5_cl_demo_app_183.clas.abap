class Z2UI5_CL_DEMO_APP_183 definition
  public
  create public .

public section.

  interfaces IF_SERIALIZABLE_OBJECT .
  interfaces Z2UI5_IF_APP .

  types:
    BEGIN OF ty_row,
        count         TYPE i,
        value         TYPE string,
        descr         TYPE string,
        icon          TYPE string,
        info          TYPE string,
        checkbox      TYPE abap_bool,
        percentage(5) TYPE p DECIMALS 2,
        valuecolor    TYPE string,
      END OF ty_row .

  data:
    t_tab TYPE STANDARD TABLE OF ty_row WITH EMPTY KEY .
  data CHECK_INITIALIZED type ABAP_BOOL .
  data CHECK_UI5 type ABAP_BOOL .
  data MV_KEY type STRING .

  methods REFRESH_DATA .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_183 IMPLEMENTATION.


  METHOD REFRESH_DATA.

    DO 100 TIMES.
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


  METHOD Z2UI5_IF_APP~MAIN.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      refresh_data( ).
    ENDIF.

    CASE client->get( )-event.

      WHEN 'GET_OPENED_COL'.
        DATA(lt_arg) = client->get( )-t_event_arg.

      WHEN 'ONSORT'.
        lt_arg = client->get( )-t_event_arg.


      WHEN 'ONGROUP'.

      WHEN 'SORT_ASCENDING'.
        SORT t_tab BY count ASCENDING.
        client->message_toast_display( 'sort ascending' ).

      WHEN 'SORT_DESCENDING'.
        SORT t_tab BY count DESCENDING.
        client->message_toast_display( 'sort descending' ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    DATA(page) = view->shell(
        )->page(
            title          = 'abap2UI5 - table with column menu'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL )
        ).

    DATA(tab) = page->scroll_container( height = '70%' vertical = abap_true
        )->table(
            growing             = abap_true
            growingthreshold    = '20'
            growingscrolltoload = abap_true
            items               = client->_bind_edit( t_tab )
            sticky              = 'ColumnHeaders,HeaderToolbar' ).

    tab->header_toolbar(
        )->toolbar(
            )->title( 'title of the table'
            )->button(
                text  = 'letf side button'
                icon  = 'sap-icon://account'
                press = client->_event( 'BUTTON_SORT' )
            )->segmented_button( selected_key = mv_key
                )->items(
                    )->segmented_button_item(
                        key = 'BLUE'
                        icon = 'sap-icon://accept'
                        text = 'blue'
                    )->segmented_button_item(
                        key = 'GREEN'
                        icon = 'sap-icon://add-favorite'
                        text = 'green'
            )->get_parent( )->get_parent(
            )->toolbar_spacer(
            )->button(
                icon = 'sap-icon://sort-descending'
                press = client->_event( 'SORT_DESCENDING' )
            )->button(
                icon = 'sap-icon://sort-ascending'
                press = client->_event( 'SORT_ASCENDING' )
        ).

*    column menu
   tab->dependents(
    )->column_menu( id = `menu` beforeopen = client->_event( val = `GET_OPENED_COL` t_arg = VALUE #( ( `$event.mParameters.openBy.getId()` ) ) )
*      )->column_menu_quick_sort( change = client->_event( val = 'ONSORT' t_arg = VALUE #( ( `${$parameters>/item.getKey}` ) ) )
*      )->column_menu_quick_sort( change = client->_event( val = 'ONSORT' t_arg = VALUE #( ( `$event` ) ) )
      )->column_menu_quick_sort( change = client->_event( 'ONSORT' )
        )->items( ns = `columnmenu`
          )->column_menu_quick_sort_item(
      )->get_parent( )->get_parent( )->get_parent(
      )->column_menu_quick_group( change = client->_event( 'ONGROUP' )
        )->items( ns = `columnmenu`
          )->column_menu_quick_group_item(
      )->get_parent( )->get_parent( )->get_parent(
      )->items( ns = `columnmenu`
        )->column_menu_action_item( icon = `sap-icon://sort` label = `Sort` press = client->_event( 'ONSORTACTIONITEM' ) )->get_parent(
        )->column_menu_action_item( icon = `sap-icon://group-2` label = `Group` press = client->_event( 'ONSGROUPACTIONITEM' ) )->get_parent(
        )->column_menu_action_item( icon = `sap-icon://filter` label = `Filter` press = client->_event( 'ONSFILTERACTIONITEM' ) )->get_parent(
        )->column_menu_action_item( icon = `sap-icon://table-column` label = `Columns` press = client->_event( 'ONSCOLUMNSACTIONITEM' )
      ).

    tab->columns(
        )->column( headermenu = `menu` id = `color_col`
            )->text( 'Color' )->get_parent(
        )->column( headermenu = `menu` id = `info_col`
            )->text( 'Info' )->get_parent(
        )->column( headermenu = `menu` id = `description_col`
            )->text( 'Description' )->get_parent(
        )->column( headermenu = `menu` id = `checkbox_col`
            )->text( 'Checkbox' )->get_parent(
        )->column( headermenu = `menu` id = `counter_col`
            )->text( 'Counter' )->get_parent(
        )->column( headermenu = `menu` id = `chart_col`
            )->text( 'Radial Micro Chart' ).

    tab->items( )->column_list_item( )->cells(
       )->text( '{VALUE}'
       )->text( '{INFO}'
       )->text( '{DESCR}'
       )->checkbox( selected = '{CHECKBOX}' enabled = abap_false
       )->text( '{COUNT}'
        ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
