CLASS z2ui5_cl_demo_app_293 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA check_initialized TYPE abap_bool.

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



CLASS z2ui5_cl_demo_app_293 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Link'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    page->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.Link/sample/sap.m.sample.Link' ).

    page->vertical_layout(
            class = `sapUiContentPadding`
            width = `100%`
            )->content( ns = `layout`
                )->link(
                    text  = `Open message box`
                    press = client->_event( `handleLinkPress` )
                )->link(
                    text    = `Disabled link`
                    enabled = abap_false
                )->link(
                    text   = `Open SAP Homepage`
                    target = `_blank`
                    href   = `http://www.sap.com`
                )->get_parent( ).

    page->vertical_layout(
           class = `sapUiContentPadding`
           width = `100%`
           )->content( ns = `layout`
               )->label( text     = `Links with Icons`
                         design   = `Bold`
                         wrapping = abap_true
                         class    = `sapUiSmallMarginTop`
                   )->link(
                       text    = `Show more information`
                       endicon = `sap-icon://inspect`
                       press   = client->_event( `handleLinkPress` )
                   )->link(
                       text    = `Disabled link with icon`
                       icon    = `sap-icon://cart`
                       enabled = abap_false
                   )->link(
                       text = `Open SAP Homepage`
                       icon = `sap-icon://globe`
                       href = `http://www.sap.com`
           )->get_parent( ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
      WHEN 'handleLinkPress'.
        client->message_box_display( `Link was clicked!` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `Here are some links. Typically links are used in user interfaces to trigger navigation to related content inside or outside of the current application.` ).

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
