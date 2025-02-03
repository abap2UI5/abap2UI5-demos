CLASS z2ui5_cl_demo_app_281 DEFINITION
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



CLASS z2ui5_cl_demo_app_281 IMPLEMENTATION.


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
            title          = 'abap2UI5 - Sample: Tile Statuses'
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
           href   = base_url && 'sdk/#/entity/sap.m.GenericTile/sample/sap.m.sample.GenericTileStates' ).

    page->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header = `Status Loaded - no press event`
           subheader           = `Subheader`
         )->tile_content( unit   = `Unit`
                          footer = `Footer`
           )->image_content( src = `sap-icon://line-charts` )->get_parent( )->get_parent( )->get_parent(
       )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header = `Status Loaded - with press event`
           subheader           = `Subheader`
                        press  = client->_event( `press` )
         )->tile_content( unit   = `Unit`
                          footer = `Footer`
           )->image_content( src = `sap-icon://home-share` )->get_parent( )->get_parent( )->get_parent(
       )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header = `Status Loading - no press event`
           subheader           = `Subheader`
                        state  = `Loading`
         )->tile_content( unit   = `Unit`
                          footer = `Footer`
           )->numeric_content( scale      = `M`
                               value      = `2.1`
                               valuecolor = `Good`
                               indicator  = `Up`
                               withmargin = abap_false )->get_parent( )->get_parent( )->get_parent(
       )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header = `Status Loading - with press event`
           subheader           = `Subheader`
                        state  = `Loading`
                        press  = client->_event( `press` )
         )->tile_content( unit   = `Unit`
                          footer = `Footer`
           )->numeric_content( scale      = `M`
                               value      = `1.96`
                               valuecolor = `Error`
                               indicator  = `Down`
                               withmargin = `false` )->get_parent( )->get_parent( )->get_parent(
       )->generic_tile( class     = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header    = `Status Failed - no press event`
           subheader              = `Subheader`
                        frametype = `TwoByOne`
                        state     = `Failed`
         )->tile_content( unit   = `Unit`
                          footer = `Footer`
           )->feed_content(
               contenttext = `@@notify Great outcome of the Presentation today. The new functionality and the design was well received. Berlin, Tokyo, Rome, Budapest, New York, Munich, London`
               subheader   = `Subheader`
               value       = `9` )->get_parent( )->get_parent( )->get_parent(
       )->generic_tile( class     = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header    = `Status Failed - with press event`
           subheader              = `Subheader`
                        frametype = `TwoByOne`
                        state     = `Failed`
                        press     = client->_event( `press` )
         )->tile_content( unit   = `Unit`
                          footer = `Footer`
           )->feed_content(
               contenttext = `@@notify Great outcome of the Presentation today. The new functionality and the design was well received. Berlin, Tokyo, Rome, Budapest, New York, Munich, London`
               subheader   = `Subheader`
               value       = `9` )->get_parent( )->get_parent( )->get_parent(
       )->slide_tile( class = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
         )->generic_tile(
             backgroundimage = base_url && `test-resources/sap/m/demokit/sample/GenericTileAsFeedTile/images/NewsImage1.png`
             frametype       = `TwoByOne`
             state           = `Loading`
           )->tile_content( unit   = `Unit`
                            footer = `Footer`
             )->news_content(
                 contenttext = `Status Loading - no press event`
                 subheader   = `Subheader` )->get_parent( )->get_parent( )->get_parent(
         )->generic_tile(
             backgroundimage = base_url && `test-resources/sap/m/demokit/sample/GenericTileAsFeedTile/images/NewsImage2.png`
             frametype       = `TwoByOne`
             state           = `Loaded`
             press           = client->_event( `press` )
           )->tile_content( unit   = `Unit`
                            footer = `Footer`
             )->news_content(
                 contenttext = `Status Loaded - with press event`
                 subheader   = `Subheader` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
       )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header = `Status Disabled - no press event`
           subheader           = `Subheader`
                        state  = `Disabled`
         )->tile_content( footer = `Footer`
                          unit   = `Unit`
           )->numeric_content( value      = `3`
                               icon       = `sap-icon://travel-expense`
                               withmargin = abap_false )->get_parent( )->get_parent( )->get_parent(
       )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header = `Status Disabled - with press event`
           subheader           = `Subheader`
                        state  = `Disabled`
                        press  = client->_event( `press` )
         )->tile_content( footer = `Footer`
                          unit   = `Unit`
           )->numeric_content( value      = `3`
                               icon       = `sap-icon://travel-expense`
                               withmargin = abap_false ).

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
                                  description = `Shows the GenericTile while it is loading, if loading fails, and in disabled status.` ).

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
