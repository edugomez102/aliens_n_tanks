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

.module Animator
;====================================================================
; includes
;====================================================================
.include "resources/entityInfo.s"
.include "man/entity.h.s"
.include "resources/animations.h.s"
.include "animator.h.s"
.include "sys/render.h.s"

;====================================================================
; FUNCION _sys_animator_update   
; Llama a la inversión de control para updatear las animaciones de cada entidad que coincida con e_type_animator
; NO llega ningun dato
;====================================================================
_sys_animator_update:
    ld hl, #_sys_animator_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x10  ; e_type_animator
    call _man_entityForAllMatching
    ret

;====================================================================
; FUNCION _sys_animator_updateOneEntity   
; Si toca cambiar el sprite de la animacion establece el siguiente sprite como el nuevo y,
; pone tambien el counter de la animacion con la duración del nuevo sprite.
; En caso de que no haya sprite y sea la dirección de memoria de la animacion, 
; resetea la animación y establece los datos como el paso descrito antes.
; HL : Entidad a updatear
;====================================================================
_sys_animator_updateOneEntity:    
   push hl
   pop ix

   call _sys_anim_blink


ret

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;;
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   _sys_anim_blink:
      dec e_animctr(ix)
      jr z, destroy_blinking_entity

      ld a, e_animctr(ix)

      ; TODO se podria mejorar pero cuando >?>
      cp #40
      jr z, blink_no_render_ai
      cp #36
      jr z, blink_reset_render_ai

      cp #32
      jr z, blink_no_render_ai
      cp #28
      jr z, blink_reset_render_ai

      cp #24
      jr z, blink_no_render_ai
      cp #20
      jr z, blink_reset_render_ai

      cp #16
      jr z, blink_no_render_ai
      cp #12
      jr z, blink_reset_render_ai

      cp #8
      jr z, blink_no_render_ai
      cp #4
      jr z, blink_reset_render_ai

      ; cp #0
      ; jr z, blink_no_render_ai
      cp #1
      jr z, blink_reset_render_ai

      ret

      blink_reset_render_ai:
         inc e_cmp(ix)
         ret

      blink_no_render_ai:
         dec e_cmp(ix)

         call _sys_render_erasePrevPtr
         ret

      destroy_blinking_entity:

         ld a, e_cmp(ix)
         sub #e_cmp_animated
         add #e_cmp_render
         ld e_cmp(ix), a

      ret
