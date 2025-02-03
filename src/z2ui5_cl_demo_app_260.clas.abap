CLASS z2ui5_cl_demo_app_260 DEFINITION
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



CLASS z2ui5_cl_demo_app_260 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Nested Splitter Layouts - 7 Areas'
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.ui.layout.Splitter/sample/sap.ui.layout.sample.SplitterNested1' ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->splitter( height      = `500px`
                                   orientation = `Vertical`
                          )->splitter( )->get(
                              )->layout_data( ns = `layout`
                                  )->splitter_layout_data( size = `50px` )->get_parent( )->get_parent(
                              )->content_areas( ns = `layout`
                                  )->button( width = `100%`
                                             text  = `Content 1` )->get(
                                      )->layout_data(
                                          )->splitter_layout_data( size = `auto` )->get_parent( )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                          )->splitter( )->get(
                              )->layout_data( ns = `layout`
                                  )->splitter_layout_data( size = `auto` )->get_parent( )->get_parent(
                              )->content_areas( ns = `layout`
                                  )->button( width = `100%`
                                             text  = `Content 2` )->get(
                                       )->layout_data(
                                           )->splitter_layout_data( size = `300px` )->get_parent( )->get_parent( )->get_parent(
                                  )->splitter( orientation = `Vertical`
                                      )->button( width = `100%`
                                                 text  = `Content 3` )->get(
                                          )->layout_data(
                                              )->splitter_layout_data( size = `auto` )->get_parent( )->get_parent( )->get_parent(
                                      )->button( width = `100%`
                                                 text  = `Content 4` )->get(
                                          )->layout_data(
                                              )->splitter_layout_data( size = `10%` ")->get_parent( )->get_parent( )->get_parent(
                                      )->get_parent( )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                          )->button( width = `100%`
                                     text  = `Content 5` )->get(
                              )->layout_data(
                                  )->splitter_layout_data( size    = `30%`
                                                           minsize = `200px` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                          )->splitter( )->get(
                               )->layout_data( ns = `layout`
                                   )->splitter_layout_data( size = `50px` )->get_parent( )->get_parent( ")->get_parent(
                               )->content_areas( ns = `layout`
                                   )->button( width = `100%`
                                              text  = `Content 6` )->get(
                                       )->layout_data(
                                           )->splitter_layout_data( size = `auto` )->get_parent( )->get_parent( )->get_parent(
                                   )->button( width = `100%`
                                              text  = `Content 7` )->get(
                                       )->layout_data(
                                           )->splitter_layout_data( size = `auto` )->get_parent( )->get_parent( )->get_parent( ).

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
                                  description = `Nested Splitter example with 7 content areas` ).

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
