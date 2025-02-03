CLASS z2ui5_cl_demo_app_101 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_feed,
        author    TYPE string,
        authorpic TYPE string,
        type      TYPE string,
        date      TYPE string,
        text      TYPE string,
      END OF ty_feed.

    TYPES temp1_c64fbbad04 TYPE TABLE OF ty_feed.
DATA mt_feed TYPE temp1_c64fbbad04.
    DATA ms_feed TYPE ty_feed.
    DATA mv_value TYPE string.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_on_event.
    METHODS z2ui5_set_data.
    METHODS z2ui5_view_display.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_101 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_set_data( ).
      z2ui5_view_display( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.
    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN 'POST'.
        IF mv_value IS INITIAL.
          RETURN.
        ENDIF.
        CLEAR ms_feed.
        ms_feed-author = sy-uname.
        ms_feed-type = 'Respond'.
        ms_feed-text = mv_value.
        mv_value = ``.
        INSERT ms_feed INTO mt_feed INDEX 1.
        client->view_model_update( ).
    ENDCASE.
  ENDMETHOD.


  METHOD z2ui5_set_data.

    DATA temp1 LIKE mt_feed.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-author = `choper725`.
    temp2-authorpic = `employee`.
    temp2-type = `Request`.
    temp2-date = `August 26 2023`.
    temp2-text = `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, seddiamnonumyeirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna` &&
`aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.`.
    INSERT temp2 INTO TABLE temp1.
    temp2-author = `choper725`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-date = `August 26 2023`.
    temp2-text = `this is feed input`.
    INSERT temp2 INTO TABLE temp1.
    mt_feed = temp1.

  ENDMETHOD.


  METHOD z2ui5_view_display.
    DATA lo_view TYPE REF TO z2ui5_cl_xml_view.
    lo_view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = lo_view->shell( )->page(
             title          = 'Feed Input'
             navbuttonpress = client->_event( 'BACK' )
             shownavbutton  = temp1 ).

    DATA fi TYPE REF TO z2ui5_cl_xml_view.
    fi = page->vbox(
      )->feed_input( post                     = client->_event( val = 'POST' )
                             growing          = abap_true
                             rows             = `4`
                             icondensityaware = abap_false
                             value            = client->_bind_edit( mv_value )
                             class            = `sapUiSmallMarginTopBottom`
      )->get_parent( )->get_parent(
      )->list(
        items          = client->_bind_edit( mt_feed )
        showseparators = `Inner`
          )->feed_list_item(
            sender                   = `{AUTHOR}`
            senderpress              = client->_event( 'SENDER_PRESS' )
            iconpress                = client->_event( 'ICON_PRESS' )
            icondensityaware         = abap_false
            showicon                 = abap_false
            info                     = `Reply`
            text                     = `{TEXT}`
            convertlinkstoanchortags = `All` ).

    client->view_display( lo_view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
