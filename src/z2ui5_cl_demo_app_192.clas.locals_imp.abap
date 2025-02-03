*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_merged_data DEFINITION.

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_s_key_value,
             fname   TYPE char30,
             value   TYPE string,
             tabname TYPE char30,
             comp    TYPE abap_componentdescr,
           END OF ty_s_key_value,
           ty_t_key_values TYPE STANDARD TABLE OF ty_s_key_value WITH DEFAULT KEY.

    TYPES: BEGIN OF ty_s_merged_data,
             t_kopf  TYPE REF TO data,
             t_pos   TYPE REF TO data,
             t_keyva TYPE ty_t_key_values,
           END OF ty_s_merged_data.


ENDCLASS.
