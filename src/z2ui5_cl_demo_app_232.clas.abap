CLASS z2ui5_cl_demo_app_232 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA check_initialized TYPE abap_bool .
  PROTECTED SECTION.

    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_232 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'Sample: MultiInput - Suggestions wrapping'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vertical_layout( class = `sapUiContentPadding`
                                          width = `100%` ).
    layout->label( text     = `Product`
                   labelfor = `wrappingMultiInput` ).
    layout->multi_input(
             id             = `wrappingMultiInput`
             placeholder    = `Enter product`
             showsuggestion = abap_true
             width          = `50%`
             )->suggestion_items(
                 )->item( key  = `1`
                          text = `Wireless DSL/ Repeater and Print Server Lorem ipsum dolar st amet, consetetur sadipscing elitr, ` &&
                                           `sed diam nonumy eirmod tempor incidunt ut labore et dolore magna aliquyam erat, diam nonumy eirmod tempor individunt ` &&
                                           `ut labore et dolore magna aliquyam erat, sed justo et ea rebum.`
                 )->item( key  = `2`
                          text = `7" Widescreen Portable DVD Player w MP3, consetetur sadipscing, sed diam nonumy eirmod tempor ` &&
                                           `invidunt ut labore et dolore et dolore magna aliquyam erat, sed diam voluptua. ` &&
                                           `At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergen, no sea takimata. ` &&
                                           `Tortor pretium viverra suspendisse potenti nullam.`
                 )->item( key  = `3`
                          text = `Portable DVD Player with 9" LCD Monitor`
            ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.
