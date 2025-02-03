CLASS z2ui5_cl_demo_app_283 DEFINITION
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



CLASS z2ui5_cl_demo_app_283 IMPLEMENTATION.


  METHOD display_view.
    " Define the base URL for the server
    DATA base_url TYPE string VALUE 'https://sapui5.hana.ondemand.com/'.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Feed Input'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp2 ).

    page->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = base_url && 'sdk/#/entity/sap.m.FeedInput/sample/sap.m.sample.FeedInput' ).

    page->label( text  = `Without Icon`
                 class = `sapUiSmallMarginTop sapUiTinyMarginBottom` ).
    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `${$source>/value}` INTO TABLE temp1.
    page->feed_input(
          post      = client->_event( val = `onPost` t_arg = temp1 )
           showicon = abap_false ).

    page->label( text  = `With Icon Placeholder`
                 class = `sapUiSmallMarginTop sapUiTinyMarginBottom` ).
    DATA temp3 TYPE string_table.
    CLEAR temp3.
    INSERT `${$source>/value}` INTO TABLE temp3.
    page->feed_input(
           post     = client->_event( val = `onPost` t_arg = temp3 )
           showicon = abap_true ).

    page->label( text  = `With Icon Placeholder`
                 class = `sapUiSmallMarginTop sapUiTinyMarginBottom` ).
    DATA temp5 TYPE string_table.
    CLEAR temp5.
    INSERT `${$source>/value}` INTO TABLE temp5.
    page->feed_input(
           post     = client->_event( val = `onPost` t_arg = temp5 )
           showicon = abap_true
           icon     = base_url && `test-resources/sap/m/images/george_washington.jpg` ).

    page->label( text  = `Disabled`
                 class = `sapUiSmallMarginTop sapUiTinyMarginBottom` ).
    DATA temp7 TYPE string_table.
    CLEAR temp7.
    INSERT `${$source>/value}` INTO TABLE temp7.
    page->feed_input(
           post     = client->_event( val = `onPost` t_arg = temp7 )
           enabled  = abap_false
           showicon = abap_true
           icon     = base_url && `test-resources/sap/m/images/george_washington.jpg` ).

    page->label( text  = `Rows Set to 5`
                 class = `sapUiSmallMarginTop sapUiTinyMarginBottom` ).
    DATA temp9 TYPE string_table.
    CLEAR temp9.
    INSERT `${$source>/value}` INTO TABLE temp9.
    page->feed_input(
           post = client->_event( val = `onPost` t_arg = temp9 )
           rows = `5` ).

    page->label( text  = `With Exceeded Text`
                 class = `sapUiSmallMarginTop sapUiTinyMarginBottom` ).
    DATA temp11 TYPE string_table.
    CLEAR temp11.
    INSERT `${$source>/value}` INTO TABLE temp11.
    page->feed_input(
           post             = client->_event( val = `onPost` t_arg = temp11 )
           maxlength        = `20`
           showexceededtext = abap_true ).

    page->label( text  = `With Growing`
                 class = `sapUiSmallMarginTop sapUiTinyMarginBottom` ).
    DATA temp13 TYPE string_table.
    CLEAR temp13.
    INSERT `${$source>/value}` INTO TABLE temp13.
    page->feed_input(
           post    = client->_event( val = `onPost` t_arg = temp13 )
           growing = abap_true ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
      WHEN 'onPost'.
        client->message_toast_display( `Posted new feed entry: ` && client->get_event_arg( 1 ) ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `This sample shows a standalone feed input with different settings.` ).

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
