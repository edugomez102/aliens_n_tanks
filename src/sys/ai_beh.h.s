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


.globl _sys_ai_behaviourBullet
.globl _sys_ai_behaviourBulletLinear
.globl _sys_ai_behaviourBulletSeektoPlayer

.globl enemy_no_move

.globl _sys_ai_behaviourPatrol
.globl _sys_ai_behaviourPatrol_f
.globl _sys_ai_behaviourPatrolRelative
.globl _sys_ai_behaviourPatrolRelative_f
.globl _sys_ai_behaviourSeekAndPatrol
.globl _sys_ai_behaviourSeekAndPatrol_f

.globl _sys_ai_behaviourSpawner_plist
.globl _sys_ai_behaviourSpawner_template
.globl _sys_ai_behaviourSpawner_template_f


.globl _sys_ai_beh_follow_player_x
.globl _sys_ai_beh_follow_player_y
.globl _sys_ai_beh_follow_player_x_f
.globl _sys_ai_beh_follow_player_y_f


.globl _sys_ai_beh_shoot_seekplayer

.globl _sys_ai_beh_shoot_x
.globl _sys_ai_beh_shoot_y
.globl _sys_ai_beh_shoot_xy_rand

.globl _sys_ai_beh_shoot_x_f
.globl _sys_ai_beh_shoot_y_f
.globl _sys_ai_beh_shoot_xy_rand_f

.globl _sys_ai_beh_shoot_d
.globl _sys_ai_beh_shoot_d_f

.globl _sys_ai_prepare_ovni_die
.globl _sys_ai_restore_spawn

.globl _sys_ai_beh_ingame_shield
.globl _sys_ai_beh_ingame_rotator

.globl _sys_ai_beh_boss_move
.globl _sys_ai_beh_boss_shoot
