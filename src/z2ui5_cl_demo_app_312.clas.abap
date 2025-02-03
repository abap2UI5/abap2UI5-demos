CLASS z2ui5_cl_demo_app_312 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ts_data_chart,
        week    TYPE string,
        revenue TYPE string,
        cost    TYPE string,
      END OF ts_data_chart.
    TYPES tt_data_chart TYPE STANDARD TABLE OF ts_data_chart WITH DEFAULT KEY.
    DATA mt_data_chart     TYPE tt_data_chart.

    TYPES:
      BEGIN OF ts_screen,
        viztype    TYPE string,
        viztypesel TYPE string,
      END OF ts_screen.
    DATA ms_screen         TYPE ts_screen.

    DATA mv_prop           TYPE string.
    DATA mt_feed_values    TYPE TABLE OF string.
    DATA check_initialized TYPE abap_bool.
    DATA mt_viztypes       TYPE z2ui5_if_types=>ty_t_name_value..

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    METHODS on_rendering.
    METHODS on_event.
    METHODS on_init.

  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_312 IMPLEMENTATION.

  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'EVT_DATA_SELECT'.
        client->message_toast_display( client->get_event_arg( 1 ) ).
      WHEN 'EVT_VIZTYPE_CHANGE'.
        ms_screen-viztype = ms_screen-viztypesel.
        on_rendering( ).
    ENDCASE.

  ENDMETHOD.

  METHOD on_init.
    " ---------- Set vizframe chart data --------------------------------------------------------------
    DATA temp1 TYPE z2ui5_cl_demo_app_312=>tt_data_chart.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-week = 'Week 1 - 4'.
    temp2-revenue = '431000.22'.
    temp2-cost = '230000.00'.
    INSERT temp2 INTO TABLE temp1.
    temp2-week = 'Week 5 - 8'.
    temp2-revenue = '494000.30'.
    temp2-cost = '238000.00'.
    INSERT temp2 INTO TABLE temp1.
    temp2-week = 'Week 9 - 12'.
    temp2-revenue = '491000.17'.
    temp2-cost = '221000.00'.
    INSERT temp2 INTO TABLE temp1.
    temp2-week = 'Week 13 - 16'.
    temp2-revenue = '536000.34'.
    temp2-cost = '280000.00'.
    INSERT temp2 INTO TABLE temp1.
    mt_data_chart = temp1.
    " ---------- Set vizframe properties (optional) ---------------------------------------------------
    mv_prop = |\{| && |\n| &&
    |"plotArea": \{| && |\n| &&
        |"dataLabel": \{| && |\n| &&
            |"formatString": "",| && |\n| &&
            |"visible": true| && |\n| &&
        |\}| && |\n|  &&
    |\},| && |\n|  &&
    |"valueAxis": \{| && |\n| &&
        |"label": \{| && |\n| &&
            |"formatString": ""| && |\n| &&
        |\},| && |\n| &&
        |"title": \{| && |\n| &&
            |"visible": true| && |\n| &&
        |\}| && |\n|  &&
    |\},| && |\n|  &&
    |"categoryAxis": \{| && |\n|  &&
        |"title": \{| && |\n| &&
            |"visible": true| && |\n| &&
        |\}| && |\n|  &&
    |\},| && |\n|  &&
    |"title": \{| && |\n| &&
        |"visible": true,| && |\n|  &&
        |"text": "Vizframe Charts for 2UI5"| && |\n| &&
    |\}| && |\n|  &&
|\}|.

    " ---------- Set vizframe feed item values for value axis -----------------------------------------
    DATA temp3 LIKE mt_feed_values.
    CLEAR temp3.
    INSERT `Revenue` INTO TABLE temp3.
    INSERT `Cost` INTO TABLE temp3.
    mt_feed_values = temp3.

    " ---------- Set viz type default -----------------------------------------------------------------
    ms_screen-viztype    = 'column'.
    ms_screen-viztypesel = 'column'.

    " ---------- Set VizFrame types -------------------------------------------------------------------
    DATA temp5 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp5.
    DATA temp6 LIKE LINE OF temp5.
    temp6-n = 'column'.
    temp6-v = 'column'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'bar'.
    temp6-v = 'bar'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'stacked_bar'.
    temp6-v = 'stacked_bar'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'stacked_column'.
    temp6-v = 'stacked_column'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'line'.
    temp6-v = 'line'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'combination'.
    temp6-v = 'combination'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'bullet'.
    temp6-v = 'bullet'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'vertical_bullet'.
    temp6-v = 'vertical_bullet'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = '100_stacked_bar'.
    temp6-v = '100_stacked_bar'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = '100_stacked_column'.
    temp6-v = '100_stacked_column'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'stacked_combination'.
    temp6-v = 'stacked_combination'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'horizontal_stacked_combination'.
    temp6-v = 'horizontal_stacked_combination'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'waterfall'.
    temp6-v = 'waterfall'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'horizontal_waterfall'.
    temp6-v = 'horizontal_waterfall'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'area'.
    temp6-v = 'area'.
    INSERT temp6 INTO TABLE temp5.
    temp6-n = 'radar'.
    temp6-v = 'radar'.
    INSERT temp6 INTO TABLE temp5.
    mt_viztypes = temp5.

  ENDMETHOD.

  METHOD on_rendering.

    DATA lr_view TYPE REF TO z2ui5_cl_xml_view.
    lr_view = z2ui5_cl_xml_view=>factory( )->shell( ).

    " ---------- Set dynamic page ---------------------------------------------------------------------
    DATA lr_dyn_page TYPE REF TO z2ui5_cl_xml_view.
    lr_dyn_page = lr_view->dynamic_page( showfooter = abap_false ).

    " ---------- Get header title ---------------------------------------------------------------------
    DATA lr_header_title TYPE REF TO z2ui5_cl_xml_view.
    lr_header_title = lr_dyn_page->title( ns = 'f' )->get( )->dynamic_page_title( ).

    " ---------- Set header title text ----------------------------------------------------------------
    lr_header_title->heading( ns = 'f' )->title( 'abap2UI5 - VizFrame Charts' ).

    " ---------- Get page header area ----------------------------------------------------------------
    DATA lr_header TYPE REF TO z2ui5_cl_xml_view.
    lr_header = lr_dyn_page->header( ns = 'f' )->dynamic_page_header( pinnable = abap_true )->content( ns = 'f' ).

    lr_header->button( text    = 'back'
                       press   = client->_event( 'BACK' )
                       visible = client->check_app_prev_stack( ) ).

    " ---------- Set Filter bar -----------------------------------------------------------------------
    DATA lr_filter_bar TYPE REF TO z2ui5_cl_xml_view.
    lr_filter_bar = lr_header->filter_bar( usetoolbar = 'false' )->filter_group_items( ).

    " ---------- Set filter ---------------------------------------------------------------------------
    DATA lr_filter TYPE REF TO z2ui5_cl_xml_view.
    lr_filter = lr_filter_bar->filter_group_item( name               = 'VizFrameType'
                                                        label              = 'VizFrame type'
                                                        groupname          = |GroupVizFrameType|
                                                        visibleinfilterbar = 'true'
                                                         )->filter_control( ).

    " ---------- Set combo box input field ------------------------------------------------------------
    lr_filter->combobox( selectedkey   = client->_bind_edit( me->ms_screen-viztypesel )
                         change        = client->_event( val = 'EVT_VIZTYPE_CHANGE' )
                         showclearicon = abap_true
                         items         = client->_bind( me->mt_viztypes )
                              )->item( key  = '{N}'
                                       text = '{V}' ).

    " ---------- Get page content area ----------------------------------------------------------------
    DATA lr_content TYPE REF TO z2ui5_cl_xml_view.
    lr_content = lr_dyn_page->content( ns = 'f' ).

    " ---------- Set vizframe chart -------------------------------------------------------------------
    DATA temp7 TYPE string_table.
    CLEAR temp7.
    INSERT `${$parameters>/data/0/data/}` INTO TABLE temp7.
    DATA lr_vizframe TYPE REF TO z2ui5_cl_xml_view.
    lr_vizframe = lr_content->viz_frame(
                            id            = 'idVizFrame'
*                            legendvisible =
*                            vizcustomizations =
                            vizproperties = mv_prop
*                            vizscales     =
                            viztype       = client->_bind( me->ms_screen-viztype )
                            height        = '500px'
                            width         = '100%'
*                            uiconfig      = `{applicationSet:'fiori'}`
*                            visible       =
                            selectdata    = client->_event( val   = 'EVT_DATA_SELECT'
                                                            t_arg = temp7 ) ).

    " ---------- Set vizframe dataset -----------------------------------------------------------------
    DATA lr_dataset TYPE REF TO z2ui5_cl_xml_view.
    lr_dataset = lr_vizframe->viz_dataset( ).

    " ---------- Set vizframe flattened dataset --------------------------------------------------------
    DATA lr_flatteneddataset TYPE REF TO z2ui5_cl_xml_view.
    lr_flatteneddataset = lr_dataset->viz_flattened_dataset( data = client->_bind( me->mt_data_chart ) ).

    " ---------- Set vizframe dimensions ---------------------------------------------------------------
    DATA lr_dimensions TYPE REF TO z2ui5_cl_xml_view.
    lr_dimensions = lr_flatteneddataset->viz_dimensions( ).

    " ---------- Set vizframe dimension ----------------------------------------------------------------
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lr_dimensions_def TYPE REF TO z2ui5_cl_xml_view.
    lr_dimensions_def = lr_dimensions->viz_dimension_definition(
*                                                                       axis  =
*                                                                       datatype =
*                                                                       displayvalue =
*                                                                       identity =
                                                                       name  = 'Week'
*                                                                       sorter =
                                                                       value = '{WEEK}' ).

    " ---------- Set vizframe measures ----------------------------------------------------------------
    DATA lr_measures TYPE REF TO z2ui5_cl_xml_view.
    lr_measures = lr_flatteneddataset->viz_measures( ).

    " ---------- Set vizframe measure definition 1 ----------------------------------------------------
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lr_measures_def1 TYPE REF TO z2ui5_cl_xml_view.
    lr_measures_def1 = lr_measures->viz_measure_definition(
*                                                                  format =
*                                                                  group =
*                                                                  identity =
                                                                  name  = 'Revenue'
*                                                                  range =
*                                                                  unit  =
                                                                  value = '{REVENUE}' ).

    " ---------- Set vizframe measure definition 2 ----------------------------------------------------
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lr_measures_def2 TYPE REF TO z2ui5_cl_xml_view.
    lr_measures_def2 = lr_measures->viz_measure_definition(
*                                                                  format =
*                                                                  group =
*                                                                  identity =
                                                                  name  = 'Cost'
*                                                                  range =
*                                                                  unit  =
                                                                  value = '{COST}' ).

    " ---------- Set vizframe feeds -------------------------------------------------------------------
    DATA lr_feeds TYPE REF TO z2ui5_cl_xml_view.
    lr_feeds = lr_vizframe->viz_feeds( ).

    " ---------- Set vizframe feed for value axis -----------------------------------------------------
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lr_lr_feed_item1 TYPE REF TO z2ui5_cl_xml_view.
    lr_lr_feed_item1 = lr_feeds->viz_feed_item( id     = 'valueAxisFeed'
                                                      uid    = 'valueAxis'
                                                      type   = 'Measure'
                                                      values = client->_bind( me->mt_feed_values ) ).

    " ---------- Set vizframe feed for category axis --------------------------------------------------
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lr_lr_feed_item2 TYPE REF TO z2ui5_cl_xml_view.
    lr_lr_feed_item2 = lr_feeds->viz_feed_item( id     = 'categoryAxisFeed'
                                                      uid    = 'categoryAxis'
                                                      type   = 'Dimension'
                                                      values = 'Week' ).

    client->view_display( lr_view->stringify( ) ).

  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->check_on_init( ) IS NOT INITIAL.
      on_init( ).
      on_rendering( ).
    ELSE.
      on_event( ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
