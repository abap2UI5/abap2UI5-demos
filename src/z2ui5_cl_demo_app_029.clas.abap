CLASS z2ui5_cl_demo_app_029 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA check_initialized TYPE abap_bool.

    DATA mv_tab_radial_active TYPE abap_bool.

    METHODS render_tab_radial.

    DATA client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_029 IMPLEMENTATION.


  METHOD render_tab_radial.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA container TYPE REF TO z2ui5_cl_xml_view.
    container = view->shell(
        )->page(
            title          = 'abap2UI5 - Visualization'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = abap_true
        )->tab_container( ).

    DATA grid TYPE REF TO z2ui5_cl_xml_view.
    grid = container->tab(
            text     = 'Radial Chart'
            selected = client->_bind( mv_tab_radial_active )
        )->grid( 'XL12 L12 M12 S12' ).

    grid->link(
        text   = 'Go to the SAP Demos for Radial Charts here...'
        target = '_blank'
        href   = 'https://sapui5.hana.ondemand.com/#/entity/sap.suite.ui.microchart.RadialMicroChart/sample/sap.suite.ui.microchart.sample.RadialMicroChart' ).

    grid->vertical_layout(
        )->horizontal_layout(
            )->radial_micro_chart(
                size       = 'M'
                percentage = '45'
                press      = client->_event( 'RADIAL_PRESS' )
            )->radial_micro_chart(
                size       = 'S'
                percentage = '45'
                press      = client->_event( 'RADIAL_PRESS' )
        )->get_parent(
        )->horizontal_layout(
            )->radial_micro_chart(
                size       = 'M'
                percentage = '99.9'
                press      = client->_event( 'RADIAL_PRESS' )
                valuecolor = 'Good'
            )->radial_micro_chart(
                size       = 'S'
                percentage = '99.9'
                press      = client->_event( 'RADIAL_PRESS' )
                valuecolor = 'Good'
        )->get_parent(
        )->horizontal_layout(
            )->radial_micro_chart(
                size       = 'M'
                percentage = '0'
                press      = client->_event( 'RADIAL_PRESS' )
                valuecolor = 'Error'
            )->radial_micro_chart(
                size       = 'S'
                percentage = '0'
                press      = client->_event( 'RADIAL_PRESS' )
                valuecolor = 'Error'
        )->get_parent(
        )->horizontal_layout(
            )->radial_micro_chart(
                size       = 'M'
                percentage = '0.1'
                press      = client->_event( 'RADIAL_PRESS' )
                valuecolor = 'Critical'
            )->radial_micro_chart(
                size       = 'S'
                percentage = '0.1'
                press      = client->_event( 'RADIAL_PRESS' )
                valuecolor = 'Critical' ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.



      render_tab_radial( ).
    ENDIF.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
