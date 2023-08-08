CLASS z2ui5_cl_app_demo_81 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA product  TYPE string.
    DATA quantity TYPE string.
    DATA mv_placement TYPE string.

    TYPES:
      BEGIN OF ty_tab,
        selected TYPE abap_bool,
        id       TYPE string,
        name     TYPE string,
      END OF ty_tab.

      DATA: mt_tab TYPE STANDARD TABLE OF ty_tab WITH EMPTY KEY.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.

    METHODS z2ui5_on_init.
    METHODS z2ui5_on_event.
    METHODS z2ui5_display_view.
    METHODS z2ui5_display_popover
      IMPORTING
        id TYPE string.
    METHODS z2ui5_display_popover_list
      IMPORTING
        id TYPE string.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_app_demo_81 IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_APP_DEMO_26->Z2UI5_DISPLAY_POPOVER
* +-------------------------------------------------------------------------------------------------+
* | [--->] ID                             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_display_popover.

    DATA(view) = z2ui5_cl_xml_view=>factory_popup( client ).
    view->popover(
                  title     = 'Popover Title'
                  placement = mv_placement
              )->footer( )->overflow_toolbar(
                  )->toolbar_spacer(
                  )->button(
                      text  = 'Cancel'
                      press = client->_event( 'BUTTON_CANCEL' )
                  )->button(
                      text  = 'Confirm'
                      press = client->_event( 'BUTTON_CONFIRM' )
                      type  = 'Emphasized'
                )->get_parent( )->get_parent(
            )->text(  'make an input here:'
            )->input( value = 'abcd'
            ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id
    ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_APP_DEMO_26->Z2UI5_DISPLAY_POPOVER_LIST
* +-------------------------------------------------------------------------------------------------+
* | [--->] ID                             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_display_popover_list.

    DATA(view) = z2ui5_cl_xml_view=>factory_popup( client ).
      view->popover(
                  title     = 'Popover Title'
                  placement = mv_placement
              )->list(
                items = client->_bind_edit( mt_tab )
*                selectionchange = client->_event( val = 'SEL_CHANGE' t_arg = VALUE #( ( `${$parameters>/listItem}` ) ) )
                selectionchange = client->_event( val = 'SEL_CHANGE' )
                mode = `SingleSelectMaster`
                 )->standard_list_item(
                  title = `{ID}`
                  description = `{NAME}`
                  selected = `{SELECTED}` ).


    client->popover_display(
      xml   = view->stringify( )
      by_id = id
    ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_APP_DEMO_26->Z2UI5_DISPLAY_VIEW
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_display_view.

    DATA(view) = z2ui5_cl_xml_view=>factory( client ).
    view->shell(
      )->page(
              title          = 'abap2UI5 - Popover with List'
              navbuttonpress = client->_event( val = 'BACK' check_view_destroy = abap_true )
              shownavbutton  = abap_true
          )->header_content(
               )->link(
                  text = 'Source_Code' target = '_blank'
                  href = view->hlp_get_source_code_url( )
          )->get_parent(
          )->simple_form( 'Popover'
              )->content( 'form'
                  )->title( 'Input'
                  )->label( 'Link'
                  )->link(  text = 'Documentation UI5 Popover Control' href = 'https://openui5.hana.ondemand.com/entity/sap.m.Popover'
                  )->label( 'placement'
                  )->segmented_button( client->_bind_edit( mv_placement )
                        )->items(
                        )->segmented_button_item(
                                key = 'Left'
                                icon = 'sap-icon://add-favorite'
                                text = 'Left'
                        )->segmented_button_item(
                                key = 'Top'
                                icon = 'sap-icon://accept'
                                text = 'Top'
                        )->segmented_button_item(
                                key = 'Bottom'
                                icon = 'sap-icon://accept'
                                text = 'Bottom'
                        )->segmented_button_item(
                                key = 'Right'
                                icon = 'sap-icon://attachment'
                                text = 'Right'
                  )->get_parent( )->get_parent(
                  )->label( 'popover'
                  )->button(
                      text  = 'show popover with list'
                      press = client->_event( 'POPOVER_LIST' )
                      id = 'TEST'
          ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method Z2UI5_CL_APP_DEMO_26->Z2UI5_IF_APP~MAIN
* +-------------------------------------------------------------------------------------------------+
* | [--->] CLIENT                         TYPE REF TO Z2UI5_IF_CLIENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_on_init( ).
      z2ui5_display_view( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_APP_DEMO_26->Z2UI5_ON_EVENT
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_on_event.

    CASE client->get( )-event.

      WHEN 'SEL_CHANGE'.
        DATA(lt_sel) = mt_tab.
        DELETE lt_sel WHERE selected IS INITIAL.

      WHEN 'POPOVER_LIST'.
        z2ui5_display_popover_list( `TEST` ).

      WHEN 'POPOVER'.
        z2ui5_display_popover( `TEST` ).

      WHEN 'BUTTON_CONFIRM'.
        client->message_toast_display( |confirm| ).
        client->popover_destroy( ).

      WHEN 'BUTTON_CANCEL'.
        client->message_toast_display( |cancel| ).
        client->popover_destroy( ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

    ENDCASE.

  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method Z2UI5_CL_APP_DEMO_26->Z2UI5_ON_INIT
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD z2ui5_on_init.

    mv_placement = 'Left'.
    product  = 'tomato'.
    quantity = '500'.

    mt_tab = VALUE #(
                      ( id = `1` name = `name1` )
                      ( id = `2` name = `name2` )
                      ( id = `3` name = `name3` )
                      ( id = `4` name = `name4` )
                    ).

  ENDMETHOD.
ENDCLASS.
