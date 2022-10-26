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
; Function declaration
;================================================================================
.globl _sys_ai_init
.globl _sys_ai_update
.globl _sys_ai_updateOneEntity
.globl _sys_ai_setAiAim


.globl _sys_ai_decrement_spawner_hp

.globl _sys_ai_shoot_bullet_l_x
.globl _sys_ai_shoot_bullet_l_y
.globl _sys_ai_shoot_bullet_l_xy_rand

.globl _sys_ai_shoot_bullet_l_x_f
.globl _sys_ai_shoot_bullet_l_y_f
.globl _sys_ai_shoot_bullet_l_xy_rand_f

.globl _sys_ai_shoot_bullet_l_d
.globl _sys_ai_shoot_bullet_l_d_f

; .globl _sys_ai_shootBulletLinear
.globl _sys_ai_shootBulletSeek


.globl _sys_ai_seekCoords_x
.globl _sys_ai_seekCoords_y

.globl _sys_ai_spawnEnemy_template
.globl _sys_ai_spawnEnemy_plist

.globl _sys_ai_reset_shoot_aictr
.globl _sys_ai_aim_to_entity


.globl _sys_ai_random_0_1

;================================================================================
; Manger Data
;================================================================================
.globl _sys_ai_directionMemory
.globl enemy_max_spawn


.globl _sys_ai_changeBevaviour
.globl _sys_ai_restore_spawn
.globl _sys_ai_prepare_spawn

.globl decrease_boss_hp
