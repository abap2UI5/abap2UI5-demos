CLASS z2ui5_cl_demo_app_278 DEFINITION
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



CLASS z2ui5_cl_demo_app_278 IMPLEMENTATION.


  METHOD display_view.
    DATA css TYPE string.
    css = `.tileLayout {`    &&
                `    float: left;` &&
                `}`.

    " Define the base URL for the server
    DATA base_url TYPE string VALUE 'https://sapui5.hana.ondemand.com/'.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Feed and News Tile'
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
           href   = base_url && 'sdk/#/entity/sap.m.GenericTile/sample/sap.m.sample.GenericTileAsFeedTile' ).

    page->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header = `Feed Tile that shows updates of the last feeds given to a specific topic:`
           frametype           = `TwoByOne`
                        press  = client->_event( `press` )
               )->tile_content( footer = `New Notifications`
                 )->feed_content( contenttext = `@@notify Great outcome of the Presentation today. New functionality well received.`
                     subheader                = `About 1 minute ago in Computer Market`
                                  value       = `352` )->get_parent( )->get_parent( )->get_parent(
      )->slide_tile( class = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
         )->tiles(
           )->generic_tile(
               backgroundimage = base_url && `test-resources/sap/m/demokit/sample/GenericTileAsFeedTile/images/NewsImage1.png`
               frametype       = `TwoByOne`
               press           = client->_event( `press` )
             )->tile_content( footer = `August 21, 2016`
               )->news_content(
                  contenttext = `Wind Map: Monitoring Real-Time and Fore-casted Wind Conditions across the Globe`
                  subheader   = `Today, SAP News` )->get_parent( )->get_parent( )->get_parent(
           )->generic_tile(
               backgroundimage = base_url && `test-resources/sap/m/demokit/sample/GenericTileAsFeedTile/images/NewsImage2.png`
               frametype       = `TwoByOne`
               press           = client->_event( `press` )
             )->tile_content( footer = `August 21, 2016`
               )->news_content(
                   contenttext = `SAP Unveils Powerful New Player Comparision Tool Exclusively on NFL.com`
                   subheader   = `Today, SAP News` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
      WHEN 'press'.
        client->message_toast_display( `The GenericTile is pressed.` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `Shows Feed Tile and News Tile samples that can contain feed content, news content, and a footer.` ).

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
