CLASS z2ui5_cl_demo_app_141 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_row,
        selkz    TYPE abap_bool,
        title    TYPE string,
        value    TYPE string,
        descr    TYPE string,
        icon     TYPE string,
        info     TYPE string,
        checkbox TYPE abap_bool,
      END OF ty_row.

    TYPES temp1_4540ab214f TYPE STANDARD TABLE OF ty_row WITH DEFAULT KEY.
DATA t_tab TYPE temp1_4540ab214f.

    DATA mv_textarea TYPE string.
    DATA mv_stretch_active TYPE abap_bool.

    DATA:
      BEGIN OF ms_popup_input,
        value1          TYPE string,
        value2          TYPE string,
        check_is_active TYPE abap_bool,
        combo_key       TYPE string,
      END OF ms_popup_input.

    DATA t_bapiret TYPE bapirettab.

    DATA check_initialized TYPE abap_bool.
    DATA client TYPE REF TO z2ui5_if_client.

    METHODS ui5_view_display.
    METHODS ui5_popup_input.
    METHODS ui5_handle_event.
    METHODS ui5_init.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_141 IMPLEMENTATION.


  METHOD ui5_handle_event.

    CASE client->get( )-event.

      WHEN 'POPUP_TO_INPUT'.
        ms_popup_input-value1 = 'value1'.
        ui5_popup_input( ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD ui5_init.

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

  ENDMETHOD.


  METHOD ui5_popup_input.

    DATA popup TYPE REF TO z2ui5_cl_xml_view.
    popup = z2ui5_cl_xml_view=>factory_popup( ).

    DATA dialog TYPE REF TO z2ui5_cl_xml_view.
    dialog = popup->dialog(
       contentheight = '500px'
       contentwidth  = '500px'
       title         = 'Title' ).

    dialog->content(
           )->simple_form(
               )->label( text = 'Input1'
                         id   = 'lbl1'
               )->input( client->_bind_edit( ms_popup_input-value1 )
               )->label( 'Input2'
               )->input( client->_bind_edit( ms_popup_input-value2 )
               )->label( 'Checkbox'
               )->checkbox(
                   selected = client->_bind_edit( ms_popup_input-check_is_active )
                   text     = 'this is a checkbox'
                   enabled  = abap_true
         )->get_parent( )->get_parent(
         )->footer( )->overflow_toolbar(
           )->toolbar_spacer(
           )->button(
               text  = 'Cancel'
               press = client->_event( 'BUTTON_TEXTAREA_CANCEL' )
           )->button(
               text  = 'Confirm'
               press = client->_event_client( client->cs_event-popup_close )
               type  = 'Emphasized' ).

    DATA temp3 TYPE z2ui5_if_types=>ty_t_name_value.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-n = `content`.
    temp4-v = `<script> sap.z2ui5.setBlackColor();  </script>`.
    INSERT temp4 INTO TABLE temp3.
    temp4-n = `preferDOM`.
    temp4-v = `true`.
    INSERT temp4 INTO TABLE temp3.
    dialog->_generic( name   = `HTML`
                      ns     = `core`
                      t_prop = temp3 )->get_parent( ).

    client->popup_display( popup->stringify( ) ).

  ENDMETHOD.


  METHOD ui5_view_display.

    DATA css TYPE string.
    css = `` &&
                `.lbl-color { color: red !important; font-size: 30px !important; }`.

    DATA script TYPE string.
    script = `` &&
                   `sap.z2ui5.setBlackColor = function() {` && |\n| &&
                   `  var lbl = sap.ui.getCore().byId('popupId--lbl1');` && |\n| &&
                   `  lbl.setText('changed from js');` && |\n| &&
                   `  lbl.addStyleClass('lbl-color');` && |\n| &&
                   `};`.


    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    view->_generic( name = `style`
                    ns   = `html` )->_cc_plain_xml( css )->get_parent( ).
    view->_generic( name = `script`
                    ns   = `html` )->_cc_plain_xml( script )->get_parent( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
        )->page(
                title          = 'abap2UI5 - Popups'
                navbuttonpress = client->_event( val = 'BACK' )
                shownavbutton  = temp1 ).

    DATA grid TYPE REF TO z2ui5_cl_xml_view.
    grid = page->grid( 'L8 M12 S12' )->content( 'layout' ).


    grid->simple_form( 'Inputs' )->content( 'form'
        )->label( '01'
        )->button(
            text  = 'Popup Get Input Values'
            press = client->_event( 'POPUP_TO_INPUT' ) ).


    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
    ENDIF.

    IF client->get( )-check_on_navigated = abap_true.
      ui5_view_display( ).
    ENDIF.

    ui5_handle_event( ).

  ENDMETHOD.
ENDCLASS.
