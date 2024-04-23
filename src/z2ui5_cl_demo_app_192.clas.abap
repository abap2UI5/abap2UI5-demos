CLASS z2ui5_cl_demo_app_192 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    DATA client TYPE REF TO z2ui5_if_client.

    TYPES: BEGIN OF ty_s_key_value,
             fname   TYPE char30,
             value   TYPE string,
             tabname TYPE char30,
             comp    TYPE abap_componentdescr,
           END OF ty_S_key_value,
           ty_t_key_values TYPE STANDARD TABLE OF ty_s_key_value WITH EMPTY KEY.

    TYPES: BEGIN OF ty_s_merged_Data,
             t_kopf  TYPE REF TO data,
             t_pos   TYPE REF TO data,
             t_keyva TYPE ty_T_KEY_VALUEs,
           END OF ty_S_merged_Data,
           ty_t_merged_Data TYPE STANDARD TABLE OF ty_s_merged_Data WITH EMPTY KEY.

    DATA mt_new_data TYPE ty_t_merged_data.

    TYPES:
      BEGIN OF ty_s_out,
        aa TYPE string,
        bb TYPE string,
        cc TYPE string,
      END OF ty_s_out,
      ty_t_out TYPE STANDARD TABLE OF ty_s_out WITH EMPTY KEY.

    DATA mt_out TYPE ty_t_out.

    METHODS ui5_display.
    METHODS ui5_event.

  PROTECTED SECTION.
    METHODS get_data.

  PRIVATE SECTION.
ENDCLASS.

CLASS z2ui5_cl_demo_app_192 IMPLEMENTATION.

  METHOD ui5_event.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

    ENDCASE.

  ENDMETHOD.

  METHOD ui5_display.

    DATA(view) = z2ui5_cl_xml_view=>factory( ).
    view->shell(
        )->page( title          = 'xxx'
                 navbuttonpress = client->_event( val = 'BACK' )
                 shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL )
            )->header_content( ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.

  METHOD z2ui5_if_app~main.

    me->client = client.

    get_DATA( ).

    ui5_display( ).

  ENDMETHOD.

  METHOD get_data.

    mt_out = VALUE #( ( aa = 'aa' bb = 'bb' cc = 'cc'  )
                      ( aa = 'a1' bb = 'b1' cc = 'c1'  ) ).

    DATA(kopf) = REF #( mt_out ).

    DATA lr_structdescr TYPE REF TO cl_abap_structdescr.
    DATA lr_tabdescr    TYPE REF TO cl_abap_tabledescr.

    FIELD-SYMBOLS <fs_s_head>     TYPE any.
    FIELD-SYMBOLS <fs_t_head_new> TYPE STANDARD TABLE.
    FIELD-SYMBOLS <fs_s_head_new> TYPE any.

    LOOP AT kopf->* ASSIGNING <fs_s_head>.

      APPEND INITIAL LINE TO mt_new_data ASSIGNING FIELD-SYMBOL(<fs_s_new_data>).

      lr_structdescr ?= cl_abap_structdescr=>describe_by_data( <fs_s_head> ).
      lr_tabdescr ?= cl_abap_tabledescr=>create( p_line_type = lr_structdescr ).

      CREATE DATA <fs_s_new_data>-t_kopf TYPE HANDLE lr_tabdescr.
      ASSIGN <fs_s_new_data>-t_kopf->* TO <fs_t_head_new>.

      APPEND INITIAL LINE TO <fs_t_head_new> ASSIGNING <fs_s_head_new>.
      <fs_s_head> = CORRESPONDING #( <fs_s_head_new> ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
