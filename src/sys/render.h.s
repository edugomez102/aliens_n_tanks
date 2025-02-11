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
; Render Functions Declaration
;================================================================================
.globl _sys_render_renderTileMap
.globl _sys_init_render
.globl _sys_render_update
.globl _m_render_tilemap
.globl _m_render_tileset
.globl _sys_render_renderHUDLifes
.globl _sys_render_renderHUDScore
.globl _renderMenuItems

.globl _sys_render_level_counter_next
.globl _sys_render_level_counter_end

.globl lvl_ctr_sprite_1
.globl lvl_ctr_sprite_2
