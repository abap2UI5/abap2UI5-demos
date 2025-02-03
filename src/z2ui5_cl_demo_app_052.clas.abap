CLASS z2ui5_cl_demo_app_052 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_s_tab,
        selkz            TYPE abap_bool,
        product          TYPE string,
        create_date      TYPE string,
        create_by        TYPE string,
        storage_location TYPE string,
        quantity         TYPE i,
      END OF ty_s_tab.
    TYPES ty_t_table TYPE STANDARD TABLE OF ty_s_tab WITH DEFAULT KEY.

    DATA mt_table TYPE ty_t_table.
    DATA check_initialized TYPE abap_bool.
    DATA client TYPE REF TO z2ui5_if_client.

    DATA mv_check_popover TYPE abap_bool.
    DATA mv_product TYPE string.

    METHODS  z2ui5_set_data.
    METHODS z2ui5_display_view.
    METHODS z2ui5_display_popover
      IMPORTING
        id TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_052 IMPLEMENTATION.


  METHOD z2ui5_display_popover.

    DATA lo_popover TYPE REF TO z2ui5_cl_xml_view.
    lo_popover = z2ui5_cl_xml_view=>factory_popup( ).

    lo_popover->popover( placement    = `Right`
                         title        = `abap2UI5 - Popover - ` && mv_product
                         contentwidth = `50%`
      )->simple_form( editable = abap_true
      )->content( 'form'
          )->label( 'Product'
          )->text( mv_product
          )->label( 'info2'
          )->text( `this is a text`
          )->label( 'info3'
          )->text( `this is a text`
          )->text( `this is a text`
        )->get_parent( )->get_parent(
        )->footer(
         )->overflow_toolbar(
            )->toolbar_spacer(
            )->button(
                text  = 'details'
                press = client->_event( 'BUTTON_DETAILS' )
                type  = 'Emphasized' ).
    client->popover_display( xml   = lo_popover->stringify( )
                             by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_display_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->page( id = `page_main`
            title               = 'abap2UI5 - List Report Features'
            navbuttonpress      = client->_event( 'BACK' )
            shownavbutton       = temp2 ).

    page = page->dynamic_page( headerexpanded = abap_true
                               headerpinned   = abap_true ).

    DATA cont TYPE REF TO z2ui5_cl_xml_view.
    cont = page->content( ns = 'f' ).
    DATA tab TYPE REF TO z2ui5_cl_xml_view.
    tab = cont->table( id    = `tab`
                             items = client->_bind_edit( val = mt_table ) ).

    DATA lo_columns TYPE REF TO z2ui5_cl_xml_view.
    lo_columns = tab->columns( ).
    lo_columns->column( )->text( text = `Product` ).
    lo_columns->column( )->text( text = `Date` ).
    lo_columns->column( )->text( text = `Name` ).
    lo_columns->column( )->text( text = `Location` ).
    lo_columns->column( )->text( text = `Quantity` ).

    DATA lo_cells TYPE REF TO z2ui5_cl_xml_view.
    lo_cells = tab->items( )->column_list_item( ).
    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `${$source>/id}` INTO TABLE temp1.
    INSERT `${PRODUCT}` INTO TABLE temp1.
    lo_cells->link( id    = `link`
                    text  = '{PRODUCT}'
                    press = client->_event( val = `POPOVER_DETAIL` t_arg = temp1 ) ).
    lo_cells->text( `{CREATE_DATE}` ).
    lo_cells->text( `{CREATE_BY}` ).
    lo_cells->text( `{STORAGE_LOCATION}` ).
    lo_cells->text( `{QUANTITY}` ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_display_view( ).
      z2ui5_set_data( ).
      RETURN.
    ENDIF.

    CASE client->get( )-event.

      WHEN `BUTTON_DETAILS`.
        client->popover_destroy( ).

      WHEN `POPOVER_DETAIL`.
        mv_check_popover = abap_true.
        mv_product = client->get_event_arg( 2 ).
        z2ui5_display_popover( client->get_event_arg( 1 ) ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_set_data.

    DATA temp3 TYPE z2ui5_cl_demo_app_052=>ty_t_table.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-product = 'table'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Peter`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 400.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'chair'.
    temp4-create_date = `01.01.2022`.
    temp4-create_by = `James`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 123.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'sofa'.
    temp4-create_date = `01.05.2021`.
    temp4-create_by = `Simone`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 700.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'computer'.
    temp4-create_date = `27.01.2023`.
    temp4-create_by = `Theo`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 200.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'printer'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Hannah`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 90.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table2'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Julia`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 110.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Peter`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 400.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'chair'.
    temp4-create_date = `01.01.2022`.
    temp4-create_by = `James`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 123.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'sofa'.
    temp4-create_date = `01.05.2021`.
    temp4-create_by = `Simone`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 700.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'computer'.
    temp4-create_date = `27.01.2023`.
    temp4-create_by = `Theo`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 200.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'printer'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Hannah`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 90.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table2'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Julia`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 110.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Peter`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 400.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'chair'.
    temp4-create_date = `01.01.2022`.
    temp4-create_by = `James`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 123.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'sofa'.
    temp4-create_date = `01.05.2021`.
    temp4-create_by = `Simone`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 700.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'computer'.
    temp4-create_date = `27.01.2023`.
    temp4-create_by = `Theo`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 200.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'printer'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Hannah`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 90.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table2'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Julia`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 110.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Peter`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 400.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'chair'.
    temp4-create_date = `01.01.2022`.
    temp4-create_by = `James`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 123.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'sofa'.
    temp4-create_date = `01.05.2021`.
    temp4-create_by = `Simone`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 700.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'computer'.
    temp4-create_date = `27.01.2023`.
    temp4-create_by = `Theo`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 200.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'printer'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Hannah`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 90.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table2'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Julia`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 110.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Peter`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 400.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'chair'.
    temp4-create_date = `01.01.2022`.
    temp4-create_by = `James`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 123.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'sofa'.
    temp4-create_date = `01.05.2021`.
    temp4-create_by = `Simone`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 700.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'computer'.
    temp4-create_date = `27.01.2023`.
    temp4-create_by = `Theo`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 200.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'printer'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Hannah`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 90.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table2'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Julia`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 110.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Peter`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 400.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'chair'.
    temp4-create_date = `01.01.2022`.
    temp4-create_by = `James`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 123.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'sofa'.
    temp4-create_date = `01.05.2021`.
    temp4-create_by = `Simone`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 700.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'computer'.
    temp4-create_date = `27.01.2023`.
    temp4-create_by = `Theo`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 200.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'printer'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Hannah`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 90.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table2'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Julia`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 110.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Peter`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 400.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'chair'.
    temp4-create_date = `01.01.2022`.
    temp4-create_by = `James`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 123.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'sofa'.
    temp4-create_date = `01.05.2021`.
    temp4-create_by = `Simone`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 700.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'computer'.
    temp4-create_date = `27.01.2023`.
    temp4-create_by = `Theo`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 200.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'printer'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Hannah`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 90.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table2'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Julia`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 110.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Peter`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 400.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'chair'.
    temp4-create_date = `01.01.2022`.
    temp4-create_by = `James`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 123.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'sofa'.
    temp4-create_date = `01.05.2021`.
    temp4-create_by = `Simone`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 700.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'computer'.
    temp4-create_date = `27.01.2023`.
    temp4-create_by = `Theo`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 200.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'printer'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Hannah`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 90.
    INSERT temp4 INTO TABLE temp3.
    temp4-product = 'table2'.
    temp4-create_date = `01.01.2023`.
    temp4-create_by = `Julia`.
    temp4-storage_location = `AREA_001`.
    temp4-quantity = 110.
    INSERT temp4 INTO TABLE temp3.
    mt_table = temp3.

  ENDMETHOD.
ENDCLASS.
