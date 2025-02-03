CLASS z2ui5_cl_demo_app_274 DEFINITION
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



CLASS z2ui5_cl_demo_app_274 IMPLEMENTATION.


  METHOD display_view.

    " Define the base URL for the server
    DATA base_url TYPE string VALUE 'https://sapui5.hana.ondemand.com/'.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Slide Tile'
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
           href   = base_url && 'sdk/#/entity/sap.m.SlideTile/sample/sap.m.sample.SlideTile' ).

    page->vertical_layout(
           )->slide_tile( class = `sapUiTinyMarginBegin sapUiTinyMarginTop`
               )->generic_tile(
                   backgroundimage = base_url && `test-resources/sap/m/demokit/sample/SlideTile/images/NewsImage2.png`
                   frametype       = `TwoByOne`
                   press           = client->_event( 'pressOnTileOne' )
                   )->tile_content( footer = `August 21, 2016`
                       )->news_content(
                           contenttext = `SAP Unveils Powerful New Player Comparision Tool Exclusively on NFL.com`
                           subheader   = `Today, SAP News` )->get_parent( )->get_parent( )->get_parent(
               )->generic_tile(
                   backgroundimage = base_url && `test-resources/sap/m/demokit/sample/SlideTile/images/NewsImage1.png`
                   frametype       = `TwoByOne`
                   press           = client->_event( 'pressOnTileTwo' )
                   )->tile_content( footer = `August 21, 2016`
                       )->news_content(
                           contenttext = `Wind Map: Monitoring Real-Time and Forecasted Wind Conditions across the Globe`
                           subheader   = `Today, SAP News` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
      )->slide_tile( class          = `sapUiTinyMarginBegin sapUiTinyMarginTop`
                     transitiontime = `250`
                     displaytime    = `2500`
               )->generic_tile(
                   backgroundimage = base_url && `test-resources/sap/m/demokit/sample/SlideTile/images/NewsImage1.png`
                   frametype       = `TwoByOne`
                   press           = client->_event( 'pressOnTileOne' )
                   )->tile_content( footer = `August 21, 2016`
                       )->news_content(
                           contenttext = `Wind Map: Monitoring Real-Time and Forecasted Wind Conditions across the Globe`
                           subheader   = `Today, SAP News` )->get_parent( )->get_parent( )->get_parent(
               )->generic_tile(
                   backgroundimage = base_url && `test-resources/sap/m/demokit/sample/SlideTile/images/NewsImage2.png`
                   frametype       = `TwoByOne`
                   state           = `Failed`
                   )->tile_content( footer = `August 21, 2016`
                       )->news_content(
                           contenttext = `AP Unveils Powerful New Player Comparision Tool Exclusively on NFL.com`
                           subheader   = `Today, SAP News` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `Shows Generic Tile with the 2x1 frame type displayed as sliding tiles.` ).

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
