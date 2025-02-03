CLASS z2ui5_cl_demo_app_302 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    TYPES:
      BEGIN OF ty_product,
        product        TYPE string,
        supplier       TYPE string,
        additionalinfo TYPE string,
      END OF ty_product.

    DATA check_initialized TYPE abap_bool.
    TYPES temp1_16f0541213 TYPE TABLE OF ty_product.
DATA lt_a_data TYPE temp1_16f0541213.

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



CLASS z2ui5_cl_demo_app_302 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: Object Attribute inside Table'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    page->header_content(
       )->button( id = `button_hint_id`
           icon      = `sap-icon://hint`
           tooltip   = `Sample information`
           press     = client->_event( 'CLICK_HINT_ICON' ) ).

    page->header_content(
       )->link(
           text   = 'UI5 Demo Kit'
           target = '_blank'
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.m.ObjectAttribute/sample/sap.m.sample.ObjectAttributeInTable' ).

    page->table( id = `idProductsTable`
           items    = client->_bind( lt_a_data )
           )->columns(
               )->column(
                   )->text( text = `Products`
               )->get_parent(
               )->column(
                   )->text( text = `Supplier`
               )->get_parent(
               )->column(
                   )->text( text = `Supplier (active)`
               )->get_parent( )->get_parent(
           )->column_list_item(
               )->object_identifier(
                   text = '{PRODUCT}' )->get_parent(
               )->object_attribute(
                   text = '{SUPPLIER}'
               )->object_attribute(
                   text   = '{SUPPLIER}'
                   active = abap_true
           )->get_parent( ).

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
                                  description = `This is an example of Object Attribute used inside Table.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).

      DATA temp1 LIKE lt_a_data.
      CLEAR temp1.
      DATA temp2 LIKE LINE OF temp1.
      temp2-product = 'Power Projector 4713'.
      temp2-supplier = 'Robert Brown Entertainment'.
      INSERT temp2 INTO TABLE temp1.
      temp2-product = 'HT-1022'.
      temp2-supplier = 'Pear Computing Services'.
      INSERT temp2 INTO TABLE temp1.
      temp2-product = 'Ergo Screen E-III'.
      temp2-supplier = 'DelBont Industries'.
      INSERT temp2 INTO TABLE temp1.
      temp2-product = 'Gladiator MX'.
      temp2-supplier = 'Asia High tech'.
      INSERT temp2 INTO TABLE temp1.
      temp2-product = 'Hurricane GX'.
      temp2-supplier = 'Telecomunicaciones Star'.
      INSERT temp2 INTO TABLE temp1.
      temp2-product = 'Notebook Basic 17'.
      temp2-supplier = 'Pear Computing Services'.
      INSERT temp2 INTO TABLE temp1.
      temp2-product = 'ITelO Vault SAT'.
      temp2-supplier = 'New Line Design'.
      INSERT temp2 INTO TABLE temp1.
      temp2-product = 'Hurricane GX'.
      temp2-supplier = 'Robert Brown Entertainment'.
      INSERT temp2 INTO TABLE temp1.
      temp2-product = 'Webcam'.
      temp2-supplier = 'Getränkegroßhandel Janssen'.
      INSERT temp2 INTO TABLE temp1.
      temp2-product = 'Deskjet Super Highspeed'.
      temp2-supplier = 'Vente Et Réparation de Ordinateur'.
      INSERT temp2 INTO TABLE temp1.
      lt_a_data = temp1.
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.
