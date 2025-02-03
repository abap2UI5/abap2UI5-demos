CLASS z2ui5_cl_demo_app_231 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    TYPES:
      BEGIN OF t_drs,
        start TYPE d,
        end   TYPE d,
      END OF t_drs .

    DATA:
      drs1    TYPE t_drs,
      drs2    TYPE t_drs,
      drs3    TYPE t_drs,
      drs4    TYPE t_drs,
      drs5    TYPE t_drs,
      mindate TYPE d VALUE '20160101',
      maxdate TYPE d VALUE '20161231',
      text    TYPE string.

  PRIVATE SECTION.
    DATA
      check_initialized TYPE abap_bool.

    METHODS:
      display_view
        IMPORTING
          client TYPE REF TO z2ui5_if_client,
      initialize,
      on_event
        IMPORTING
          client TYPE REF TO z2ui5_if_client.

ENDCLASS.



CLASS z2ui5_cl_demo_app_231 IMPLEMENTATION.


  METHOD display_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA temp1 TYPE z2ui5_if_types=>ty_s_name_value.
    CLEAR temp1.
    temp1-n = `core:require`.
    temp1-v = `{Helper:'z2ui5/Util'}`.
    view->_generic_property( temp1 ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp3 TYPE xsdboolean.
    temp3 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
                    )->page(
                        title          = 'abap2UI5 - Sample: Date Range Selection'
                        navbuttonpress = client->_event( 'BACK' )
                        shownavbutton  = temp3 ).

    page->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.DateRangeSelection/sample/sap.m.sample.DateRangeSelection' ).

    DATA vbox TYPE REF TO z2ui5_cl_xml_view.
    vbox = page->vbox( ).

    " DRS1
    DATA temp2 TYPE string_table.
    CLEAR temp2.
    INSERT `DRS2` INTO TABLE temp2.
    vbox->label( text     = `DateRangeSelection displayFormat 'yyyy/MM/dd', set via binding:`
                 labelfor = `DRS1`
       )->date_range_selection(
            id              = 'DRS1'
            displayformat   = 'yyyy/MM/dd'
            change          = client->_event( val = 'handleChange' t_arg = temp2 )
            datevalue       = `{= Helper.DateCreateObject($` && client->_bind( drs1-start ) && ') }'
            seconddatevalue = `{= Helper.DateCreateObject($` && client->_bind( drs1-end ) && ') }' ).

    " DRS2
    DATA temp4 TYPE string_table.
    CLEAR temp4.
    INSERT `DRS2` INTO TABLE temp4.
    vbox->label( text     = `DateRangeSelection with minDate=2016-01-01 and maxDate=2016-12-31:`
                 labelfor = `DRS2`
       )->date_range_selection(
            id              = 'DRS2'
            mindate         = `{= Helper.DateCreateObject($` && client->_bind( mindate ) && ') }'
            maxdate         = `{= Helper.DateCreateObject($` && client->_bind( maxdate ) && ') }'
            change          = client->_event( val = 'handleChange' t_arg = temp4 )
            datevalue       = `{= Helper.DateCreateObject($` && client->_bind( drs2-start ) && ') }'
            seconddatevalue = `{= Helper.DateCreateObject($` && client->_bind( drs2-end ) && ') }' ).

    " DRS3
    DATA temp6 TYPE string_table.
    CLEAR temp6.
    INSERT `DRS3` INTO TABLE temp6.
    vbox->label( text     = `DateRangeSelection with OK button in the footer and with shortcut for today:"`
                 labelfor = `DRS3`
       )->date_range_selection(
            id                    = 'DRS3'
            showcurrentdatebutton = abap_true
            showfooter            = abap_true
            change                = client->_event( val = 'handleChange' t_arg = temp6 )
            datevalue             = `{= Helper.DateCreateObject($` && client->_bind( drs3-start ) && ') }'
            seconddatevalue       = `{= Helper.DateCreateObject($` && client->_bind( drs3-end ) && ') }' ).

    " DRS4
    DATA temp8 TYPE string_table.
    CLEAR temp8.
    INSERT `DRS4` INTO TABLE temp8.
    vbox->label( text     = `DateRangeSelection with displayFormat 'MM/yyyy':`
                 labelfor = `DRS3`
       )->date_range_selection(
            id              = 'DRS4'
            change          = client->_event( val = 'handleChange' t_arg = temp8 )
            displayformat   = 'MM/yyyy'
            datevalue       = `{= Helper.DateCreateObject($` && client->_bind( drs4-start ) && ') }'
            seconddatevalue = `{= Helper.DateCreateObject($` && client->_bind( drs4-end ) && ') }' ).

    " DRS5
    DATA temp10 TYPE string_table.
    CLEAR temp10.
    INSERT `DRS5` INTO TABLE temp10.
    vbox->label( text     = `DateRangeSelection with displayFormat 'MM/yyyy':`
                 labelfor = `DRS3`
       )->date_range_selection(
            id              = 'DRS5'
            change          = client->_event( val = 'handleChange' t_arg = temp10 )
            displayformat   = 'yyyy'
            datevalue       = `{= Helper.DateCreateObject($` && client->_bind( drs5-start ) && ') }'
            seconddatevalue = `{= Helper.DateCreateObject($` && client->_bind( drs5-end ) && ') }' ).

    vbox->label( text     = 'Change event'
                 labelfor = 'TextEvent' ).
    vbox->text( id   = 'TextEvent'
                text = client->_bind_edit( text ) ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD initialize.

    drs1-start = '20140202'.
    drs1-end   = '20140217'.

    drs2-start = '20160216'.
    drs2-end   = '20160218'.

    drs3-start = '20140202'.
    drs3-end   = '20140217'.

    drs4-start = '20190401'.
    drs4-end   = '20191001'.

    drs5-start = '20150101'.
    drs5-end   = '20191001'.

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'handleChange'.

        DATA args TYPE string_table.
        args = client->get( )-t_event_arg.
        DATA source LIKE LINE OF args.
        DATA temp1 LIKE LINE OF args.
        DATA temp2 LIKE sy-tabix.
        temp2 = sy-tabix.
        READ TABLE args INDEX 1 INTO temp1.
        sy-tabix = temp2.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        source = temp1.

        FIELD-SYMBOLS <drs> TYPE any.
        ASSIGN me->(source) TO <drs>.

        DATA temp12 TYPE t_drs.
        CLEAR temp12.
        MOVE-CORRESPONDING <drs> TO temp12.
        DATA drs LIKE temp12.
        drs = temp12.

        text = |Id: { source }\n|
            && |From: { drs-start }\n|
            && |To: { drs-end }|.

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      initialize( ).
      display_view( client ).
    ELSE.
      client->view_model_update( ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.

ENDCLASS.
