CLASS z2ui5_cl_demo_app_238 DEFINITION
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



CLASS z2ui5_cl_demo_app_238 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Message Strip'
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.MessageStrip/sample/sap.m.sample.MessageStrip' ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vertical_layout( class = `sapUiContentPadding`
                                          width = `100%` ).

    layout->message_strip( text    = `Default (Information) with default icon and close button:`
                   showicon        = abap_true
                   showclosebutton = abap_true
                   class           = `sapUiMediumMarginBottom` ).

    layout->message_strip( text    = `Error with default icon and close button:`
                   type            = `Error`
                   showicon        = abap_true
                   showclosebutton = abap_true
                   class           = `sapUiMediumMarginBottom` ).

    layout->message_strip( text    = `Warning with default icon and close button:`
                   type            = `Warning`
                   showicon        = abap_true
                   showclosebutton = abap_true
                   class           = `sapUiMediumMarginBottom` ).

    layout->message_strip( text    = `Success with default icon and close button:`
                   type            = `Success`
                   showicon        = abap_true
                   showclosebutton = abap_true
                   class           = `sapUiMediumMarginBottom` ).

    layout->message_strip( text = `Information with default icon.`
                   type         = `Information`
                   showicon     = abap_true
                   class        = `sapUiMediumMarginBottom` ).

    layout->message_strip( text = `Information with custom icon`
                   type         = `Information`
                   showicon     = abap_true
                   customicon   = `sap-icon://locked`
                   class        = `sapUiMediumMarginBottom` ).

    layout->message_strip( text    = `Error with link`
                   type            = `Error`
                   showclosebutton = abap_true
                   class           = `sapUiMediumMarginBottom`
                   )->get(
                       )->link( text   = `Open SAP Homepage`
                                target = `_blank`
                                href   = `http://www.sap.com` ).

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
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `MessageStrip for showing status messages.` ).

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
