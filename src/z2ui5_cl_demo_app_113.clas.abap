CLASS z2ui5_cl_demo_app_113 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_feed,
        author    TYPE string,
        title     TYPE string,
        authorpic TYPE string,
        type      TYPE string,
        date      TYPE string,
        datetime  TYPE string,
        text      TYPE string,
      END OF ty_feed.

    TYPES temp1_4a20fb9fa2 TYPE TABLE OF ty_feed.
DATA mt_feed TYPE temp1_4a20fb9fa2.
    DATA ms_feed TYPE ty_feed.

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_on_event.
    METHODS z2ui5_set_data.
    METHODS z2ui5_view_display.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_113 IMPLEMENTATION.


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
    ENDCASE.
  ENDMETHOD.


  METHOD z2ui5_set_data.

    DATA temp1 LIKE mt_feed.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-author = `Developer9`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-datetime = `01.11.2023`.
    temp2-text = `newest entry`.
    INSERT temp2 INTO TABLE temp1.
    temp2-author = `Developer8`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-datetime = `01.10.2023`.
    temp2-text = `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor`.
    INSERT temp2 INTO TABLE temp1.
    temp2-author = `Developer7`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-datetime = `01.09.2023`.
    temp2-text = `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor`.
    INSERT temp2 INTO TABLE temp1.
    temp2-author = `Developer6`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-datetime = `01.08.2023`.
    temp2-text = `Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor`.
    INSERT temp2 INTO TABLE temp1.
    temp2-author = `Developer5`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-datetime = `01.07.2023`.
    temp2-text = `this is a text`.
    INSERT temp2 INTO TABLE temp1.
    temp2-author = `Developer4`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-datetime = `01.06.2023`.
    temp2-text = `this is another entry Product D`.
    INSERT temp2 INTO TABLE temp1.
    temp2-author = `Developer3`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-datetime = `01.05.2023`.
    temp2-text = `this is another entry Product C`.
    INSERT temp2 INTO TABLE temp1.
    temp2-author = `Developer2`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-datetime = `01.04.2023`.
    temp2-text = `this is another entry Product B`.
    INSERT temp2 INTO TABLE temp1.
    temp2-author = `Developer1`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-datetime = `01.03.2023`.
    temp2-text = `this is another entry Product A`.
    INSERT temp2 INTO TABLE temp1.
    temp2-author = `Developer`.
    temp2-title = `this is a title`.
    temp2-datetime = `01.02.2023`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Request`.
    temp2-date = `August 26 2023`.
    temp2-text =
`this is a long text Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, seddiamnonumyeirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.` &&
`Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna` &&
`aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.`.
    INSERT temp2 INTO TABLE temp1.
    temp2-title = `first entry`.
    temp2-author = `Developer`.
    temp2-datetime = `01.01.2023`.
    temp2-authorpic = `sap-icon://employee`.
    temp2-type = `Reply`.
    temp2-date = `August 26 2023`.
    temp2-text = `this is the beginning of a timeline`.
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
             title          = 'Timeline'
             navbuttonpress = client->_event( 'BACK' )
             shownavbutton  = temp1 ).

    DATA timeline TYPE REF TO z2ui5_cl_xml_view.
    timeline = page->timeline(
          content = client->_bind( mt_feed ) ).

    timeline->content( ns = `commons` )->timeline_item(
        datetime    = `{DATETIME}`
        title       = `{TITLE}`
        userpicture = `{AUTHORPIC}`
        text        = `{TEXT}`
        username    = `{AUTHOR}` ).

    client->view_display( lo_view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
