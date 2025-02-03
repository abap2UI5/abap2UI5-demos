CLASS z2ui5_cl_demo_app_314 DEFINITION PUBLIC.

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
    TYPES temp1_8f5bed27c2 TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
DATA t_tab TYPE temp1_8f5bed27c2.

    DATA mv_val TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_314 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF client->check_on_init( ) IS NOT INITIAL.

      DO 10 TIMES.
        DATA ls_row TYPE ty_row.
        ls_row-count = sy-index.
        ls_row-value = 'red'.
        ls_row-descr = 'this is a description'.
        ls_row-checkbox = abap_true.
        ls_row-valuecolor = `Good`.
        INSERT ls_row INTO TABLE t_tab.
      ENDDO.

      DATA view TYPE REF TO z2ui5_cl_xml_view.
      view = z2ui5_cl_xml_view=>factory( ).
      DATA page TYPE REF TO z2ui5_cl_xml_view.
      DATA temp1 TYPE xsdboolean.
      temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
      page = view->shell(
          )->page(
              title          = 'abap2UI5 - Device Model, HTTP Model, OData Model'
              navbuttonpress = client->_event( 'BACK' )
              shownavbutton  = temp1 ).

      page->input( description = `device model` value = `{device>/resize/width}` enabled = abap_false ).

      mv_val = `input value with http model`.
      page->input( client->_bind_edit( val = mv_val switch_default_model = abap_true ) ).

      DATA tab TYPE REF TO z2ui5_cl_xml_view.
      tab = page->table( client->_bind_edit( val = t_tab switch_default_model = abap_true ) ).

      tab->header_toolbar(
          )->toolbar(
              )->title( 'table with http model (framework default)' ).

      tab->columns(
          )->column(
              )->text( 'Value' )->get_parent(
          )->column(
              )->text( 'Info' )->get_parent(
          )->column(
              )->text( 'Description' )->get_parent( ).

      tab->items( )->column_list_item( )->cells(
         )->text( '{http>VALUE}'
         )->text( '{http>INFO}'
         )->text( '{http>DESCR}').


      tab = page->table(
         items = `{/BookingSupplement}`
         growing = abap_true
          ).

      tab->header_toolbar(
        )->toolbar(
        )->title( 'table with odata model' ).

      tab->columns(
          )->column(  )->text( 'TravelID' )->get_parent(
          )->column( )->text( 'BookingID' )->get_parent(
          )->column( )->text( 'BookingSupplementID' )->get_parent(
          )->column( )->text( 'SupplementID' )->get_parent(
          )->column( )->text( 'SupplementText' )->get_parent(
          )->column( )->text( 'Price' )->get_parent(
          )->column( )->text( 'CurrencyCode' )->get_parent(
          ).

      tab->items( )->column_list_item( )->cells(
         )->text( '{TravelID}'
         )->text( '{BookingID}'
         )->text( '{BookingSupplementID}'
         )->text( '{SupplementID}'
         )->text( '{SupplementText}'
         )->text( '{Price}'
         )->text( '{CurrencyCode}'
         ).

      client->view_display( val = view->stringify( ) switch_default_model_path = `/sap/opu/odata/DMO/API_TRAVEL_U_V2/` ).

    ENDIF.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
