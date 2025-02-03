CLASS z2ui5_cl_demo_app_094 DEFINITION PUBLIC.

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
    DATA mr_input  TYPE REF TO data.
    DATA mr_screen TYPE REF TO data.
    DATA mo_app    TYPE REF TO z2ui5_cl_demo_app_094.
    DATA mv_val    TYPE string.

    DATA client      TYPE REF TO z2ui5_if_client.
    DATA mv_init     TYPE abap_bool.

    METHODS on_init.
    METHODS view_build.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA page TYPE REF TO z2ui5_cl_xml_view.

ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_094 IMPLEMENTATION.


  METHOD on_init.
    FIELD-SYMBOLS <input> TYPE any.
    FIELD-SYMBOLS <screen> TYPE ty_s_01.

    ms_screen-input = `structure level 01 - working`.


    CREATE DATA mr_input TYPE string.
    ASSIGN mr_input->* TO <input>.

    <input> = `ref data - working`.


    CREATE DATA mr_screen TYPE ty_s_01.
    ASSIGN mr_screen->* TO <screen>.

    <screen>-input = `ref data struc - working`.

    ms_screen-ty_s_02-input = `struc deep dissolve - working`.

    ms_screen-ty_s_02-ty_s_03-ty_s_04-input = `struc deep switch guid name - working`.

    CREATE OBJECT mo_app.
    mo_app->mv_val = `instance attribute val - working`.
    mo_app->ms_screen-input = `instance attribute struc - working`.

  ENDMETHOD.


  METHOD view_build.

    FIELD-SYMBOLS <input> TYPE any.
    FIELD-SYMBOLS <screen> TYPE ty_s_01.
    ASSIGN mr_input->* TO <input>.


    ASSIGN mr_screen->* TO <screen>.

    page = z2ui5_cl_xml_view=>factory( )->shell(
          )->page( title = `test` ).

    DATA o_grid TYPE REF TO z2ui5_cl_xml_view.
    o_grid = page->grid( 'L6 M12 S12'
        )->content( 'layout' ).

    DATA content TYPE REF TO z2ui5_cl_xml_view.
    content = o_grid->simple_form( title = 'Input'
          )->content( 'form' ).

    content->label( 'structure level 01'
      )->input( client->_bind_edit( ms_screen-input )
      )->label( 'ref data'
      )->input( client->_bind_edit( <input> )
      )->label( 'ref data struc field'
      )->input( client->_bind_edit( <screen>-input )
      )->label( 'struc deep dissolve'
      )->input( client->_bind_edit( ms_screen-ty_s_02-input )
      )->label( 'struc deep switch guid name'
      )->input( client->_bind_edit( ms_screen-ty_s_02-ty_s_03-ty_s_04-input )
      )->label( 'instance attribute val'
      )->input( client->_bind_edit( mo_app->mv_val )
      )->label( 'instance attribute struc'
      )->input( client->_bind_edit( mo_app->ms_screen-input ) ).

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

    client->view_display( page->get_root( )->xml_get( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF mv_init = abap_false.
      mv_init = abap_true.
      on_init( ).

    ENDIF.

    view_build( ).
    client->message_toast_display( `server roundtrip` ).

  ENDMETHOD.
ENDCLASS.
