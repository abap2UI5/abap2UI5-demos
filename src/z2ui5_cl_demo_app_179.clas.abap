CLASS z2ui5_cl_demo_app_179 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

*https://github.com/abap2UI5/abap2UI5/issues/988#issuecomment-1978738754

    INTERFACES z2ui5_if_app.

    DATA zoomlevel TYPE i.

    TYPES:
      BEGIN OF ty_s_data,
        objectid       TYPE string,
        relationid     TYPE string,
        parentobjectid TYPE string,
        predectaskid   TYPE string,
        succtaskid     TYPE string,
        relationtype   TYPE string,
        shapetypestart TYPE string,
        shapetypeend   TYPE string,
        starttime      TYPE string,
        endtime        TYPE string,
      END OF ty_s_data.
    TYPES temp1_6cd5a9d875 TYPE STANDARD TABLE OF ty_s_data WITH DEFAULT KEY.
DATA mt_data TYPE temp1_6cd5a9d875.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client .
    DATA check_initialized TYPE abap_bool .

    METHODS set_view .
    METHODS z2ui5_on_event .
    METHODS set_mock_data .

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_179 IMPLEMENTATION.


  METHOD set_mock_data.


    DATA lv_mock TYPE string.
    lv_mock = `[` && |\n| &&
                    `   {` && |\n| &&
                    `       "ObjectID": "rls-0-1",` && |\n| &&
                    `       "RelationID": "rls-0",` && |\n| &&
                    `       "ParentObjectID": "object-0-1-1",` && |\n| &&
                    `       "PredecTaskID": "object-0-1-1",` && |\n| &&
                    `       "SuccTaskID": "object-0-1-2",` && |\n| &&
                    `       "RelationType": "StartToFinish",` && |\n| &&
                    `       "shapeTypeStart":"VerticalRectangle",` && |\n| &&
                    `       "shapeTypeEnd":"Diamond",` && |\n| &&
                    `       "StartTime":"2018-11-01T09:00:00",` && |\n| &&
                    `       "EndTime":"2018-11-27T09:00:00"` && |\n| &&
                    `   },` && |\n| &&
                    |\n| &&
                    `   {` && |\n| &&
                    `       "ObjectID": "rls-1-1",` && |\n| &&
                    `       "RelationID": "rls-1",` && |\n| &&
                    `       "ParentObjectID": "object-0-2-2",` && |\n| &&
                    `       "PredecTaskID": "object-0-2-2",` && |\n| &&
                    `       "SuccTaskID": "object-0-2-3",` && |\n| &&
                    `       "RelationType": "FinishToFinish",` && |\n| &&
                    `       "shapeTypeStart":"Square",` && |\n| &&
                    `       "shapeTypeEnd":"Diamond",` && |\n| &&
                           `       "StartTime":"2018-11-01T09:00:00",` && |\n| &&
                    `       "EndTime":"2018-11-27T09:00:00"` && |\n| &&
                    `   },  ` && |\n| &&
                    |\n| &&
                    `   {` && |\n| &&
                    `       "ObjectID": "rls-2-1",` && |\n| &&
                    `       "RelationID": "rls-2",` && |\n| &&
                    `       "ParentObjectID": "object-0-2-1",` && |\n| &&
                    `       "PredecTaskID": "object-0-2-1",` && |\n| &&
                    `       "SuccTaskID": "object-0-2-4",` && |\n| &&
                    `       "RelationType": "StartToStart",` && |\n| &&
                    `       "enableCurvedEdge":true,` && |\n| &&
                           `       "StartTime":"2018-11-01T09:00:00",` && |\n| &&
                    `       "EndTime":"2018-11-27T09:00:00"` && |\n| &&
                    `   ` && |\n| &&
                    `   },` && |\n| &&
                    `   {` && |\n| &&
                    `       "ObjectID": "rls-3-1",` && |\n| &&
                    `       "RelationID": "rls-3",` && |\n| &&
                    `       "ParentObjectID": "object-0-2-1",` && |\n| &&
                    `       "PredecTaskID": "object-0-2-1",` && |\n| &&
                    `       "SuccTaskID": "object-0-2-3",` && |\n| &&
                    `       "RelationType": "FinishToFinish",` && |\n| &&
                    `       "shapeTypeStart":"Diamond",` && |\n| &&
                    `       "shapeTypeEnd":"Circle",` && |\n| &&
                           `       "StartTime":"2018-11-01T09:00:00",` && |\n| &&
                    `       "EndTime":"2018-11-27T09:00:00"` && |\n| &&
                    `   },` && |\n| &&
                    `   ` && |\n| &&
                    `   {` && |\n| &&
                    `       "ObjectID": "rls-4-1",` && |\n| &&
                    `       "RelationID": "rls-4",` && |\n| &&
                    `       "ParentObjectID": "object-0-1",` && |\n| &&
                    `       "PredecTaskID": "object-0-1",` && |\n| &&
                    `       "SuccTaskID": "object-0-2",` && |\n| &&
                    `       "RelationType": "StartToFinish",` && |\n| &&
                    `       "shapeTypeStart":"Circle",` && |\n| &&
                    `       "shapeTypeEnd":"Diamond",` && |\n| &&
                    `       "startShapeColor":"white",` && |\n| &&
                    `       "endShapeColor":"green",` && |\n| &&
                    `       "selectedStartShapeColor":"blue",` && |\n| &&
                    `       "selectedEndShapeColor":"yellow",` && |\n| &&
                    `       "enableCurvedEdge":true,` && |\n| &&
                           `       "StartTime":"2018-11-01T09:00:00",` && |\n| &&
                    `       "EndTime":"2018-11-27T09:00:00"` && |\n| &&
                    `   },` && |\n| &&
                    `   {` && |\n| &&
                    `       "ObjectID": "rls-5-1",` && |\n| &&
                    `       "RelationID": "rls-5",` && |\n| &&
                    `       "ParentObjectID": "object-0-2-4",` && |\n| &&
                    `       "PredecTaskID": "object-0-2-4",` && |\n| &&
                    `       "SuccTaskID": "object-0-2-5",` && |\n| &&
                    `       "RelationType": "FinishToStart",` && |\n| &&
                    `       "lShapeForTypeFS":false,` && |\n| &&
                           `       "StartTime":"2018-11-01T09:00:00",` && |\n| &&
                    `       "EndTime":"2018-11-27T09:00:00"` && |\n| &&
                    `   },` && |\n| &&
                    `   {` && |\n| &&
                    `       "ObjectID": "rls-6-1",` && |\n| &&
                    `       "RelationID": "rls-6",` && |\n| &&
                    `       "ParentObjectID": "object-0-3",` && |\n| &&
                    `       "PredecTaskID": "object-0-3",` && |\n| &&
                    `       "SuccTaskID": "object-0-3-1",` && |\n| &&
                    `       "RelationType": "FinishToStart",` && |\n| &&
                           `       "StartTime":"2018-11-01T09:00:00",` && |\n| &&
                    `       "EndTime":"2018-11-27T09:00:00"` && |\n| &&
                    `   }` && |\n| &&
                    `]`.

    z2ui5_cl_util=>json_parse(
      EXPORTING
        val  = lv_mock
      CHANGING
        data = mt_data ).

  ENDMETHOD.


  METHOD set_view.


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

    DATA cont TYPE REF TO z2ui5_cl_xml_view.
    cont = page->scroll_container(
*               height     =
*               width      =
*               vertical   =
                   horizontal = abap_true
*               id         =
*               focusable  =
*               visible    =
                 ).

    DATA tool TYPE REF TO z2ui5_cl_xml_view.
    tool = cont->container_toolbar(
      showsearchbutton        = abap_true
        showdisplaytypebutton = abap_true
        showlegendbutton      = abap_true
        showsettingbutton     = abap_true
        showtimezoomcontrol   = abap_true
*        findbuttonpress           = client->_event( val = 'FIRE' )
*    stepcountofslider         =
*    zoomcontroltype           =
*        zoomlevel                 = client->_bind_edit( zoomlevel )
*  RECEIVING
*    result                    =
      ).


    DATA gantt_container TYPE REF TO z2ui5_cl_xml_view.
    gantt_container = cont->gantt_chart_container( ).

*    gantt_charts

    DATA gantt TYPE REF TO z2ui5_cl_xml_view.
    gantt = gantt_container->gantt_chart_with_table(
         id                        = `gantt`
         shapeselectionmode        = `Single`
         isconnectordetailsvisible = abap_true ).

    DATA table TYPE REF TO z2ui5_cl_xml_view.
    table = gantt->gantt_table( )->tree_table(
        rows = `{path: '` && client->_bind( val = mt_data path = abap_true ) &&
         `',     parameters: {` && |\r\n| &&
         `           operationMode: 'Server',` && |\r\n| &&
         `           numberOfExpandedLevels: 2,` && |\r\n| &&
         `           treeAnnotationProperties: {` && |\r\n| &&
         `                 hierarchyNodeFor:                'OBJECTID',` && |\r\n| &&
         `                 hierarchyParentNodeFor:          'PARENTOBJECTID',` && |\r\n| &&
         `                 hierarchyLevelFor:               'HierarchyNodeLevel',` && |\r\n| &&
         `                 hierarchyDrillStateFor:          'DrillDownState',` && |\r\n| &&
         `                 hierarchyNodeDescendantCountFor: 'Magnitude'` && |\r\n| &&
         `             },` && |\r\n| &&
         `          expand: 'Relationships'` && |\r\n| &&
         `     }` && |\r\n| &&
         `}` ).



    DATA row_settings TYPE REF TO z2ui5_cl_xml_view.
    row_settings = table->row_settings_template( )->gantt_row_settings( rowid = `{OBJECTID}`
*                                  shapes1 = `{path: 'TASK', templateShareable:false}`
*                                  shapes2 = `{path: 'SUBTASK', templateShareable:false}`
                                  relationships                                     = `{path:'Relationships', templateShareable: 'true'}` ).

    DATA shapes TYPE REF TO z2ui5_cl_xml_view.
    shapes = row_settings->shapes1( ).
    shapes->base_rectangle(
        shapeid                 = `{OBJECTID}`
        time                    = `{= Helper.DateCreateObject(${STARTTIME}) }`
        endtime                 = `{= Helper.DateCreateObject(${ENDTIME}) }`
        height                  = `19`
        title                   = `{OBJECTNAME}`
        connectable             = abap_true
        horizontaltextalignment = `Start` ).

    DATA relas TYPE REF TO z2ui5_cl_xml_view.
    relas = row_settings->relationships( ).
    relas->relationship(
        shapeid     = `{RELATIONID}`
        type        = `{RELATIONTYPE}`
        successor   = `{SUCCTASKID}`
        predecessor = `{PREDECTASKID}` ).


    DATA columns TYPE REF TO z2ui5_cl_xml_view.
    columns = table->ui_columns( ).
    DATA column TYPE REF TO z2ui5_cl_xml_view.
    column = columns->ui_column(
         id = 'OBJECTNAME' ).

    column->ui_custom_data( )->core_custom_data(
       key    = 'exportTableColumnConfig'
        value = '{"columnKey": "OBJECTNAME",' && |\r\n| &&
                 '    "leadingProperty":"OBJECTNAME",' && |\r\n| &&
                 '    "dataType": "string",' && |\r\n| &&
                 '    "hierarchyNodeLevel": "HierarchyNodeLevel",' && |\r\n| &&
                 '    "wrap": true}'
      ).

    column->text( text = `Object Name` ).
    column->tree_template( )->label( text = `{OBJECTNAME}` ).

    gantt->axis_time_strategy(
      )->proportion_zoom_strategy(
        )->total_horizon(
          )->time_horizon( starttime = `20181101000000`
                           endtime   = `20181131000000` )->get_parent( )->get_parent(
        )->visible_horizon(
          )->time_horizon( starttime = `20181101000000`
                           endtime   = `20181131000000` ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      set_mock_data( ).
      set_view( ).
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
ENDCLASS.
