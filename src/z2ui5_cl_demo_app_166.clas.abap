CLASS z2ui5_cl_demo_app_166 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_struc_incl,
        incl_title  TYPE string,
        incl_value  TYPE string,
        incl_value2 TYPE string,
      END OF ty_struc_incl.

    TYPES:
      BEGIN OF ty_struc,
        title  TYPE string,
        value  TYPE string,
        value2 TYPE string,
      END OF ty_struc.
    DATA ms_struc TYPE ty_struc.

    DATA
      BEGIN OF ms_struc2.
        INCLUDE TYPE ty_struc.
        INCLUDE TYPE ty_struc_incl.
    DATA END OF ms_struc2.

    DATA check_initialized TYPE abap_bool.
    DATA client TYPE REF TO z2ui5_if_client.
    METHODS set_view.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_166 IMPLEMENTATION.


  METHOD set_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
        )->page(
                title          = 'abap2UI5 - Binding Structure Level'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = temp1 ).

    page->input( client->_bind_edit( val = ms_struc-title ) ).
    page->input( client->_bind_edit( val = ms_struc-value ) ).
    page->input( client->_bind_edit( val = ms_struc-value2 ) ).

    page->input( client->_bind_edit( val = ms_struc2-title ) ).
    page->input( client->_bind_edit( val = ms_struc2-value ) ).
    page->input( client->_bind_edit( val = ms_struc2-value2 ) ).

    page->input( client->_bind_edit( val = ms_struc2-incl_title ) ).
    page->input( client->_bind_edit( val = ms_struc2-incl_value ) ).
    page->input( client->_bind_edit( val = ms_struc2-incl_value2 ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      ms_struc-title  = `title`.
      ms_struc-value  = `val01`.
      ms_struc-value2 = `val02`.


      ms_struc2-title  = `title`.
      ms_struc2-value  = `val01`.
      ms_struc2-value2 = `val02`.
      ms_struc2-incl_title = `title_incl`.
      ms_struc2-incl_value = `val01_incl`.
      ms_struc2-incl_value2 = `val02_incl`.

      set_view( ).
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

    client->view_model_update( ).

  ENDMETHOD.
ENDCLASS.
