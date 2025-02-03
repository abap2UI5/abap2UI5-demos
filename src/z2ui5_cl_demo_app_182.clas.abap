CLASS z2ui5_cl_demo_app_182 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

    TYPES: BEGIN OF t_attributes3,
             label TYPE i,
             value TYPE string,
           END OF t_attributes3.
    TYPES tt_attributes3 TYPE STANDARD TABLE OF t_attributes3 WITH DEFAULT KEY.
    TYPES: BEGIN OF t_nodes2,
             id         TYPE string,
             title      TYPE string,
             src        TYPE string,
             attributes TYPE tt_attributes3,
             team       TYPE i,
             supervisor TYPE string,
             location   TYPE string,
             position   TYPE string,
             email      TYPE string,
             phone      TYPE string,
           END OF t_nodes2.
    TYPES: BEGIN OF t_lines4,
             from TYPE string,
             to   TYPE string,
           END OF t_lines4.
    TYPES tt_nodes2 TYPE STANDARD TABLE OF t_nodes2 WITH DEFAULT KEY.
    TYPES tt_lines4 TYPE STANDARD TABLE OF t_lines4 WITH DEFAULT KEY.
    TYPES: BEGIN OF t_json1,
             nodes TYPE tt_nodes2,
             lines TYPE tt_lines4,
           END OF t_json1.

    DATA mv_initialized TYPE abap_bool .
    DATA mt_data TYPE t_json1 .

    METHODS on_event .
    METHODS view_display .
    METHODS detail_popover
      IMPORTING
        id   TYPE string
        node TYPE t_nodes2.
  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_182 IMPLEMENTATION.


  METHOD detail_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    DATA qv TYPE REF TO z2ui5_cl_xml_view.
    qv = view->quick_view( placement = `Left`
              )->quick_view_page(
                                  header      = `Employee`
                                  title       = node-title
                                  description = node-position
                )->get( )->quick_view_page_avatar( )->avatar( src          = node-src
                                                              displayshape = `Square` )->get_parent(
                )->quick_view_group( heading = `Contact Detail`
                  )->quick_view_group_element( label = `Location`
                                               value = node-location )->get_parent(
                  )->quick_view_group_element( label = `Mobile`
                                               value = node-phone
                                               type  = `phone` )->get_parent(
                  )->quick_view_group_element( label        = `Email`
                                               value        = node-email
                                               type         = `email`
                                               emailsubject = `Contact` && node-id ).

    IF node-team IS NOT INITIAL.
      DATA temp1 TYPE string.
      temp1 = node-team.
      qv = qv->get_parent( )->get_parent(
        )->quick_view_group( heading = `Team`
           )->quick_view_group_element( label = `Size`
                                        value = temp1 ).
    ENDIF.

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'LINE_PRESS'.
        client->message_toast_display( 'LINE_PRESSED' ).

      WHEN 'DETAIL_POPOVER'.
        DATA lt_arg TYPE string_table.
        lt_arg = client->get( )-t_event_arg.

        DATA ls_node TYPE z2ui5_cl_demo_app_182=>t_nodes2.
        DATA temp1 LIKE LINE OF lt_arg.
        DATA temp4 LIKE sy-tabix.
        temp4 = sy-tabix.
        READ TABLE lt_arg INDEX 2 INTO temp1.
        sy-tabix = temp4.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        READ TABLE mt_data-nodes INTO ls_node WITH KEY id = temp1.

        DATA temp2 LIKE LINE OF lt_arg.
        DATA temp3 LIKE sy-tabix.
        temp3 = sy-tabix.
        READ TABLE lt_arg INDEX 1 INTO temp2.
        sy-tabix = temp3.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        detail_popover( id   = temp2
                        node = ls_node ).

      WHEN 'BACK'.
        client->nav_app_leave( ).
        RETURN.
    ENDCASE.

  ENDMETHOD.


  METHOD view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->page(
                    title          = 'abap2UI5 - Network Graph - Org Tree'
                    navbuttonpress = client->_event( val = 'BACK' )
                    shownavbutton  = temp1 ).

    DATA temp4 TYPE string_table.
    CLEAR temp4.
    INSERT `${$source>/id}` INTO TABLE temp4.
    INSERT `${ID}` INTO TABLE temp4.
    DATA graph TYPE REF TO z2ui5_cl_xml_view.
    graph = page->network_graph( enablewheelzoom = abap_false
                                       orientation     = `TopBottom`
                                       nodes           = client->_bind( mt_data-nodes )
                                       lines           = client->_bind( mt_data-lines )
                                       layout          = `Layered`
                                       searchsuggest   = `suggest`
                                       search          = `search`
                                       id              = `graph`
                                     )->get( )->layout_algorithm( )->layered_layout( mergeedges    = abap_true
                                                                                     nodeplacement = `Simple`
                                                                                     nodespacing   = `40`
                                     )->get_parent(
                                     )->get_parent(
                                  )->nodes( ns = `networkgraph`
                                    )->node( icon                  = `sap-icon://action-settings`
                                             key                   = `{ID}`
                                             description           = `{TITLE}`
                                             title                 = `{TITLE}`
                                             width                 = `90`
                                             collapsed             = `{COLLAPSED}`
                                             attributes            = `{ATTRIBUTES}`
                                             showactionlinksbutton = abap_false
                                             showdetailbutton      = abap_false
                                             descriptionlinesize   = `0`
                                             shape                 = `Box`
*                                            )->get( )->custom_data( ns = `networkgraph` )->core_custom_data( key = `supervisor` value = `{SUPERVISOR}`
*                                                                                        )->core_custom_data( key = `team` value = `{TEAM}`
*                                                                                        )->core_custom_data( key = `location` value = `{LOCATION}`
*                                                                                        )->core_custom_data( key = `position` value = `{POSITION}`
*                                                                                        )->core_custom_data( key = `team` value = `{TEAM}`
*                                                                                        )->core_custom_data( key = `email` value = `{EMAIL}`
*                                                                                        )->core_custom_data( key = `phone` value = `{PHONE}`
*                                           )->get_parent(
*                                           )->get( )->get_parent( )->get_parent( )->attributes( ns = `networkgraph`
                                           )->get( )->attributes( ns = `networkgraph`
                                            )->element_attribute( label = `{LABEL}`
                                                                  value = `{VALUE}`
                                           )->get_parent(
                                           )->get_parent(
                                           )->get( )->get_parent( )->get_parent( )->action_buttons(
                                            )->action_button( "id = `{ID}`
                                                              position = `Left`
                                                              title    = `Detail`
                                                              icon     = `sap-icon://employee`
                                                              press    = client->_event( val = `DETAIL_POPOVER` t_arg = temp4 )
                                           )->get_parent(
                                           )->get_parent(
                                           )->get( )->get_parent( )->get_parent( )->_generic( ns   = `networkgraph`
                                                                                              name = `image`
                                            )->node_image( src    = `{SRC}`
                                                           width  = `80`
                                                           height = `100`
                                                          )->get_parent(
                                                       )->get_parent(
                                                )->get_parent(
                                          )->get_parent(
                                          )->lines(
                                            )->line( from             = `{FROM}`
                                                     to               = `{TO}`
                                                     arroworientation = `None`
                                                     press            = client->_event( `LINE_PRESS` ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF mv_initialized = abap_false.
      mv_initialized = abap_true.

      CLEAR mt_data.
      DATA temp5 TYPE z2ui5_cl_demo_app_182=>tt_nodes2.
      CLEAR temp5.
      DATA temp6 LIKE LINE OF temp5.
      temp6-id = `Dinter`.
      temp6-title = `Sophie Dinter`.
      temp6-src = `https://ui5.sap.com/test-resources/sap/suite/ui/commons/demokit/images/people/female_IngallsB.jpg`.
      DATA temp1 TYPE z2ui5_cl_demo_app_182=>tt_attributes3.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-label = 35.
      temp2-value = ``.
      INSERT temp2 INTO TABLE temp1.
      temp6-attributes = temp1.
      temp6-team = 13.
      temp6-location = `Walldorf`.
      temp6-position = `lobal Solutions Manager`.
      temp6-email = `sophie.dinter@example.com`.
      temp6-phone = `+000 423 230 000`.
      INSERT temp6 INTO TABLE temp5.
      temp6-id = `Ninsei`.
      temp6-title = `Yamasaki Ninsei`.
      temp6-src = `https://ui5.sap.com/test-resources/sap/suite/ui/commons/demokit/images/people/male_GordonR.jpg`.
      DATA temp3 TYPE z2ui5_cl_demo_app_182=>tt_attributes3.
      CLEAR temp3.
      DATA temp4 LIKE LINE OF temp3.
      temp4-label = 9.
      temp4-value = ``.
      INSERT temp4 INTO TABLE temp3.
      temp6-attributes = temp3.
      temp6-supervisor = `Dinter`.
      temp6-team = 9.
      temp6-location = `Walldorf`.
      temp6-position = `Lead Markets Manage`.
      temp6-email = `yamasaki.ninsei@example.com`.
      temp6-phone = `+000 423 230 002`.
      INSERT temp6 INTO TABLE temp5.
      temp6-id = `Mills`.
      temp6-title = `Henry Mills`.
      temp6-src = `https://ui5.sap.com/test-resources/sap/suite/ui/commons/demokit/images/people/male_MillerM.jpg`.
      DATA temp9 TYPE z2ui5_cl_demo_app_182=>tt_attributes3.
      CLEAR temp9.
      DATA temp10 LIKE LINE OF temp9.
      temp10-label = 4.
      temp10-value = ``.
      INSERT temp10 INTO TABLE temp9.
      temp6-attributes = temp9.
      temp6-supervisor = `Ninsei`.
      temp6-team = 4.
      temp6-location = `Praha`.
      temp6-position = `Sales Manager`.
      temp6-email = `henry.mills@example.com`.
      temp6-phone = `+000 423 232 003`.
      INSERT temp6 INTO TABLE temp5.
      temp6-id = `Polak`.
      temp6-title = `Adam Polak`.
      temp6-src = `https://ui5.sap.com/test-resources/sap/suite/ui/commons/demokit/images/people/male_PlatteR.jpg`.
      temp6-supervisor = `Mills`.
      temp6-location = `Praha`.
      temp6-position = `Marketing Specialist`.
      temp6-email = `adam.polak@example.com`.
      temp6-phone = `+000 423 232 004`.
      INSERT temp6 INTO TABLE temp5.
      temp6-id = `Sykorova`.
      temp6-title = `Vlasta Sykorova`.
      temp6-src = `https://ui5.sap.com/test-resources/sap/suite/ui/commons/demokit/images/people/female_SpringS.jpg`.
      temp6-supervisor = `Mills`.
      temp6-location = `Praha`.
      temp6-position = `Human Assurance Officer`.
      temp6-email = `vlasta.sykorova@example.com`.
      temp6-phone = `+000 423 232 005`.
      INSERT temp6 INTO TABLE temp5.
      mt_data-nodes = temp5.
      DATA temp7 TYPE z2ui5_cl_demo_app_182=>tt_lines4.
      CLEAR temp7.
      DATA temp8 LIKE LINE OF temp7.
      temp8-from = `Dinter`.
      temp8-to = `Ninsei`.
      INSERT temp8 INTO TABLE temp7.
      temp8-from = `Ninsei`.
      temp8-to = `Mills`.
      INSERT temp8 INTO TABLE temp7.
      temp8-from = `Mills`.
      temp8-to = `Polak`.
      INSERT temp8 INTO TABLE temp7.
      temp8-from = `Mills`.
      temp8-to = `Sykorova`.
      INSERT temp8 INTO TABLE temp7.
      mt_data-lines = temp7.

      view_display( ).

    ENDIF.

    on_event( ).

  ENDMETHOD.
ENDCLASS.
