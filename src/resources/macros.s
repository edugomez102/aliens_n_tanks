;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of Aliens'n Tanks: An Amstrad CPC Game 
;;  Copyright (C) 2021 Yaroslav Paslavskiy Danko / Rodrigo Guzmán Escribá / 
;;                     Eduardo David Gómez Saldias / Semag Ohcaco (@SemagOhcaco)
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU Lesser General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU Lesser General Public License for more details.
;;
;;  You should have received a copy of the GNU Lesser General Public License
;;  along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;------------------------------------------------------------------------------

.module Macros
.include "resources/macros.h.s"

.macro PREPARE_SCORE_DIGIT_TO_RENDER _vmem 
    
    and #0x0F
    ld de, (_vmem)
    ld hl, #_m_HUD_scoreHeight
    ld b, (hl)
    ld hl, #_m_HUD_scoreWidth
    ld c, (hl)

.endm 

;;Cargar el valor de _m_sizeOfEntity
.macro LOAD_VARIABLE_IN_REGISTER _var, _register
    ld a, (#_var)
    ld _register, a
.endm 

;;Cargar crear entidades con el template indicado
.macro CREATE_ENTITY_FROM_TEMPLATE _template
    ld bc, #_template
    call _m_game_createInitTemplate
.endm

;;Cargar crear entidades con el template indicado
.macro CREATE_ENTITY_FROM_REGISTER _template
    ld bc, #_template
    call _m_game_createInitTemplate
.endm


;;Incrementa en 1 la variable indicada de la entidad indicada
.macro INCREMENT_ENTITY_VARIABLE _entity, _entity_var
    push af
    
    ld _entityAux
    ld ix, _entityAux
    inc _entity_var(ix)

    pop af
.endm

;;Decrementa en 1 la variable indicada de la entidad indicada
.macro DECREMENT_ENTITY_VARIABLE _entity, _entity_var
    push af
    

    ld ix, _entity
    dec _entity_var(ix)

    pop af
.endm

;; Aumenta el registro X veces
;;IMportante no se puede incrementar HL ni BC
.macro INCREMENT_REGISTER_DE _numLoops
    ; push bc
    ld a, _numLoops
    ld c, a
    ld b, #0
    ex de, hl
    add hl, bc
    ex de, hl
    ; pop bc
.endm

;;Comprueba si la tecla pasada por parametro se está pulsando
.macro CHECK_KEYBOARD_INPUT_IN_KEY _key
    ; call cpct_scanKeyboard_f_asm
    
    ld hl, #_key
    call cpct_isKeyPressed_asm
.endm 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Calculate the given number negated
;; Return: Return the number negated in the _register
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro NEGATE_NUMBER _register
   ld a, _register
   xor #0xFF
   add a, #0x01

.endm


;===============================================================================
; Comprobrar los dos af despues de salir de seekCoords_x y seekCoords_y
; Salta ret si no es el caso !!!
; Parameters:
;  - HL: af register
;  - BC: previous af register
;  - DE: paramter for _call_on_succes that goes on HL
;===============================================================================
.macro X_AND_Y_ON_ZERO_AFTER_SEEK _call_on_succes
   ld a, #0x40
   and l
   ld l, a

   ld a, #0x40
   and c
   ld c, a

   ld a, l
   cp c
   jr z, same_values_in_f
   ret

   same_values_in_f:
      ld a, #0x40
      cp c

      ex de, hl
      call z, _call_on_succes
.endm

;; TODO[Edu]: meter velocidades tambien

.macro SEEK_COORDS_X_Y_SAVING_FLAGS
   call _sys_ai_seekCoords_x
   push af
   call _sys_ai_seekCoords_y
   push af
   pop hl
   pop bc
.endm

;===============================================================================
; Comprobrar si entidad esta parada
; Salta ret si no es el caso !!!
; Usar al final de un label
;===============================================================================
.macro CHECK_VX_VY_ZERO _call_on_succes
   ld a, e_vx(ix)
   or a
   jr z, . + 3
   jr . + 9
   ;; . + 3
      ld a, e_vy(ix)
      or a
      call z, _call_on_succes
   ;; . + 9

.endm

.macro CHECK_VX_VY_ZERO_JR _jr_on_succes
   ld a, e_vx(ix)
   or a
   jr z, . + 3
   jr . + 9
   ;; . + 3
      ld a, e_vy(ix)
      or a
      jr z, _jr_on_succes
   ;; . + 9

.endm

.macro CHECK_NO_AIM_XY _call_on_succes2
   ld a, e_ai_aim_x(ix)
   or a
   jr z, . + 3
   jr . + 9
   ;; . + 3
      ld a, e_ai_aim_y(ix)
      or a
      call z, _call_on_succes2
   ;; . + 9
.endm

;===============================================================================
; Comprobrar si entidad esta parada
; Destroy: BC, HL
;===============================================================================
.macro GET_PLAYER_ENTITY _register
   ld hl, #_m_playerEntity
   ld b, (hl)
   inc hl
   ld c, (hl)
   push bc
   pop _register
.endm

;; Según la orientación de la entidad devuelve el bounding box
;; de arriba o abajo
.macro CHECK_ORIENTATION_PLAYER_FOR_COLLISION_Y _orientation _height

    ;; UP = 3
    ld a, #0x03
    ld d, _orientation
    sub d
    jp z, _is_up

    ;; DOWN = 1
    ld a, #0x01
    ld d, _orientation
    sub d
    jp z, _is_down

    jp _is_none_x

    _is_up:
    ld d, #0xFF
    jp _done_check_y_orientation

    _is_down:
    ld d, _height
    jp _done_check_y_orientation

    _is_none_x:
    ld d, #0x00

    _done_check_y_orientation:

.endm

.macro CHECK_ORIENTATION_PLAYER_FOR_COLLISION_X _orientation _width

    ;; RIGHT = 0
    ld a, #0x00
    ld d, _orientation
    sub d
    jp z, _is_right

    ;; LEFT = 2
    ld a, #0x02
    ld d, _orientation
    sub d
    jp z, _is_left

    jp _is_none_y

    _is_right:
    ld d, _width
    jp _done_check_x_orientation

    _is_left:
    ld d, #0xFF
    jp _done_check_x_orientation

    _is_none_y:
    ld d, #0x00

    _done_check_x_orientation:

.endm



.macro SET_TILESET _set
    ld hl, #_set
    ex de, hl

    ld hl, #_m_render_tileset
    
    ld (hl), e
    inc hl
    ld (hl), d

.endm

.macro SET_TILEMAP _map
    ld hl, #_map
    ex de, hl

    ld hl, #_m_render_tilemap
    
    ld (hl), e
    inc hl
    ld (hl), d

.endm

;; Según la orientación del axis del jugador
;; devuelve en a (0 = x_axis) o (1 = y_axis)
.macro CHECK_ORIENTATION_AXIS_PLAYER _orientation

    ;; RIGHT = 0
    ld a, #0x00
    ld d, _orientation
    sub d
    jp z, _is_x_axis

    ;; DOWN = 1
    ld a, #0x01
    ld d, _orientation
    sub d
    jp z, _is_y_axis

    ;; LEFT = 2
    ld a, #0x02
    ld d, _orientation
    sub d
    jp z, _is_x_axis

    ;; UP = 3
    ld a, #0x03
    ld d, _orientation
    sub d
    jp z, _is_y_axis

    _is_x_axis:
    ld a, #0x00
    jp _axis_checked

    _is_y_axis:
    ld a, #0x01

    _axis_checked:

.endm


.macro CHECK_HAS_MOVEMENT _vx_vel _vy_vel
    ;; a = 0 -> no_vel
    ;; a = 1 -> x_vel
    ;; a = 2 -> y_vel

    ld a, _vx_vel
    ld b, #0x00
    sub b
    jr nz, _has_vel

    ld a, _vy_vel
    ld b, #0x00
    sub b
    jr nz, _has_vel

    jp _has_no_vel

    _has_vel:
    ld b, #0x00
    jp _vel_checked

    _has_no_vel:
    ld b, #0x01
    
    _vel_checked:
    
.endm

;; Obtiene la posición de la entidad en el array que se le pasa
;;      - DE: La posición de la entidad en el array
.macro GET_ENTITY_POSITION _entityDirection
   ld hl, #_entityDirection
   ld d, (hl)
   inc hl
   ld e, (hl)
.endm


.macro LOAD_PNG_TO_SCREEN _xpng _ypng _wpng _hpng _mempng
   ld de, #0xC000
   ld c, _xpng    ;; X
   ld b, _ypng   ;; Y
   call cpct_getScreenPtr_asm
   ld c, _wpng    ;; Width
   ld b, _hpng    ;; Height
   ld de, #_mempng
   call _renderMenuItems
.endm

.macro ITEM_LEVEL_ZEROS
.dw #0
.db #0
.db #0
.dw #0
.dw #0
.endm
