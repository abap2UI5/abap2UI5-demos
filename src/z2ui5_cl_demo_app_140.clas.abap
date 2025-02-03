CLASS z2ui5_cl_demo_app_140 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF s_combobox,
        key  TYPE string,
        text TYPE string,
      END OF s_combobox .
    TYPES
      ty_t_combo TYPE STANDARD TABLE OF s_combobox WITH DEFAULT KEY .

    DATA client TYPE REF TO z2ui5_if_client .
    DATA check_initialized TYPE abap_bool .
    DATA gt_multi TYPE ty_t_combo.
    DATA gt_sel_multi TYPE ty_t_combo.
    DATA gt_sel_multi2 TYPE string_table.
    METHODS ui5_on_init .
    METHODS ui5_on_event .
    METHODS ui5_view_main_display .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_140 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DEMO_MULTICOMBOBOX_UI5->UI5_ON_EVENT
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ui5_on_event.

    TRY.
        DATA ok_code TYPE z2ui5_if_types=>ty_s_get-event.
        ok_code = client->get( )-event.
        CASE ok_code.
          WHEN 'FILTERBAR'.

            client->view_model_update( ).
        ENDCASE.
        DATA x TYPE REF TO cx_root.
      CATCH cx_root INTO x.
        client->message_box_display( text = x->get_text( )
                                     type = `error` ).
    ENDTRY.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DEMO_MULTICOMBOBOX_UI5->UI5_ON_INIT
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ui5_on_init.

    DATA temp1 TYPE ty_t_combo.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-key = 'A01'.
    temp2-text = 'T1'.
    INSERT temp2 INTO TABLE temp1.
    temp2-key = 'A02'.
    temp2-text = 'T2'.
    INSERT temp2 INTO TABLE temp1.
    temp2-key = 'A03'.
    temp2-text = 'T3'.
    INSERT temp2 INTO TABLE temp1.
    temp2-key = 'A04'.
    temp2-text = 'T4'.
    INSERT temp2 INTO TABLE temp1.
    temp2-key = 'A05'.
    temp2-text = 'T5'.
    INSERT temp2 INTO TABLE temp1.
    gt_multi = temp1.

    DATA temp3 TYPE string_table.
    CLEAR temp3.
    INSERT `A01` INTO TABLE temp3.
    gt_sel_multi2 = temp3.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DEMO_MULTICOMBOBOX_UI5->UI5_VIEW_MAIN_DISPLAY
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD ui5_view_main_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    view->shell(
            )->page(
                    title          = 'abap2UI5 - Multi Combo Box'
                    navbuttonpress = client->_event( val = 'BACK' )
                    shownavbutton  = temp1
               )->simple_form( title    = 'Form Title'
                               editable = abap_true
                    )->content( 'form'
                  )->multi_combobox(
*                            name = 'Multi'
                           name          = 'MultiComboBox'
                    selectedkeys         = client->_bind_edit( gt_sel_multi2 )
*                            selecteditems = client->_bind_edit( gt_sel_multi )
                                   items = client->_bind_edit( val = gt_multi )
                                   )->item(
                                      key  = '{KEY}'
                                      text = '{TEXT}'
                                  )->get_parent(
                  )->button(
                            text  = 'post'
                            press = client->_event( val = 'BUTTON_POST' ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_DEMO_MULTICOMBOBOX_UI5->Z2UI5_IF_APP~MAIN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO Z2UI5_IF_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_if_app~main.
    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      ui5_on_init( ).
    ENDIF.

    ui5_view_main_display( ).
    ui5_on_event( ).
  ENDMETHOD.
ENDCLASS.

