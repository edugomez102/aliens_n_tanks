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

.module Entity
;===================================================================================================================================================
; includes
;===================================================================================================================================================
.include "resources/macros.s"
.include "resources/entityInfo.s"
.include "resources/sprites.h.s"
.include "resources/animations.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"

;===================================================================================================================================================
; Manager data   
;===================================================================================================================================================
;; Descripcion : Array de entidades
;; TODO: recalcular con los cambios de estructura de entity
_m_entities:
    .ds 448

;; Descripcion : Memoria vacia al final del array para controlar su final
_m_emptyMemCheck:
    .ds 1

;; Descripcion : Direccion de memoria con la siguiente posicion del array libre 
_m_next_free_entity:
    .ds 2

;; Descripcion : Direccion de memoria donde este la funcion de inversion de control
_m_functionMemory:
    .ds 2

;; Descripcion : Signature para comprobar entidades en el forAllMatching 
_m_signatureMatch:
    .ds 1

;; Descripcion : Numero de entidades que caben en el array _m_entities
_m_numEntities:
    .ds 1

;; Descripcion : TAmaño en bytes de 1 entity
_m_sizeOfEntity:
    .db #0x1c


;===================================================================================================================================================
; FUNCION _man_entityInit   
; Inicializa el manager de entidades y sus datos
; NO llega ningun dato
;===================================================================================================================================================
_man_entityInit:
    ld  DE, #_m_entities
    ld  A,  #0x00
    ld  (_m_emptyMemCheck), a
    ld  (_m_numEntities), a
    ld  BC, #0x01C0
    call    cpct_memset_asm
    
    ld  hl, #_m_entities
    ld  (_m_next_free_entity), hl
    
    ret


;===================================================================================================================================================
; FUNCION _man_createEntity   
; Crea una entidad
; NO llega ningun dato
;===================================================================================================================================================
_man_createEntity:
    ld  de, (_m_next_free_entity)
    ld  h, #0x00

    LOAD_VARIABLE_IN_REGISTER _m_sizeOfEntity, l

    add hl,de
    ld  (_m_next_free_entity),hl
    ld  hl, #_m_numEntities
    inc (hl)

    ld  l,e
    ld  h,d
    ret



;===================================================================================================================================================
; FUNCION _man_entityForAllMatching
; Ejecuta la funcion  de _m_functionMemory por cada entidad que cumpla con el tipo designado en  _m_signatureMatch
; NO llega ningun dato
;===================================================================================================================================================
_man_entityForAllMatching:
    ld  hl, #_m_entities
    
    ld  a,(hl)
    
    or a,a
    ret Z
    push hl
    jp checkSignature
    not_invalid2:
        pop hl
        push hl
        ld ix, #next_entity2
        push ix

        ld ix, (#_m_functionMemory)
        jp (ix)

        next_entity2:
        pop hl
        ld  a, (#_m_sizeOfEntity)
        ld  c, a
        ld  b, #0x00

        add hl,bc
        push hl
        ld  a,(hl)
        or a,a 
        jr  Z, allDone
        checkSignature:
        ld a,(#_m_signatureMatch)
        inc hl
        and (hl)
        ld hl , #_m_signatureMatch
        sub (hl)
        jr Z, not_invalid2
        jp next_entity2
    allDone:
    pop hl
    ret


;===================================================================================================================================================
; FUNCION _man_setEntity4Destroy
; Establece la entidad para ser destruida
; HL : La entidad para ser marcada
;===================================================================================================================================================
_man_setEntity4Destroy:
   ; ld (hl), #e_type_dead
    ld a, #0x80
    or (hl)
    ld (hl),a
ret

;===================================================================================================================================================
; FUNCION _man_entityDestroy
; Elimina de las entidades la entidad de HL y arregla el array de entidades 
; para establecer la ultima entidad al espacio liberado por la entidad destruida 
; HL : La entidad para ser destruida
;===================================================================================================================================================
_man_entityDestroy:
    ;; HL = _m_next_free_entity
    ;; DE = entity to destroy
    ld de, (#_m_next_free_entity)
    ex de, hl

    ;; Buscamos la ultima entidad
    ld  a, (#_m_sizeOfEntity)
    setLast:
        dec hl
        dec a
        jr NZ, setLast
    ;; de = e && hl = last

    ;;Comprobamos que la ultima entidad libre y la entidad a destruir no sea la misma
    ;;if( e != last)
    ld a, e
    sub l
    jr Z, checkMemory

    jr copy
    checkMemory:
    ld a,d
    sub h
    jr Z, no_copy 

    ;;Si no es la misma copiamos la ultima entidad al espacio de la entidad a destruir
    copy:
    ; cpct_memcpy(e,last,sizeof(Entity_t));
    ld b, #0x00
    ld  a, (#_m_sizeOfEntity)
    ld c, a
    call cpct_memcpy_asm

    ;;Volvemos a asignar a hl el valor de la ultima entity
    ld hl, #_m_next_free_entity
    ld e,(hl)
    inc hl
    ld d,(hl)
    ex de,hl
    ld  a, (#_m_sizeOfEntity)
    setLast2:
        dec hl
        dec a
        jr NZ, setLast2


    ;;Aquí liberamos el ultimo espacio del array de entidades y lo seteamos como el proximo espacio libre 
    no_copy:
    ;last->type = e_type_invalid;
    ld (hl),#0x00
    ;m_next_free_entity = last;
    ld de, #_m_next_free_entity
    ex de, hl
    ld (hl), e
    inc hl
    ld (hl), d
    ;    --m_num_entities;      
    ld  hl, #_m_numEntities
    dec (hl)
    ret


;===================================================================================================================================================
; FUNCION _man_entitiesUpdate
; Recorre todas las entidades y destruye las entidades marcadas
; NO llega ningun dato 
;===================================================================================================================================================
_man_entitiesUpdate:
    ld hl, #_m_entities

    inc (hl)
    dec (hl)
    ret Z 
    ld a, (#_m_sizeOfEntity)
    ld c, a
    ld b, #0x00    
    ld a, #0x80    
    valid:
        and (hl)
        jr Z, _next_entity
        jr NZ, _man_entityDestroy
        jr continue

        _next_entity:
            add hl, bc
        continue:
            ld a, #0x80
            inc (hl)
            dec (hl)
            jr NZ, valid
    ret


;===================================================================================================================================================
; FUNCION _man_entity_freeSpace
; Devuelve en a si hay espacio libre en las entidades para poder generar
; NO llega ningun dato 
;===================================================================================================================================================
; _man_entity_freeSpace:
        ; ld hl, #_m_numEntities
        ; ld a, (#_m_numEntities)
        ; sub (hl)
    ; ret



;===================================================================================================================================================
; FUNCION _man_entityUpdate
; Encargado de updatear las entidades y al jugador
; NO llega ningun dato 
;===================================================================================================================================================
_man_entityUpdate:
    call _man_entitiesUpdate
    call _man_playerUpdate
    ret



;===================================================================================================================================================
; FUNCION _man_playerUpdate
; Actualiza el sprite del jugador en funcion de su orientacion
; NO llega ningun dato 
;===================================================================================================================================================
_man_playerUpdate:
    ;; Actualiza el cooldown de la bala
    call _man_playerBulletCooldown
    
    ld ix, #_m_playerEntity
    
    ld h, (ix)
    inc ix
    ld l, (ix)
    push hl
    pop ix

    ld a, e_orient(ix)
    sub e_prorient(ix)
    ret Z

    ld a,   e_orient(ix)
    ld e_prorient(ix), a

    dec a ;Si vale 0 se irá a -1 y por lo tanto llegará al último jr
    jr Z, setYDownAxis
    dec a
    jr Z, setXLeftAxis
    dec a
    jr Z, setYUpAxis
    jr NZ, setXRightAxis

    setXRightAxis:
        ld hl, #_man_anim_player_x_right
        ld e_anim2(ix), h
        ld e_anim1(ix), l
        ld hl, #_tanque_0
        jp setSprite
    setYUpAxis:    
        ld hl, #_man_anim_player_y_up
        ld e_anim2(ix), h
        ld e_anim1(ix), l
        ld hl, #_tanque_1
        jp setSprite

    setXLeftAxis:
        ld hl, #_man_anim_player_x_left
        ld e_anim2(ix), h
        ld e_anim1(ix), l
        ld hl, #_tanque_4
        jp setSprite

    setYDownAxis:    
        ld hl, #_man_anim_player_y_down
        ld e_anim2(ix), h
        ld e_anim1(ix), l
        ld hl, #_tanque_5
    
    setSprite:
    ld e_sprite2(ix), h
    ld e_sprite1(ix), l
    ld e_animctr(ix), #0x0A

    ret


;===================================================================================================================================================
; FUNCION _man_playerBulletCooldown
; Descuenta el cooldown de la bala
; NO llega ningun dato 
;===================================================================================================================================================
_man_playerBulletCooldown:
    ld ix, #_m_playerEntity
    
    ld h, (ix)
    inc ix
    ld l, (ix)
    push hl
    pop ix

    ;; Comprueba si el player ha disparado
    ld a, e_aictr(ix)
    ld b, #0x00
    sub b
    jp z, _stopCheckCooldown ;; Si es 0 (no hay cooldown)

    ld a, e_aictr(ix)
    dec a
    ld e_aictr(ix), a

    _stopCheckCooldown:

ret

_man_getEntityArray:
      ld hl, #_m_entities
ret

_man_getNumEntities:
      ld hl, #_m_numEntities
ret

_man_getSizeOfEntity:
      ld hl, #_m_sizeOfEntity
ret
