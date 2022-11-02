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

.module Collision
;====================================================================
; includes
;====================================================================
.include "resources/entityInfo.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"
.include "sys/render.h.s"
.include "cpctelera.h.s"
.include "collision.h.s"
.include "ai.h.s"
.include "assets/maps/map01.h.s"
.include "resources/macros.s"
.include "sys/ai_beh.h.s"
.include "man/HUD.h.s"
.include "resources/templates.h.s"
.include "sys/ai.h.s"
.include "sys/ai_beh.h.s"


;;Math
.include "macros/math.h.s"

;====================================================================
; Manager data   
;====================================================================
;; Punto 1 de la colision de la entidad
_sys_entityColisionPos1_X:
    .ds 1

_sys_entityColisionPos1_Y:
    .ds 1

;; Punto 2 de la colision de la entidad
_sys_entityColisionPos2_X:
    .ds 1

_sys_entityColisionPos2_Y:
    .ds 1

_sys_entityArray:
    .dw #0x0000

_sys_numEntities:
    .ds 1

_sys_sizeOfEntity:
    .ds 1    
;====================================================================
; FUNCION _sys_collision_update
; Llama a varias etiquetas para updatear las colisiones
; NO llega ningun dato
;====================================================================
_sys_collision_update:

    call _sys_checkColissionBwEntities
    call _sys_checkColissionBwTile

ret


;====================================================================
; FUNCION _sys_checkColissionBwEntities
; Setea las variables para comprobar la colision entre todas las entidades
; NO llega ningun dato
;====================================================================
_sys_checkColissionBwEntities:
    ld hl, #_m_entities
    ld (#_sys_entityArray), hl
    ld a, (#_m_numEntities)
    ld (#_sys_numEntities), a
    ld a, (#_m_sizeOfEntity)
    ld (#_sys_sizeOfEntity), a

    ;;Call forAllMatching to check all the entities
    ld hl, #_sys_collision_updateMultiple
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x20  ; e_cmp_collider = #0x20
    call _man_entityForAllMatching
ret


;====================================================================
; FUNCION _sys_checkColissionBwTile
; Comprueba la colision de los type colisionables con el tile del mapa
; NO llega ningun dato
;====================================================================
_sys_checkColissionBwTile:
    ld hl, #_sys_collision_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x40  ; e_cmp_collider_tilemap = #0x40
    call _man_entityForAllMatching
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  - IX: should contain the entity's memory direction we want to know 
;;        if its colliding with something
;;	- HL: should contain the entity array memory address
;; Objetive: Check if some player is colliding with something he can
;;           collide with.
;;
;; Modifies: -
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
check_player_collision:
    ;;First we load the entity array in IY
    ld hl, (#_sys_entityArray)
    ld__iy_hl

    loop_entities_player_collision:
        IS_ENTITY_GIVEN_TYPE_IY e_type_enemy_bullet
        jr nz, check_colliding_to_death_player_collision

        IS_ENTITY_GIVEN_TYPE_IY e_type_enemy
        jr nz, check_colliding_to_death_player_collision

        IS_ENTITY_GIVEN_TYPE_IY e_type_item
        jr nz, check_colliding_to_item_player_collision

        IS_ENTITY_GIVEN_TYPE_IY e_type_bullet
        jr nz, check_colliding_to_axe_player_collision

        jr increment_next_entity_player_collision

    check_colliding_to_death_player_collision:
      ; si esta blink jr a increment_next_entity_player_collision
      ld a, e_animctr(ix)
      or a
      jr nz, increment_next_entity_player_collision

        call _sys_collisionEntity_check
        jr c, increment_next_entity_player_collision

        push iy
        ld__iy_ix
        call _man_game_decreasePlayerLife
        pop iy
        jr increment_next_entity_player_collision

    check_colliding_to_item_player_collision:
        call _sys_collisionEntity_check
        jr c, increment_next_entity_player_collision

        call _man_game_getItem
        jr increment_next_entity_player_collision
    
    check_colliding_to_axe_player_collision:
        ;;Check if we can get the axe
        ld a, e_ai_aux_l(ix)
        cp #2
        jp nz, increment_next_entity_player_collision

        ;;Check if the high value of the player's axe is the same as the iy axe
        ld b, e_patrol_step_h(ix)
        ld__a_iyh
        cp b
        jp nz, increment_next_entity_player_collision

        ;;Check if the low value of the player's axe is the same as the iy axe
        ld b, e_patrol_step_l(ix)
        ld__a_iyl
        cp b
        jp nz, increment_next_entity_player_collision

        ;;If is the same we can get the axe so we check the collision
        call _sys_collisionEntity_check
        jp c, increment_next_entity_player_collision

        ;;Make the axe return to the player
        push ix
        push iy
        ld__hl_ix
        ld__ix_iy
        ld__iy_hl
        call sys_ai_axe_set_follow
        pop iy
        pop ix

    increment_next_entity_player_collision:
        ld bc, #0x0000
        ld a, (#_sys_sizeOfEntity)
        ld c, a
        add iy, bc

        ;;Here check if we don't have more entities to loop
        ld__hl_iy
        ld a, (hl)
        or a, a
        ret z

        jp loop_entities_player_collision
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  - IX: should contain the entity's memory direction we want to know 
;;        if its colliding with something
;;	- HL: should contain the entity array memory address
;; Objetive: Check if some enemy is colliding with something he can
;;           collide with.
;;
;; Modifies: -
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
check_enemy_collision:
    ;;First we load the entity array in IY
    ld hl, (#_sys_entityArray)
    ld__iy_hl

    loop_entities_enemy_collision:
        IS_ENTITY_GIVEN_TYPE_IY e_type_bullet
        jr nz, check_colliding_to_death_enemy_collision

        jr increment_next_entity_enemy_collision

    check_colliding_to_death_enemy_collision:
        call _sys_collisionEntity_check
        jr c, increment_next_entity_enemy_collision

        ld__hl_ix
        call _sys_ai_prepare_enemy_die
        ret

    increment_next_entity_enemy_collision:
        ld bc, #0x0000
        ld a, (#_sys_sizeOfEntity)
        ld c, a
        add iy, bc

        ;;Here check if we don't have more entities to loop
        ld__hl_iy
        ld a, (hl)
        or a, a
        ret z

        jr loop_entities_enemy_collision
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  - IX: should contain the entity's memory direction we want to know 
;;        if its colliding with something
;;	- HL: should contain the entity array memory address
;; Objetive: Check if some enemy is colliding with something he can
;;           collide with.
;;
;; Modifies: -
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
check_enemyBullet_collision:
    ;;First we load the entity array in IY
    ld hl, (#_sys_entityArray)
    ld__iy_hl

    loop_entities_enemyBullet_collision:
        IS_ENTITY_GIVEN_TYPE_IY e_type_bullet
        jr nz, check_colliding_to_death_enemyBullet_collision

        jr increment_next_entity_enemyBullet_collision

    check_colliding_to_death_enemyBullet_collision:
        call _sys_collisionEntity_check
        jr c, increment_next_entity_enemyBullet_collision

        ld__hl_ix
        call _m_game_destroyEntity
        ret

    increment_next_entity_enemyBullet_collision:
        ld bc, #0x0000
        ld a, (#_sys_sizeOfEntity)
        ld c, a
        add iy, bc

        ;;Here check if we don't have more entities to loop
        ld__hl_iy
        ld a, (hl)
        or a, a
        ret z

        jr loop_entities_enemyBullet_collision
ret

;====================================================================
; FUNCION _sys_collision_updateMultiple
; Comprueba la colision entre todas las entidades
; NO llega ningun dato
;====================================================================
_sys_collision_updateMultiple:
    ;; Guardamos en "ix" la entidad base a updatear
    ld__ix_hl

    IS_ENTITY_GIVEN_TYPE_IX e_type_player
    jr nz, is_player_type

    IS_ENTITY_GIVEN_TYPE_IX e_type_enemy
    jr nz, is_enemy_type

    IS_ENTITY_GIVEN_TYPE_IX e_type_enemy_bullet
    jr nz, is_enemyBullet_type

    ret

    is_player_type:
        call check_player_collision
        ret
    
    is_enemyBullet_type:
        call check_enemyBullet_collision
        ret

    is_enemy_type:
        call check_enemy_collision
ret

;====================================================================
; FUNCION _sys_collision_updateMultiple
; Comprueba se las entidades realmente colisionan
; NO llega ningun dato
;====================================================================
_sys_collisionEntity_check:
    ;;Check the x axis
    ld  a, e_xpos(ix)
    add a, e_width(ix)
    sub e_xpos(iy)
    ret c
    
    ld  a, e_xpos(iy)
    add a, e_width(iy)
    sub e_xpos(ix)
    ret c


    ;;Check the y axis
    ld a, e_ypos(ix)
    add e_heigth(ix)
    sub e_ypos(iy)
    ret c

    ld a, e_ypos(iy)
    add e_heigth(iy)
    sub e_ypos(ix)
    ret c

ret

;====================================================================
; FUNCION _sys_collision_updateOneEntity
; Comprueba según la orientación si está colisionando con una tile
; HL : Entidad a updatear
;====================================================================
_sys_collision_updateOneEntity:
    push hl
    pop ix

    ;;Check if the entity will surpass the right border if we update it's position
    ld a, e_xpos(ix)
    add a, e_vx(ix)

    IS_HIGHER 0x49
    jr nc, set_vx_zero

    ;;Check if the entity will surpass the left border if we update it's position
    ld a, e_xpos(ix)
    add a, e_vx(ix)

    ld b, #0x04
    cp b
    jr c, set_vx_zero

    ;;Check if the entity will surpass the up border if we update it's position
    check_y_axis:
        ld a, e_ypos(ix)
        add a, e_vy(ix)

        ld b, #0x30
        cp b
        jr c, set_vy_zero

        ld a, e_ypos(ix)
        add a, e_vy(ix)

        IS_HIGHER 0xB6
        jr nc, set_vy_zero

    ret

    set_vx_zero:

        ld e_vx(ix), #0x00

        IS_ENTITY_GIVEN_TYPE_IX e_type_enemy_bullet
        jr nz, delete_bullet

        IS_ENTITY_GIVEN_TYPE_IX e_type_bullet
        jr nz, quit_colliderTilemap_cmp

        jp check_y_axis

    set_vy_zero:

        ld e_vy(ix), #0x00

        IS_ENTITY_GIVEN_TYPE_IX e_type_enemy_bullet
        jr nz, delete_bullet

        IS_ENTITY_GIVEN_TYPE_IX e_type_bullet
        jr nz, quit_colliderTilemap_cmp

        ret
    
    quit_colliderTilemap_cmp:
        ;;Quit the collider tilemap cmp so we don't check it
        ld a, e_cmp(ix)
        sub #e_cmp_colliderTilemap
        ld e_cmp(ix), a

        ;;Set the left time to the axe to zero
        ld e_aictr(ix), #1

        ret

    delete_bullet:
        call _m_game_destroyEntity
        ld h, e_patrol_step_h(ix)
        ld l, e_patrol_step_l(ix)
        ld__ix_hl
        call _sys_ai_reset_shoot_aictr
ret
