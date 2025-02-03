CLASS z2ui5_cl_demo_app_lp_01 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_lp_01 IMPLEMENTATION.
  METHOD z2ui5_if_app~main.
    IF check_initialized = abap_false.
      check_initialized = abap_true.

      IF client->get( )-check_launchpad_active = abap_false.
        client->message_box_display( `No Launchpad Active, Sample not working!` ).
      ENDIF.

      DATA view TYPE REF TO z2ui5_cl_xml_view.
      view = z2ui5_cl_xml_view=>factory( ).
      DATA page TYPE REF TO z2ui5_cl_xml_view.
      page = view->shell( )->page( showheader = abap_false ).
      client->view_display( page->simple_form( title    = 'Laucnhpad I - Read Startup Parameters' editable = abap_true
                     )->content( 'form'
                         )->label( ``
                         )->button( text  = 'Read Parameters'
                                    press = client->_event( val = 'READ_PARAMS' )
                         )->label( ``
                         )->button( text  = 'Go Back'
                                    press = client->_event( val = 'BACK' ) )->stringify( ) ).

    ENDIF.

    CASE client->get( )-event.

      WHEN 'READ_PARAMS'.
        DATA lv_text TYPE string.
        lv_text = `Start Parameter: `.
        DATA lt_params TYPE z2ui5_if_types=>ty_t_name_value.
        lt_params = client->get( )-t_comp_params.
        DATA ls_param LIKE LINE OF lt_params.
        LOOP AT lt_params INTO ls_param.
          lv_text = |{ lv_text } / { ls_param-n } = { ls_param-v }|.
        ENDLOOP.
        client->message_box_display( lv_text ).

      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
