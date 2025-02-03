CLASS z2ui5_cl_demo_app_261 DEFINITION
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



CLASS z2ui5_cl_demo_app_261 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: News Content'
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
                href   = 'https://sapui5.hana.ondemand.com/#/entity/sap.m.NewsContent/sample/sap.m.sample.NewsContent' ).

    page->tile_content( class = `sapUiSmallMargin`
               )->content(
                   )->news_content(
                       contenttext = `SAP Unveils Powerful New Player Comparison Tool Exclusively on NFL.com`
                       subheader   = `August 21, 2013`
                       press       = client->_event( 'NEWS_CONTENT_PRESS' ) ).

    client->view_display( page->stringify( ) ).
  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'POPOVER'.
        z2ui5_display_popover( `hint_icon` ).
      WHEN 'NEWS_CONTENT_PRESS'.
        client->message_toast_display( `The news content is pressed.` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `This control is used to display the news content text and subheader in a tile.` ).

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
