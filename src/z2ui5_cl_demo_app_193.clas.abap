CLASS z2ui5_cl_demo_app_193 DEFINITION PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_serializable_object.

    TYPES:
      BEGIN OF ty_s_key_value,
        fname   TYPE char30,
        value   TYPE string,
        tabname TYPE char30,
        comp    TYPE abap_componentdescr,
      END OF ty_s_key_value,
      ty_t_key_values TYPE STANDARD TABLE OF ty_s_key_value WITH DEFAULT KEY.

    DATA mt_kopf  TYPE REF TO data.
    DATA mt_pos   TYPE REF TO data.
    DATA mt_keyva TYPE ty_t_key_values.

    DATA mt_kopf_xml  TYPE string.
    DATA mt_pos_xml   TYPE string.

    METHODS xml_parse.
    METHODS xml_stringify.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_193 IMPLEMENTATION.


  METHOD xml_parse.

    IF mt_pos_xml IS NOT INITIAL.
      mt_kopf = z2ui5_cl_util=>xml_srtti_parse( mt_kopf_xml ).
      CLEAR mt_kopf_xml.
    ENDIF.

    IF mt_pos_xml IS NOT INITIAL.
      mt_pos = z2ui5_cl_util=>xml_srtti_parse( mt_pos_xml ).
      CLEAR mt_pos_xml.
    ENDIF.

  ENDMETHOD.


  METHOD xml_stringify.

    FIELD-SYMBOLS <head> TYPE data.
    ASSIGN mt_kopf->* TO <head>.
    IF sy-subrc = 0.
      mt_kopf_xml = z2ui5_cl_util=>xml_srtti_stringify( <head> ).
      CLEAR mt_kopf.
    ENDIF.

    FIELD-SYMBOLS <pos> TYPE data.
    ASSIGN mt_pos->* TO <pos>.
    IF sy-subrc = 0.
      mt_pos_xml = z2ui5_cl_util=>xml_srtti_stringify( <pos> ).
      CLEAR mt_pos.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
