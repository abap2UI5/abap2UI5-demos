CLASS z2ui5_cl_demo_app_268 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.

    DATA check_initialized TYPE abap_bool.
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



CLASS z2ui5_cl_demo_app_268 IMPLEMENTATION.


  METHOD display_view.

    DATA css TYPE string.
    css = `.size1 {`                    &&
                `  font-size : 1.5rem;`       &&
                `}`                           &&
                `.size2 {`                    &&
                `  font-size : 2.5rem;`       &&
                `}`                           &&
                `.size3 {`                    &&
                `  font-size : 5rem;`         &&
                `}`                           &&
                `.size4 {`                    &&
                `  font-size : 7.5rem;`       &&
                `}`                           &&
                `.size5 {`                    &&
                `  font-size : 10rem;`        &&
                `}`                           &&
      `@media (max-width:599px) {`  &&
                ` .size1 {`                   &&
                `   font-size : 1rem;`        &&
                ` }`                          &&
                ` .size2 {`                   &&
                `   font-size : 2rem;`        &&
                `}`                           &&
                ` .size3 {`                   &&
                `   font-size : 3rem;`        &&
                ` }`                          &&
                ` .size4 {`                   &&
                `   font-size : 4rem;`        &&
                ` }`                          &&
                ` .size5 {`                   &&
                `   font-size : 5rem;`        &&
                ` }`                          &&
                `}`.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).
    view->_generic( name = `style`
                    ns   = `html` )->_cc_plain_xml( css )->get_parent( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
         )->page(
            title          = `abap2UI5 - Sample: Icon`
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
           href   = 'https://sapui5.hana.ondemand.com/sdk/#/entity/sap.ui.core.Icon/sample/sap.ui.core.sample.Icon' ).

    page->hbox( class = `sapUiSmallMargin`
           )->icon(
               src   = `sap-icon://syringe`
               class = `size1`
               color = `#031E48` )->get(
               )->layout_data( ns = `core`
                   )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
           )->icon(
               src   = `sap-icon://pharmacy`
               class = `size2`
               color = `#64E4CE` )->get(
               )->layout_data( ns = `core`
                   )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
           )->icon(
               src   = `sap-icon://electrocardiogram`
               class = `size3`
               color = `#E69A17` )->get(
               )->layout_data( ns = `core`
                   )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
           )->icon(
               src   = `sap-icon://doctor`
               class = `size4`
               color = `#1C4C98` )->get(
               )->layout_data( ns = `core`
                   )->flex_item_data( growfactor = `1` )->get_parent( )->get_parent(
           )->icon(
               src   = `sap-icon://stethoscope`
               class = `size5`
               color = `#8875E7`
               press = client->_event( `handleStethoscopePress` ) )->get(
               )->layout_data( ns = `core`
                   )->flex_item_data( growfactor = `1` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
      WHEN 'CLICK_HINT_ICON'.
        z2ui5_display_popover( `button_hint_id` ).
      WHEN 'handleStethoscopePress'.
        client->message_toast_display( `Over budget!` ).
    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_display_popover.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory_popup( ).
    view->quick_view( placement = `Bottom`
                      width     = `auto`
              )->quick_view_page( pageid      = `sampleInformationId`
                                  header      = `Sample information`
                                  description = `Built with an embedded font, icons scale well, and can be altered with CSS. ` &&
                                                `They can also fire a press event. See the Icon Explorer for more icons.` ).

    client->popover_display(
      xml   = view->stringify( )
      by_id = id ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.
