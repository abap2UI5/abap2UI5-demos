CLASS z2ui5_cl_demo_app_076 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES: BEGIN OF t_subtask5,
             id        TYPE string,
             starttime TYPE string,
             endtime   TYPE string,
           END OF t_subtask5.
    TYPES tt_subtask5 TYPE STANDARD TABLE OF t_subtask5 WITH DEFAULT KEY.
    TYPES: BEGIN OF t_task3,
             id        TYPE string,
             starttime TYPE string,
             endtime   TYPE string,
           END OF t_task3.
    TYPES: BEGIN OF t_children4,
             id      TYPE string,
             text    TYPE string,
             subtask TYPE tt_subtask5,
           END OF t_children4.
    TYPES tt_task3 TYPE STANDARD TABLE OF t_task3 WITH DEFAULT KEY.
    TYPES tt_children4 TYPE STANDARD TABLE OF t_children4 WITH DEFAULT KEY.
    TYPES: BEGIN OF t_children2,
             id       TYPE string,
             text     TYPE string,
             task     TYPE tt_task3,
             children TYPE tt_children4,
           END OF t_children2.
    TYPES tt_children2 TYPE STANDARD TABLE OF t_children2 WITH DEFAULT KEY.
    TYPES: BEGIN OF t_root6,
             children TYPE tt_children2,
           END OF t_root6.
    TYPES: BEGIN OF t_json1,
             root TYPE t_root6,
           END OF t_json1.

    DATA mt_table TYPE t_root6.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client .
    DATA check_initialized TYPE abap_bool .

    METHODS z2ui5_on_init .
    METHODS z2ui5_on_event .
    METHODS z2ui5_set_data .

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_076 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.
    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      z2ui5_set_data( ).
      z2ui5_on_init( ).
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


  METHOD z2ui5_on_init.


    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA temp1 TYPE z2ui5_if_types=>ty_s_name_value.
    CLEAR temp1.
    temp1-n = `core:require`.
    temp1-v = `{Helper:'z2ui5/Util'}`.
    view->_generic_property( temp1 ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->page( id = `page_main`
            title               = 'abap2UI5 - Gantt'
            navbuttonpress      = client->_event( 'BACK' )
            shownavbutton       = temp2
            class               = 'sapUiContentPadding' ).



    DATA gantt TYPE REF TO z2ui5_cl_xml_view.
    gantt = page->gantt_chart_container(
      )->gantt_chart_with_table( id                 = `gantt`
                                 shapeselectionmode = `Single`
        )->axis_time_strategy(
          )->proportion_zoom_strategy(
            )->total_horizon(
              )->time_horizon( starttime = `20181029000000`
                               endtime   = `20181129000000` )->get_parent( )->get_parent(
            )->visible_horizon(
              )->time_horizon( starttime = `20181029000000`
                               endtime   = `20181129000000` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
      )->gantt_table(
        )->tree_table( rows = `{path: '` && client->_bind( val = mt_table path = abap_true ) && `', parameters: {arrayNames: ['CHILDREN'],numberOfExpandedLevels: 1}}`
          )->tree_columns(
            )->tree_column( label = 'Col 1' )->tree_template( )->text( text = `{TEXT}` )->get_parent( )->get_parent( )->get_parent(
*            )->tree_column( label = 'Col 1' template = 'text' )->get_parent( )->get_parent(
          )->row_settings_template(
            )->gantt_row_settings( rowid   = `{ID}`
                                   shapes1 = `{path: 'TASK', templateShareable:false}`
                                   shapes2 = `{path: 'SUBTASK', templateShareable:false}`
              )->shapes1(
                )->task( time  = `{= Helper.DateCreateObject(${STARTTIME} ) }`
                endtime        = `{= Helper.DateCreateObject(${ENDTIME} ) }`
                         type  = `SummaryExpanded`
                         color = `sapUiAccent5` )->get_parent( )->get_parent(
      )->shapes2(
                )->task( time = `{= Helper.DateCreateObject(${STARTTIME} ) }`
                endtime       = `{= Helper.DateCreateObject(${ENDTIME} ) }` ).


    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_set_data.


    CLEAR mt_table.
    DATA temp1 TYPE z2ui5_cl_demo_app_076=>tt_children2.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-id = `line`.
    temp2-text = `Level 1`.
    DATA temp3 TYPE z2ui5_cl_demo_app_076=>tt_task3.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-id = `rectangle1`.
    temp4-starttime = `2018-11-01T09:00:00`.
    temp4-endtime = `2018-11-27T09:00:00`.
    INSERT temp4 INTO TABLE temp3.
    temp2-task = temp3.
    DATA temp5 TYPE z2ui5_cl_demo_app_076=>tt_children4.
    CLEAR temp5.
    DATA temp6 LIKE LINE OF temp5.
    temp6-id = `line2`.
    temp6-text = `Level 2`.
    DATA temp7 TYPE z2ui5_cl_demo_app_076=>tt_subtask5.
    CLEAR temp7.
    DATA temp8 LIKE LINE OF temp7.
    temp8-id = `chevron1`.
    temp8-starttime = `2018-11-01T09:00:00`.
    temp8-endtime = `2018-11-13T09:00:00`.
    INSERT temp8 INTO TABLE temp7.
    temp8-id = `chevron2`.
    temp8-starttime = `2018-11-15T09:00:00`.
    temp8-endtime = `2018-11-27T09:00:00`.
    INSERT temp8 INTO TABLE temp7.
    temp6-subtask = temp7.
    INSERT temp6 INTO TABLE temp5.
    temp2-children = temp5.
    INSERT temp2 INTO TABLE temp1.
    mt_table-children = temp1.

  ENDMETHOD.
ENDCLASS.
