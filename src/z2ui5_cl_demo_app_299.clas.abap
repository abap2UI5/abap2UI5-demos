CLASS z2ui5_cl_demo_app_299 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_product_collection,
        product_id TYPE string,
        name       TYPE string,
      END OF ty_product_collection.

    DATA check_initialized TYPE abap_bool.
    TYPES temp1_3750dc126e TYPE TABLE OF ty_product_collection.
DATA lt_product_collection  TYPE temp1_3750dc126e.
    TYPES temp2_3750dc126e TYPE TABLE OF ty_product_collection.
DATA lt_product_collection2 TYPE temp2_3750dc126e.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

    METHODS z2ui5_set_data.
    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.
    METHODS z2ui5_display_popover
      IMPORTING
        id TYPE string.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_299 IMPLEMENTATION.


  METHOD display_view.

    DATA page_01 TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page_01 = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = `abap2UI5 - Sample: Select - Wrapping text`
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    page_01->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page_01->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.Select/sample/sap.m.sample.SelectWithWrappedItemText' ).

    page_01->select(
                width         = `300px`
                wrapitemstext = abap_true
                class         = `sapUiLargeMargin`
                items         = client->_bind( lt_product_collection )
                )->item( key  = '{PRODUCT_ID}'
                         text = '{NAME}'
             )->get_parent(
             )->select(
                width         = `300px`
                wrapitemstext = abap_true
                class         = `sapUiLargeMargin`
                items         = client->_bind( lt_product_collection2 )
                )->item( key  = '{PRODUCT_ID}'
                         text = '{NAME}'
             )->get_parent( ).

    client->view_display( page_01->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `Illustrates how the text in items wrap.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
      z2ui5_set_data( ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.


  METHOD z2ui5_set_data.

    CLEAR lt_product_collection.
    CLEAR lt_product_collection2.

    " Populating lt_product_collection
    DATA temp1 LIKE lt_product_collection.
    CLEAR temp1.
    DATA temp2 LIKE LINE OF temp1.
    temp2-product_id = 'HT-1001'.
    temp2-name = 'Select option 1'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1002'.
    temp2-name = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1003'.
    temp2-name = 'Select option 3'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1007'.
    temp2-name = 'Select option 4'.
    INSERT temp2 INTO TABLE temp1.
    temp2-product_id = 'HT-1010'.
    temp2-name = 'Select option 5'.
    INSERT temp2 INTO TABLE temp1.
    lt_product_collection = temp1.
    SORT lt_product_collection BY name.

    " Populating lt_product_collection2
    DATA temp3 LIKE lt_product_collection2.
    CLEAR temp3.
    DATA temp4 LIKE LINE OF temp3.
    temp4-product_id = 'key1'.
    temp4-name = 'Select option 1'.
    INSERT temp4 INTO TABLE temp3.
    temp4-product_id = 'key2'.
    temp4-name = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.'.
    INSERT temp4 INTO TABLE temp3.
    temp4-product_id = 'key3'.
    temp4-name = 'Select option 3'.
    INSERT temp4 INTO TABLE temp3.
    temp4-product_id = 'key4'.
    temp4-name = 'Select option 4'.
    INSERT temp4 INTO TABLE temp3.
    temp4-product_id = 'key5'.
    temp4-name = 'Select option 5'.
    INSERT temp4 INTO TABLE temp3.
    lt_product_collection2 = temp3.
    SORT lt_product_collection2 BY name.

  ENDMETHOD.
ENDCLASS.
