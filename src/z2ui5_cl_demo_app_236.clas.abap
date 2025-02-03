CLASS z2ui5_cl_demo_app_236 DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app .

    DATA check_initialized TYPE abap_bool .
  PROTECTED SECTION.

    METHODS display_view
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

    METHODS on_event
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_236 IMPLEMENTATION.


  METHOD display_view.

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = z2ui5_cl_xml_view=>factory( )->shell(
         )->page(
            title          = 'abap2UI5 - Sample: TextArea - Growing'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp1 ).

    DATA layout TYPE REF TO z2ui5_cl_xml_view.
    layout = page->vertical_layout(
                          class = `sapUiContentPadding`
                          width = `100%`
                          )->content( ns = `layout`
                              )->message_strip(
                                  showicon = abap_true
                                  text     = `This TextArea shows up to 7 lines, then a scrollbar is presented.`
                                  )->text_area( placeholder     = `Enter Text`
                                                growing         = abap_true
                                                growingmaxlines = `7`
                                                width           = `100%`
      )->message_strip(
                                  showicon = abap_true
                                  text     = `This TextArea shows up to 7 lines, then a scrollbar is presented.`
                                  class    = `sapUiMediumMarginTop`
                              )->text_area( value                                                                                     = `Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy ` &&
                                                    `eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ` &&
                                                    `At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, ` &&
                                                    `no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, ` &&
                                                    `consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ` &&
                                                    `magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing ` &&
                                                    `elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat. ` &&
                                                    `Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor ` &&
                                                    `invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et ` &&
                                                    `accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata ` &&
                                                    `sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing ` &&
                                                    `elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, ` &&
                                                    `sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam ` &&
                                                    `nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.`  growing = abap_true
                                            growingmaxlines                                                                           = `7`
                                            width                                                                                     = `100%`
      )->message_strip(
                                  showicon = abap_true
                                  text     = `This TextArea adjusts its height according to its content.`
                                  class    = `sapUiMediumMarginTop`
                              )->text_area( value                                                                                     = `Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy ` &&
                                                    `eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ` &&
                                                    `At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, ` &&
                                                    `no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, ` &&
                                                    `consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ` &&
                                                    `magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing ` &&
                                                    `elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat. ` &&
                                                    `Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor ` &&
                                                    `invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et ` &&
                                                    `accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata ` &&
                                                    `sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing ` &&
                                                    `elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, ` &&
                                                    `sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam ` &&
                                                    `nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.`  growing = abap_true
                                            width                                                                                     = `100%`
      )->message_strip(
                                  showicon = abap_true
                                  text     = `Growing TextArea in a SimpleForm`
                                  class    = `sapUiMediumMarginTop`
                                  )->simple_form( "ns = `form`
                                      editable = `true`
                                      layout   = `ResponsiveGridLayout`
                                      )->label( text = `Comment`
                              )->text_area( value                                                                                     = `Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy ` &&
                                                    `eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. ` &&
                                                    `At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, ` &&
                                                    `no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, ` &&
                                                    `consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore ` &&
                                                    `magna aliquyam erat, sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing ` &&
                                                    `elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat. ` &&
                                                    `Lorem ipsum dolor st amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor ` &&
                                                    `invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et ` &&
                                                    `accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata ` &&
                                                    `sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing ` &&
                                                    `elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, ` &&
                                                    `sed diam voluptua. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam ` &&
                                                    `nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.`  growing = abap_true
                                            width                                                                                     = `100%` ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.

      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      display_view( client ).
    ENDIF.

    on_event( client ).

  ENDMETHOD.
ENDCLASS.
