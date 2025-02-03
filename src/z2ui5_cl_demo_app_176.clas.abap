CLASS z2ui5_cl_demo_app_176 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_s_data,
        name TYPE string,
        date TYPE string,
        age  TYPE string,
      END OF ty_s_data,
      ty_t_data TYPE STANDARD TABLE OF ty_s_data WITH DEFAULT KEY.

    TYPES:
      BEGIN OF ty_s_layout,
        fname   TYPE string,
        merge   TYPE string,
        visible TYPE string,
        binding TYPE string,
      END OF ty_s_layout,
      ty_t_layout TYPE STANDARD TABLE OF ty_s_layout WITH DEFAULT KEY.

    DATA mt_layout TYPE ty_t_layout.
    DATA mt_data   TYPE ty_t_data.

    METHODS main_view
      IMPORTING
        i_client TYPE REF TO z2ui5_if_client.
    METHODS nest_view
      IMPORTING
        i_client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_176 IMPLEMENTATION.


  METHOD main_view.

    DATA lo_view TYPE REF TO z2ui5_cl_xml_view.
    lo_view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( i_client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = lo_view->shell(
        )->page(
                title          = `Main View`
                id             = `test`
                navbuttonpress = i_client->_event( 'BACK' )
                shownavbutton  = temp1 ).

    i_client->view_display( lo_view->stringify( ) ).

  ENDMETHOD.


  METHOD nest_view.

    i_client->_bind( mt_layout ).

    DATA temp1 TYPE z2ui5_cl_demo_app_176=>ty_t_data.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-name = 'Theo'.
    temp2-date = '01.01.2000'.
    temp2-age = '5'.
    INSERT temp2 INTO TABLE temp1.
    temp2-name = 'Lore'.
    temp2-date = '01.01.2000'.
    temp2-age = '1'.
    INSERT temp2 INTO TABLE temp1.
    mt_data = temp1.

    DATA temp3 TYPE z2ui5_cl_demo_app_176=>ty_t_layout.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-fname = 'NAME'.
    temp4-merge = 'false'.
    temp4-visible = 'true'.
    temp4-binding = '{NAME}'.
    INSERT temp4 INTO TABLE temp3.
    temp4-fname = 'DATE'.
    temp4-merge = 'false'.
    temp4-visible = 'true'.
    temp4-binding = '{DATE}'.
    INSERT temp4 INTO TABLE temp3.
    temp4-fname = 'AGE'.
    temp4-merge = 'false'.
    temp4-visible = 'false'.
    temp4-binding = '{AGE}'.
    INSERT temp4 INTO TABLE temp3.
    mt_layout = temp3.

    DATA lo_view_nested TYPE REF TO z2ui5_cl_xml_view.
    lo_view_nested = z2ui5_cl_xml_view=>factory( ).

    lo_view_nested->shell( )->page( `Nested View`
      )->table( items = i_client->_bind( mt_data )
      )->columns(
        )->template_repeat( list = `{template>/MT_LAYOUT}`
                            var  = `LO`
          )->column( mergeduplicates = `{LO>MERGE}`
                     visible         = `{LO>VISIBLE}` )->get_parent(
        )->get_parent( )->get_parent(
        )->items(
          )->column_list_item(
            )->cells(
              )->template_repeat( list = `{template>/MT_LAYOUT}`
                                  var  = `LO2`
                )->object_identifier( text = `{= '{' + ${LO2>FNAME} + '}' }` ).

    i_client->nest_view_display( val           = lo_view_nested->stringify( )
                                 id            = `test`
                                 method_insert = 'addContent' ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
        RETURN.
    ENDCASE.

    main_view( client ).
    nest_view( client ).

  ENDMETHOD.
ENDCLASS.
