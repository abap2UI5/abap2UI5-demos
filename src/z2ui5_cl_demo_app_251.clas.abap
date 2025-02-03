CLASS z2ui5_cl_demo_app_251 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA check_initialized TYPE abap_bool .
  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_display_popover
      IMPORTING
        id TYPE string.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_251 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Input - Description'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    page->header_content(
       )->button( id = `hint_icon`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'POPOVER' ) ).

    page->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.Input/sample/sap.m.sample.InputDescription' ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vertical_layout( class = `sapUiContentPadding`
                                          width = `100%` ).

    layout->input( value       = `10`
                   description = `PC`
                   width       = `100px`
                   fieldwidth  = `60%`
                   class       = `sapUiSmallMarginBottom` ).

    layout->input( value       = `220`
                   description = `EUR / 5 pieces`
                   width       = `200px`
                   fieldwidth  = `60px`
                   class       = `sapUiSmallMarginBottom` ).

    layout->input( value         = `220.00`
                   description   = `EUR`
                   width         = `250px`
                   fieldwidth    = `80%`
                   showclearicon = abap_true
                   class         = `sapUiSmallMarginBottom` ).

    layout->input( value       = `007`
                   description = `Bastian Schweinsteiger`
                   width       = `300px`
                   fieldwidth  = `50px`
                   class       = `sapUiSmallMarginBottom` ).

    layout->input( value           = `EDP_LAPTOP`
                   ariadescribedby = `descriptionNodeId`
                   description     = `IT Laptops`
                   width           = `400px`
                   fieldwidth      = `75%`
                   class           = `sapUiSmallMarginBottom` ).

    layout->invisible_text( ns   = `core`
                            id   = `descriptionNodeId`
                            text = `Additional input description refferenced by aria-describedby.` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'POPOVER'.
        z2ui5_display_popover( `hint_icon` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `This sample illustrates the usage of the description with input fields, e.g. description for units of measurements and currencies.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.
