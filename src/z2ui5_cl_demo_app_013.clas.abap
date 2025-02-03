CLASS z2ui5_cl_demo_app_013 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA check_initialized TYPE abap_bool.

    DATA mv_sel4 TYPE abap_bool.
    DATA mv_sel5 TYPE abap_bool.
    DATA mv_sel6 TYPE abap_bool.

    DATA mv_tab_donut_active TYPE abap_bool.
    DATA total_count TYPE i.

    TYPES:
      BEGIN OF ty_chart,
        text    TYPE string,
        percent TYPE p LENGTH 3 DECIMALS 2,
      END OF ty_chart.

    DATA counts TYPE STANDARD TABLE OF ty_chart WITH DEFAULT KEY.

    METHODS render_tab_donut.
    DATA client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_013 IMPLEMENTATION.


  METHOD render_tab_donut.

    DATA container TYPE REF TO z2ui5_cl_xml_view.
    container = z2ui5_cl_xml_view=>factory(
        )->shell(
        )->page(
            title          = 'abap2UI5 - Visualization'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = abap_true
        )->tab_container( ).

    DATA grid TYPE REF TO z2ui5_cl_xml_view.
    grid = container->tab(
            text     = 'Donut Chart'
            selected = client->_bind( mv_tab_donut_active )
         )->grid( 'XL6 L6 M6 S12' ).

    grid->link(
         text   = 'Go to the SAP Demos for Interactive Donut Charts here...'
         target = '_blank'
         href   = 'https://sapui5.hana.ondemand.com/#/entity/sap.suite.ui.microchart.InteractiveDonutChart/sample/sap.suite.ui.microchart.sample.InteractiveDonutChart'
        )->text(
                text  = 'Three segments'
                class = 'sapUiSmallMargin'
            )->get( )->layout_data(
                )->grid_data( 'XL12 L12 M12 S12' ).


    DATA seg TYPE REF TO z2ui5_cl_xml_view.
    seg = grid->flex_box(
            width          = '22rem'
            height         = '13rem'
            alignitems     = 'Start'
            justifycontent = 'SpaceBetween'
                )->items( )->interact_donut_chart(
                            selectionchanged = client->_event( 'DONUT_CHANGED' )
                    )->segments( ).
    seg->interact_donut_chart_segment( selected       = client->_bind( mv_sel4 )
                                       label          = 'Impl. Phase'
                                       value          = '40.0'
                                       displayedvalue = '40.0%' ).
    seg->interact_donut_chart_segment( selected       = client->_bind( mv_sel5 )
                                       label          = 'Design Phase'
                                       value          = '21.5'
                                       displayedvalue = '21.5%' ).
    seg->interact_donut_chart_segment( selected       = client->_bind( mv_sel6 )
                                       label          = 'Test Phase'
                                       value          = '38.5'
                                       displayedvalue = '38.5%' ).

    grid->text(
            text  = 'Four segments'
            class = 'sapUiSmallMargin'
        )->get( )->layout_data(
            )->grid_data( 'XL12 L12 M12 S12' ).

    seg = grid->flex_box(
            width          = '22rem'
            height         = '13rem'
            alignitems     = 'Start'
            justifycontent = 'SpaceBetween'
         )->items( )->interact_donut_chart(
                selectionchanged  = client->_event( 'DONUT_CHANGED' )
                press             = client->_event( 'DONUT_PRESS' )
                displayedsegments = '4'
            )->segments( ).
    seg->interact_donut_chart_segment( label          = 'Design Phase'
                                       value          = '32.0'
                                       displayedvalue = '32.0%' ).
    seg->interact_donut_chart_segment( label          = 'Implementation Phase'
                                       value          = '28'
                                       displayedvalue = '28%' ).
    seg->interact_donut_chart_segment( label          = 'Test Phase'
                                       value          = '25'
                                       displayedvalue = '25%' ).
    seg->interact_donut_chart_segment( label          = 'Launch Phase'
                                       value          = '15'
                                       displayedvalue = '15%' ).

    grid->text(
            text  = 'Error Messages'
            class = 'sapUiSmallMargin'
        )->get( )->layout_data(
            )->grid_data( 'XL12 L12 M12 S12' ).

    seg = grid->flex_box(
            width          = '22rem'
            height         = '13rem'
            alignitems     = 'Start'
            justifycontent = 'SpaceBetween'
        )->items( )->interact_donut_chart(
                selectionchanged  = client->_event( 'DONUT_CHANGED' )
                showerror         = abap_true
                errormessagetitle = 'No data'
                errormessage      = 'Currently no data is available'
            )->segments( ).
    seg->interact_donut_chart_segment( label          = 'Implementation Phase'
                                       value          = '40.0'
                                       displayedvalue = '40.0%' ).
    seg->interact_donut_chart_segment( label          = 'Design Phase'
                                       value          = '21.5'
                                       displayedvalue = '21.5%' ).
    seg->interact_donut_chart_segment( label          = 'Test Phase'
                                       value          = '38.5'
                                       displayedvalue = '38.5%' ).

    grid->text(
            text  = 'Model Update Table Data'
            class = 'sapUiSmallMargin'
        )->get( )->layout_data(
            )->grid_data( 'XL12 L12 M12 S12' ).

    DATA donut_chart TYPE REF TO z2ui5_cl_xml_view.
    donut_chart = grid->button( text  = `update chart`
                                      press = client->_event( 'UPDATE_CHART_DATA' ) )->get_parent(
      )->flex_box(
        width          = '30rem'
        height         = '18rem'
        alignitems     = 'Start'
        justifycontent = 'SpaceBetween'
            )->items(
                )->interact_donut_chart( displayedsegments = client->_bind_edit( total_count )
                                         segments          = client->_bind_edit( counts ) ).


    donut_chart->interact_donut_chart_segment(
              label          = `{TEXT}`
              value          = `{PERCENT}`
              displayedvalue = `{PERCENT}` ).

    client->view_display( container->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.


      DATA temp1 LIKE counts.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-text = '1st'.
      temp2-percent = '10.0'.
      INSERT temp2 INTO TABLE temp1.
      temp2-text = '2nd'.
      temp2-percent = '60.0'.
      INSERT temp2 INTO TABLE temp1.
      temp2-text = '3rd'.
      temp2-percent = '30.0'.
      INSERT temp2 INTO TABLE temp1.
      counts = temp1.

      total_count = lines( counts ).



      render_tab_donut( ).
    ENDIF.

    CASE client->get( )-event.
      WHEN 'UPDATE_CHART_DATA'.
        CLEAR counts.
        DATA temp3 LIKE counts.
        CLEAR temp3.
        DATA temp4 LIKE LINE OF temp3.
        temp4-text = '1st'.
        temp4-percent = '60.0'.
        INSERT temp4 INTO TABLE temp3.
        temp4-text = '2nd'.
        temp4-percent = '10.0'.
        INSERT temp4 INTO TABLE temp3.
        temp4-text = '3rd'.
        temp4-percent = '15.0'.
        INSERT temp4 INTO TABLE temp3.
        temp4-text = '4th'.
        temp4-percent = '15.0'.
        INSERT temp4 INTO TABLE temp3.
        counts = temp3.

        total_count = lines( counts ).

        client->view_model_update( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
