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

.module Animations

.include "resources/sprites.h.s"
.include "animations.h.s"

;===================================================================================================================================================
; Player Animations
;===================================================================================================================================================
_man_anim_player_x_right:
    .db #5
    .dw #_tanque_0
    .db #5
    .dw #_tanque_2
    .db #0x00
    .dw #_man_anim_player_x_right

_man_anim_player_y_up:
    .db #0x05
    .dw #_tanque_1
    .db #0x05
    .dw #_tanque_3
    .db #0x00
    .dw #_man_anim_player_y_up

_man_anim_player_x_left:
    .db #0x05
    .dw #_tanque_4
    .db #0x05
    .dw #_tanque_6
    .db #0x00
    .dw #_man_anim_player_x_left

_man_anim_player_y_down:
    .db #0x05
    .dw #_tanque_5
    .db #0x05
    .dw #_tanque_7
    .db #0x00
    .dw #_man_anim_player_y_down


;===================================================================================================================================================
; Enemy Animations
;===================================================================================================================================================
_man_anim_enemy_green:
    .db #0x0A
    .dw #_ovni_green_0
    .db #0x0A
    .dw #_ovni_green_1
    .db #0x0A
    .dw #_ovni_green_2
    .db #0
    .dw #_man_anim_enemy_green

_man_anim_enemy_blue:
    .db #0x0A
    .dw #_ovni_blue_0
    .db #0x0A
    .dw #_ovni_blue_1
    .db #0x0A
    .dw #_ovni_blue_2
    .db #0
    .dw #_man_anim_enemy_blue

_man_anim_enemy_purple:
    .db #0x0A
    .dw #_ovni_purple_0
    .db #0x0A
    .dw #_ovni_purple_1
    .db #0x0A
    .dw #_ovni_purple_2
    .db #0
    .dw #_man_anim_enemy_purple

_man_anim_enemy_red:
    .db #0x0A
    .dw #_ovni_red_0
    .db #0x0A
    .dw #_ovni_red_1
    .db #0x0A
    .dw #_ovni_red_2
    .db #0
    .dw #_man_anim_enemy_red

_man_anim_exp:
    .db #1
    .dw #_ovni_exp_0
    .db #1
    .dw #_ovni_exp_1
    .db #1
    .dw #_ovni_exp_2
    .db #2
    .dw #_ovni_exp_3
    .db #0
    .dw #_man_anim_exp


;===================================================================================================================================================
; Enemy Bullet Animations
;===================================================================================================================================================
_man_anim_enemy_bullet:
    .db #0x03
    .dw #_ovni_bullet_0
    .db #0x03
    .dw #_ovni_bullet_1
    .db #0
    .dw #_man_anim_enemy_bullet

