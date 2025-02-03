CLASS z2ui5_cl_demo_app_266 DEFINITION
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



CLASS z2ui5_cl_demo_app_266 IMPLEMENTATION.


  METHOD display_view.

    DATA page_01 TYPE REF TO z2ui5_cl_xml_view.
    DATA temp11 TYPE xsdboolean.
    temp11 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page_01 = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = `abap2UI5 - Sample: Toggle Button`
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp11 ).

    page_01->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page_01->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/#/entity/sap.m.ToggleButton/sample/sap.m.sample.ToggleButton' ).

    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `${$source>/pressed}` INTO TABLE temp1.
    INSERT `${$source>/id}` INTO TABLE temp1.
    DATA temp2 TYPE string_table.
    CLEAR temp2.
    INSERT `${$source>/pressed}` INTO TABLE temp2.
    INSERT `${$source>/id}` INTO TABLE temp2.
    DATA temp3 TYPE string_table.
    CLEAR temp3.
    INSERT `${$source>/pressed}` INTO TABLE temp3.
    INSERT `${$source>/id}` INTO TABLE temp3.
    DATA temp4 TYPE string_table.
    CLEAR temp4.
    INSERT `${$source>/pressed}` INTO TABLE temp4.
    INSERT `${$source>/id}` INTO TABLE temp4.
    DATA temp5 TYPE string_table.
    CLEAR temp5.
    INSERT `${$source>/pressed}` INTO TABLE temp5.
    INSERT `${$source>/id}` INTO TABLE temp5.
    DATA temp6 TYPE string_table.
    CLEAR temp6.
    INSERT `${$source>/pressed}` INTO TABLE temp6.
    INSERT `${$source>/id}` INTO TABLE temp6.
    DATA temp7 TYPE string_table.
    CLEAR temp7.
    INSERT `${$source>/pressed}` INTO TABLE temp7.
    INSERT `${$source>/id}` INTO TABLE temp7.
    DATA temp8 TYPE string_table.
    CLEAR temp8.
    INSERT `${$source>/pressed}` INTO TABLE temp8.
    INSERT `${$source>/id}` INTO TABLE temp8.
    DATA temp9 TYPE string_table.
    CLEAR temp9.
    INSERT `${$source>/pressed}` INTO TABLE temp9.
    INSERT `${$source>/id}` INTO TABLE temp9.
    DATA temp10 TYPE string_table.
    CLEAR temp10.
    INSERT `${$source>/pressed}` INTO TABLE temp10.
    INSERT `${$source>/id}` INTO TABLE temp10.
    DATA page_02 TYPE REF TO z2ui5_cl_xml_view.
    page_02 = page_01->page(
                              title = `Page`
                              class = `sapUiContentPadding`
                              )->custom_header(
                                  )->bar(
                                      )->content_middle(
                                          )->title( level = `H2`
                                                    text  = `Title`
                                      )->get_parent(
                                      )->content_right(
                                          )->toggle_button( icon  = `sap-icon://edit`
                                                            press = client->_event( val = `onPress` t_arg = temp1 )
                                      )->get_parent(
                                  )->get_parent(
                              )->get_parent(
                              )->sub_header(
                                  )->bar(
                                      )->content_left(
                                          )->toggle_button( text    = `Pressed`
                                                            enabled = abap_true
                                                            pressed = abap_true
                                                            press   = client->_event( val = `onPress` t_arg = temp2 )
                                          )->toggle_button( text    = `Pressed & Disabled`
                                                            enabled = abap_false
                                                            pressed = abap_true
                                                            press   = client->_event( val = `onPress` t_arg = temp3 )
                                      )->get_parent(
                                      )->content_right(
                                          )->toggle_button( icon  = `sap-icon://action`
                                                            press = client->_event( val = `onPress` t_arg = temp4 )
                                          )->toggle_button( icon    = `sap-icon://home`
                                                            enabled = abap_false
                                                            press   = client->_event( val = `onPress` t_arg = temp5 )
                                      )->get_parent(
                                  )->get_parent(
                              )->get_parent(
                              )->hbox(
                                  )->toggle_button( text    = `Disabled`
                                                    enabled = `false`
                                                    press   = client->_event( val = `onPress` t_arg = temp6 ) )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1`
                                      )->get_parent(
                                  )->get_parent(
                                  )->toggle_button( text    = `Pressed`
                                                    enabled = abap_true
                                                    pressed = abap_true
                                                    press   = client->_event( val = `onPress` t_arg = temp7 ) )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1`
                                      )->get_parent(
                                  )->get_parent(
                                  )->toggle_button( icon    = `sap-icon://action`
                                                    enabled = abap_true
                                                    pressed = abap_true
                                                    press   = client->_event( val = `onPress` t_arg = temp8 ) )->get(
                                      )->layout_data(
                                          )->flex_item_data( growfactor = `1`
                                      )->get_parent(
                                  )->get_parent(
                              )->get_parent(
                              )->footer(
                                   )->bar(
                                       )->content_right(
                                           )->toggle_button( text    = `Pressed & Disabled`
                                                             enabled = abap_false
                                                             pressed = abap_true
                                                             press   = client->_event( val = `onPress` t_arg = temp9 )
                                           )->toggle_button( icon  = `sap-icon://action`
                                                             press = client->_event( val = `onPress` t_arg = temp10 )
                                       )->get_parent(
                                   )->get_parent(
                              )->get_parent( ).
    client->view_display( page_02->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
      WHEN 'onPress'.
        IF client->get_event_arg( 1 ) = 'X'.
          client->message_toast_display( client->get_event_arg( 2 ) && ` Pressed` ).
        ELSE.
          client->message_toast_display( client->get_event_arg( 2 ) && ` Unpressed` ).
        ENDIF.
    ENDCASE.


  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `Toggle Buttons can be toggled between pressed and normal state.` ).

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
