CLASS z2ui5_cl_demo_app_313 DEFINITION PUBLIC.

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

    TYPES temp1_4e59990452 TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
DATA t_tab TYPE temp1_4e59990452.
    DATA check_initialized TYPE abap_bool.
    DATA check_ui5 TYPE abap_bool.
    DATA mv_key TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_313 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF client->check_on_init( ) IS NOT INITIAL.

      DATA view TYPE REF TO z2ui5_cl_xml_view.
      view = z2ui5_cl_xml_view=>factory( ).

      DATA page TYPE REF TO z2ui5_cl_xml_view.
      DATA temp1 TYPE xsdboolean.
      temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
      page = view->shell(
          )->page(
              title          = 'abap2UI5 - Smart Controls with Variants'
              navbuttonpress = client->_event( 'BACK' )
              shownavbutton  = temp1 ).


      page->smart_filter_bar(
          id             = 'smartFilterBar'
          persistencykey = 'SmartFilterPKey'
          entityset      = 'BookingSupplement'
      )->_control_configuration(
          )->control_configuration(
          previnitdatafetchinvalhelpdia = abap_false
          visibleinadvancedarea         = abap_true
          key                           = 'TravelID'
      )->get_parent(
      )->smart_table(
          id                      = 'smartFiltertable'
          smartfilterid           = 'smartFilterBar'
          tabletype               = 'ResponsiveTable'
          editable                = abap_false
          initiallyvisiblefields  = 'TravelID,BookingID'
          entityset               = 'BookingSupplement'
          usevariantmanagement    = abap_true
          useexporttoexcel        = abap_true
          usetablepersonalisation = abap_true
          header                  = 'Test'
          showrowcount            = abap_true
          enableexport            = abap_false
          enableautobinding       = abap_true
      ).

      client->view_display( val = view->stringify( ) switch_default_model_path = `/sap/opu/odata/DMO/API_TRAVEL_U_V2/` ).

    ENDIF.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
