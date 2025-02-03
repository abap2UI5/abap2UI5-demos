CLASS z2ui5_cl_demo_app_071 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF s_combobox,
        key  TYPE string,
        text TYPE string,
      END OF s_combobox.
    TYPES ty_t_combo TYPE STANDARD TABLE OF s_combobox WITH DEFAULT KEY.

    DATA mv_set_size_limit TYPE i VALUE 100.
    DATA mv_combo_number TYPE i VALUE 105.
    DATA check_initialized TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_071 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    CASE client->get( )-event.
      WHEN `UPDATE`.
        DATA temp1 TYPE string_table.
        CLEAR temp1.
        DATA temp2 TYPE string.
        temp2 = mv_set_size_limit.
        INSERT temp2 INTO TABLE temp1.
        INSERT client->cs_view-main INTO TABLE temp1.
        client->follow_up_action( client->_event_client(
                                    val   = `SET_SIZE_LIMIT`
                                    t_arg = temp1
                        ) ).
        client->view_model_update( ).
        client->message_toast_display( `SizeLimitUpdated` ).


      WHEN 'BACK'.
        client->nav_app_leave( ).
        RETURN.
    ENDCASE.



    DATA temp3 TYPE ty_t_combo.
    CLEAR temp3.
    DATA lt_combo LIKE temp3.
    lt_combo = temp3.
    DO mv_combo_number TIMES.
      DATA temp4 TYPE z2ui5_cl_demo_app_071=>s_combobox.
      CLEAR temp4.
      temp4-key = sy-index.
      temp4-text = sy-index.
      INSERT temp4 INTO TABLE lt_combo.
    ENDDO.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA temp5 TYPE xsdboolean.
    temp5 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    client->view_display( val = view->shell(
         )->page(
                 title          = 'abap2UI5 - First Example'
                 navbuttonpress = client->_event( val = 'BACK' )
                 shownavbutton  = temp5
             )->simple_form( title = 'Form Title' editable = abap_true
                 )->content( 'form'
                     )->title( 'Input'
                     )->label( 'Link'
                     )->label( 'setSizeLimit'
                     )->input( value = client->_bind_edit( mv_set_size_limit )
                     )->label( 'Number of Entries'
                     )->input( value = client->_bind_edit( mv_combo_number )
                     )->label( 'demo'
                     )->combobox( items = client->_bind_local( lt_combo )
                        )->item( key = '{KEY}' text = '{TEXT}'
                        )->get_parent( )->get_parent(
                     )->button(
                         text  = 'Press 2x update'
                         press = client->_event( val = 'UPDATE' )
        )->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
