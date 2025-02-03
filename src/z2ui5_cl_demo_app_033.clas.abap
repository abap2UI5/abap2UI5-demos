CLASS z2ui5_cl_demo_app_033 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.
    DATA mv_type TYPE string.

    METHODS display_view.
    DATA mv_html TYPE string.
    DATA check_initialized TYPE abap_bool.
    DATA client TYPE REF TO z2ui5_if_client.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_033 IMPLEMENTATION.


  METHOD display_view.

    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    page = view->shell(
        )->page(
            title          = 'abap2UI5 - Illustrated Messages'
            navbuttonpress = client->_event( val = 'BACK'  )
              shownavbutton = abap_true
            )->header_content(
                 )->link(
                    text = 'Demo'  target = '_blank'
                    href = `https://twitter.com/abap2UI5/status/1647175810917318657`
                )->link(


            )->get_parent( ).
    page->link( text = 'Documentation'  target = '_blank' href = `https://openui5.hana.ondemand.com/api/sap.m.IllustratedMessageType#properties` ).
    page->button( text = 'NoActivities' press = client->_event( 'sapIllus-NoActivities' ) ).
    page->button( text = 'AddPeople' press = client->_event( 'sapIllus-AddPeople' ) ).
    page->button( text = 'Connection' press = client->_event( 'sapIllus-Connection' ) ).
    page->button( text = 'NoDimensionsSet' press = client->_event( 'sapIllus-NoDimensionsSet' ) ).
    page->button( text = 'NoEntries' press = client->_event( 'sapIllus-NoEntries' ) ).
    page->illustrated_message( illustrationtype = client->_bind( mv_type )
    )->additional_content(  )->button(
                text  = 'information'
                press = client->_event( 'BUTTON_MESSAGE_BOX' ) ).

    client->view_display( view->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.
    me->client = client.

    mv_html = `<p>link: <a href="https://www.sap.com" style="color:green; font-weight:600;">link to sap.com</a> - links open in ` &&
    `a new window.</p><p>paragraph: <strong>strong</strong> and <em>emphasized</em>.</p><p>list:</p><ul` &&
  `><li>list item 1</li><li>list item 2<ul><li>sub item 1</li><li>sub item 2</li></ul></li></ul><p>pre:</p><pre>abc    def    ghi</pre><p>code: <code>var el = document.getElementById("myId");</code></p><p>cite: <cite>a reference to a source</cite></p>` &&
  `<dl><dt>definition:</dt><dd>definition list of terms and descriptions</dd>`.

    IF check_initialized = abap_false.
      check_initialized = abap_true.
      mv_type = `sapIllus-NoActivities`.
      display_view( ).
      RETURN.
    ENDIF.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).

      WHEN 'BUTTON_MESSAGE_BOX'.
        client->message_box_display( 'Action of illustrated message' ).

      WHEN OTHERS.
        mv_type = client->get( )-event.

    ENDCASE.


    display_view( ).

  ENDMETHOD.
ENDCLASS.
