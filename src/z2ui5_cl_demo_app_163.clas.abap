CLASS z2ui5_cl_demo_app_163 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

  PROTECTED SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    DATA mv_check_initialized TYPE abap_bool.
    METHODS on_event.
    METHODS view_display.
    METHODS view_action_sheet.

  PRIVATE SECTION.

ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_163 IMPLEMENTATION.


  METHOD on_event.

    CASE client->get( )-event.

      WHEN 'OPEN_ACTION_SHEET'.
        view_action_sheet( ).
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

  ENDMETHOD.


  METHOD view_action_sheet.

    DATA action_sheet_view TYPE REF TO z2ui5_cl_xml_view.
    action_sheet_view = z2ui5_cl_xml_view=>factory_popup( ).

    DATA temp1 TYPE z2ui5_if_types=>ty_s_name_value.
    CLEAR temp1.
    temp1-n = `core:require`.
    temp1-v = `{ MessageToast: 'sap/m/MessageToast' }`.
    action_sheet_view->_generic_property( temp1 ).

    action_sheet_view->action_sheet( placement        = `Botton`
                                     showcancelbutton = abap_true
                                     title            = `Choose Your Action`
      )->button( text  = `Accept`
                 icon  = `sap-icon://accept`
                 press = `MessageToast.show('selected action is ' + ${$source>/text})`
      )->button( text  = `Reject`
                 icon  = `sap-icon://decline`
                 press = `MessageToast.show('selected action is ' + ${$source>/text})`
      )->button( text  = `Email`
                 icon  = `sap-icon://email`
                 press = `MessageToast.show('selected action is ' + ${$source>/text})`
      )->button( text  = `Forward`
                 icon  = `sap-icon://forward`
                 press = `MessageToast.show('selected action is ' + ${$source>/text})`
      )->button( text  = `Delete`
                 icon  = `sap-icon://delete`
                 press = `MessageToast.show('selected action is ' + ${$source>/text})`
      )->button( text  = `Other`
                 press = `MessageToast.show('selected action is ' + ${$source>/text})` ).

    client->popover_display( xml   = action_sheet_view->stringify( )
                             by_id = `actionSheet` ).

  ENDMETHOD.


  METHOD view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view = view->shell( )->page( id = `page_main`
             title                  = 'abap2UI5 - Action Sheet'
             navbuttonpress         = client->_event( 'BACK' )
             shownavbutton          = temp1 ).

    DATA vbox TYPE REF TO z2ui5_cl_xml_view.
    vbox = view->vbox( ).

    vbox->button( text  = 'Open Action Sheet'
                  press = client->_event( 'OPEN_ACTION_SHEET' )
                  id    = `actionSheet`
                  class = `sapUiSmallMargin` ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF mv_check_initialized = abap_false.
      mv_check_initialized = abap_true.
      view_display( ).
      RETURN.
    ENDIF.

    on_event( ).

  ENDMETHOD.
ENDCLASS.
