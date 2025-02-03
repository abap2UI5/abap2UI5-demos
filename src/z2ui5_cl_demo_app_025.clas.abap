CLASS z2ui5_cl_demo_app_025 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA mv_input TYPE string.
    DATA mv_input_previous TYPE string.
    DATA mv_input_previous_set TYPE string.
    DATA mv_show_view TYPE string.

    DATA mv_event_backend TYPE string.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_025 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    CASE client->get( )-event.

      WHEN 'BUTTON_ROUNDTRIP'.
        client->message_box_display( 'server-client roundtrip, method on_event of the abap controller was called' ).

      WHEN 'BUTTON_RESTART'.
        DATA temp1 TYPE REF TO z2ui5_cl_demo_app_025.
        CREATE OBJECT temp1 TYPE z2ui5_cl_demo_app_025.
        client->nav_app_call( temp1 ).

      WHEN 'BUTTON_CHANGE_APP'.
        DATA temp2 TYPE REF TO z2ui5_cl_demo_app_001.
        CREATE OBJECT temp2 TYPE z2ui5_cl_demo_app_001.
        client->nav_app_call( temp2 ).

      WHEN 'BUTTON_READ_PREVIOUS'.
        DATA temp3 TYPE REF TO z2ui5_cl_demo_app_024.
        temp3 ?= client->get_app( client->get( )-s_draft-id_prev_app ).
        DATA lo_previous_app LIKE temp3.
        lo_previous_app = temp3.
        mv_input_previous = lo_previous_app->mv_input2.
        client->message_toast_display( `data of previous app read` ).

      WHEN 'SHOW_VIEW_MAIN'.
        mv_show_view = 'MAIN'.

      WHEN 'BACK_WITH_EVENT'.
        DATA temp4 TYPE REF TO z2ui5_cl_demo_app_024.
        temp4 ?= client->get_app( client->get( )-s_draft-id_prev_app_stack ).
        lo_previous_app = temp4.
        lo_previous_app->mv_backend_event = 'CALL_PREVIOUS_APP_INPUT_RETURN'.
        client->nav_app_leave( lo_previous_app ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN OTHERS.

        CASE mv_event_backend.

          WHEN 'NEW_APP_EVENT'.
            client->message_box_display( 'new app called and event NEW_APP_EVENT raised' ).

        ENDCASE.

    ENDCASE.


    CASE mv_show_view.

      WHEN 'MAIN' OR ''.

        DATA view TYPE REF TO z2ui5_cl_xml_view.
        view = z2ui5_cl_xml_view=>factory( ).
        DATA page TYPE REF TO z2ui5_cl_xml_view.
        page = view->shell(
            )->page(
                   title          = 'abap2UI5 - flow logic - APP 02'
                   navbuttonpress = client->_event( 'BACK' )
                   shownavbutton  = abap_true ).

        page->grid( 'L6 M12 S12' )->content( 'layout'
          )->simple_form( 'View: FIRST' )->content( 'form'
          )->label( 'Input set by previous app'
               )->input( mv_input_previous_set
          )->label( 'Data of previous app'
               )->input( mv_input_previous
               )->button( text  = 'read'
                          press = client->_event( 'BUTTON_READ_PREVIOUS' )
          )->label( 'Call previous app and show data of this app'
               )->input( client->_bind_edit( mv_input )
               )->button( text  = 'back'
                          press = client->_event( 'BACK_WITH_EVENT' ) ).

      WHEN 'SECOND'.

        view = z2ui5_cl_xml_view=>factory( ).
        page = view->shell(
            )->page(
                    title          = 'abap2UI5 - flow logic - APP 02'
                    navbuttonpress = client->_event( val = 'BACK' )
                    shownavbutton  = abap_true ).

        page->grid( 'L6 M12 S12' )->content( 'layout'
            )->simple_form( 'View: SECOND' )->content( 'form'
              )->label( 'Demo'
              )->button( text  = 'leave to previous app'
                         press = client->_event( 'BACK' )
              )->label( 'Demo'
              )->button( text  = 'show view main'
                         press = client->_event( 'SHOW_VIEW_MAIN' ) ).

    ENDCASE.

    client->view_display( view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
