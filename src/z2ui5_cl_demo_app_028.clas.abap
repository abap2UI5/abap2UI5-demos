CLASS z2ui5_cl_demo_app_028 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        title    TYPE string,
        value    TYPE string,
        descr    TYPE string,
        icon     TYPE string,
        info     TYPE string,
        checkbox TYPE abap_bool,
      END OF ty_row.
    TYPES temp1_35f4bb9be9 TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
DATA t_tab TYPE temp1_35f4bb9be9.

    DATA mv_counter TYPE i.
    DATA mv_check_active TYPE abap_bool.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_on_init.
    METHODS z2ui5_on_event.
    METHODS z2ui5_view_display.

  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_028 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    me->client     = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_on_init( ).
      z2ui5_view_display( ).
    ENDIF.

    IF client->get( )-event IS NOT INITIAL.
      z2ui5_on_event( ).
    ENDIF.

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.

      WHEN 'TIMER_FINISHED'.
        mv_counter = mv_counter + 1.
        DATA temp1 TYPE z2ui5_cl_demo_app_028=>ty_row.
        CLEAR temp1.
        temp1-title = 'entry' && mv_counter.
        temp1-info = 'completed'.
        temp1-descr = 'this is a description'.
        temp1-icon = 'sap-icon://account'.
        INSERT temp1
            INTO TABLE t_tab.

        IF mv_counter = 3.
          mv_check_active = abap_false.
          client->message_toast_display( `timer deactivated` ).
        ENDIF.

        client->view_model_update( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_init.

    mv_counter = 1.
    mv_check_active = abap_true.

    DATA temp2 LIKE t_tab.
    CLEAR temp2.
    DATA temp3 LIKE LINE OF temp2.
    temp3-title = 'entry' && mv_counter.
    temp3-info = 'completed'.
    temp3-descr = 'this is a description'.
    temp3-icon = 'sap-icon://account'.
    INSERT temp3 INTO TABLE temp2.
    t_tab = temp2.

  ENDMETHOD.


  METHOD z2ui5_view_display.

    DATA lo_view TYPE REF TO z2ui5_cl_xml_view.
    lo_view = z2ui5_cl_xml_view=>factory( ).

    lo_view->_z2ui5( )->timer(
        finished    = client->_event( 'TIMER_FINISHED' )
        delayms     = `2000`
        checkactive = client->_bind( mv_check_active ) ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = lo_view->shell( )->page(
             title          = 'abap2UI5 - CL_GUI_TIMER - Monitor'
             navbuttonpress = client->_event( 'BACK' )
             shownavbutton  = temp1 ).

    page->list(
         headertext = 'Data auto refresh (2 sec)'
         items      = client->_bind( t_tab )
         )->standard_list_item(
             title       = '{TITLE}'
             description = '{DESCR}'
             icon        = '{ICON}'
             info        = '{INFO}' ).

    client->view_display( lo_view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
