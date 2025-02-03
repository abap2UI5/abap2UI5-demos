CLASS z2ui5_cl_demo_app_100 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_s_tab,
        selkz            TYPE abap_bool,
        row_id           TYPE string,
        product          TYPE string,
        create_date      TYPE string,
        create_by        TYPE string,
        storage_location TYPE string,
        quantity         TYPE i,
        meins            TYPE meins,
        price            TYPE p LENGTH 10 DECIMALS 2,
        waers            TYPE waers,
        selected         TYPE abap_bool,
        process          TYPE string,
        process_state    TYPE string,
      END OF ty_s_tab .
    TYPES ty_t_table TYPE STANDARD TABLE OF ty_s_tab WITH DEFAULT KEY.

    DATA mt_table TYPE ty_t_table .
    DATA lv_selkz TYPE abap_bool .

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_set_data.
    METHODS z2ui5_view_display.
    METHODS z2ui5_view_vm_popup.
    METHODS z2ui5_on_event.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_100 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      z2ui5_set_data( ).

      z2ui5_view_display( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_set_data.

    DATA temp1 TYPE z2ui5_cl_demo_app_100=>ty_t_table.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-selkz = abap_false.
    temp2-row_id = '1'.
    temp2-product = 'table'.
    temp2-create_date = `01.01.2023`.
    temp2-create_by = `Olaf`.
    temp2-storage_location = `AREA_001`.
    temp2-quantity = 400.
    temp2-meins = 'ST'.
    temp2-price = '1000.50'.
    temp2-waers = 'EUR'.
    temp2-process = '10'.
    temp2-process_state = 'None'.
    INSERT temp2 INTO TABLE temp1.
    temp2-selkz = abap_false.
    temp2-row_id = '2'.
    temp2-product = 'chair'.
    temp2-create_date = `01.01.2022`.
    temp2-create_by = `Karlo`.
    temp2-storage_location = `AREA_001`.
    temp2-quantity = 123.
    temp2-meins = 'ST'.
    temp2-price = '2000.55'.
    temp2-waers = 'USD'.
    temp2-process = '20'.
    temp2-process_state = 'Warning'.
    INSERT temp2 INTO TABLE temp1.
    temp2-selkz = abap_false.
    temp2-row_id = '3'.
    temp2-product = 'sofa'.
    temp2-create_date = `01.05.2021`.
    temp2-create_by = `Elin`.
    temp2-storage_location = `AREA_002`.
    temp2-quantity = 700.
    temp2-meins = 'ST'.
    temp2-price = '3000.11'.
    temp2-waers = 'CNY'.
    temp2-process = '30'.
    temp2-process_state = 'Success'.
    INSERT temp2 INTO TABLE temp1.
    temp2-selkz = abap_false.
    temp2-row_id = '4'.
    temp2-product = 'computer'.
    temp2-create_date = `27.01.2023`.
    temp2-create_by = `Theo`.
    temp2-storage_location = `AREA_002`.
    temp2-quantity = 200.
    temp2-meins = 'ST'.
    temp2-price = '4000.88'.
    temp2-waers = 'USD'.
    temp2-process = '40'.
    temp2-process_state = 'Information'.
    INSERT temp2 INTO TABLE temp1.
    temp2-selkz = abap_false.
    temp2-row_id = '5'.
    temp2-product = 'printer'.
    temp2-create_date = `01.01.2023`.
    temp2-create_by = `Renate`.
    temp2-storage_location = `AREA_003`.
    temp2-quantity = 90.
    temp2-meins = 'ST'.
    temp2-price = '5000.47'.
    temp2-waers = 'EUR'.
    temp2-process = '70'.
    temp2-process_state = 'Warning'.
    INSERT temp2 INTO TABLE temp1.
    temp2-selkz = abap_false.
    temp2-row_id = '6'.
    temp2-product = 'table2'.
    temp2-create_date = `01.01.2023`.
    temp2-create_by = `Angela`.
    temp2-storage_location = `AREA_003`.
    temp2-quantity = 110.
    temp2-meins = 'ST'.
    temp2-price = '6000.33'.
    temp2-waers = 'GBP'.
    temp2-process = '90'.
    temp2-process_state = 'Error'.
    INSERT temp2 INTO TABLE temp1.
    mt_table = temp1.


  ENDMETHOD.


  METHOD z2ui5_view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->shell(
        )->page(
            title           = 'abap2UI5 - List'
            navbuttonpress  = client->_event( 'BACK' )
              shownavbutton = abap_true
            )->header_content(
                )->link(
      )->get_parent( ).


    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = page->ui_table( rows                   = client->_bind( val = mt_table )
                                    id                 = `persoTable`
                                    editable           = abap_false
                                    alternaterowcolors = abap_true
                                    rowactioncount     = '2'
                                    enablegrouping     = abap_false
                                    fixedcolumncount   = '1'
                                    selectionmode      = 'None'
                                    sort               = client->_event( 'SORT' )
                                    filter             = client->_event( 'FILTER' )
                                    customfilter       = client->_event( 'CUSTOMFILTER' ) ).
    tab->ui_extension( )->overflow_toolbar( )->title( text = 'Products' )->toolbar_spacer(
      )->variant_management( showexecuteonselection = abap_true
        )->variant_items(
          )->variant_item( key                = `{KEY}`
                           text               = `{TEXT}`
                           executeonselection = abap_true )->get_parent( ).
    DATA lo_columns TYPE REF TO z2ui5_cl_xml_view.
    lo_columns = tab->ui_columns( ).
    lo_columns->ui_column( width = '4rem' )->checkbox( selected = client->_bind_edit( lv_selkz )
                                                       enabled  = abap_true
                                                       select   = client->_event( val = `SELKZ` ) )->ui_template( )->checkbox( selected = `{SELKZ}` ).
    lo_columns->ui_column( width                         = '5rem'
                           sortproperty                  = 'ROW_ID'
                                          filterproperty = 'ROW_ID' )->text( text = `Index` )->ui_template( )->text( text = `{ROW_ID}` ).
    lo_columns->ui_column( width          = '11rem'
                           sortproperty   = 'PROCESS'
                           filterproperty = 'PROCESS' )->text( text = `Process Indicator`
      )->ui_template( )->progress_indicator( class        = 'sapUiSmallMarginBottom'
                                             percentvalue = `{PROCESS}`
                                             displayvalue = '{PROCESS} %'
                                             showvalue    = 'true'
                                             state        = '{PROCESS_STATE}' ).
    lo_columns->ui_column( width          = '11rem'
                           sortproperty   = 'PRODUCT'
                           filterproperty = 'PRODUCT' )->text( text = `Product` )->ui_template( )->input( value    = `{PRODUCT}`
                                                                                                          editable = abap_false ).
    lo_columns->ui_column( width          = '11rem'
                           sortproperty   = 'CREATE_DATE'
                           filterproperty = 'CREATE_DATE' )->text( text = `Date` )->ui_template( )->text( text = `{CREATE_DATE}` ).
    lo_columns->ui_column( width          = '11rem'
                           sortproperty   = 'CREATE_BY'
                           filterproperty = 'CREATE_BY' )->text( text = `Name` )->ui_template( )->text( text = `{CREATE_BY}` ).
    lo_columns->ui_column( width          = '11rem'
                           sortproperty   = 'STORAGE_LOCATION'
                           filterproperty = 'STORAGE_LOCATION' )->text( text = `Location` )->ui_template( )->text( text = `{STORAGE_LOCATION}` ).
    lo_columns->ui_column( width          = '11rem'
                           sortproperty   = 'QUANTITY'
                           filterproperty = 'QUANTITY' )->text( text = `Quantity` )->ui_template( )->text( text = `{QUANTITY}` ).
    lo_columns->ui_column( width          = '6rem'
                           sortproperty   = 'MEINS'
                           filterproperty = 'MEINS' )->text( text = `Unit` )->ui_template( )->text( text = `{MEINS}` ).
    lo_columns->ui_column( width          = '11rem'
                           sortproperty   = 'PRICE'
                           filterproperty = 'PRICE' )->text( text = `Price` )->ui_template( )->currency( value    = `{PRICE}`
                                                                                                         currency = `{WAERS}` ).
    DATA temp3 TYPE string_table.
    CLEAR temp3.
    INSERT `${ROW_ID}` INTO TABLE temp3.
    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `${ROW_ID}` INTO TABLE temp1.
    lo_columns->get_parent( )->ui_row_action_template( )->ui_row_action(
      )->ui_row_action_item( type = 'Navigation'
                           press  = client->_event( val = 'ROW_ACTION_ITEM_NAVIGATION' t_arg = temp3 )
                          )->get_parent( )->ui_row_action_item( icon  = 'sap-icon://edit'
                                                                text  = 'Edit'
                                                                press = client->_event( val = 'ROW_ACTION_ITEM_EDIT' t_arg = temp1 ) ).
*

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_view_vm_popup.

    DATA popup_sort TYPE REF TO z2ui5_cl_xml_view.
    popup_sort = z2ui5_cl_xml_view=>factory_popup( ).
    client->popup_display( popup_sort->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
