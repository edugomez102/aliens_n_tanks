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

.module Patrol_Data

.include "sys/patrol.h.s"
.include "resources/patrol_data.h.s"
.include "resources/templates.h.s"

;===============================================================================
; Regular Patrol
;===============================================================================

; CENTRO: 36, 104
; !! se puede hacer que un patrol redirija  a otro !!
; Esquinas MAX:
;   4, 48
;  70, 48
;   4, 176
;  70, 176


patrol_01:
   .db  8, 56
   .db  36, 56
   .db #patrol_invalid_move
   .dw #patrol_01

patrol_02:
   .db  64, 56
   .db  64, 168
   .db  32, 168
   .db  64, 168
   .db #patrol_invalid_move
   .dw #patrol_02

patrol_03:
   .db  8, 56
   .db  8, 120
   .db #patrol_invalid_move
   .dw #patrol_03

patrol_04:
   .db  20, 56
   .db  20, 156
   .db #patrol_invalid_move
   .dw #patrol_04

patrol_05:
   .db  20, 64
   .db  20, 164
   .db #patrol_invalid_move
   .dw #patrol_05

patrol_06:
   .db  40, 56
   .db  72, 56
   .db  72, 88
   .db  64, 88
   .db #patrol_invalid_move
   .dw #patrol_06

patrol_07:
   .db  28, 80
   .db  28, 48
   .db  70, 48
   .db  70, 128
   .db  46, 128
   .db #patrol_invalid_move
   .dw #patrol_07

patrol_08:
   .db  28, 80
   .db  52, 80
   .db #patrol_invalid_move
   .dw #patrol_08

; estos dos vann junwos
patrol_09:
   .db  70, 176
   .db #patrol_invalid_move
   .dw #patrol_10

patrol_10:
   ; .db  70, 136
   .db   12, 88
   .db   44, 96
   .db   52, 96
   .db   52, 56
   .db   12, 48
   .db #patrol_invalid_move
   .dw #patrol_09

patrol_11:
   .db  4, 56
   .db  4, 108
   .db  22, 56
   .db  22, 108
   .db  22, 56
   .db  4, 108
   .db  4, 56

   .db #patrol_invalid_move
   .dw #patrol_11
   


patrol_none:
   .db  50, 60
   ; .db  20, 80
   .db #patrol_invalid_move
   .dw #patrol_none

patrol_x_50_20:
   .db  50, 50
   .db  20, 50
   .db #patrol_invalid_move
   .dw #patrol_x_50_20

patrol_y_50_120:
   .db  10, 50
   .db  10, 120
   .db #patrol_invalid_move
   .dw #patrol_y_50_120


; m for max
patrol_all_game_zone_00:
   .db   4, 48
   .db  70, 48
   .db  70, 176
   .db   4, 176
   .db #patrol_invalid_move
   .dw #patrol_all_game_zone_00

patrol_all_game_zone_0m:
   .db  70, 48
   .db  70, 176
   .db   4, 176
   .db   4, 48
   .db #patrol_invalid_move
   .dw #patrol_all_game_zone_0m

; i: inverted
patrol_all_game_zone_0m_i:
   .db   4, 48
   .db   4, 176
   .db  70, 176
   .db  70, 48
   .db #patrol_invalid_move
   .dw #patrol_all_game_zone_0m_i

patrol_all_game_zone_mm:
   .db  70, 176
   .db   4, 176
   .db   4, 48
   .db  70, 48
   .db #patrol_invalid_move
   .dw #patrol_all_game_zone_mm

patrol_all_game_zone_m0:
   .db   4, 176
   .db   4, 48
   .db  70, 48
   .db  70, 176
   .db #patrol_invalid_move
   .dw #patrol_all_game_zone_m0

patrol_boss:
   .db  33, 88
   .db  41, 88
   .db  25, 88

   .db  4, 48
   .db  68, 48

   .db  33, 88
   .db  41, 88
   .db  25, 88

   ; .db  4, 48
   ; .db  66, 48

   .db  66, 168

   .db  66, 170
   .db  4, 170
   .db  4, 48

   .db #patrol_invalid_move
   .dw #patrol_boss_2

patrol_boss_2:
   .db  66, 48
   .db  4, 48

   .db  25, 88
   .db  41, 88
   .db  33, 88

   .db  4, 88
   .db  4, 168
   .db  6, 88

   .db  66, 48
   .db  4, 48

   .db  25, 88
   .db  41, 88
   .db  33, 88

   .db  44, 48
   .db  68, 48
   .db  4, 48

   .db #patrol_invalid_move
   .dw #patrol_boss_3
   
patrol_boss_3:
   .db  4, 48

   .db  4, 56
   .db  64, 56

   .db  64, 64
   .db  4, 64

   .db  4, 72
   .db  64, 72

   .db  64, 80
   .db  4, 80

   .db  4, 96
   .db  64, 96

   .db  64, 112
   .db  4, 112

   .db  4, 144
   .db  64, 144

   .db #patrol_invalid_move
   .dw #patrol_boss_3

;=============================================================================== 
; Relative Patrol
;===============================================================================

;; moverse alredeodr de una entidad
patrol_relative_around_01:
   .db  6, -16
   .db  6, 16
   .db  -6, 16
   .db  -6, -16
   .db #patrol_invalid_move
   .dw #patrol_relative_around_01

patrol_relative_around_02:
   .db  4, -8
   .db  4, 12
   .db  -2, 12
   .db  -2, -8
   .db #patrol_invalid_move
   .dw #patrol_relative_around_02

patrol_seeknpatrol_01:
   .db  0, -16
   .db  0, 0
   .db #patrol_invalid_move
   .dw #patrol_seeknpatrol_01

patrol_seeknpatrol_02:
   .db  0, 0
   .db  -12, 0
   .db #patrol_invalid_move
   .dw #patrol_seeknpatrol_02

patrol_seeknpatrol_03:
   .db  0, -32
   .db  0, 0
   .db #patrol_invalid_move
   .dw #patrol_seeknpatrol_03

; ????
patrol_relative_03:
   .db  0, 0
   .db  0, 12
   .db  24, 12
   .db  24, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_03

patrol_relative_none:
   .db  0, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_none


patrol_relative_x_12:
   .db  0, 0
   .db  12, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_x_12

patrol_relative_x_16:
   .db  0, 0
   .db  16, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_x_16

patrol_relative_x_24:
   .db  0, 0
   .db  24, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_x_24

patrol_relative_x_36:
   .db  0, 0
   .db  36, 0
   .db #patrol_invalid_move
   .dw #patrol_relative_x_36

patrol_relative_x_36_around:
   .db  0, 0
   .db  36, 0
   .db  36, 8
   .db  0, 8
   .db #patrol_invalid_move
   .dw #patrol_relative_x_36_around


patrol_relative_y_32:
   .db  0, 0
   .db  0, 32
   .db #patrol_invalid_move
   .dw #patrol_relative_y_32

patrol_relative_y_48:
   .db  0, 0
   .db  0, 48
   .db #patrol_invalid_move
   .dw #patrol_relative_y_48

patrol_relative_y_64:
   .db  0, 0
   .db  0, 64
   .db #patrol_invalid_move
   .dw #patrol_relative_y_64
;===============================================================================
; Spawner Patrol List
;===============================================================================
; !!!! el tamanyo tiene que ser menor que enemy_max_spawn !!!j
; igora el ultimo por eso hay que poner 0000 al final!

spawner_plist_01:
   .dw #t_es_02
   .dw #t_es_01
   .dw #t_es_01
   .dw #t_es_01
   .dw #0x0000
   .db #patrol_invalid_move

; pasa del primero
spawner_plist_02:
   .dw #t_es_03
   .dw #t_es_01
   .dw #t_es_02
   .dw #t_es_03
   .dw #t_es_02
   .dw #0x0000
   .db #patrol_invalid_move

; que saque enemigos que se qeuden alredeodr del spawner
; y otros que vayan a hacer un patrol o un seeknpatrol
spawner_plist_03:
   .dw #t_enemy_patrol_game_zone
   .dw #t_enemy_patrol_game_zone_i
   .dw #t_enemy_seeknpatrol
   .dw #0x0000
   .dw #patrol_invalid_move

spawner_plist_04:
   .dw #t_es_06
   .dw #t_enemy_seeknpatrol
   .dw #t_es_06
   .dw #t_enemy_seeknpatrol
   .dw #0x0000
   .dw #patrol_invalid_move

spawner_plist_05:
   .dw #t_es_04
   .dw #t_es_06
   .dw #t_es_07
   .dw #t_es_06
   .dw #t_es_04

   .dw #t_es_07
   .dw #t_es_07
   .dw #t_es_07
   .dw #t_es_07
   .dw #0x0000
   .dw #patrol_invalid_move

; 08 es seeknpatrol
spawner_plist_06:
   .dw #t_es_06
   .dw #t_es_08
   .dw #t_es_08
   .dw #t_es_07
   .dw #t_es_08
   .dw #t_es_07
   .dw #t_es_08
   .dw #t_es_07

   .dw #0x0000
   .dw #patrol_invalid_move


