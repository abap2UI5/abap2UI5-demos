CLASS z2ui5_cl_demo_app_279 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA text_input TYPE string .
    DATA dirty TYPE abap_bool.

  PRIVATE SECTION.
    DATA client TYPE REF TO z2ui5_if_client.
    DATA initialized TYPE abap_bool.

    METHODS display_view.
    METHODS on_event.
    METHODS security_check_popup.
    METHODS ui5_callback.

ENDCLASS.



CLASS z2ui5_cl_demo_app_279 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory(
                   )->shell(
                   )->page(
                      title          = 'abap2UI5 - data loss protection'
                      navbuttonpress = client->_event( 'BACK' )
                      shownavbutton  = temp1 ).

    DATA box TYPE REF TO z2ui5_cl_xml_view.
    box = page->flex_box( direction  = `Row`
                                alignitems = `Start`
                                class      = 'sapUiTinyMargin' ).

    box->input(
      id          = `input`
      value       = client->_bind_edit( text_input )
      submit      = client->_event( 'submit' )
      width       = `40rem`
      placeholder = `Enter data, submit and navigate back to trigger data loss protection` ).

    box->info_label(
      text        = 'dirty'
      colorscheme = '8'
      icon        = 'sap-icon://message-success'
      class       = `sapUiSmallMarginBegin sapUiTinyMarginTop`
      visible     = client->_bind( dirty ) ).

    box->button(
      text    = 'Reset'
      press   = client->_event( 'reset' )
      class   = `sapUiSmallMarginBegin`
      visible = client->_bind( dirty ) ).

    page->_z2ui5( )->focus( focusid = `input` ).


    page->_z2ui5( )->dirty( client->_bind( dirty ) ).


    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        IF dirty = abap_true.
          security_check_popup( ).
        ELSE.
          client->nav_app_leave( ).
        ENDIF.
      WHEN 'submit'.
        DATA temp2 TYPE xsdboolean.
        temp2 = boolc( text_input IS NOT INITIAL ).
        dirty = temp2.
      WHEN 'reset'.
        CLEAR:
          dirty,
          text_input.
    ENDCASE.

  ENDMETHOD.


  METHOD security_check_popup.

    client->nav_app_call( z2ui5_cl_pop_to_confirm=>factory(
                              i_question_text       = `Your entries will be lost when you leave this page.`
                              i_title               = `Warning`
                              i_icon                = `sap-icon://status-critical`
                              i_button_text_confirm = `Leave Page`
                              i_button_text_cancel  = `Cancel` ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF client->get( )-check_on_navigated = abap_true.
      ui5_callback( ).
    ENDIF.

    on_event( ).

    IF initialized = abap_false.
      initialized = abap_true.
      display_view( ).
    ELSE.
      client->view_model_update( ).
    ENDIF.

  ENDMETHOD.


  METHOD ui5_callback.

    TRY.
        DATA prev TYPE REF TO z2ui5_if_app.
        prev = client->get_app( client->get( )-s_draft-id_prev_app ).
        DATA temp1 TYPE REF TO z2ui5_cl_pop_to_confirm.
        temp1 ?= prev.
        DATA confirm_leave TYPE abap_bool.
        confirm_leave = temp1->result( ).

      CATCH cx_root.
    ENDTRY.

    IF confirm_leave = abap_true.
      CLEAR dirty.
      client->nav_app_leave( ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
