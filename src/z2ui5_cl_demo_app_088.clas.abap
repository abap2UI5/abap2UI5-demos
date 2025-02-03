CLASS z2ui5_cl_demo_app_088 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.
    DATA mv_selected_key TYPE string.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.
    METHODS z2ui5_view_display.
    METHODS z2ui5_on_event.

  PRIVATE SECTION.
    DATA mv_page TYPE string.

ENDCLASS.



CLASS z2ui5_cl_demo_app_088 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client     = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      mv_page = `page1`.
      z2ui5_view_display( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN OTHERS.
        mv_page = client->get( )-event.
        z2ui5_view_display( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell( )->page(
        navbuttonpress = client->_event( val = 'BACK' )
        shownavbutton  = temp2
        title          = `abap2UI5 - Sample: Nav Container`
       )->content( ).

    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `NavCon` INTO TABLE temp1.
    INSERT `${$parameters>/selectedKey}` INTO TABLE temp1.
    page->icon_tab_header( selectedkey                   = client->_bind_edit( mv_selected_key )
                                                  select = client->_event_client( val = client->cs_event-nav_container_to t_arg  = temp1 )
                                                  mode   = `Inline`
                                  )->items(
                                    )->icon_tab_filter( key  = `page1`
                                                        text = `Home` )->get_parent(
                                    )->icon_tab_filter( key  = `page2`
                                                        text = `Applications` )->get_parent(
                                    )->icon_tab_filter( key  = `page3`
                                                        text = `Users and Groups` ).

    page->nav_container( id                    = `NavCon`
                         initialpage           = `page1`
                         defaulttransitionname = `flip`
                                     )->pages(
                                     )->page(
                                       title = 'first page'
                                       id    = `page1`
                                    )->get_parent(
                                     )->page(
                                       title = 'second page'
                                       id    = `page2`
                                    )->get_parent(
                                     )->page(
                                       title = 'third page'
                                       id    = `page3` ).


    client->view_display( page->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
