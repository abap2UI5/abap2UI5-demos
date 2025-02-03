CLASS z2ui5_cl_demo_app_290 DEFINITION
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



CLASS z2ui5_cl_demo_app_290 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp5 TYPE xsdboolean.
    temp5 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Object List Item - markers aggregation'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp5 ).

    page->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.ObjectListItem/sample/sap.m.sample.ObjectListItemMarkers' ).

    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `${$source>/title}` INTO TABLE temp1.
    DATA temp2 TYPE string_table.
    CLEAR temp2.
    INSERT `${$source>/title}` INTO TABLE temp2.
    DATA temp3 TYPE string_table.
    CLEAR temp3.
    INSERT `${$source>/title}` INTO TABLE temp3.
    DATA temp4 TYPE string_table.
    CLEAR temp4.
    INSERT `${$source>/title}` INTO TABLE temp4.
    page->list(
           headertext = `Products`
           )->object_list_item(
                 title      = `Gladiator MX`
                 type       = `Active`
                 press      = client->_event( val = `onListItemPress` t_arg = temp1 )
                 number     = `87.50`
                 numberunit = `EUR`
               )->first_status(
                   )->object_status(
                       text  = `Available`
                       state = `Success`
                   )->get_parent(
               )->get_parent(
               )->object_attribute( text = `125 g`
               )->object_attribute( text = `145 x 140 x 360 cm`
               )->markers(
                   )->object_marker( type = `Favorite` )->get_parent(
                   )->object_marker( type = `Flagged` )->get_parent(
               )->get_parent(
           )->get_parent(
           )->object_list_item(
                 title      = `Hurricane GX`
                 type       = `Active`
                 press      = client->_event( val = `onListItemPress` t_arg = temp2 )
                 number     = `235`
                 numberunit = `EUR`
               )->first_status(
                   )->object_status(
                       text  = `Out of stock`
                       state = `Warning`
                   )->get_parent(
                )->get_parent(
               )->object_attribute( text = `34 g`
               )->object_attribute( text = `45 x 14 x 36 cm`
               )->markers(
                   )->object_marker( type = `Flagged` )->get_parent(
                   )->object_marker( type = `Locked` )->get_parent(
               )->get_parent(
           )->get_parent(
           )->object_list_item(
                 title      = `Power Projector 4713`
                 type       = `Active`
                 press      = client->_event( val = `onListItemPress` t_arg = temp3 )
                 number     = `135`
                 numberunit = `EUR`
               )->first_status(
                   )->object_status(
                       text  = `Discontinued`
                       state = `Error`
                   )->get_parent(
                )->get_parent(
               )->object_attribute( text = `67 g`
               )->object_attribute( text = `425 x 35 x 30 cm`
               )->markers(
                   )->object_marker( type = `Favorite` )->get_parent(
                   )->object_marker( type = `Locked` )->get_parent(
                   )->object_marker( type = `Draft` )->get_parent(
               )->get_parent(
           )->get_parent(
           )->object_list_item(
                 title      = `Webcam`
                 type       = `Active`
                 press      = client->_event( val = `onListItemPress` t_arg = temp4 )
                 number     = `15`
                 numberunit = `EUR`
               )->first_status(
                   )->object_status(
                       text = `New`
                   )->get_parent(
                )->get_parent(
               )->object_attribute( text = `67 g`
               )->object_attribute( text = `15 x 15 x 10 cm`
               )->markers(
                   )->object_marker( type = `Unsaved` )->get_parent(
               )->get_parent(
           )->get_parent( ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
      WHEN 'onListItemPress'.
        client->message_toast_display( `Pressed : ` && client->get_event_arg( 1 ) ).
    ENDCASE.

    "Pressed : " + oEvent.getSource().getTitle()
  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `This sample shows the different states of an Object List Item, which can be set using the markers aggregation.` ).

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
