CLASS z2ui5_cl_demo_app_121 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA longitude TYPE string.
    DATA latitude TYPE string.
    DATA altitude TYPE string.
    DATA speed TYPE string.
    DATA altitudeaccuracy TYPE string.
    DATA accuracy TYPE string.
    DATA check_initialized TYPE abap_bool .

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_121 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.


    "on init
    IF check_initialized = abap_false.
      check_initialized = abap_true.

      client->view_display( z2ui5_cl_xml_view=>factory(
        )->_z2ui5( )->timer( client->_event( )
        )->stringify( ) ).


      RETURN.
    ENDIF.


    "user command
    CASE client->get( )-event.

      WHEN 'TIMER_FINISHED'.
        client->message_box_display( `Timer finished!` ).
        RETURN.

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).
        RETURN.

    ENDCASE.


    "render view
    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    client->view_display( view->shell(
          )->page(
                  title          = 'abap2UI5'
                  navbuttonpress = client->_event( val = 'BACK' )
                  shownavbutton  = temp1
              )->_z2ui5( )->timer(
                                        finished = client->_event( `TIMER_FINISHED` )
                                        delayms  = `2000`
              )->simple_form( title    = 'Timer Interval 2000 ms'
                              editable = abap_true
                  )->content( 'form'
           )->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
