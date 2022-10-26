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
;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "resources/entityInfo.s"
.include "man/entity.h.s"
.include "resources/animations.h.s"
.include "animator.h.s"

;===================================================================================================================================================
; FUNCION _sys_animator_update   
; Llama a la inversión de control para updatear las animaciones de cada entidad que coincida con e_type_animator
; NO llega ningun dato
;===================================================================================================================================================
_sys_animator_update:
    ld hl, #_sys_animator_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x10  ; e_type_animator
    call _man_entityForAllMatching
    ret

;===================================================================================================================================================
; FUNCION _sys_animator_updateOneEntity   
; Si toca cambiar el sprite de la animacion establece el siguiente sprite como el nuevo y,
; pone tambien el counter de la animacion con la duración del nuevo sprite.
; En caso de que no haya sprite y sea la dirección de memoria de la animacion, 
; resetea la animación y establece los datos como el paso descrito antes.
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_animator_updateOneEntity:    
    ;/
    ;|Comprobamos comprobamos y decrementamos el valor de anim. counter
    ;\
    push hl
    pop ix
    dec e_animctr(ix)
    ret NZ
    push hl

    ;/
    ;| Cargamos en DE el valor de la animacion de la entidad en este momento
    ;\
    ld d, e_anim2(ix)
    ld e, e_anim1(ix)

    ;/
    ;| Hacemos que DE apunte a la siguiente parte de la animacion
    ;\
    inc de
    inc de
    inc de

    ;/
    ;| Guardamos en la entidad la nueva parte de la animacion
    ;\
    ld e_anim1(ix), e
    ld e_anim2(ix), d

    ex de,hl  ;HL tiene la direccion de la anim

    ;/
    ;| En caso que el valor de la duracion de esta parte de la animacion sea 0,
    ;| cargaremos de nuevo la animacion en la entidad desde el principio
    ;\
    dec (hl)
    inc (hl)
    jr NZ, noRepeatAnim

    ;/
    ;| HL llega apuntando a la nueva parte de la animacion que sabemos que se acaba.
    ;| Así que cargamos el inicio de la animacion en la animacion de la entity
    ;\
    inc hl
    ld e, (hl)
    inc hl
    ld d, (hl)

    ld e_anim2(ix),d
    ld e_anim1(ix),e

    ;/
    ;| Aqui ya está en la Entity asignado el inicio de la anim
    ;\
    noRepeatAnim:
    ;pop hl   ;;Aqui en HL está el inicio de la animacion en la memoria de la entity

    ;/
    ;| Aqui seteamos los valores de la entidad con los 
    ;| valores de la nueva parte de la animacion
    ;\    
    ld h, e_anim2(ix)
    ld l, e_anim1(ix)

    ;/
    ;| El valor del tiempo
    ;\    
    ld a, (hl) ; a = newTIME
    ld e_animctr(ix),a

    ;/
    ;| El valor del sprite
    ;\    
    inc hl
    ld a,(hl)
    ld e_sprite1(ix),a
    inc hl
    ld a,(hl)
    ld e_sprite2(ix),a

    ;/
    ;| Devolvemos el valor de Hl del inicio
    ;\    
    pop hl
   ret
