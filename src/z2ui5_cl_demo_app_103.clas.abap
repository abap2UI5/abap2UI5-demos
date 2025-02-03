CLASS z2ui5_cl_demo_app_103 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_on_event.
    METHODS z2ui5_view_display.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_103 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_view_display( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.

  METHOD z2ui5_view_display.


    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = z2ui5_cl_xml_view=>factory( )->shell(
           )->page(
              title           = 'abap2UI5 - Side Panel Example'
              navbuttonpress  = client->_event( 'BACK' )
                shownavbutton = abap_true ).

    page->header_content(
         )->link( ).

    page->responsive_splitter( defaultpane = `default`
       )->pane_container(
         )->split_pane( requiredparentwidth = `400`
                        id                  = `default`
           )->layout_data( ns = `layout`
             )->splitter_layout_data( size = `auto` )->get_parent( )->get_parent(
           )->panel( headertext = `first pane` )->get_parent( )->get_parent(
         )->pane_container( orientation = `Vertical`
           )->split_pane( requiredparentwidth = `600`
             )->layout_data( ns = `layout`
               )->splitter_layout_data( size = `auto` )->get_parent( )->get_parent(
             )->panel( headertext = `second pane` )->get_parent( )->get_parent(
           )->split_pane( requiredparentwidth = `800`
             )->layout_data( ns = `layout`
               )->splitter_layout_data( size = `auto` )->get_parent( )->get_parent(
             )->panel( headertext = `second pane` ).


    client->view_display( page->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
