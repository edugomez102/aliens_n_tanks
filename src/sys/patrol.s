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

.module Patrol

.include "resources/entityInfo.s"
.include "resources/macros.s"
.include "sys/patrol.h.s"
.include "resources/patrol_data.h.s"
.include "sys/ai.h.s"
.include "sys/ai_beh.h.s"
.include "man/game.h.s"

; por parametro el array a las posociones a las que tiene que hacer patrool
; beh patrol
; beh x right left
; beh y up down
;===============================================================================
; actualiza _sys_ai_nextPatrolCoords y llama a _sys_ai_setAiAim
; IX: entidad
; Destroy: HL
;===============================================================================
_sys_patrol_next::

   ld h, e_patrol_step_h(ix)
   ld l, e_patrol_step_l(ix)

   ld a, (hl)
   cp #patrol_invalid_move
   call z, reset_patrol

   ld d, (hl)
   inc hl
   ld e, (hl)
   ex de, hl

   call _sys_ai_setAiAim

   ex de, hl
   inc hl

   ld e_patrol_step_h(ix), h
   ld e_patrol_step_l(ix), l

   ret

_sys_patrol_next_relative:
   call _sys_patrol_next

   ld h, e_ai_aim_x(ix)
   ld l, e_ai_aim_y(ix)

   ld d, e_ai_aux_h(ix)
   ld e, e_ai_aux_l(ix)

   ld a, h
   add a, e
   ld e_ai_aim_x(ix), a

   ld a, l
   add a, d
   ld e_ai_aim_y(ix), a
   ret

_sys_patrol_next_spawner:
   ld h, e_patrol_step_h(ix)
   ld l, e_patrol_step_l(ix)

   inc hl
   inc hl
   ld e_patrol_step_h(ix), h
   ld e_patrol_step_l(ix), l

   ret

check_next_step:
   ld h, e_patrol_step_h(ix)
   ld l, e_patrol_step_l(ix)
   inc hl
   inc hl
   ld a, (hl)
   cp #patrol_invalid_move

   ret

reset_patrol_spawner:
   inc hl
   ld a, (hl)
   inc hl
   ld h, (hl)

   ld e_patrol_step_l(ix), a
   ld e_patrol_step_h(ix), h
   ret

reset_patrol:
   inc hl
   ld a, (hl)
   inc hl
   ld h, (hl)

   ld e_patrol_step_l(ix), a
   ld e_patrol_step_h(ix), h

   ; actualizamos nuevo para volver a _sys_patrol_next
   ld h, e_patrol_step_h(ix)
   ld l, e_patrol_step_l(ix)

   ret

stop_spawning:
   ; ld hl, #enemy_max_spawn
   ; ld (hl), #1
   ; ld e_cmp(ix), #21
   ; push ix
   ; pop hl
   ; call _m_game_destroyEntity
   ld de, #enemy_no_move
   ld e_aibeh1(ix), e
   ld e_aibeh2(ix), d

   ; hacemos esto porque en cada llamada de spawnEnemy_plist hacemos
   ; un inc primero
   ld hl, #_m_enemyCounter
   dec (hl)
   ld a, #0
   or a

   ret

.globl t_bullet_timer_enemy
;===============================================================================
; Meter en ai_aux la posicion del jugador al hacer el call
; Destroy: BC
; IY: entity to set as origin
; IX: AI
;===============================================================================
_sys_patrol_set_relative_origin:

   ld h, e_xpos(iy)
   ld l, e_ypos(iy)

   ld e_ai_aux_h(ix), l
   ld e_ai_aux_l(ix), h

   ;; TODO: donde va aaa
   ld a, e_ai_aux_h(ix)
   ld e_ai_aux_l(ix), a

   ret

