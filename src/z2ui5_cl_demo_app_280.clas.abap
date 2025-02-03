CLASS z2ui5_cl_demo_app_280 DEFINITION
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



CLASS z2ui5_cl_demo_app_280 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Header Container - Vertical Mode'
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.HeaderContainer/sample/sap.m.sample.HeaderContainerVM' ).

    page->header_container( scrollstep  = `124`
                            scrolltime  = `500`
                            orientation = `Vertical`
                            height      = `400px`
         )->numeric_content( scale      = `M`
                             value      = `1.75`
                             valuecolor = `Good`
                             indicator  = `Up`
                             press      = client->_event( `press` ) )->get_parent(
         )->numeric_content( scale      = `M`
                             value      = `0.57`
                             valuecolor = `Error`
                             indicator  = `Down`
                             press      = client->_event( `press` ) )->get_parent(
         )->numeric_content( scale      = `M`
                             value      = `1.04`
                             valuecolor = `Neutral`
                             indicator  = `Up`
                             press      = client->_event( `press` ) )->get_parent(
         )->numeric_content( scale      = `M`
                             value      = `3.65`
                             valuecolor = `Good`
                             indicator  = `Up`
                             press      = client->_event( `press` ) )->get_parent(
         )->numeric_content( scale      = `M`
                             value      = `0.73`
                             valuecolor = `Error`
                             indicator  = `Down`
                             press      = client->_event( `press` ) )->get_parent(
         )->numeric_content( scale      = `M`
                             value      = `1.01`
                             valuecolor = `Critical`
                             indicator  = `Down`
                             press      = client->_event( `press` ) )->get_parent(
         )->numeric_content( scale      = `M`
                             value      = `1.42`
                             valuecolor = `Good`
                             indicator  = `Up`
                             press      = client->_event( `press` ) )->get_parent(
         )->numeric_content( scale      = `M`
                             value      = `0.21`
                             valuecolor = `Error`
                             indicator  = `Down`
                             press      = client->_event( `press` ) )->get_parent( )->get_parent(
       )->header_container( scrollstep  = `200`
                            orientation = `Vertical`
                            height      = `400px`
         )->tile_content( unit   = `EUR`
                          footer = `Current Quarter`
           )->content(
             )->numeric_content( value      = `1.96`
                                 valuecolor = `Error`
                                 indicator  = `Down`
                                 press      = client->_event( `press` ) )->get_parent( )->get_parent( )->get_parent(
         )->tile_content( footer = `Leave Requests`
           )->content(
             )->numeric_content( value = `35`
                                 icon  = `sap-icon://travel-expense` )->get_parent( )->get_parent( )->get_parent(
         )->tile_content( footer = `Hours since last Activity`
           )->content(
             )->numeric_content( value = `9`
                                 icon  = `sap-icon://horizontal-bar-chart` )->get_parent( )->get_parent( )->get_parent(
         )->tile_content( unit   = `EUR`
                          footer = `Current Quarter`
           )->content(
             )->numeric_content( scale     = `M`
                                 value     = `88`
                        valuecolor         = `Good`
                                 indicator = `Up` )->get_parent( )->get_parent( )->get_parent(
         )->tile_content( unit   = `Unit`
                          footer = `Footer Text`
           )->content(
             )->numeric_content( value = `1522`
                                 icon  = `sap-icon://bubble-chart` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
      WHEN 'press'.
        client->message_toast_display( `Fire press` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `The Header Container with a vertical layout and with divider lines.` ).

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
