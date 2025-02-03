CLASS z2ui5_cl_demo_app_095 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_s_01,
        input TYPE string,
        BEGIN OF ty_s_02,
          input TYPE string,
          BEGIN OF ty_s_03,
            input TYPE string,
            BEGIN OF ty_s_04,
              input TYPE string,
            END OF ty_s_04,
          END OF ty_s_03,
        END OF ty_s_02,
      END OF ty_s_01.
    DATA ms_screen TYPE ty_s_01.

    DATA mo_app_sub TYPE REF TO z2ui5_cl_demo_app_096.

    DATA client      TYPE REF TO z2ui5_if_client.
    DATA mv_init     TYPE abap_bool.
    DATA mo_grid_sub TYPE REF TO z2ui5_cl_xml_view.

    DATA mr_input  TYPE REF TO data.
    DATA mr_screen TYPE REF TO data.

    METHODS on_init.
    METHODS on_event.
    METHODS view_build.
    METHODS on_init_sub.
    METHODS on_event_sub.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA page TYPE REF TO z2ui5_cl_xml_view.

ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_095 IMPLEMENTATION.


  METHOD on_event.

    CASE client->get( )-event.

      WHEN 'BUTTON_SAVE'.
        client->message_box_display( `event main app` ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD on_event_sub.

    mo_app_sub->mo_view_parent = mo_grid_sub.
    mo_app_sub->z2ui5_if_app~main( client = client ).

  ENDMETHOD.


  METHOD on_init.

    ms_screen-input = `app main`.
    view_build( ).

  ENDMETHOD.


  METHOD on_init_sub.

    CREATE OBJECT mo_app_sub.
    mo_app_sub->mo_view_parent = mo_grid_sub.
    mo_app_sub->z2ui5_if_app~main( client = client ).

    client->view_display( page->get_root( )->xml_get( ) ).

  ENDMETHOD.


  METHOD view_build.

    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title           = 'abap2UI5 - Main App with Sub App'
            navbuttonpress  = client->_event( 'BACK' )
              shownavbutton = abap_true ).

    DATA o_grid TYPE REF TO z2ui5_cl_xml_view.
    o_grid = page->grid( 'L6 M12 S12'
        )->content( 'layout' ).

    DATA content TYPE REF TO z2ui5_cl_xml_view.
    content = o_grid->simple_form( title = 'Input'
          )->content( 'form' ).
    content->label( 'main app'
      )->input(
          value  = client->_bind_edit( ms_screen-input )
          submit = client->_event( 'INPUT' ) ).

    mo_grid_sub = page->grid( 'L12 M12 S12'
        )->content( 'layout' ).

    page->footer( )->overflow_toolbar(
                   )->toolbar_spacer(
                   )->button(
                       text  = 'Delete'
                       press = client->_event( 'BUTTON_DELETE' )
                       type  = 'Reject'
                       icon  = 'sap-icon://delete'
                   )->button(
                       text  = 'Add'
                       press = client->_event( 'BUTTON_ADD' )
                       type  = 'Default'
                       icon  = 'sap-icon://add'
                   )->button(
                       text  = 'Save'
                       press = client->_event( 'BUTTON_SAVE' )
                       type  = 'Success' ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF mv_init = abap_false.
      mv_init = abap_true.
      on_init( ).
      on_init_sub( ).
      client->view_display( page->get_root( )->xml_get( ) ).
      RETURN.
    ENDIF.

    on_event( ).
    on_event_sub( ).

  ENDMETHOD.
ENDCLASS.
