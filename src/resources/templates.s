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

.module Templates

.include "sys/ai.h.s"
.include "sys/ai_beh.h.s"
.include "sys/patrol.h.s"
.include "resources/patrol_data.h.s"
.include "animations.h.s"
.include "resources/sprites.h.s"
.include "templates.h.s"
.include "entityInfo.s"
.include "sys/items.h.s"

; tiempo hasta que un enemy dispara
t_shoot_timer_enemy_s = 38
t_shoot_timer_enemy = 70
; r for range
t_shoot_timer_enemy_r_l = 54
t_shoot_timer_enemy_r_h = 96

; tiempo de espera hasta disparar despues de bala tile colision
t_shoot_timer_tile_collision = 28

; tiempo hasta que la bala de un enemy se destruye
t_bullet_timer_enemy = 120
; fast
t_bullet_timer_enemy_f = 60

; tiempo hasta que la bala del player se destruye
t_bullet_timer_player = 27

t_spawner_timer = 45

player_max_bullets = 1

; behaviours tipo follow in axis
t_follow_timer = 20
t_follow_timer_f = 1

; vidas de spaner
t_spawner_max_hp = 3

; ai_aux_l
t_bullet_vel_x = 1
; ai_aux_h
t_bullet_vel_y = 2

; ai_aux_l
t_bullet_vel_x_f = 2
; ai_aux_h
t_bullet_vel_y_f = 4

t_bullet_vel_x_ff = 3
t_bullet_vel_y_ff = 5

t_enemy_vx = 1
t_enemy_vy = 2

t_enemy_vx_f = 2
t_enemy_vy_f = 4


enemy_no_shoot = 0x0000

free_item = 0

;===================================================================================================================================================
; Templates
;===================================================================================================================================================
t_player:
   .db #e_type_player
   .db #0x37                                 ; cmp
   .db #0x26                                 ; x
   .db #0xa0                                 ; y
   .db #0x04                                 ; width
   .db #0x0C                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_tanque_0                            ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0x0000                               ; ai_behaviour
   .db #0x00                                 ; ai_counter
   .dw #_man_anim_player_x_right             ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .dw #0x0000                               ; ai_aim_position
   .db #player_max_bullets                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h

; w 12 ;6
; h 16 ;16
t_enemy_basic_green:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_green_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #enemy_no_move                                    ; ai_behaviour
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_green                                  ; animator
   .db #0x01                                  ; anim. counter
   .dw #enemy_no_shoot                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #0                                    ; patrol_step

t_enemy_basic_blue:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_blue_0                      ; sprite
   .db #0x00                                 ; orientation   
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #enemy_no_move                                    ; ai_behaviour
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_blue                                  ; animator
   .db #0x01                                  ; anim. counter
   .dw #enemy_no_shoot                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #0                                    ; patrol_step

t_enemy_basic_purple:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_purple_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #enemy_no_move                                    ; ai_behaviour
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_purple                                  ; animator
   .db #0x01                                  ; anim. counter
   .dw #enemy_no_shoot                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #0                                    ; patrol_step

t_enemy_basic_red:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_red_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #enemy_no_move                                    ; ai_behaviour
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_red                                  ; animator
   .db #0x01                                  ; anim. counter
   .dw #enemy_no_shoot                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #patrol_seeknpatrol_01                                    ; patrol_step


; anim counter : life
t_final_boss:
   .db #e_type_enemy                         ; type
   .db #0x2b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #10                                    ; width
   .db #22                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   ; .dw #_final_boss                      ; sprite
   .dw #_final_boss_09                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #enemy_no_move                                    ; ai_behaviour
   .db #t_shoot_timer_enemy_s
   .dw #0                                  ; animator
   .db #10                                  ; anim. counter
   .dw #enemy_no_shoot                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #0                                    ; patrol_step

t_enemy_seeknpatrol:
   .db #e_type_enemy                                 ; type
   .db #0x3b                                 ; cmp
   .db #00                                 ; x
   .db #00                                 ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_ovni_red_0                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSeekAndPatrol              ; ai_behaviour
   .db #t_shoot_timer_enemy_s                                 ; ai_counter
   .dw #_man_anim_enemy_red                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0                                 ; e_ai_aim_x
   .db #0                                 ; e_ai_aim_y
   .db #t_follow_timer                                 ; e_ai_aux_l
   .db #t_follow_timer                                 ; e_ai_aux_h
   .dw #patrol_seeknpatrol_01

t_enemy_seeknpatrol_02:
   .db #e_type_enemy                                 ; type
   .db #0x3b                                 ; cmp
   .db #00                                 ; x
   .db #00                                 ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_ovni_red_0                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSeekAndPatrol              ; ai_behaviour
   .db #t_shoot_timer_enemy_s                                 ; ai_counter
   .dw #_man_anim_enemy_red                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0                                 ; e_ai_aim_x
   .db #0                                 ; e_ai_aim_y
   .db #t_follow_timer                                 ; e_ai_aux_l
   .db #t_follow_timer                                 ; e_ai_aux_h
   .dw #patrol_seeknpatrol_02

t_enemy_patrol_game_zone:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_purple_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol      ; ai_behaviour
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_purple                                  ; animator
   .db #0x0                                  ; anim. counter
   .dw #_sys_ai_beh_shoot_seekplayer                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #patrol_all_game_zone_0m                                    ; patrol_step

t_enemy_patrol_game_zone_i:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_purple_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol      ; ai_behaviour
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_purple                                  ; animator
   .db #0x0                                  ; anim. counter
   .dw #_sys_ai_beh_shoot_seekplayer                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #patrol_all_game_zone_0m_i                                    ; patrol_step

;================================================================================
; SPAWNER
;================================================================================

; es como un enemy raealmente
; template porque genera entidades de un template !!
t_spawner_from_template_01:
   .db #e_type_spawner
   .db #0x0b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #6                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_ovni_portal_0                      ; sprite
   .db #t_spawner_max_hp                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSpawner_template             ; ai_behaviour
   .db #0x32                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #40                                    ; e_ai_aux_l
   .db #80                                 ; e_ai_aux_h
   .dw #t_enemy_patrol_relative_02

; 36 18
; 16 16
t_spawner_from_template_02:
   .db #e_type_spawner
   .db #0x0b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #6                                   ; width
   .db #16                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_ovni_portal_0                      ; sprite
   .db #t_spawner_max_hp                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSpawner_template             ; ai_behaviour
   .db #0x16                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                 ; e_ai_aux_h
   .dw #t_enemy_patrol_relative_01
   ; .db #0x00                                 ; e_patrol_step_l
   ; .db #0x00                                 ; e_patrol_step_h

t_spawner_from_plist_01:
   .db #e_type_spawner
   .db #0x0b                                 ; cmp
   .db #16                                    ; x
   .db #50                                    ; y
   .db #6                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_ovni_portal_0                      ; sprite
   .db #t_spawner_max_hp                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSpawner_plist             ; ai_behaviour
   .db #0x16                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #spawner_plist_01
   ; .db #0x00                                 ; e_patrol_step_l
   ; .db #0x00                                 ; e_patrol_step_h


;================================================================================
; BULLETS
;================================================================================

t_bullet_player:
   .db #e_type_bullet                                 ; type
   .db #0x3B                                 ; cmp
   .db #0x00                                 ; x
   .db #0x00                                 ; y
   .db #0x03                                 ; width
   .db #0x06                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_vBullet_1                           ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourBullet              ; ai_behaviour
   .db #60                                ; ai_counter   ;; Contador de la bala
   .dw #0x00                                 ; animator
   .db #0x00                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .dw #0x0000                               ; ai_aim_position
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h

;; la bullet del enemey
t_bullet_enemy_sp:
   .db #e_type_enemy_bullet                                 ; type
   .db #0x3B                                 ; cmp
   .db #0x00                                 ; x
   .db #0x00                                 ; y
   .db #02                                 ; width
   .db #06                                 ; heigth
   .db #0x01                                 ; vx
   .db #0x01                                 ; vy
   .dw #_ovni_bullet_0                     ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .dw #0x0000                               ; prevptr
   .db #0x00                                 ; prev. orientation
   .dw #_sys_ai_behaviourBulletSeektoPlayer  ; ai_behaviour
   .db #t_bullet_timer_enemy                 ; ai_counter   ;; Contador de la bala
   .dw #_man_anim_enemy_bullet                                 ; animator
   .db #0x01                                 ; anim. counter
   ; ! si es 1 es tipo sp
   .dw #0x0001                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #t_bullet_vel_x                                  ; e_ai_aux_l
   .db #t_bullet_vel_y                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h

t_bullet_enemy_l:
   .db #e_type_enemy_bullet                                 ; type
   .db #0x3B                                 ; cmp
   .db #50
   .db #150
   .db #02                                 ; width
   .db #06                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_ovni_bullet_0                     ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .dw #0x0000                               ; prevptr
   .db #0x00                                 ; prev. orientation
   .dw #_sys_ai_behaviourBulletLinear; ai_behaviour
   .db #t_bullet_timer_enemy                 ; ai_counter   ;; Contador de la bala
   .dw #_man_anim_enemy_bullet                                 ; animator
   .db #0x01                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #t_bullet_vel_x                                  ; e_ai_aux_l
   .db #t_bullet_vel_y                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h

t_bullet_enemy_l_f:
   .db #e_type_enemy_bullet                                 ; type
   .db #0x3B                                 ; cmp
   .db #50
   .db #150
   .db #02                                 ; width
   .db #06                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_ovni_bullet_0                     ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .dw #0x0000                               ; prevptr
   .db #0x00                                 ; prev. orientation
   .dw #_sys_ai_behaviourBulletLinear; ai_behaviour
   .db #t_bullet_timer_enemy_f                 ; ai_counter   ;; Contador de la bala
   .dw #_man_anim_enemy_bullet                                 ; animator
   .db #0x01                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #t_bullet_vel_x_f                                  ; e_ai_aux_l
   .db #t_bullet_vel_y_f                                 ; e_ai_aux_h
   .db #0x00                                 ; e_patrol_step_l
   .db #0x00                                 ; e_patrol_step_h

;================================================================================
; ENEMY TEMPLATES FOR SPAWNER
;================================================================================
t_es_01:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_blue_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_blue                                  ; animator
   .db #0x1                                  ; anim. counter
   .dw #_sys_ai_beh_shoot_xy_rand                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #patrol_07                                    ; patrol_step

t_es_02:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_purple_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_beh_follow_player_y
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_purple                                  ; animator
   .db #0x1                                  ; anim. counter
   .dw #enemy_no_shoot                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #20                                    ; e_ai_aux_l
   .db #20                                    ; e_ai_aux_h
   .dw #patrol_07                                    ; patrol_step

t_es_03:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_green_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrolRelative_f
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_green                                  ; animator
   .db #0x1                                  ; anim. counter
   .dw #enemy_no_shoot                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #54                                    ; e_ai_aux_l
   .db #80                                    ; e_ai_aux_h
   .dw #patrol_relative_around_01                                    ; patrol_step

t_es_04:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #4                                    ; x
   .db #174                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_blue_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrolRelative
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_blue                  ; animator
   .db #0x1                                  ; anim. counter
   .dw #_sys_ai_beh_shoot_xy_rand                       ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #patrol_09                                    ; patrol_step

t_es_05:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_purple_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_beh_follow_player_y
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_purple                                  ; animator
   .db #0x1                                  ; anim. counter
   .dw #_sys_ai_beh_shoot_d                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #20                                    ; e_ai_aux_l
   .db #20                                    ; e_ai_aux_h
   .dw #patrol_07                                    ; patrol_step

t_es_06:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_blue_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrolRelative_f
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_blue
   .db #0x1                                  ; anim. counter
   .dw #_sys_ai_beh_shoot_seekplayer                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #20                                    ; e_ai_aux_l
   .db #140                                    ; e_ai_aux_h
   .dw #patrol_relative_x_36                                    ; patrol_step

t_es_07:
   .db #e_type_enemy                         ; type
   .db #0x3b                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_ovni_blue_0                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrolRelative
   .db #t_shoot_timer_enemy_s
   .dw #_man_anim_enemy_blue
   .db #0x1                                  ; anim. counter
   .dw #_sys_ai_beh_shoot_d                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #36                                    ; e_ai_aux_l
   .db #108                                    ; e_ai_aux_h
   .dw #patrol_relative_around_01                                    ; patrol_step

t_es_08:
   .db #e_type_enemy                                 ; type
   .db #0x3b                                 ; cmp
   .db #00                                 ; x
   .db #00                                 ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_ovni_red_0                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSeekAndPatrol              ; ai_behaviour
   .db #t_shoot_timer_enemy_s                                 ; ai_counter
   .dw #_man_anim_enemy_red                                  ; animator
   .db #0x01                                 ; anim. counter
   .dw #_sys_ai_beh_shoot_seekplayer                               ; input_behaviour
   .db #0                                 ; e_ai_aim_x
   .db #0                                 ; e_ai_aim_y
   .db #t_follow_timer                                 ; e_ai_aux_l
   .db #t_follow_timer                                 ; e_ai_aux_h
   .dw #patrol_seeknpatrol_03

t_es_09:
   .db #e_type_enemy                                 ; type
   .db #0x3b                                 ; cmp
   .db #00                                 ; x
   .db #00                                 ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_ovni_red_0                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourSeekAndPatrol              ; ai_behaviour
   .db #t_shoot_timer_enemy_s                                 ; ai_counter
   .dw #_man_anim_enemy_red                                  ; animator
   .db #0x01                                 ; anim. counter
   .dw #_sys_ai_beh_shoot_xy_rand_f                               ; input_behaviour
   .db #0                                 ; e_ai_aim_x
   .db #0                                 ; e_ai_aim_y
   .db #t_follow_timer                                 ; e_ai_aux_l
   .db #t_follow_timer                                 ; e_ai_aux_h
   .dw #patrol_seeknpatrol_01

;================================================================================
; TESTING
;================================================================================
t_enemy_testing:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_beh_follow_player_x
   .db #t_shoot_timer_enemy_s
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #_sys_ai_beh_shoot_x                              ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #t_follow_timer                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_x_50_20                            ; e_patrol_step

t_enemy_testing2:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol             ; ai_behaviour
   .db #0x1                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_x_50_20                            ; e_patrol_step

t_enemy_patrol_relative_01:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #100                                    ; x
   .db #100                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrolRelative        ; ai_behaviour
   .db #1
   ; .dw #_sys_ai_behaviourPatrolRelative        ; ai_behaviour
   ; .db #1
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   ;; poner en e_ai_aux mismo valor que position
   ;; para que funcione patrol relativo
   .db #45
   .db #90                                 ; e_ai_aux_h
   .dw #patrol_relative_03
   ; .dw #patrol_relative_x_24

;; simula un escudo !! poner en ai_aux coordenadas iniciales
t_enemy_patrol_relative_02:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #100                                    ; x
   .db #100                                    ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrolRelative        ; ai_behaviour
   .db #1
   ; .dw #_sys_ai_behaviourPatrolRelative        ; ai_behaviour
   ; .db #1
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   ;; poner en e_ai_aux mismo valor que position
   ;; para que funcione patrol relativo
   .db #62
   .db #64                                 ; e_ai_aux_h
   .dw #patrol_relative_around_01


t_enemy_patrol_01:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol; ai_behaviour
   .db #0x1                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x00                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_02                            ; e_patrol_step


;; e_ai_aux_l para decir si dispara en x o en y
t_enemy_patrol_x_shoot_y:
   .db #e_type_enemy                                 ; type
   .db #0x2b                                 ; cmp
   .db #40                                 ; x
   .db #40                                 ; y
   .db #4                                   ; width
   .db #12                                   ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sprite_enemy01                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_behaviourPatrol              ; ai_behaviour
   .db #t_shoot_timer_enemy_s                                 ; ai_counter
   .dw #0x0                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0x0000                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0x02                                 ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #patrol_03                            ; e_patrol_step

;===============================================================================
; Pickable items
;===============================================================================

; e_ai_aim_y: precio item
; animator: funcion que ejecuta al pick
t_item_heart:
   .db #e_type_item                                 ; type
   .db #0x21                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #7                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_heart_item_sprite                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0
   .db #0
   .dw #item_pick_heart                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0                                    ; input_behaviour
   .db #0                                 ; e_ai_aim_x
   .db #8                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #0                                    ; e_patrol_step

t_item_heart_free:
   .db #e_type_item                                 ; type
   .db #0x21                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #7                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_heart_item_free_sprite                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0
   .db #0
   .dw #item_pick_heart                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0                                    ; input_behaviour
   .db #0                                 ; e_ai_aim_x
   .db #free_item                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #0                                    ; e_patrol_step

; TODO cambiar el price en release!
t_item_shield:
   .db #e_type_item                                 ; type
   .db #0x21                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #7                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_shield_item_sprite                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0
   .db #0
   .dw #item_pick_shield                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0                                    ; input_behaviour
   .db #i_id_shield                                 ; e_ai_aim_x
   .db #23                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #0                                    ; e_patrol_step

t_item_restart:
   .db #e_type_item                                 ; type
   .db #0x21                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #7                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_restart_item_sprite                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0
   .db #0
   .dw #item_pick_restart                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0                                    ; input_behaviour
   .db #i_id_restart                                 ; e_ai_aim_x
   .db #3                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #0                                    ; e_patrol_step

t_item_skip:
   .db #e_type_item                                 ; type
   .db #0x21                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #7                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_skip_item_sprite                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0
   .db #0
   .dw #item_pick_skip                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0                                    ; input_behaviour
   .db #i_id_skip                                 ; e_ai_aim_x
   .db #10                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #0                                    ; e_patrol_step

t_item_skip_to_boss:
   .db #e_type_item                                 ; type
   .db #0x21                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #7                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_skip_to_boss_item_sprite                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0
   .db #0
   .dw #item_pick_skip                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0                                    ; input_behaviour
   .db #i_id_skip                                 ; e_ai_aim_x
   .db #free_item                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #0                                    ; e_patrol_step

t_item_speed_bullet:
   .db #e_type_item                                 ; type
   .db #0x21                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #7                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_speed_b_item_sprite                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0
   .db #0
   .dw #item_pick_speed_bullet                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0                                    ; input_behaviour
   .db #i_id_speed_bullet                                 ; e_ai_aim_x
   .db #15                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #0                                    ; e_patrol_step

t_item_rotator:
   .db #e_type_item                                 ; type
   .db #0x21                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #7                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_rotator_item_sprite                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0
   .db #0
   .dw #item_pick_rotator                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0                                    ; input_behaviour
   .db #i_id_rotator                                 ; e_ai_aim_x
   .db #12                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #0                                    ; e_patrol_step

t_item_sharp_bullet:
   .db #e_type_item                                 ; type
   .db #0x21                                 ; cmp
   .db #50                                 ; x
   .db #50                                 ; y
   .db #7                                 ; width
   .db #16                                 ; heigth
   .db #0x00                                 ; vx
   .db #0x00                                 ; vy
   .dw #_sharp_bullet_sprite                      ; sprite
   .db #0x00                                 ; orientation   0 = Right // 1 = Down // 2 = Left // 3 = Up
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #0
   .db #0
   .dw #item_pick_sharp_bullet                                  ; animator
   .db #0x0A                                 ; anim. counter
   .dw #0                                    ; input_behaviour
   .db #i_id_sharp_bullet                                 ; e_ai_aim_x
   .db #25                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0x00                                 ; e_ai_aux_h
   .dw #0                                    ; e_patrol_step

;===============================================================================
; Ingame items
;===============================================================================

; type_bullet puede servir??
t_ingame_shield:
   .db #e_type_bullet                         ; type
   .db #0x2B                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #6                                   ; width
   .db #16                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_shield_ingame_sprite                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_beh_ingame_shield            ; ai_behaviour
   .db #0
   .dw #0                                  ; animator
   .db #0                                  ; anim. counter
   .dw #0                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #0                                    ; patrol_step

; input_behaviour: id de ingame item
t_ingame_rotator:
   .db #e_type_bullet                         ; type
   .db #0x2B                                 ; cmp
   .db #0                                    ; x
   .db #0                                    ; y
   .db #2                                   ; width
   .db #6                                   ; heigth
   .db #0                                    ; vx
   .db #0                                    ; vy
   .dw #_rotator_ingame_sprite                      ; sprite
   .db #0x00                                 ; orientation
   .db #0x00                                 ; prev. orientation
   .dw #0x0000                               ; prevptr
   .dw #_sys_ai_beh_ingame_rotator            ; ai_behaviour
   .db #0
   .dw #0                                  ; animator
   .db #0                                  ; anim. counter
   .dw #i_id_rotator                               ; input_behaviour
   .db #0x00                                 ; e_ai_aim_x
   .db #0x00                                 ; e_ai_aim_y
   .db #0                                    ; e_ai_aux_l
   .db #0                                    ; e_ai_aux_h
   .dw #patrol_relative_around_02                                    ; patrol_step
