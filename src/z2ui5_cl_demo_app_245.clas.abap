CLASS z2ui5_cl_demo_app_245 DEFINITION
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



CLASS z2ui5_cl_demo_app_245 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = `abap2UI5 - Sample: Flex Box - Direction & Order`
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.FlexBox/sample/sap.m.sample.FlexBoxDirectionOrder' ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vbox(
                          )->panel( headertext = `Reverse, horizontal`
                              )->flex_box( direction  = `RowReverse`
                                           alignitems = `Start`
                                  )->button( text = `1`
                                             type = `Emphasized`
                                  )->button( text = `2`
                                             type = `Reject`
                                  )->button( text = `3`
                                             type = `Accept` )->get_parent( )->get_parent(
      )->panel( headertext = `Top to bottom, vertical`
                              )->flex_box( direction  = `Column`
                                           alignitems = `Start`
                                  )->button( text = `1`
                                             type = `Emphasized`
                                  )->button( text = `2`
                                             type = `Reject`
                                  )->button( text = `3`
                                             type = `Accept` )->get_parent( )->get_parent(
      )->panel( headertext = `Bottom to top, reverse vertical`
                              )->flex_box( direction  = `ColumnReverse`
                                           alignitems = `Start`
                                  )->button( text = `1`
                                             type = `Emphasized`
                                  )->button( text = `2`
                                             type = `Reject`
                                  )->button( text = `3`
                                             type = `Accept` )->get_parent( )->get_parent(
      )->panel( headertext = `Arbitrary flex item order`
                              )->flex_box( alignitems = `Start`
                                  )->button( text  = `1`
                                             type  = `Emphasized`
                                             class = `sapUiTinyMarginEnd` )->get(
                                      )->layout_data(
                                          )->flex_item_data( order = `2` )->get_parent( )->get_parent(
                                  )->button( text  = `2`
                                             type  = `Reject`
                                             class = `sapUiTinyMarginEnd` )->get(
                                      )->layout_data(
                                          )->flex_item_data( order = `3` )->get_parent( )->get_parent(
                                  )->button( text  = `3`
                                             type  = `Accept`
                                             class = `sapUiTinyMarginEnd` )->get(
                                      )->layout_data(
                                          )->flex_item_data( order = `1` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'POPOVER'.
        z2ui5_display_popover( `hint_icon` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `You can influence the direction and order of elements in horizontal and vertical Flex Box controls with the direction property.` ).

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
