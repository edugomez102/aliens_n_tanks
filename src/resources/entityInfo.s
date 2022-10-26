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

.module EntityInfo
;===================================================================================================================================================
; Entity types   
;===================================================================================================================================================
e_type_invalid       = 0x00
e_type_player        = 0x01
e_type_item          = 0x02
e_type_bullet        = 0x04
e_type_enemy         = 0x08
e_type_spawner       = 0x10
e_type_enemy_bullet  = 0x20
e_type_dead          = 0x80

;===================================================================================================================================================
; Component types   
;===================================================================================================================================================
e_cmp_render   = 0x01
e_cmp_movable  = 0x02
e_cmp_input    = 0x04
e_cmp_ai       = 0x08
e_cmp_animated = 0x10
e_cmp_collider = 0x20
; 0x2b

;===================================================================================================================================================
; Entity variables    
;===================================================================================================================================================
e_type      =  0
e_cmp       =  1
e_xpos      =  2
e_ypos      =  3
e_width     =  4
e_heigth    =  5
e_vx        =  6
e_vy        =  7
e_sprite1   =  8
e_sprite2   =  9
e_orient    = 10

e_prorient  = 11
e_prevptr1  = 12
e_prevptr2  = 13
e_aibeh1    = 14
e_aibeh2    = 15
e_aictr     = 16
e_anim1     = 17
e_anim2     = 18
e_animctr   = 19
e_inputbeh1 = 20
e_inputbeh2 = 21

e_ai_aim_x  = 22
e_ai_aim_y  = 23
;; se usa segun el comportamiento
e_ai_aux_l = 24
e_ai_aux_h = 25

e_patrol_step_l = 26
e_patrol_step_h = 27

;================================================================================
; Item id
;================================================================================
i_id_heart        = 0
i_id_skip         = 1
i_id_restart      = 2
i_id_restart      = 3
i_id_speed_bullet = 4
i_id_shield       = 5
i_id_rotator      = 6
i_id_sharp_bullet = 7

;===================================================================================================================================================
; Entity struct       TODO : Investigar si así guay la estruct
;===================================================================================================================================================
; entity:
;    .db #0x00                         ; type
;    .db #0x00                         ; components
;    .db #0x00                         ; x-pos
;    .db #0x00                         ; y-pos
;    .db #0x00                         ; width
;    .db #0x00                         ; heigth
;    .db #0x00                         ; vx
;    .db #0x00                         ; vy
;    .dw #_sprite_spriteExample        ; sprite  
;    .db #0x00                         ; orientation 
;    .dw #_prevptr_prevptrExample      ; prevptr
;    .dw #_man_anim_animExample        ; animator
;    .db #0x00                         ; anim. counter
;    .dw #_sys_ai_behaviourExample     ; ai_behaviour
;    .db #0x00                         ; ai_counter
;    .dw #_sys_
