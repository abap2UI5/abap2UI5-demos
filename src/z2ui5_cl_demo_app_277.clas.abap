CLASS z2ui5_cl_demo_app_277 DEFINITION
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



CLASS z2ui5_cl_demo_app_277 IMPLEMENTATION.


  METHOD display_view.
    " Define the base URL for the server
    DATA base_url TYPE string VALUE 'https://sapui5.hana.ondemand.com/'.

    DATA css TYPE string.
    css = `.tileLayout {` &&
                ` float: left;` &&
                `}`.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    view->_generic( name = `style`
                    ns   = `html` )->_cc_plain_xml( css )->get_parent( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
         )->page(
            title          = `abap2UI5 - Sample: KPI Tile`
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
           href   = base_url && 'sdk/#/entity/sap.m.GenericTile/sample/sap.m.sample.GenericTileAsKPITile' ).

    page->generic_tile( class     = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                        header    = `Country-Specific Profit Margin`
                frametype         = `OneByHalf`
                        subheader = `Expenses`
                        press     = client->_event( `onPress` )
            )->tile_content( unit   = `EUR`
                             footer = `Current Quarter`
                )->numeric_content( scale      = `M`
                                    value      = `1.96`
                                    valuecolor = `Error`
                                    indicator  = `Up`
                                    withmargin = abap_false )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class     = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header    = `US Profit Margin`
                       press     = client->_event( `onPress` )
                       frametype = `OneByHalf`
         )->tile_content( unit = `Unit`
         )->numeric_content( scale      = `%`
                             value      = `12`
                             valuecolor = `Critical`
                             indicator  = `Up`
                             withmargin = abap_false )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class     = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header    = `Sales Fulfillment Application Title`
                subheader        = `Subtitle`
                       press     = client->_event( `onPress` )
                       frametype = `TwoByHalf`
         )->tile_content( unit   = `EUR`
                          footer = `Current Quarter`
           )->image_content( src = `sap-icon://home-share` )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header = `Manage Activity Master Data Type`
                subheader     = `Subtitle`
                       press  = client->_event( `onPress` ) "frameType = `OneByHalf`
         )->tile_content(
           )->image_content( src = base_url && `test-resources/sap/m/demokit/sample/GenericTileAsLaunchTile/images/SAPLogoLargeTile_28px_height.png` )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header = `Manage Activity Master Data Type With a Long Title Without an Icon`
                subheader     = `Subtitle Launch Tile`
                       mode   = `HeaderMode`
                       press  = client->_event( `onPress` )
         )->tile_content( unit   = `EUR`
                          footer = `Current Quarter` )->get_parent( )->get_parent(
      )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header = `Jessica D. Prince Senior Consultant`
                subheader     = `Department`
                       press  = client->_event( `onPress` )
         )->tile_content(
           )->image_content( src = base_url && `test-resources/sap/m/demokit/sample/GenericTileAsLaunchTile/images/ProfileImage_LargeGenTile.png` )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class            = `sapUiTinyMarginBegin sapUiTinyMarginTop`
                        backgroundimage = base_url && `test-resources/sap/m/images/NewsImage1.png`
                        frametype       = `OneByOne`
                       press            = client->_event( `onPress` )
         )->tile_content( footer    = `Report Available`
                          frametype = `OneByOne`
           )->news_content(
                 contenttext = `Realtime Business Service Analytics`
                 subheader   = `SAP Analytics Cloud` )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class = `sapUiTinyMarginBegin sapUiTinyMarginTop`
             backgroundimage = base_url && `test-resources/sap/m/demokit/sample/SlideTile/images/NewsImage1.png`
             frametype       = `TwoByOne`
                       press = client->_event( `onPress` )
         )->tile_content( footer = `August 21, 2016`
           )->news_content(
                 contenttext = `Wind Map: Monitoring Real-Time and Forecasted Wind Conditions across the Globe`
                 subheader   = `Today, SAP News` )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class       = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header      = `Country-Specific Profit Margin`
                subheader          = `Expenses`
                       press       = client->_event( `onPress` )
                       systeminfo  = `system info`
                       appshortcut = `app shortcut`
         )->tile_content( unit   = `EUR`
                          footer = `Current Quarter`
           )->numeric_content( scale      = `M`
                               value      = `1.96`
                               valuecolor = `Error`
                               indicator  = `Up`
                               withmargin = abap_false )->get_parent( )->get_parent( )->get_parent(
      )->slide_tile( class          = `sapUiTinyMarginBegin sapUiTinyMarginTop`
                     transitiontime = `250`
                     displaytime    = `2500`
         )->generic_tile(
             backgroundimage = base_url && `test-resources/sap/m/demokit/sample/SlideTile/images/NewsImage1.png`
             frametype       = `TwoByOne`
             press           = client->_event( `onPress` )
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
                   contenttext = `SAP Unveils Powerful New Player Comparision Tool Exclusively on NFL.com`
                   subheader   = `Today, SAP News` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header = `Feed Tile that shows updates of the last feeds given to a specific topic:`
                  frametype   = `TwoByOne`
                       press  = client->_event( `onPress` )
           )->tile_content( footer = `New Notifications`
             )->feed_content( contenttext = `@@notify Great outcome of the Presentation today. New functionality well received.`
                       subheader          = `About 1 minute ago in Computer Market`
                              value       = `352` )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header = `Country-Specific Profit Margin`
                       press  = client->_event( `onPress` )
                  frametype   = `TwoByHalf`
           )->tile_content( unit   = `EUR`
                            footer = `Current Quarter`
             )->numeric_content( scale      = `M`
                                 value      = `1.96`
                                 valuecolor = `Error`
                                 indicator  = `Up`
                                 withmargin = abap_false )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class     = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header    = `Cumulative Totals`
                       subheader = `Expenses`
                       press     = client->_event( `onPress` )
                       frametype = `OneByHalf`
           )->tile_content( unit   = `Unit`
                            footer = `Footer Text`
             )->numeric_content( value      = `1762`
                                 icon       = `sap-icon://line-charts`
                                 withmargin = abap_false )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class     = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header    = `Right click to open in new tab`
              subheader          = `Link tile`
                       press     = client->_event( `onPress` )
                       url       = `https://www.sap.com/`
                       frametype = `TwoByHalf`
           )->tile_content(
             )->image_content( src = base_url && `test-resources/sap/m/demokit/sample/GenericTileAsLaunchTile/images/SAPLogoLargeTile_28px_height.png` )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class  = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header = `US Profit Margin`
                       press  = client->_event( `onPress` )
           )->tile_content( unit = `Unit`
             )->numeric_content( scale      = `%`
                                 value      = `12`
                                 valuecolor = `Critical`
                                 indicator  = `Up`
                                 withmargin = `false` )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class       = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header      = `Sales Fulfillment Application Title`
              subheader            = `Subtitle`
                       press       = client->_event( `onPress` )
                       systeminfo  = `system`
                       appshortcut = `shortcut`
           )->tile_content( unit   = `EUR`
                            footer = `Current Quarter`
             )->image_content( src = base_url && `sap-icon://home-share` )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class     = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header    = `Cumulative Totals`
                       subheader = `Expenses`
                       press     = client->_event( `onPress` )
           )->tile_content( unit   = `Unit`
                            footer = `Footer Text`
             )->numeric_content( value      = `1762`
                                 icon       = `sap-icon://line-charts`
                                 withmargin = abap_false )->get_parent( )->get_parent( )->get_parent(
      )->generic_tile( class     = `sapUiTinyMarginBegin sapUiTinyMarginTop tileLayout`
                       header    = `Right click to open in new tab`
              subheader          = `Link tile`
                       press     = client->_event( `onPress` )
                       url       = `https://www.sap.com/`
                       frametype = `TwoByOne`
           )->tile_content(
             )->image_content( src = base_url && `test-resources/sap/m/demokit/sample/GenericTileAsLaunchTile/images/SAPLogoLargeTile_28px_height.png` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
      WHEN 'onPress'.
        client->message_toast_display( `The tile is pressed.` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `Shows KPI Tile samples that can contain header, subheader, key value, trend, scale, unit, and a footer.` ).

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
