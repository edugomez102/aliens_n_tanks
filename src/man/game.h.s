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
.globl _m_game_createInitTemplate
.globl _m_game_init
.globl _m_game_play
.globl _m_game_destroyEntity
.globl _m_game_bulletDestroyed
.globl _m_game_playerShot
.globl _m_game_StartMenu
.globl _man_game_decreaseEnemyCounter
.globl _man_game_decreasePlayerLife
.globl _man_game_increasePlayerLife
.globl _man_game_getItem
.globl _wait

;================================================================================
; Manager Data
;================================================================================
.globl _m_playerShot
.globl _m_playerEntity

.globl _m_enemyCounter

.globl restartLevel
.globl nextLevel

.globl player_bullet_vel_x
.globl player_bullet_vel_y

.globl player_has_rotator
.globl player_has_shield
.globl player_has_sharp_bullet
.globl player_has_speed_bullet

.globl _m_game_quit_rotator

.globl player_vel_x
.globl player_vel_y
