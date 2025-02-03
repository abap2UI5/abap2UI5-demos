CLASS z2ui5_cl_demo_app_091 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES children_array TYPE STANDARD TABLE OF int4 WITH NON-UNIQUE KEY table_line.
    TYPES texts_array TYPE STANDARD TABLE OF string WITH NON-UNIQUE KEY table_line.

    TYPES: BEGIN OF t_children3,
             children TYPE i,
           END OF t_children3.
    TYPES t_texts4 TYPE string.
    TYPES tt_children3 TYPE STANDARD TABLE OF t_children3 WITH DEFAULT KEY.
    TYPES tt_texts4 TYPE STANDARD TABLE OF t_texts4 WITH DEFAULT KEY.
    TYPES: BEGIN OF t_nodes2,
             id                TYPE string,
             lane              TYPE string,
             title             TYPE string,
             titleabbreviation TYPE string,
             children          TYPE children_array,
             state             TYPE string,
             statetext         TYPE string,
             focused           TYPE abap_bool,
             highlighted       TYPE abap_bool,
             texts             TYPE texts_array,
           END OF t_nodes2.
    TYPES: BEGIN OF t_lanes5,
             id       TYPE string,
             icon     TYPE string,
             label    TYPE string,
             position TYPE i,
           END OF t_lanes5.
    TYPES tt_nodes2 TYPE STANDARD TABLE OF t_nodes2 WITH DEFAULT KEY.
    TYPES tt_lanes5 TYPE STANDARD TABLE OF t_lanes5 WITH DEFAULT KEY.

    DATA mt_nodes TYPE tt_nodes2.
    DATA mt_lanes TYPE tt_lanes5.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_set_data.
    METHODS z2ui5_view_display.
    METHODS z2ui5_on_event.


  PRIVATE SECTION.

ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_091 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client     = client.

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

    DATA temp1 TYPE z2ui5_cl_demo_app_091=>tt_nodes2.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-id = `1`.
    temp2-lane = `0`.
    temp2-title = `Sales Order 1`.
    temp2-titleabbreviation = `SO 1`.
    DATA temp5 TYPE z2ui5_cl_demo_app_091=>children_array.
    CLEAR temp5.
    INSERT 10 INTO TABLE temp5.
    INSERT 11 INTO TABLE temp5.
    INSERT 12 INTO TABLE temp5.
    temp2-children = temp5.
    temp2-state = `Positive`.
    temp2-statetext = `OK status`.
    temp2-focused = abap_true.
    temp2-highlighted = abap_false.
    DATA temp7 TYPE z2ui5_cl_demo_app_091=>texts_array.
    CLEAR temp7.
    INSERT `Sales Order Document Overdue long text for the wrap up all the aspects` INTO TABLE temp7.
    INSERT `Not cleared` INTO TABLE temp7.
    temp2-texts = temp7.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `10`.
    temp2-lane = `1`.
    temp2-title = `Outbound Delivery 40`.
    temp2-titleabbreviation = `OD 40`.
    temp2-state = `Positive`.
    temp2-statetext = `OK status`.
    temp2-focused = abap_true.
    temp2-highlighted = abap_false.
    DATA temp9 TYPE z2ui5_cl_demo_app_091=>texts_array.
    CLEAR temp9.
    INSERT `Sales Order Document Overdue long text for the wrap up all the aspects` INTO TABLE temp9.
    INSERT `Not cleared` INTO TABLE temp9.
    temp2-texts = temp9.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `11`.
    temp2-lane = `1`.
    temp2-title = `Outbound Delivery 43`.
    temp2-titleabbreviation = `OD 43`.
    DATA temp11 TYPE z2ui5_cl_demo_app_091=>children_array.
    CLEAR temp11.
    INSERT 21 INTO TABLE temp11.
    temp2-children = temp11.
    temp2-state = `Neutral`.
    temp2-statetext = `OK status`.
    temp2-focused = abap_true.
    temp2-highlighted = abap_false.
    DATA temp13 TYPE z2ui5_cl_demo_app_091=>texts_array.
    CLEAR temp13.
    INSERT `Sales Order Document Overdue long text for the wrap up all the aspects` INTO TABLE temp13.
    INSERT `Not cleared` INTO TABLE temp13.
    temp2-texts = temp13.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `12`.
    temp2-lane = `1`.
    temp2-title = `Outbound Delivery 45`.
    temp2-titleabbreviation = `OD 45`.
    DATA temp15 TYPE z2ui5_cl_demo_app_091=>children_array.
    CLEAR temp15.
    INSERT 20 INTO TABLE temp15.
    temp2-children = temp15.
    temp2-state = `Neutral`.
    temp2-focused = abap_false.
    temp2-highlighted = abap_false.
    DATA temp17 TYPE z2ui5_cl_demo_app_091=>texts_array.
    CLEAR temp17.
    INSERT `Sales Order Document Overdue long text for the wrap up all the aspects` INTO TABLE temp17.
    INSERT `Not cleared` INTO TABLE temp17.
    temp2-texts = temp17.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `20`.
    temp2-lane = `2`.
    temp2-title = `Invoice 9`.
    temp2-titleabbreviation = `I 9`.
    temp2-state = `Positive`.
    temp2-statetext = `OK status`.
    temp2-focused = abap_false.
    temp2-highlighted = abap_false.
    DATA temp19 TYPE z2ui5_cl_demo_app_091=>texts_array.
    CLEAR temp19.
    INSERT `Sales Order Document Overdue long text for the wrap up all the aspects` INTO TABLE temp19.
    INSERT `Not cleared` INTO TABLE temp19.
    temp2-texts = temp19.
    INSERT temp2 INTO TABLE temp1.
    temp2-id = `21`.
    temp2-lane = `2`.
    temp2-title = `Invoice Planned`.
    temp2-titleabbreviation = `IP`.
    temp2-state = `PlannedNegative`.
    temp2-focused = abap_false.
    temp2-highlighted = abap_false.
    DATA temp21 TYPE z2ui5_cl_demo_app_091=>texts_array.
    CLEAR temp21.
    INSERT `Sales Order Document Overdue long text for the wrap up all the aspects` INTO TABLE temp21.
    INSERT `Not cleared` INTO TABLE temp21.
    temp2-texts = temp21.
    INSERT temp2 INTO TABLE temp1.
    mt_nodes = temp1.

    DATA temp3 TYPE z2ui5_cl_demo_app_091=>tt_lanes5.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-id = `0`.
    temp4-icon = `sap-icon://order-status`.
    temp4-label = `Order Processing`.
    temp4-position = 0.
    INSERT temp4 INTO TABLE temp3.
    temp4-id = `1`.
    temp4-icon = `sap-icon://monitor-payments`.
    temp4-label = `Delivery Processing`.
    temp4-position = 1.
    INSERT temp4 INTO TABLE temp3.
    temp4-id = `2`.
    temp4-icon = `sap-icon://payment-approval`.
    temp4-label = `Invoicing`.
    temp4-position = 2.
    INSERT temp4 INTO TABLE temp3.
    mt_lanes = temp3.
  ENDMETHOD.


  METHOD z2ui5_view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell( )->page(
        title          = 'abap2UI5 - Process Flow'
        navbuttonpress = client->_event( 'BACK' )
        shownavbutton  = temp1
        class          = 'sapUiContentPadding' ).

    DATA process_flow TYPE REF TO z2ui5_cl_xml_view.
    process_flow = page->process_flow(
        id            = `processflow1`
        scrollable    = abap_true
        wheelzoomable = abap_false
        foldedcorners = abap_true
        nodepress     = client->_event( val = `NODE_PRESS` )
        nodes         = client->_bind_edit( mt_nodes )
        lanes         = client->_bind_edit( mt_lanes )
      )->nodes( ns = `commons`
        )->process_flow_node(
          laneid            = `{LANE}`
          nodeid            = `{ID}`
          title             = `{TITLE}`
          titleabbreviation = `{TITLEABBREVIATION}`
          children          = `{CHILDREN}`
          state             = `{STATE}`
          statetext         = `{STATETEXT}`
*          texts = `{TEXTS}`
          highlighted       = `{HIGHLIGHTED}`
          focused           = `{FOCUSED}`
        )->get_parent( )->get_parent(
      )->lanes(
        )->process_flow_lane_header(
          laneid   = `{ID}`
          iconsrc  = `{ICON}`
          text     = `{LABEL}`
          position = `{POSITION}` ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
