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

.module Sprites
.include "sprites.h.s"
.include "resources/entityInfo.s"

_sprite_player01:
   .dw #0x3F3F
   .dw #0x3F3F
   .dw #0x3F3F

   .dw #0x3F3F
   .dw #0x3F3F
   .dw #0x3F3F

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0xFF3F
   .dw #0xFFFF
   .dw #0x3FFF

   .dw #0x3F3F
   .dw #0x3F3F
   .dw #0x3F3F

   .dw #0x3F3F
   .dw #0x3F3F
   .dw #0x3F3F



_sprite_player02:
   .dw #0x3F3F
   .dw #0x3F3F
   .dw #0x3F3F

   .dw #0x3F3F
   .dw #0x3F3F
   .dw #0x3F3F

   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE

   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE

   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE
   
   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE
   
   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE
   
   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE
   
   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE
   
   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE

   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE
   
   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE
   
   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE
   
   .dw #0xEE3F
   .dw #0xEEEE
   .dw #0x3FEE

   .dw #0x3F3F
   .dw #0x3F3F
   .dw #0x3F3F
   
   .dw #0x3F3F
   .dw #0x3F3F
   .dw #0x3F3F

_sprite_bullet01:
   .dw #0x0000
   .dw #0x0000
   .dw #0xFF00
   .dw #0x00FF
   .dw #0xFF00
   .dw #0x00FF
   .dw #0x0000
   .dw #0x0000


_sprite_enemy01:
   .dw #0x0000
   .dw #0x0000
   .dw #0x0000
   .dw #0x0000
   .dw #0x0000
   .dw #0x0000
   .dw #0xbb00
   .dw #0xbbbb
   .dw #0x00bb
   .dw #0xbb00
   .dw #0xbbbb
   .dw #0x00bb
   .dw #0xbb00
   .dw #0xbbbb
   .dw #0x00bb
   .dw #0xbb00
   .dw #0xbbbb
   .dw #0x00bb
   .dw #0xbb00
   .dw #0xbbbb
   .dw #0x00bb
   .dw #0xbb00
   .dw #0xbbbb
   .dw #0x00bb
   .dw #0xbb00
   .dw #0xbbbb
   .dw #0x00bb
   .dw #0xbb00
   .dw #0xbbbb
   .dw #0x00bb
   .dw #0x0000
   .dw #0x0000
   .dw #0x0000
   .dw #0x0000
   .dw #0x0000
   .dw #0x0000

; los jugadores tienen spritelist

avocado_p1_sprite_list:
   .dw #_avocado_p1_sprite_0
   .dw #_avocado_p1_sprite_1
   .dw #_avocado_p1_sprite_2
   .dw #_avocado_p1_sprite_3

avocado_nn_p1_sprite_list:
   .dw #_avocado_nn_p1_sprite_0
   .dw #_avocado_nn_p1_sprite_1
   .dw #_avocado_nn_p1_sprite_2
   .dw #_avocado_nn_p1_sprite_3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Sets sprite of entity from a sprite list and an index
;; Orientation   0 = Right , 1 = Down , 2 = Left , 3 = Up
;;
;; Param A : index in sprite list. starts from 0
;; Param HL: sprite_list
;; Param IY: player dir
;; 
;; Destroy: HL, BC, A
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
update_sprite_from_list:
   cp #0
   jp z, sprite_list_apply

   cp #1
   jp z, sprite_list_index_1

   cp #2
   jp z, sprite_list_index_2

   cp #3
   jp z, sprite_list_index_3

   sprite_list_index_1:
      inc hl
      inc hl
      jp sprite_list_apply

   sprite_list_index_2:
      inc hl
      inc hl
      inc hl
      inc hl
      jp sprite_list_apply

   sprite_list_index_3:
      inc hl
      inc hl
      inc hl
      inc hl
      inc hl
      inc hl
      jp sprite_list_apply

   sprite_list_apply:
      ld b, (hl)
      inc hl
      ld c, (hl)
      ld e_sprite2(iy), c
      ld e_sprite1(iy), b

   ret

