CLASS z2ui5_cl_demo_app_lp_04 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA product  TYPE string.
    DATA product_url  TYPE string.
    DATA quantity TYPE string.
    DATA check_initialized TYPE abap_bool.
    DATA check_launchpad_active TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_lp_04 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    product_url = z2ui5_cl_util=>url_param_get(
                    val =  `product`
                    url = client->get( )-s_config-search ).
    check_launchpad_active = client->get( )-check_launchpad_active.

    DATA lt_params TYPE z2ui5_if_types=>ty_t_name_value.
    lt_params = client->get( )-t_comp_params.
    try.
    DATA temp1 LIKE LINE OF lt_params.
    DATA temp2 LIKE sy-tabix.
    temp2 = sy-tabix.
    READ TABLE lt_params WITH KEY n = `PRODUCT` INTO temp1.
    sy-tabix = temp2.
    IF sy-subrc <> 0.
      ASSERT 1 = 0.
    ENDIF.
    product = temp1-v.
    catch cx_root.
    endtry.
    IF check_initialized = abap_false.
      check_initialized = abap_true.

      quantity = '500'.

      DATA temp3 TYPE string_table.
      CLEAR temp3.
      INSERT `{ semanticObject: "Z2UI5_CL_LP_SAMPLE_03",  action: "display" }` INTO TABLE temp3.
      INSERT `{ ProductID : "123234" }` INTO TABLE temp3.
      DATA temp4 TYPE xsdboolean.
      temp4 = boolc( abap_false = client->get( )-check_launchpad_active ).
      DATA temp5 TYPE xsdboolean.
      temp5 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
      client->view_display( view->shell(
            )->page(
                    showheader       = temp4
                    title          = 'abap2UI5 -  Cross App Navigation App 128'
                    navbuttonpress = client->_event( val = 'BACK' )
                    shownavbutton = temp5
                )->header_content(
                    )->link(
                        text = 'Source_Code'

                        target = '_blank'
                )->get_parent(
                )->simple_form( title = 'App 128' editable = abap_true
                    )->content( 'form'
                        )->title( 'Input'
                        )->label( 'product nav param'
                        )->input( client->_bind_edit( product )
                        )->label( `CHECK_LAUNCHPAD_ACTIVE`
                        )->input( check_launchpad_active
                        )->button( press = client->_event(  )
                        )->button( text = 'BACK' press = client->_event_client( client->cs_event-cross_app_nav_to_prev_app )
                        )->button(
                            text  = 'go to app 127'
                            press = client->_event_client(
            val    = client->cs_event-cross_app_nav_to_ext
            t_arg  = temp3
        )
             )->stringify( ) ).

    ENDIF.

    client->view_model_update( ).

    CASE client->get( )-event.

      WHEN 'BUTTON_POST'.

*        client->message_toast_display( |{ product } { quantity } - send to the server| ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack  ) ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
