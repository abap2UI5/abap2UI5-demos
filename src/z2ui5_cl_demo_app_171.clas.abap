CLASS z2ui5_cl_demo_app_171 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

ENDCLASS.

CLASS z2ui5_cl_demo_app_171 IMPLEMENTATION.
  METHOD z2ui5_if_app~main.
    TRY.

        "first app start,
        IF client->check_on_init( ) IS NOT INITIAL.

          "init values here..
          RETURN.
        ENDIF.


        "callback after previous app.
        IF client->check_on_navigated( ) IS NOT INITIAL.

          DATA lo_app_prev TYPE REF TO z2ui5_if_app.
          lo_app_prev = client->get_app_prev( ).
          "read attributes of previous app here...
          RETURN.
        ENDIF.


        "handle events..
        CASE client->get( )-event.
          WHEN 'OK'.
            DATA lt_arg TYPE string.
            lt_arg = client->get_event_arg( ).
            "...

          WHEN 'CANCEL'.
            "...

        ENDCASE.

        "error handling here..
        DATA lx TYPE REF TO cx_root.
      CATCH cx_root INTO lx.
        client->message_box_display( lx ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
