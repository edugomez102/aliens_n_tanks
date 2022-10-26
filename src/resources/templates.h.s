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

;================================================================================
; Globals
;================================================================================
.globl t_shoot_timer_enemy
.globl t_shoot_timer_enemy_r_l
.globl t_shoot_timer_enemy_r_h
.globl t_shoot_timer_tile_collision

.globl t_bullet_timer_enemy
.globl player_max_bullets

.globl t_bullet_player
.globl t_bullet_enemy_sp
.globl t_bullet_enemy_l
.globl t_bullet_enemy_l_f


.globl t_follow_timer
.globl t_follow_timer_f
.globl t_spawner_timer
.globl enemy_no_shoot

;================================================================================
; Template declaration
;================================================================================

.globl t_player

.globl t_enemy_basic_green
.globl t_enemy_basic_blue
.globl t_enemy_basic_purple
.globl t_enemy_basic_red
.globl t_final_boss

.globl t_enemy_patrol_game_zone
.globl t_enemy_patrol_game_zone_i

.globl t_enemy_patrol_relative_01
.globl t_enemy_patrol_relative_02
.globl t_enemy_seeknpatrol
.globl t_enemy_seeknpatrol_02
.globl t_enemy_patrol_01
.globl t_enemy_patrol_x_shoot_y

.globl t_spawner_from_template_01
.globl t_spawner_from_template_02
.globl t_spawner_from_plist_01


.globl t_bullet_vel_x
.globl t_bullet_vel_y

.globl t_bullet_vel_x_f
.globl t_bullet_vel_y_f
.globl free_item


.globl t_es_01
.globl t_es_02
.globl t_es_03
.globl t_es_04
.globl t_es_05
.globl t_es_06
.globl t_es_07
.globl t_es_08
.globl t_es_09

.globl t_enemy_testing
.globl t_enemy_testing2

.globl t_item_heart
.globl t_item_heart_free
.globl t_item_shield
.globl t_item_skip
.globl t_item_skip_to_boss
.globl t_item_restart
.globl t_item_speed_bullet
.globl t_item_rotator
.globl t_item_sharp_bullet

.globl t_ingame_shield
.globl t_ingame_rotator
