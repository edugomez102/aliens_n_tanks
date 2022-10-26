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

;===================================================================================================================================================
; Levels
;===================================================================================================================================================
.globl _level1

;================================================================================
; Esquema de enemigos
;================================================================================

;; Esquema behaviour follow
; .db #level_new_entity
; .dw #t_enemy_basic
; .db #45
; .db #60
; .dw #_sys_ai_beh_follow_player_y
; ;; si es un timer realmente puede ser cualquier valor
; .db #t_follow_timer
; .db #t_follow_timer
; .dw #patrol_x_50_20
; .dw #_sys_ai_beh_shoot_x_f

;; Esquema patrol relative
; .db #level_new_entity
; .dw #t_enemy_patrol_01
; .db #40
; .db #90
; .dw #_sys_ai_behaviourPatrolRelative
; .db #40
; .db #90                                 ; e_ai_aux_h
; .dw #patrol_relative_x_12
; .dw #_sys_ai_beh_shoot_seekplayer
;
;; Esquema spawner
; TODO: hacer templates para los enemigos a spawnear
; .db #level_new_entity
; .dw #t_spawner_template_02
; .db #55
; .db #90
; .dw #_sys_ai_behaviourSpawner_template
; .db #00                                 ; e_ai_aux_l
; .db #00                                 ; e_ai_aux_h
; .dw #t_enemy_patrol_01
; .dw #enemy_no_shoot
;
; Esquema seeknpatrol
; .db #level_new_entity
; .dw #t_enemy_seeknpatrol
; .db #45
; .db #60
; .dw #_sys_ai_behaviourSeekAndPatrol
; .db #t_follow_timer
; .db #t_follow_timer
; ; .dw #patrol_relative_none
; .dw #patrol_seeknpatrol_01
; .dw #_sys_ai_beh_shoot_xy_rand


; ;; spaner bichong
; .db #level_new_entity
; .dw #t_spawner_from_template_02
; .db #55
; .db #90
; .dw #_sys_ai_behaviourSpawner_plist
; .db #00                                 ; e_ai_aux_l
; .db #00                                 ; e_ai_aux_h
; ; .dw #t_enemy_testing
; .dw #spawner_plist_02
; .dw #enemy_no_shoot
