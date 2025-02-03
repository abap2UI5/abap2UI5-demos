CLASS z2ui5_cl_demo_app_129 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF s_suggestion_items,
        value TYPE string,
        descr TYPE string,
      END OF s_suggestion_items .
    TYPES:
      BEGIN OF s_combobox,
        key  TYPE string,
        text TYPE string,
      END OF s_combobox .
    TYPES
      ty_t_combo TYPE STANDARD TABLE OF s_combobox WITH DEFAULT KEY .
    DATA lv_text TYPE string.
    DATA:
      BEGIN OF screen,
        check_is_active TYPE abap_bool,
        colour          TYPE string,
        combo_key       TYPE string,
        combo_key2      TYPE string,
        segment_key     TYPE string,
        date            TYPE string,
        date_time       TYPE string,
        time_start      TYPE string,
        time_end        TYPE string,
        check_switch_01 TYPE abap_bool VALUE abap_false,
        check_switch_02 TYPE abap_bool VALUE abap_false,
      END OF screen .
    DATA
      mt_suggestion TYPE STANDARD TABLE OF s_suggestion_items WITH DEFAULT KEY .
    DATA check_initialized TYPE abap_bool .
  PROTECTED SECTION.

    METHODS z2ui5_on_rendering
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_on_init.
    METHODS z2ui5_on_rendering_popup
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_on_rendering_popover
      IMPORTING
        id     TYPE string
        client TYPE REF TO z2ui5_if_client.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_129 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      lv_text = 10.
      check_initialized = abap_true.
      z2ui5_on_init( ).
      z2ui5_on_rendering( client ).

    ENDIF.

    z2ui5_on_event( client ).

  ENDMETHOD.


  METHOD z2ui5_on_event.

    CASE client->get( )-event.
      WHEN 'REFRESH'.
        lv_text = lv_text + 10.


        client->view_model_update( ).

      WHEN 'BUTTON_SEND'.

        z2ui5_on_rendering_popup( client ).
      WHEN 'BUTTON_POPOVER'.
        z2ui5_on_rendering_popover( client = client
                                    id     = 'ppvr' ).

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_on_init.

    CLEAR screen.
    screen-check_is_active = abap_true.
    screen-colour = 'BLUE'.
    screen-combo_key = 'GRAY'.
    screen-segment_key = 'GREEN'.
    screen-date = '07.12.22'.
    screen-date_time = '23.12.2022, 19:27:20'.
    screen-time_start = '05:24:00'.
    screen-time_end = '17:23:57'.

    DATA temp1 LIKE mt_suggestion.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-descr = 'Green'.
    temp2-value = 'GREEN'.
    INSERT temp2 INTO TABLE temp1.
    temp2-descr = 'Blue'.
    temp2-value = 'BLUE'.
    INSERT temp2 INTO TABLE temp1.
    temp2-descr = 'Black'.
    temp2-value = 'BLACK'.
    INSERT temp2 INTO TABLE temp1.
    temp2-descr = 'Grey'.
    temp2-value = 'GREY'.
    INSERT temp2 INTO TABLE temp1.
    temp2-descr = 'Blue2'.
    temp2-value = 'BLUE2'.
    INSERT temp2 INTO TABLE temp1.
    temp2-descr = 'Blue3'.
    temp2-value = 'BLUE3'.
    INSERT temp2 INTO TABLE temp1.
    mt_suggestion = temp1.

  ENDMETHOD.


  METHOD z2ui5_on_rendering.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = z2ui5_cl_xml_view=>factory( ).

    page->_z2ui5( )->timer( finished    = client->_event( 'REFRESH' )
                            checkrepeat = abap_true
                            delayms     = `3000` ).



    page = page->shell(
         )->page(
            title           = 'abap2UI5 - Selection-Screen Example'
            navbuttonpress  = client->_event( 'BACK' )
              shownavbutton = abap_true ).

    DATA grid TYPE REF TO z2ui5_cl_xml_view.
    grid = page->grid( 'L6 M12 S12'
        )->content( 'layout' ).

    grid = grid->text( text = client->_bind_edit( val = lv_text view = client->cs_view-main
      ) ).

    DATA temp3 TYPE string_table.
    CLEAR temp3.
    INSERT `${$source>/sId}` INTO TABLE temp3.
    page->footer( )->overflow_toolbar(
         )->toolbar_spacer(
         )->button(
             id    = `ppvr`
             text  = 'Open Popover'
             press = client->_event( val = 'BUTTON_POPOVER' t_arg = temp3 )
             type  = 'Ghost'
         )->button(
             text  = 'Open Popup'
             press = client->_event( 'BUTTON_SEND' )
             type  = 'Success' ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_on_rendering_popover.
    DATA popover TYPE REF TO z2ui5_cl_xml_view.
    popover = z2ui5_cl_xml_view=>factory_popup( )->popover( placement = `Top` ).

    popover->text( text = 'this is popover in middle with timer auto refresh' ).
    client->popover_display( xml   = popover->stringify( )
                             by_id = id ).
  ENDMETHOD.


  METHOD z2ui5_on_rendering_popup.

    DATA dialog TYPE REF TO z2ui5_cl_xml_view.
    dialog = z2ui5_cl_xml_view=>factory_popup( )->dialog( ).

    dialog->text( text = 'this is popup in middle with timer auto refresh' ).
    dialog->button( text  = 'close'
                    press = client->_event_client( client->cs_event-popup_close ) ).
    client->popup_display( dialog->stringify( ) ).

  ENDMETHOD.
ENDCLASS.
