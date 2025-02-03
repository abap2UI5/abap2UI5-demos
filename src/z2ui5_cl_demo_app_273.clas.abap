CLASS z2ui5_cl_demo_app_273 DEFINITION
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



CLASS z2ui5_cl_demo_app_273 IMPLEMENTATION.


  METHOD display_view.

    " Define the base URL for the server
    DATA base_url TYPE string VALUE 'https://sapui5.hana.ondemand.com/'.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: LightBox'
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
           href   = base_url && 'sdk/#/entity/sap.m.LightBox/sample/sap.m.sample.LightBox' ).

    page->message_strip( text                                                                                                             = `Clicking on each of the images will open a LightBox, showing the real size of the image. ` &&
                                `Images will be scaled down if their size is bigger than the window size." class="sapUiSmallMargin` class = `sapUiSmallMargin`
          )->list(
              )->custom_list_item(
                  )->hbox( class = `sapUiSmallMargin`
                      )->image(
                          src          = base_url && `test-resources/sap/ui/documentation/sdk/images/HT-6100.jpg`
                          decorative   = abap_false
                          width        = `170px`
                          densityaware = abap_false )->get(
                          )->detail_box(
                             )->light_box(
                                 )->light_box_item(
                                     imagesrc = base_url && `test-resources/sap/ui/documentation/sdk/images/HT-6100-large.jpg`
                                     alt      = `Beamer`
                                     title    = `This is a beamer`
                                     subtitle = `This is beamer's description` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                          )->vbox( class = `sapUiSmallMarginBegin`
                              )->title( text = `Beamer`
                                  )->text( text = `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam interdum lectus et tempus blandit.`    &&
                                                  `Sed porta ex quis tortor gravida, ut suscipit felis dignissim. Ut iaculis elit vel ligula scelerisque,` &&
                                                  `et porttitor est pretium. Suspendisse purus dolor, fermentum in tortor eu, semper finibus velit.`       &&
                                                  `Proin vel lobortis leo, vel eleifend lorem. Etiam ac erat sollicitudin, condimentum magna ac,`          &&
                                                  `venenatis lacus. Pellentesque non mauris consectetur, tristique arcu id, aliquet tortor.` )->get_parent( )->get_parent(
      )->custom_list_item(
                  )->hbox( class = `sapUiSmallMargin`
                      )->image(
                          src          = base_url && `test-resources/sap/ui/documentation/sdk/images/HT-6120.jpg`
                          decorative   = abap_false
                          width        = `170px`
                          densityaware = abap_false )->get(
                          )->detail_box(
                             )->light_box(
                                 )->light_box_item(
                                     imagesrc = base_url && `test-resources/sap/ui/documentation/sdk/images/HT-6120-large.jpg`
                                     alt      = `USB`
                                     title    = `This is a USB`
                                     subtitle = `This is USB's description` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                          )->vbox( class = `sapUiSmallMarginBegin`
                              )->title( text = `USB`
                                  )->text( text = `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam interdum lectus et tempus blandit.`    &&
                                                  `Sed porta ex quis tortor gravida, ut suscipit felis dignissim. Ut iaculis elit vel ligula scelerisque,` &&
                                                  `et porttitor est pretium. Suspendisse purus dolor, fermentum in tortor eu, semper finibus velit.`       &&
                                                  `Proin vel lobortis leo, vel eleifend lorem. Etiam ac erat sollicitudin, condimentum magna ac,`          &&
                                                  `venenatis lacus. Pellentesque non mauris consectetur, tristique arcu id, aliquet tortor.` )->get_parent( )->get_parent(
      )->custom_list_item(
                  )->hbox( class = `sapUiSmallMargin`
                      )->image(
                          src          = base_url && `test-resources/sap/ui/documentation/sdk/images/HT-7777.jpg`
                          decorative   = abap_false
                          width        = `170px`
                          densityaware = abap_false )->get(
                          )->detail_box(
                             )->light_box(
                                 )->light_box_item(
                                     imagesrc = base_url && `test-resources/sap/ui/documentation/sdk/images/HT-7777-large.jpg`
                                     alt      = `Speakers`
                                     title    = `These are speakers`
                                     subtitle = `This is speakers' description` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                          )->vbox( class = `sapUiSmallMarginBegin`
                              )->title( text = `Speakers`
                                  )->text( text = `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam interdum lectus et tempus blandit.`    &&
                                                  `Sed porta ex quis tortor gravida, ut suscipit felis dignissim. Ut iaculis elit vel ligula scelerisque,` &&
                                                  `et porttitor est pretium. Suspendisse purus dolor, fermentum in tortor eu, semper finibus velit.`       &&
                                                  `Proin vel lobortis leo, vel eleifend lorem. Etiam ac erat sollicitudin, condimentum magna ac,`          &&
                                                  `venenatis lacus. Pellentesque non mauris consectetur, tristique arcu id, aliquet tortor.` )->get_parent( )->get_parent(
      )->custom_list_item(
                  )->hbox( class = `sapUiSmallMargin`
                      )->image(
                          src          = base_url && `test-resources/sap/ui/documentation/sdk/images/nature/ALotOfElephants_small.jpg`
                          decorative   = abap_false
                          width        = `170px`
                          densityaware = abap_false )->get(
                          )->detail_box(
                             )->light_box(
                                 )->light_box_item(
                                     imagesrc = base_url && `test-resources/sap/ui/documentation/sdk/images/nature/ALotOfElephants.jpg`
                                     alt      = `Nature image`
                                     title    = `This is a sample image`
                                     subtitle = `This is a place for description` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                          )->vbox( class = `sapUiSmallMarginBegin`
                              )->title( text = `Nature image`
                                  )->text( text = `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam interdum lectus et tempus blandit.`    &&
                                                  `Sed porta ex quis tortor gravida, ut suscipit felis dignissim. Ut iaculis elit vel ligula scelerisque,` &&
                                                  `et porttitor est pretium. Suspendisse purus dolor, fermentum in tortor eu, semper finibus velit.`       &&
                                                  `Proin vel lobortis leo, vel eleifend lorem. Etiam ac erat sollicitudin, condimentum magna ac,`          &&
                                                  `venenatis lacus. Pellentesque non mauris consectetur, tristique arcu id, aliquet tortor.` )->get_parent( )->get_parent(
      )->custom_list_item(
                  )->hbox( class = `sapUiSmallMargin`
                      )->image(
                          src          = base_url && `test-resources/sap/ui/documentation/sdk/images/nature/flatFish.jpg`
                          decorative   = abap_false
                          width        = `170px`
                          densityaware = abap_false )->get(
                          )->detail_box(
                             )->light_box(
                                 )->light_box_item(
                                     imagesrc = base_url && `test-resources/sap/ui/documentation/sdk/images/nature/flatFish.jpg`
                                     alt      = `Nature image`
                                     title    = `This is a sample image`
                                     subtitle = `This is a place for description` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                          )->vbox( class = `sapUiSmallMarginBegin`
                              )->title( text = `Nature image`
                                  )->text( text = `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam interdum lectus et tempus blandit.`    &&
                                                  `Sed porta ex quis tortor gravida, ut suscipit felis dignissim. Ut iaculis elit vel ligula scelerisque,` &&
                                                  `et porttitor est pretium. Suspendisse purus dolor, fermentum in tortor eu, semper finibus velit.`       &&
                                                  `Proin vel lobortis leo, vel eleifend lorem. Etiam ac erat sollicitudin, condimentum magna ac,`          &&
                                                  `venenatis lacus. Pellentesque non mauris consectetur, tristique arcu id, aliquet tortor.` )->get_parent( )->get_parent(
      )->custom_list_item(
                  )->hbox( class = `sapUiSmallMargin`
                      )->image(
                          src          = base_url && `test-resources/sap/ui/documentation/sdk/images/nature/horses.jpg`
                          decorative   = abap_false
                          width        = `170px`
                          densityaware = abap_false )->get(
                          )->detail_box(
                             )->light_box(
                                 )->light_box_item(
                                     imagesrc = base_url && `test-resources/sap/ui/documentation/sdk/images/nature/horses.jpg`
                                     alt      = `Nature image`
                                     title    = `This is a sample image`
                                     subtitle = `This is a place for description` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                          )->vbox( class = `sapUiSmallMarginBegin`
                              )->title( text = `Nature image`
                                  )->text( text = `Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam interdum lectus et tempus blandit.`    &&
                                                  `Sed porta ex quis tortor gravida, ut suscipit felis dignissim. Ut iaculis elit vel ligula scelerisque,` &&
                                                  `et porttitor est pretium. Suspendisse purus dolor, fermentum in tortor eu, semper finibus velit.`       &&
                                                  `Proin vel lobortis leo, vel eleifend lorem. Etiam ac erat sollicitudin, condimentum magna ac,`          &&
                                                  `venenatis lacus. Pellentesque non mauris consectetur, tristique arcu id, aliquet tortor.` )->get_parent( )->get_parent(
      )->custom_list_item(
                  )->hbox( class = `sapUiSmallMargin`
                      )->image(
                          src          = base_url && `test-resources/sap/ui/documentation/sdk/images/nature/elephant.jpg`
                          decorative   = abap_false
                          width        = `170px`
                          densityaware = abap_false )->get(
                          )->detail_box(
                             )->light_box(
                                 )->light_box_item(
                                     imagesrc = base_url && `test-resources/sap/ui/documentation/sdk/images/nature/image_does_not_exist.jpg`
                                     alt      = `Nature image`
                                     title    = `This is a sample image`
                                     subtitle = `This is a place for description` )->get_parent( )->get_parent( )->get_parent( )->get_parent(
                          )->vbox( class = `sapUiSmallMarginBegin`
                              )->title( text = `Unavailable image`
                                  )->text( text = `Shows an error when an image could not be loaded, or when it takes too much time to load it.` )->get_parent( )->get_parent( ).

    client->view_display( page->stringify( ) ).

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
                                  description = `Displays several image thumbnails. Clicking on each of them will open a LightBox.` ).

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
