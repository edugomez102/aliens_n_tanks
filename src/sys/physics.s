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

.module Physics
;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "resources/entityInfo.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"
.include "physics.h.s"

;===================================================================================================================================================
; FUNCION _sys_physics_update
; Llama a la inversión de control para updatear las fisicas de cada entidad que coincida con e_type_movable
; NO llega ningun dato
;===================================================================================================================================================
_sys_physics_update:
    ld hl, #_sys_physics_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x02  ; e_type_movable
    call _man_entityForAllMatching
    ret


;===================================================================================================================================================
; FUNCION _sys_physics_updateOneEntity
; Updatea las posiciones de las entidades en funcion de 
; los valores de sus velocidades
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_physics_updateOneEntity:    
    push hl
    pop ix

    ;; BD = x_pos y_pos
    ld  b, e_xpos(ix) 
    ld  d, e_ypos(ix) 

    ;; CE = x_vel y_vel
    ld  c, e_vx(ix) 
    ld  e, e_vy(ix) 

    ;; A = x_pos + x_vel
    ld a,b
    add a,c
    cp #0x4c
    jr nc, skip_x_increment
    ld e_xpos(ix),a
    skip_x_increment:

    ;; A = y_pos + y_vel
    ld a,d
    add a,e
    cp #0xc2
    jr nc, skip_x_increment
    ld e_ypos(ix),a
    skip_y_increment:

   ret
