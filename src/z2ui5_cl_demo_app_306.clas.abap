CLASS z2ui5_cl_demo_app_306 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_picture,
        time     TYPE string,
        id       TYPE string,
        name     TYPE string,
        data     TYPE string,
        selected TYPE abap_bool,
      END OF ty_picture.

    TYPES temp1_80bb85a5cb TYPE STANDARD TABLE OF ty_picture WITH DEFAULT KEY.
DATA mt_picture TYPE temp1_80bb85a5cb.
    TYPES temp2_80bb85a5cb TYPE STANDARD TABLE OF ty_picture WITH DEFAULT KEY.
DATA mt_picture_out TYPE temp2_80bb85a5cb.
    DATA mv_pic_display TYPE string.
    DATA mv_check_init TYPE abap_bool.
    DATA mv_picture_base TYPE string.

  PROTECTED SECTION.

    METHODS view_display
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_306 IMPLEMENTATION.


  METHOD view_display.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA cont TYPE REF TO z2ui5_cl_xml_view.
    cont = view->shell( ).
    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp3 TYPE xsdboolean.
    temp3 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = cont->page( title = 'abap2UI5 - Device Camera Picture'
               navbuttonpress      = client->_event( 'BACK' )
               shownavbutton       = temp3
              )->header_content(
                  )->link( text   = 'Source_Code'
                           target = '_blank'
          )->get_parent( ).

    page->_z2ui5( )->camera_picture(
                      value   = client->_bind_edit( mv_picture_base )
                      onphoto = client->_event( 'CAPTURE' ) ).

    page->list(
        headertext      = 'List Ouput'
        items           = client->_bind_edit( mt_picture_out )
        mode            = `SingleSelectMaster`
        selectionchange = client->_event( 'DISPLAY' )
        )->standard_list_item(
            title       = '{NAME}'
            description = '{NAME}'
            icon        = '{ICON}'
            info        = '{INFO}'
            selected    = `{SELECTED}` ).

    IF mv_pic_display IS NOT INITIAL.
      DATA temp1 TYPE z2ui5_if_types=>ty_t_name_value.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-n = 'src'.
      temp2-v = mv_pic_display.
      INSERT temp2 INTO TABLE temp1.
      page->_generic( ns   = 'html'
                      name = 'center'
        )->_generic( ns     = 'html'
                     name   = 'img'
                     t_prop = temp1 ).
    ENDIF.

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF mv_check_init = abap_false.
      mv_check_init = abap_true.

      view_display( client ).


    ENDIF.

    CASE client->get( )-event.

      WHEN 'CAPTURE'.
        DATA temp3 TYPE z2ui5_cl_demo_app_306=>ty_picture.
        CLEAR temp3.
        temp3-data = mv_picture_base.
        temp3-time = sy-uzeit.
        INSERT temp3 INTO TABLE mt_picture.
        CLEAR mv_picture_base.
        client->view_model_update( ).

      WHEN 'START'.


      WHEN 'DISPLAY'.
        DATA lt_sel LIKE mt_picture_out.
        lt_sel = mt_picture_out.
        DELETE lt_sel WHERE selected = abap_false.
        DATA ls_sel LIKE LINE OF lt_sel.
        DATA temp1 LIKE LINE OF lt_sel.
        DATA temp2 LIKE sy-tabix.
        temp2 = sy-tabix.
        READ TABLE lt_sel INDEX 1 INTO temp1.
        sy-tabix = temp2.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        ls_sel = temp1.
        DATA temp4 LIKE LINE OF mt_picture.
        DATA temp5 LIKE sy-tabix.
        temp5 = sy-tabix.
        READ TABLE mt_picture INDEX ls_sel-id INTO temp4.
        sy-tabix = temp5.
        IF sy-subrc <> 0.
          ASSERT 1 = 0.
        ENDIF.
        mv_pic_display = temp4-data.
        view_display( client ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

    ENDCASE.

    DATA temp6 LIKE mt_picture_out.
    CLEAR temp6.
    mt_picture_out = temp6.
    DATA ls_pic LIKE LINE OF mt_picture.
    LOOP AT mt_picture INTO ls_pic.
      DATA temp7 TYPE z2ui5_cl_demo_app_306=>ty_picture.
      CLEAR temp7.
      temp7-name = `picture ` && sy-tabix.
      temp7-id = sy-tabix.
      INSERT temp7 INTO TABLE mt_picture_out.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
