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
; HUD Functions Declaration
;================================================================================
.globl _m_HUD_decreaseLife
.globl _m_HUD_increaseLife
.globl _m_HUD_initLifes
.globl _m_HUD_renderLifes
.globl _m_HUD_renderScore
.globl _m_HUD_initHUD
.globl _m_HUD_addPoints
.globl _m_HUD_renderHUD
.globl _m_HUD_resetLevelScore
.globl _m_HUD_saveScore


;================================================================================
; HUD Data Declaration
;================================================================================
.globl _m_HUD_lifeWidth
.globl _m_HUD_lifeHeight
.globl _m_playerScore

.globl _m_HUD_subPoints
