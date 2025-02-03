CLASS z2ui5_cl_demo_app_097 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

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

    DATA t_tab TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
    DATA t_tab2 TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
    DATA mv_layout TYPE string.
    DATA check_initialized TYPE abap_bool .
    DATA mv_check_enabled_01 TYPE abap_bool VALUE abap_true.
    DATA mv_check_enabled_02 TYPE abap_bool .
  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS view_display_master.
    METHODS view_display_detail.

  PRIVATE SECTION.

ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_097 IMPLEMENTATION.


  METHOD view_display_detail.

    DATA lo_view_nested TYPE REF TO z2ui5_cl_xml_view.
    lo_view_nested = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = lo_view_nested->page( title = `Nested View` ).

    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = page->ui_table( rows               = client->_bind_edit( val = t_tab2 view = client->cs_view-nested )
                                editable           = abap_false
                                alternaterowcolors = abap_true
                                rowactioncount     = '1'
                                enablegrouping     = abap_false
                                fixedcolumncount   = '1'
                                selectionmode      = 'None'
                                sort               = client->_event( 'SORT' )
                                filter             = client->_event( 'FILTER' )
                                customfilter       = client->_event( 'CUSTOMFILTER' ) ).
    tab->ui_extension( )->overflow_toolbar( )->title( text = 'Products' ).
    DATA lo_columns TYPE REF TO z2ui5_cl_xml_view.
    lo_columns = tab->ui_columns( ).

    lo_columns->ui_column( sortproperty                  = 'TITLE'
                                          filterproperty = 'TITLE' )->text( text = `Index` )->ui_template( )->text( text = `{TITLE}` ).
    lo_columns->ui_column( sortproperty   = 'DESCR'
                           filterproperty = 'DESCR' )->text( text = `DESCR` )->ui_template( )->text( text = `{DESCR}` ).
    lo_columns->ui_column( sortproperty   = 'INFO'
                           filterproperty = 'INFO' )->text( text = `INFO` )->ui_template( )->text( text = `{INFO}` ).
    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `${TITLE}` INTO TABLE temp1.
    lo_columns->get_parent( )->ui_row_action_template( )->ui_row_action(
       )->ui_row_action_item( icon = `sap-icon://delete`
                           press   = client->_event( val = 'ROW_DELETE' t_arg = temp1 ) ).

    client->nest_view_display(
      val            = lo_view_nested->stringify( )
      id             = `test`
      method_insert  = 'addMidColumnPage'
      method_destroy = 'removeAllMidColumnPages' ).

  ENDMETHOD.


  METHOD view_display_master.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = z2ui5_cl_xml_view=>factory(
       )->page(
          title           = 'abap2UI5 - Master Detail Page with Nested View'
          navbuttonpress  = client->_event( 'BACK' )
            shownavbutton = abap_true ).

    page->header_content(
             )->link( text   = 'Demo'
                      target = '_blank'
                      href   = `https://twitter.com/abap2UI5/status/1628701535222865922`
             )->link(
         )->get_parent( ).

    DATA col_layout TYPE REF TO z2ui5_cl_xml_view.
    col_layout = page->flexible_column_layout( layout = client->_bind_edit( mv_layout )
                                                     id     = 'test' ).

    DATA lr_master TYPE REF TO z2ui5_cl_xml_view.
    lr_master = col_layout->begin_column_pages( ).

    DATA lr_list TYPE REF TO z2ui5_cl_xml_view.
    lr_list = lr_master->list(
          headertext      = 'List Ouput'
          items           = client->_bind_edit( val = t_tab view = client->cs_view-main )
          mode            = `SingleSelectMaster`
          selectionchange = client->_event( 'SELCHANGE' )
          )->standard_list_item(
              title       = '{TITLE}'
              description = '{DESCR}'
              icon        = '{ICON}'
              info        = '{INFO}'
              press       = client->_event( 'TEST' )
              selected    = `{SELECTED}` ).

    client->view_display( lr_list->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      DATA temp3 LIKE t_tab.
      CLEAR temp3.
      DATA temp4 LIKE LINE OF temp3.
      temp4-title = 'row_01'.
      temp4-info = 'completed'.
      temp4-descr = 'this is a description'.
      temp4-icon = 'sap-icon://account'.
      INSERT temp4 INTO TABLE temp3.
      temp4-title = 'row_02'.
      temp4-info = 'incompleted'.
      temp4-descr = 'this is a description'.
      temp4-icon = 'sap-icon://account'.
      INSERT temp4 INTO TABLE temp3.
      temp4-title = 'row_03'.
      temp4-info = 'working'.
      temp4-descr = 'this is a description'.
      temp4-icon = 'sap-icon://account'.
      INSERT temp4 INTO TABLE temp3.
      temp4-title = 'row_04'.
      temp4-info = 'working'.
      temp4-descr = 'this is a description'.
      temp4-icon = 'sap-icon://account'.
      INSERT temp4 INTO TABLE temp3.
      temp4-title = 'row_05'.
      temp4-info = 'completed'.
      temp4-descr = 'this is a description'.
      temp4-icon = 'sap-icon://account'.
      INSERT temp4 INTO TABLE temp3.
      temp4-title = 'row_06'.
      temp4-info = 'completed'.
      temp4-descr = 'this is a description'.
      temp4-icon = 'sap-icon://account'.
      INSERT temp4 INTO TABLE temp3.
      t_tab = temp3.

      mv_layout = `OneColumn`.

      view_display_master( ).
      view_display_detail( ).

    ENDIF.

    CASE client->get( )-event.

      WHEN 'ROW_DELETE'.
        DATA lt_arg TYPE string_table.
        lt_arg = client->get( )-t_event_arg.
        DATA ls_arg TYPE string.
        READ TABLE lt_arg INTO ls_arg INDEX 1.
        IF ls_arg IS NOT INITIAL.
          DELETE t_tab2 WHERE title = ls_arg.
        ENDIF.

        client->nest_view_model_update( ).

      WHEN `SELCHANGE`.
        DATA lt_sel LIKE t_tab.
        lt_sel = t_tab.
        DELETE lt_sel WHERE selected = abap_false.

        DATA ls_sel TYPE z2ui5_cl_demo_app_097=>ty_row.
        READ TABLE lt_sel INTO ls_sel INDEX 1.
        APPEND ls_sel TO t_tab2.

        mv_layout = `TwoColumnsMidExpanded`.

        client->nest_view_model_update( ).
        client->view_model_update( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
