CLASS z2ui5_cl_demo_app_135 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA lock_counter TYPE i READ-ONLY .
    DATA check_initialized TYPE abap_bool READ-ONLY .
    DATA session_is_stateful TYPE abap_bool READ-ONLY .
    DATA session_text TYPE string READ-ONLY .
    DATA lock_text TYPE string READ-ONLY .
    DATA:
      BEGIN OF error READ-ONLY,
        text TYPE string,
        flag TYPE abap_bool,
      END OF error.

  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS initialize_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

    METHODS set_session_stateful
      IMPORTING
        client   TYPE REF TO z2ui5_if_client
        stateful TYPE abap_bool.

    METHODS update_lock_counter.

ENDCLASS.



CLASS z2ui5_cl_demo_app_135 IMPLEMENTATION.

  METHOD initialize_view.
    set_session_stateful( client   = client
                          stateful = abap_true ).

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell( )->page(
      title          = `abap2UI5 - Sample: Sticky Session with locks - (ABAP Standard Only)`
      navbuttonpress = client->_event( 'BACK' )
      shownavbutton  = temp1 ).

    page->message_strip(
        text    = client->_bind( error-text )
        type    = 'Error'
        visible = client->_bind( error-flag ) ).

    DATA vbox TYPE REF TO z2ui5_cl_xml_view.
    vbox = page->vbox( ).

    DATA hbox TYPE REF TO z2ui5_cl_xml_view.
    hbox = vbox->hbox( alignitems = 'Center' ).

    hbox->info_label( text = client->_bind( session_text ) ).

    hbox->button(
      text  = 'End session'
      press = client->_event( 'END_SESSION' ) ).

    hbox->button(
      text  = 'Start session again'
      press = client->_event( 'START_SESSION' ) ).

    hbox = vbox->hbox( alignitems = 'Center' ).
    hbox->label( text  = 'press button to create lock entry (SM12) in backend session'
                 class = 'sapUiTinyMarginEnd' ).
    hbox->button(
      text  = 'Lock'
      press = client->_event( 'LOCK' )
      type  = 'Emphasized' ).

    hbox = vbox->hbox( ).

    hbox->button(
      text  = 'Refresh lock counter'
      press = client->_event( 'REFRESH' ) ).

    hbox->button(
      text  = 'Rollback Work'
      press = client->_event( 'ROLLBACK' ) ).

    vbox->hbox( )->info_label( client->_bind( lock_text ) ).

    client->view_display( view->stringify( ) ).
  ENDMETHOD.


  METHOD on_event.
    CASE client->get( )-event.
      WHEN 'BACK'.
        set_session_stateful( client   = client
                              stateful = abap_false ).
        client->nav_app_leave( ).
      WHEN 'LOCK'.
        lcl_locking=>acquire_lock( ).
        client->message_toast_display( `Lock acquired. Press 'Refresh lock counter'` ).
        client->view_model_update( ).
      WHEN 'END_SESSION'.
        set_session_stateful( client   = client
                              stateful = abap_false ).
      WHEN 'START_SESSION'.
        set_session_stateful( client   = client
                              stateful = abap_true ).
      WHEN 'REFRESH'.
        update_lock_counter( ).
        client->view_model_update( ).
      WHEN 'ROLLBACK'.
        ROLLBACK WORK.
        client->message_toast_display( |ROLLBACK WORK done, { lock_counter } locks released. Press 'Refresh lock counter'| ).
    ENDCASE.
  ENDMETHOD.


  METHOD set_session_stateful.
    client->set_session_stateful( stateful ).
    session_is_stateful = stateful.
    IF stateful = abap_true.
      session_text = 'Session ON (stateful)'.
    ELSE.
      session_text = 'Session OFF (stateless)'.
    ENDIF.
    client->view_model_update( ).
  ENDMETHOD.


  METHOD z2ui5_if_app~main.
    TRY.

        CLEAR error.

        IF check_initialized = abap_false.
          check_initialized = abap_true.
          update_lock_counter( ).
          initialize_view( client ).
        ENDIF.

        TRY.
            on_event( client ).
            DATA x_error TYPE REF TO z2ui5_cx_util_error.
          CATCH z2ui5_cx_util_error INTO x_error.
            error-text = x_error->get_text( ).
            error-flag = abap_true.
            client->view_model_update( ).
        ENDTRY.

        DATA lx TYPE REF TO cx_root.
      CATCH cx_root INTO lx.
        client->message_box_display( lx->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD update_lock_counter.

    lock_counter = lcl_locking=>get_lock_counter( ).
    lock_text = |There are { lock_counter } SM12 locks|.

  ENDMETHOD.

ENDCLASS.

