CLASS z2ui5_cl_demo_app_289 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_product,
        product        TYPE string,
        type           TYPE string,
        additionalinfo TYPE string,
      END OF ty_product.

    DATA check_initialized TYPE abap_bool.
    TYPES temp1_97fab6e42f TYPE TABLE OF ty_product.
DATA lt_a_data TYPE temp1_97fab6e42f.

  PROTECTED SECTION.

    DATA client TYPE REF TO z2ui5_if_client.

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



CLASS z2ui5_cl_demo_app_289 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Object Marker in a table'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp2 ).

    page->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.ObjectMarker/sample/sap.m.sample.ObjectMarker' ).

    DATA temp1 TYPE string_table.
    CLEAR temp1.
    INSERT `${TYPE}` INTO TABLE temp1.
    page->table( id = `idProductsTable`
           items    = client->_bind( lt_a_data )
           )->columns(
               )->column(
                   )->text( text = `Products`
               )->get_parent(
               )->column(
                   )->text( text = `Status`
               )->get_parent(
               )->column(
                   )->text( text = `Status (active)`
               )->get_parent( )->get_parent(
           )->column_list_item(
               )->object_identifier(
                   text = '{PRODUCT}' )->get_parent(
               )->object_marker(
                   type           = '{TYPE}'
                   additionalinfo = '{ADDITIONALINFO}' )->get_parent(
               )->object_marker(
                   type           = '{TYPE}'
                   additionalinfo = '{ADDITIONALINFO}'
                   press          = client->_event( val = `onPress` t_arg = temp1 ) ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
      WHEN 'onPress'.
        client->message_toast_display( client->get_event_arg( 1 ) && ` marker pressed!` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `The ObjectMarker is a small building block representing an object by an icon or text and icon. Often it is used in a table.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).

      DATA temp3 LIKE lt_a_data.
      CLEAR temp3.
      DATA temp4 LIKE LINE OF temp3.
      temp4-product = 'Power Projector 4713'.
      temp4-type = 'Locked'.
      INSERT temp4 INTO TABLE temp3.
      temp4-product = 'Power Projector 4713'.
      temp4-type = 'LockedBy'.
      temp4-additionalinfo = 'John Doe'.
      INSERT temp4 INTO TABLE temp3.
      temp4-product = 'Power Projector 4713'.
      temp4-type = 'LockedBy'.
      INSERT temp4 INTO TABLE temp3.
      temp4-product = 'Gladiator MX'.
      temp4-type = 'Draft'.
      INSERT temp4 INTO TABLE temp3.
      temp4-product = 'Hurricane GX'.
      temp4-type = 'Unsaved'.
      INSERT temp4 INTO TABLE temp3.
      temp4-product = 'Hurricane GX'.
      temp4-type = 'UnsavedBy'.
      temp4-additionalinfo = 'John Doe'.
      INSERT temp4 INTO TABLE temp3.
      temp4-product = 'Hurricane GX'.
      temp4-type = 'UnsavedBy'.
      INSERT temp4 INTO TABLE temp3.
      temp4-product = 'Hurricane GX'.
      temp4-type = 'Unsaved'.
      INSERT temp4 INTO TABLE temp3.
      temp4-product = 'Webcam'.
      temp4-type = 'Favorite'.
      INSERT temp4 INTO TABLE temp3.
      temp4-product = 'Deskjet Super Highspeed'.
      temp4-type = 'Flagged'.
      INSERT temp4 INTO TABLE temp3.
      lt_a_data = temp3.

    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.
