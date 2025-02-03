CLASS z2ui5_cl_demo_app_186 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    INTERFACES z2ui5_if_app .

    DATA is_initialized TYPE abap_bool .
    DATA file_content_64 TYPE string .
    DATA file_name TYPE string .
    DATA mime_type TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA client TYPE REF TO z2ui5_if_client .

    METHODS initialize .
    METHODS on_event .
    METHODS render_screen .
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_186 IMPLEMENTATION.


  METHOD initialize.

    file_name = 'Default_File_Name.jpg'.
    mime_type = 'text/plain'.
    file_content_64 = `data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAApgAAA` &&
      `KYB3X3/OAAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAANCSURBVEiJtZZPbBtFFMZ/M7ubXdtdb1xSFyeilBapySVU8h8OoFaooFSqiihIVIp` &&
      `QBKci6KEg9Q6H9kovIHoCIVQJJCKE1ENFjnAgcaSGC6rEnxBwA04Tx43t2FnvDAfjkNibxgHxnWb2e/u992bee7tCa00YFsffekFY+nUzFtjW0LrvjRXrCDIAaPLlW` &&
      `0nHL0SsZtVoaF98mLrx3pdhOqLtYPHChahZcYYO7KvPFxvRl5XPp1sN3adWiD1ZAqD6XYK1b/dvE5IWryTt2udLFedwc1+9kLp+vbbpoDh+6TklxBeAi9TL0taeWpd` &&
      `mZzQDry0AcO+jQ12RyohqqoYoo8RDwJrU+qXkjWtfi8Xxt58BdQuwQs9qC/afLwCw8tnQbqYAPsgxE1S6F3EAIXux2oQFKm0ihMsOF71dHYx+f3NND68ghCu1YIoeP` &&
      `PQN1pGRABkJ6Bus96CutRZMydTl+TvuiRW1m3n0eDl0vRPcEysqdXn+jsQPsrHMquGeXEaY4Yk4wxWcY5V/9scqOMOVUFthatyTy8QyqwZ+kDURKoMWxNKr2EeqVKc` &&
      `TNOajqKoBgOE28U4tdQl5p5bwCw7BWquaZSzAPlwjlithJtp3pTImSqQRrb2Z8PHGigD4RZuNX6JYj6wj7O4TFLbCO/Mn/m8R+h6rYSUb3ekokRY6f/YukArN979jc` &&
      `W+V/S8g0eT/N3VN3kTqWbQ428m9/8k0P/1aIhF36PccEl6EhOcAUCrXKZXXWS3XKd2vc/TRBG9O5ELC17MmWubD2nKhUKZa26Ba2+D3P+4/MNCFwg59oWVeYhkzgN/` &&
      `JDR8deKBoD7Y+ljEjGZ0sosXVTvbc6RHirr2reNy1OXd6pJsQ+gqjk8VWFYmHrwBzW/n+uMPFiRwHB2I7ih8ciHFxIkd/3Omk5tCDV1t+2nNu5sxxpDFNx+huNhVT3` &&
      `/zMDz8usXC3ddaHBj1GHj/As08fwTS7Kt1HBTmyN29vdwAw+/wbwLVOJ3uAD1wi/dUH7Qei66PfyuRj4Ik9is+hglfbkbfR3cnZm7chlUWLdwmprtCohX4HUtlOcQj` &&
      `LYCu+fzGJH2QRKvP3UNz8bWk1qMxjGTOMThZ3kvgLI5AzFfo379UAAAAASUVORK5CYII=`.

  ENDMETHOD.


  METHOD on_event.

    CASE client->get( )-event.

      WHEN 'BUTTON_DOWNLOAD'.



        DATA temp1 TYPE string_table.
        CLEAR temp1.
        INSERT file_content_64 INTO TABLE temp1.
        INSERT file_name INTO TABLE temp1.
        client->follow_up_action( val = client->_event_client( val = client->cs_event-download_b64_file t_arg = temp1 ) ).


      WHEN 'BACK'.
        client->nav_app_leave( ).

    ENDCASE.

  ENDMETHOD.


  METHOD render_screen.

    DATA lv_script TYPE string.


    DATA view TYPE REF TO z2ui5_cl_xml_view.
    view = z2ui5_cl_xml_view=>factory( ).

    DATA page TYPE REF TO z2ui5_cl_xml_view.
    DATA temp1 TYPE xsdboolean.
    temp1 = boolc( abap_false = client->get( )-check_launchpad_active ).
    DATA temp2 TYPE xsdboolean.
    temp2 = boolc( client->get( )-s_draft-id_prev_app_stack IS NOT INITIAL ).
    page = view->shell(
         )->page(
            showheader     = temp1
            title          = 'abap2UI5 - Download Base64 File'
            navbuttonpress = client->_event( 'BACK' )
            shownavbutton  = temp2 ).

    page->flex_box( width          = `100%`
                    height         = `600px`
                    alignitems     = `Center`
                    justifycontent = `SpaceAround`
      )->vbox( )->text( text = `Base64 String:`
      )->text_area( value    = client->_bind_edit( file_content_64 )
                    rows     = `20`
                    width    = `800px`
                    wrapping = abap_true
      )->get_parent(
      )->vbox( justifycontent = `Center`
               alignitems     = `Center`
      )->text( text = `fill filename:`
      )->input( value = client->_bind_edit( file_name )
                class = `sapUiLargeMarginBottom`
                width = `15rem`
      )->button( type  = 'Emphasized'
                 text  = 'Open Download Popup'
                 press = client->_event( 'BUTTON_DOWNLOAD' ) ).

    client->view_display( page->stringify( ) ).

  ENDMETHOD.


  METHOD z2ui5_if_app~main.

    me->client = client.

    IF is_initialized = abap_false.

      initialize( ).
      render_screen( ).
      is_initialized = abap_true.

    ENDIF.

    on_event( ).

  ENDMETHOD.
ENDCLASS.
