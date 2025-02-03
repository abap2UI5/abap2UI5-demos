CLASS z2ui5_cl_demo_app_068 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_prodh_node_level3,
        is_selected TYPE abap_bool,
        text        TYPE string,
        prodh       TYPE string,
      END OF ty_prodh_node_level3,
      BEGIN OF ty_prodh_node_level2,
        is_selected TYPE abap_bool,
        text        TYPE string,
        prodh       TYPE string,
        nodes       TYPE STANDARD TABLE OF ty_prodh_node_level3 WITH DEFAULT KEY,
      END OF ty_prodh_node_level2,
      BEGIN OF ty_prodh_node_level1,
        is_selected TYPE abap_bool,
        text        TYPE string,
        prodh       TYPE string,
        nodes       TYPE STANDARD TABLE OF ty_prodh_node_level2 WITH DEFAULT KEY,
      END OF ty_prodh_node_level1,
      ty_prodh_nodes TYPE STANDARD TABLE OF ty_prodh_node_level1 WITH DEFAULT KEY.

    DATA prodh_nodes    TYPE ty_prodh_nodes.
    DATA is_initialized TYPE abap_bool.

    METHODS ui5_display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    METHODS ui5_initialize.
    METHODS ui5_display_popup_tree_select.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_068 IMPLEMENTATION.


  METHOD ui5_display_popup_tree_select.

    DATA dialog TYPE REF TO z2ui5_cl_xml_view.
    dialog = z2ui5_cl_xml_view=>factory_popup(
        )->dialog( title         = 'Choose Product here...'
                   contentheight = '50%'
                   contentwidth  = '50%' ).

    dialog->tree(
        mode  = 'SingleSelectMaster'
        items = client->_bind_edit( prodh_nodes )
        )->items(
            )->standard_tree_item( selected = '{IS_SELECTED}'
                                   title    = '{TEXT}' ).

    dialog->buttons(
        )->button( text = 'Continue'
               icon     = `sap-icon://accept`
               type     = `Accept`
               press    = client->_event( 'CONTINUE' )
        )->button( text = 'Cancel'
               icon     = `sap-icon://decline`
               type     = `Reject`
               press    = client->_event( 'CANCEL' ) ).

    client->popup_display( dialog->stringify( ) ).

  ENDMETHOD.


  METHOD ui5_display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title           = 'abap2UI5 - Popup Tree select Entry'
            navbuttonpress  = client->_event( 'BACK' )
              shownavbutton = abap_true ).

    page->header_content(
             )->link( text   = 'Demo'
                      target = '_blank'
                      href   = `https://twitter.com/abap2UI5/status/1680261069535584259`
             )->link(
         )->get_parent( ).

    client->view_display( page->button( text  = 'Open Popup here...'
                                        press = client->_event( 'POPUP_TREE' ) )->stringify( ) ).

  ENDMETHOD.


  METHOD ui5_initialize.
    DATA temp1 TYPE z2ui5_cl_demo_app_068=>ty_prodh_nodes.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-text = 'Machines'.
    temp2-prodh = '00100'.
    DATA temp3 TYPE z2ui5_cl_demo_app_068=>ty_prodh_node_level1-nodes.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-text = 'Pumps'.
    temp4-prodh = '0010000100'.
    DATA temp7 TYPE z2ui5_cl_demo_app_068=>ty_prodh_node_level2-nodes.
    CLEAR temp7.
    DATA temp8 LIKE LINE OF temp7.
    temp8-text = 'Pump 001'.
    temp8-prodh = '001000010000000100'.
    INSERT temp8 INTO TABLE temp7.
    temp8-text = 'Pump 002'.
    temp8-prodh = '001000010000000105'.
    INSERT temp8 INTO TABLE temp7.
    temp4-nodes = temp7.
    INSERT temp4 INTO TABLE temp3.
    temp2-nodes = temp3.
    INSERT temp2 INTO TABLE temp1.
    temp2-text = 'Paints'.
    temp2-prodh = '00110'.
    DATA temp5 TYPE z2ui5_cl_demo_app_068=>ty_prodh_node_level1-nodes.
    CLEAR temp5.
    DATA temp6 LIKE LINE OF temp5.
    temp6-text = 'Gloss paints'.
    temp6-prodh = '0011000105'.
    DATA temp9 TYPE z2ui5_cl_demo_app_068=>ty_prodh_node_level2-nodes.
    CLEAR temp9.
    DATA temp10 LIKE LINE OF temp9.
    temp10-text = 'Paint 001'.
    temp10-prodh = '001100010500000100'.
    INSERT temp10 INTO TABLE temp9.
    temp10-text = 'Paint 002'.
    temp10-prodh = '001100010500000105'.
    INSERT temp10 INTO TABLE temp9.
    temp6-nodes = temp9.
    INSERT temp6 INTO TABLE temp5.
    temp2-nodes = temp5.
    INSERT temp2 INTO TABLE temp1.
    prodh_nodes =
      temp1.


  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF is_initialized = abap_false.
      is_initialized = abap_true.
      ui5_initialize( ).
      ui5_display_view( client ).
    ENDIF.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN 'POPUP_TREE'.
        ui5_display_popup_tree_select( ).

      WHEN 'CONTINUE'.
        client->popup_destroy( ).
        client->message_box_display( `Selected entry is set in the backend` ).

      WHEN 'CANCEL'.
        client->popup_destroy( ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
