CLASS z2ui5_cl_demo_app_064 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF ty_s_tab,
        selkz     TYPE abap_bool,
        row_id    TYPE string,
        carrid    TYPE string,
        connid    TYPE string,
        fldate    TYPE string,
        planetype TYPE string,
      END OF ty_s_tab .
    TYPES
      ty_t_table TYPE STANDARD TABLE OF ty_s_tab WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_s_filter_pop,
        option TYPE string,
        low    TYPE string,
        high   TYPE string,
        key    TYPE string,
      END OF ty_s_filter_pop .

    DATA mt_mapping TYPE z2ui5_if_types=>ty_t_name_value .
    DATA mv_search_value TYPE string .
    DATA mt_table TYPE ty_t_table .
    DATA lv_selkz TYPE abap_bool .
    DATA mv_check_active TYPE abap_bool.
    DATA:
      BEGIN OF screen,
        progress_value TYPE string VALUE '0',
        display_value  TYPE string VALUE '',
      END OF screen.

    DATA mv_percent TYPE i.
    DATA mv_check_enabled TYPE abap_bool.
  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.
    DATA check_initialized TYPE abap_bool.


    METHODS z2ui5_on_init.
    METHODS z2ui5_on_event.
  PRIVATE SECTION.

    METHODS set_selkz
      IMPORTING
        iv_selkz TYPE abap_bool.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_064 IMPLEMENTATION.


  METHOD set_selkz.

    FIELD-SYMBOLS <ls_table> TYPE ty_s_tab.

    LOOP AT mt_table ASSIGNING <ls_table>.
      <ls_table>-selkz = iv_selkz.
    ENDLOOP.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      z2ui5_on_init( ).
      RETURN.
    ENDIF.

    z2ui5_on_event( ).

  ENDMETHOD.


  METHOD z2ui5_on_event.
    DATA lt_arg TYPE string_table.
    DATA ls_arg TYPE string.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN `LOAD`.

        mv_percent = mv_percent + 25.
        mv_check_active = abap_true.
        mv_check_enabled = abap_false.
        IF mv_percent > 100.
          mv_percent = 0.
          mv_check_active = abap_false.
          mv_check_enabled = abap_true.
        ENDIF.

        client->message_toast_display( `loaded` ).
        WAIT UP TO 2 SECONDS.
        client->view_model_update( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_init.

    DATA temp1 TYPE z2ui5_if_types=>ty_t_name_value.
    DATA view TYPE REF TO z2ui5_cl_xml_view.
    DATA page1 TYPE REF TO z2ui5_cl_xml_view.
    DATA temp5 TYPE abap_bool.
    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    CLEAR temp1.

    mv_check_enabled = abap_true.
    view = z2ui5_cl_xml_view=>factory( ).

    view->_z2ui5( )->timer(
        finished    = client->_event( 'LOAD' )
        checkactive = client->_bind( mv_check_active ) ).

    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    temp5 = temp2.
    page1 = view->shell( )->page( id = 'page_main'
      title                          = 'abap2UI5 - Progress Bar while Server Request'
      navbuttonpress                 = client->_event( 'BACK' )
      shownavbutton                  = temp5
      class                          = 'sapUiContentPadding' ).


    layout = page1->vertical_layout( class = 'sapuicontentpadding'
                                     width = '100%' ).
    layout->vbox( )->progress_indicator(
      percentvalue = client->_bind_edit( mv_percent )
      displayvalue = client->_bind_edit( screen-display_value )
      showvalue    = abap_true
           state   = 'Success' ).

    layout->button(
        text    = `Load`
        press   = client->_event( 'LOAD' )
        enabled = client->_bind( mv_check_enabled ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
