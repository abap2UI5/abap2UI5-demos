CLASS z2ui5_cl_demo_app_309 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

    DATA mv_initialized TYPE abap_bool.
    DATA mv_url TYPE string.

    METHODS on_event.
    METHODS view_display.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_309 IMPLEMENTATION.


  METHOD on_event.

    CASE client->get( )-event.

      WHEN 'CUSTOM_JS_FROM_EB'.

*        client->follow_up_action( val = `sap.z2ui5.afterBE()` ).
        client->follow_up_action( `alert("afterBE triggered !!");` ).

      WHEN 'BACK'.
        client->nav_app_leave( ).
        RETURN.

    ENDCASE.

  ENDMETHOD.


  METHOD view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    view->_generic( name = `script`
                    ns   = `html` )->_cc_plain_xml( `sap.z2ui5.afterBE = () => { alert("afterBE triggered !!"); }` ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell( )->page(
        title          = `Client->FOLLOW_UP_ACTION use cases`
        class          = `sapUiContentPadding`
        navbuttonpress = client->_event( 'BACK' )
        shownavbutton  = temp1 ).
    page = page->vbox( ).
    page->get_parent( )->hbox( class = `sapUiSmallMargin` ).
    page->button( text  = `call custom JS from EB`
                  press = client->_event( 'CUSTOM_JS_FROM_EB' ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF mv_initialized = abap_false.
      mv_initialized = abap_true.

      view_display( ).

    ENDIF.

    on_event( ).

  ENDMETHOD.
ENDCLASS.
