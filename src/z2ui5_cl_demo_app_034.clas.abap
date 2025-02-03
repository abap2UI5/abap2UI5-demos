CLASS z2ui5_cl_demo_app_034 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA t_bapiret TYPE bapirettab.
    DATA check_initialized TYPE abap_bool.
    DATA mv_popup_name TYPE string.
    DATA mv_main_xml TYPE string.
    DATA mv_popup_xml TYPE string.

    METHODS view_main
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS view_popup_bal
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_034 IMPLEMENTATION.


  METHOD view_main.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
        )->page(
                title          = 'abap2UI5 - Popups'
                navbuttonpress = client->_event( 'BACK' )
                shownavbutton  = temp1 ).

    DATA grid TYPE REF TO z2ui5_cl_xml_view.
    grid = page->grid( 'L8 M12 S12' )->content( 'layout' ).

    grid->simple_form( 'Tables' )->content( 'form'
        )->label( '01'
        )->button(
            text  = 'Show bapiret tab'
            press = client->_event( 'POPUP_BAL' ) ).

    mv_main_xml = page->get_root( )->xml_get( ).

  ENDMETHOD.


  METHOD view_popup_bal.

    DATA popup TYPE REF TO z2ui5_cl_xml_view.
    popup = z2ui5_cl_xml_view=>factory_popup(
        )->dialog( 'abap2ui5 - Popup Message Log'
            )->table( client->_bind( t_bapiret )
                )->columns(
                    )->column( '5rem'
                        )->text( 'Type' )->get_parent(
                    )->column( '5rem'
                        )->text( 'Number' )->get_parent(
                    )->column( '5rem'
                        )->text( 'ID' )->get_parent(
                    )->column(
                        )->text( 'Message' )->get_parent(
                )->get_parent(
                )->items(
                    )->column_list_item(
                        )->cells(
                            )->text( '{TYPE}'
                            )->text( '{NUMBER}'
                            )->text( '{ID}'
                            )->text( '{MESSAGE}'
            )->get_parent( )->get_parent( )->get_parent( )->get_parent(
            )->footer( )->overflow_toolbar(
                )->toolbar_spacer(
                )->button(
                    text  = 'close'
                    press = client->_event( 'POPUP_BAL_CLOSE' )
                    type  = 'Emphasized' ).

    mv_popup_xml = popup->get_root( )->xml_get( ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      DATA temp1 TYPE bapirettab.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-message = 'An empty Report field causes an empty XML Message to be sent'.
      temp2-type = 'E'.
      temp2-id = 'MSG1'.
      temp2-number = '001'.
      INSERT temp2 INTO TABLE temp1.
      temp2-message = 'Check was executed for wrong Scenario'.
      temp2-type = 'E'.
      temp2-id = 'MSG1'.
      temp2-number = '002'.
      INSERT temp2 INTO TABLE temp1.
      temp2-message = 'Request was handled without errors'.
      temp2-type = 'S'.
      temp2-id = 'MSG1'.
      temp2-number = '003'.
      INSERT temp2 INTO TABLE temp1.
      temp2-message = 'product activated'.
      temp2-type = 'S'.
      temp2-id = 'MSG4'.
      temp2-number = '375'.
      INSERT temp2 INTO TABLE temp1.
      temp2-message = 'check the input values'.
      temp2-type = 'W'.
      temp2-id = 'MSG2'.
      temp2-number = '375'.
      INSERT temp2 INTO TABLE temp1.
      temp2-message = 'product already in use'.
      temp2-type = 'I'.
      temp2-id = 'MSG2'.
      temp2-number = '375'.
      INSERT temp2 INTO TABLE temp1.
      t_bapiret = temp1.

    ENDIF.

    mv_popup_name = ''.

    CASE client->get( )-event.

      WHEN 'POPUP_BAL'.
        mv_popup_name = 'POPUP_BAL'.

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

    view_main( client ).

    CASE mv_popup_name.
      WHEN 'POPUP_BAL'.
        view_popup_bal( client ).
    ENDCASE.

    client->view_display( mv_main_xml ).
    client->popup_display( mv_popup_xml ).
    CLEAR: mv_main_xml, mv_popup_xml.
  ENDMETHOD.
ENDCLASS.
