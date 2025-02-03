CLASS z2ui5_cl_demo_app_170 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA client TYPE REF TO z2ui5_if_client .
    DATA mv_selected_key TYPE string .

    METHODS ui5_display .
    METHODS ui5_event .
    METHODS simple_popup1 .
    METHODS simple_popup2.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_170 IMPLEMENTATION.


  METHOD simple_popup1.

    DATA popup TYPE REF TO z2ui5_cl_xml_view.
    popup = z2ui5_cl_xml_view=>factory_popup( ).

    DATA dialog TYPE REF TO z2ui5_cl_xml_view.
    dialog = popup->dialog( stretch = abap_true
            afterclose                    = client->_event( 'BTN_OK_1ND' )
         )->content( ).

    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `NavCon` INTO TABLE temp1.
    INSERT `${$parameters>/selectedKey}` INTO TABLE temp1.
    DATA content TYPE REF TO z2ui5_cl_xml_view.
    content = dialog->icon_tab_bar( selectedkey        = client->_bind_edit( mv_selected_key )
                                                  select     = client->_event_client( val = `POPUP_NAV_CONTAINER_TO` t_arg  = temp1 )
                                                  headermode = `Inline`
                                                  expanded   = abap_true
                                                  expandable = abap_false
                                  )->items(
                                    )->icon_tab_filter( key  = `page1`
                                                        text = `Home` )->get_parent(
                                    )->icon_tab_filter( key  = `page2`
                                                        text = `Applications` )->get_parent(
                                    )->icon_tab_filter( key  = `page3`
                                                        text = `Users and Groups`
                                      )->items(
                                         )->icon_tab_filter( key  = `page11`
                                                             text = `User 1` )->get_parent(
                                         )->icon_tab_filter( key  = `page32`
                                                             text = `User 2` )->get_parent(
                                         )->icon_tab_filter( key  = `page33`
                                                             text = `User 3`
      )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                                        )->content( )->vbox( height = `100%`
                                         )->nav_container( id                    = `NavCon`
                                                           initialpage           = `page1`
                                                           defaulttransitionname = `flip`
                                                           height                = '400px'
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

    dialog->get_parent( )->footer( )->overflow_toolbar(
                  )->toolbar_spacer(
                  )->button(
                      text  = 'OK'
                      press = client->_event( 'BTN_OK_1ND' )
                      type  = 'Emphasized' ).

    client->popup_display( popup->stringify( ) ).

  ENDMETHOD.


  METHOD simple_popup2.

    DATA popup TYPE REF TO z2ui5_cl_xml_view.
    popup = z2ui5_cl_xml_view=>factory_popup( ).

    DATA dialog TYPE REF TO z2ui5_cl_xml_view.
    dialog = popup->dialog(
        afterclose = client->_event( 'BTN_OK_2ND' )
         )->content( ).

    DATA content TYPE REF TO z2ui5_cl_xml_view.
    content = dialog->label( text = 'this is a second popup' ).

    dialog->get_parent( )->footer( )->overflow_toolbar(
                  )->toolbar_spacer(
                  )->button(
                      text  = 'GOTO 1ST POPUP'
                      press = client->_event( 'BTN_OK_2ND' )
                      type  = 'Emphasized' ).

    client->popup_display( popup->stringify( ) ).

  ENDMETHOD.


  METHOD ui5_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view->shell(
        )->page(
                title          = 'abap2UI5 - Popup To Popup'
                navbuttonpress = client->_event( val = 'BACK' )
                shownavbutton  = temp1
           )->button(
            text  = 'Open Popup...'
            press = client->_event( 'POPUP' ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD ui5_event.

    CASE client->get( )-event.
      WHEN 'GOTO_2ND'.
        simple_popup2( ).

      WHEN 'BTN_OK_2ND'.
        client->popup_destroy( ).
        simple_popup1( ).

      WHEN 'BTN_OK_1ND'.
        client->popup_destroy( ).

      WHEN 'POPUP'.
        simple_popup1( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->get( )-check_on_navigated = abap_true.
      ui5_display( ).
      RETURN.
    ENDIF.

    ui5_event( ).

  ENDMETHOD.
ENDCLASS.
