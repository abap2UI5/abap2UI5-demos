CLASS z2ui5_cl_demo_app_010 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES Z2UI5_if_app.

  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.


CLASS z2ui5_cl_demo_app_010 IMPLEMENTATION.

  METHOD Z2UI5_if_app~main.

    CASE client->get( )-event.
      WHEN 'BACK'.
        client->nav_app_leave( ).
    ENDCASE.

    DATA(page) = z2ui5_cl_xml_view=>factory( )->shell(
        )->page( title          = 'abap2UI5 - Demo Layout'
                 navbuttonpress = client->_event( 'BACK' )
                 shownavbutton  = xsdbool( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL )
             ).

    page->header_content(
      )->button( text = 'button'
       ).

    page->sub_header(
        )->overflow_toolbar(
            )->button( text = 'button'
            )->text( 'text'
            )->link( text = 'link'
                     href = 'https://twitter.com/abap2UI5'
            )->toolbar_spacer(
            )->text( 'subheader'
            )->toolbar_spacer(
            )->button( text = 'button'
            )->text( 'text'
            )->link( text = 'link'
                     href = 'https://twitter.com/abap2UI5' ).

    DATA(grid) = page->grid( 'L4 M4 S4' )->content( 'layout' ).

    grid->simple_form( 'Grid width 33%' )->content( 'form'
       )->button( text = 'button'
       )->text( 'text'
       )->link( text = 'link'
                href = 'https://twitter.com/abap2UI5' ).

    grid->simple_form( 'Grid width 33%' )->content( 'form'
      )->button( text = 'button'
      )->text( 'text'
      )->link( text = 'link'
               href = 'https://twitter.com/abap2UI5' ).

    grid->simple_form( 'Grid width 33%' )->content( 'form'
      )->button( text = 'button'
      )->text( 'text'
      )->link( text = 'link'
               href = 'https://twitter.com/abap2UI5' ).

    grid = page->grid( 'L12 M12 S12' )->content( 'layout' ).

    grid->simple_form( 'grid width 100%' )->content( 'form'
      )->button( text = 'button'
      )->text( 'text'
      )->link( text = 'link'
               href = 'https://twitter.com/abap2UI5' ).

    page->footer(
        )->overflow_toolbar(
            )->button( text = 'button'
            )->text( 'text'
            )->link( text = 'link'
                     href = 'https://twitter.com/abap2UI5'
            )->toolbar_spacer(
            )->text( 'footer'
            )->toolbar_spacer(
            )->text( 'text'
            )->link( text = 'link'
                     href = 'https://twitter.com/abap2UI5'
            )->button( text = 'reject'
                       type = 'Reject'
            )->button( text = 'accept'
                       type = 'Success' ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.

ENDCLASS.
