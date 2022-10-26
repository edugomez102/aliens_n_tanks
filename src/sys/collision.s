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
;===================================================================================================================================================
; includes
;===================================================================================================================================================
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

;===================================================================================================================================================
; Manager data   
;===================================================================================================================================================
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
;===================================================================================================================================================
; FUNCION _sys_collision_update
; Llama a varias etiquetas para updatear las colisiones
; NO llega ningun dato
;===================================================================================================================================================
_sys_collision_update:

    call _sys_checkColissionBwEntities
    call _sys_checkColissionBwTile

    ret


;===================================================================================================================================================
; FUNCION _sys_checkColissionBwEntities
; Setea las variables para comprobar la colision entre todas las entidades
; NO llega ningun dato
;===================================================================================================================================================
_sys_checkColissionBwEntities:
    ld hl, #_m_entities
    ld (#_sys_entityArray), hl
    ld a, (#_m_numEntities)
    ld (#_sys_numEntities), a
    ld a, (#_m_sizeOfEntity)
    ld (#_sys_sizeOfEntity), a
    call _sys_collision_updateMultiple
ret


;===================================================================================================================================================
; FUNCION _sys_checkColissionBwTile
; Comprueba la colision de los type colisionables con el tile del mapa
; NO llega ningun dato
;===================================================================================================================================================
_sys_checkColissionBwTile:
    ld hl, #_sys_collision_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x21  ; e_type_movable | e_cmp_collider = #0x21
    call _man_entityForAllMatching
ret


;===================================================================================================================================================
; FUNCION _sys_collision_updateMultiple
; Comprueba la colision entre todas las entidades
; NO llega ningun dato
;===================================================================================================================================================
_sys_collision_updateMultiple:
    ;; Guardamos en "ix" la entidad base a updatear
    ld hl, (#_sys_entityArray)
    push hl
    pop ix
    ld d, h
    ld e, l

    ; ld a, e_cmp(ix)
    ; and #e_cmp_collider
    ; cp #e_cmp_collider
    ; jp z, _next_ix

    jp _next_iy

    _next_ix:
        ;; NO PONGO EL MACRO PORQUE NO ME DEJA EL DESGRACIADO
        ld a, (#_sys_sizeOfEntity)
        ld e, a
        ld d, #0
        add hl, de

    push hl
    pop ix
    ld d, h
    ld e, l

    ld a, (de)
    inc a
    dec a
    ret z

    ;; Se pasa a la siguiente entidad para iy
    _next_iy:
    INCREMENT_REGISTER_DE (#_sys_sizeOfEntity)

    ld a, (de)
    inc a
    dec a
    jr z, _jumpNext

    push de
    pop iy

    ld a, e_type(iy)

    call _sys_collisionEntity_check
    jr c, _no_collision

    push de
    push hl

    ld a, #0x01
    and e_type(ix)
    call NZ, playerCollisionBehaviour

    ld a, #0x04
    and e_type(ix)
    call NZ, bulletCollisionBehaviour

    ld a, #0x08
    and e_type(ix)
    call NZ, enemyCollisionBehaviour

    ld a, #0x10
    and e_type(ix)
    call NZ, enemySpawnerCollisionBehaviour

    ld a, #0x20
    and e_type(ix)
    call NZ, enemyBulletCollisionBehaviour
    
    pop hl
    pop de


    jr _next_iy
    
    _no_collision:
    jr _next_iy

    _jumpNext:
        jp _next_ix
ret

;===================================================================================================================================================
; FUNCION _sys_collision_updateMultiple
; Comprueba se las entidades realmente colisionan
; NO llega ningun dato
;===================================================================================================================================================
_sys_collisionEntity_check:
    
    ld a, e_xpos(ix)
    ; sub #player_vel_x
    add e_width(ix)
    sub e_xpos(iy)
    ret c

    ld a, e_xpos(iy)
    ; sub #player_vel_x
    add e_width(iy)
    sub e_xpos(ix)
    ret c


    ld a, e_ypos(ix)
    add e_heigth(ix)
    sub e_ypos(iy)
    ret c

    ld a, e_ypos(iy)
    add e_heigth(iy)
    sub e_ypos(ix)
    ret c

ret

;===================================================================================================================================================
; FUNCION _sys_collision_updateOneEntity
; Comprueba según la orientación si está colisionando con una tile
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_collision_updateOneEntity:
    push hl
    pop ix

    ld a, e_vx(ix)
    dec a
    inc a
    jp NZ , checkColl

    ld a, e_vy(ix)
    dec a
    inc a
    ret Z

    checkColl:

    ld d, h ;; | Guardamos hl en de 
    ld e, l ;; |

    ;; Establecemos los dos puntos de colisiones del sprite
    ld a, e_orient(ix)
    call _sys_setEntityCollisionPoints
    ex de, hl

    push hl
    pop ix
    ;; Chekeamos que el primer punto no esté en el tile que no toca
    ld a, (#_sys_entityColisionPos1_Y)
    ld b, a
    ld a, (#_sys_entityColisionPos1_X)
    ld c, a
    call _sys_checkTilePosition

    ;; Chekeamos que el segundo punto no esté en el tile que no toca
    ld a, (#_sys_entityColisionPos2_Y)
    ld b, a
    ld a, (#_sys_entityColisionPos2_X)
    ld c, a
    call _sys_checkTilePosition

ret

tile_margin_x: .db 0
tile_margin_y: .db 0

check_tile_margin_bullets:
   special_tile_collision = (e_type_bullet | e_type_enemy_bullet)
   ld a, #special_tile_collision

   and e_type(ix)
   jr nz, has_to_set_margin

   ld hl, #tile_margin_x
   ld (hl), #0

   ld hl, #tile_margin_y
   ld (hl), #0
   ret

   has_to_set_margin:

      ld hl, #tile_margin_x
      ld a, e_vx(ix)
      ld (hl), a

      ld hl, #tile_margin_y
      ld a, e_vy(ix)
      ld (hl), a

   ret

;===================================================================================================================================================
; FUNCION _sys_checkTilePosition
; Comprueba si el punto que le han pasado colisiona con la tile y en ese caso updatea su velocidad
; BC : El punto en el que se va a comprobar la colision
;===================================================================================================================================================
_sys_checkTilePosition:
    call check_tile_margin_bullets

    ld a, (tile_margin_y)
    add e_ypos(ix)
    ; ld  a, e_ypos(ix)

    ; add e_vy(ix)
    add b ;; Sumo el alto de mi personaje 10
    ;; Desplazo a la derecha 3 veces el bit 
    ;;(Si deplazo a la derecha 1 bit divido entre 2)
    ;; A = ty (y/8)
    srl a ;; |
    srl a ;; | A = A/8
    srl a ;; |
    ;; HL = A (HL = ty)
    ld  h, #0
    ld  l, a
    ;; HL = 20*HL
    add hl, hl  ;; HL = 2*ty
    add hl, hl  ;; HL = 4*ty
    ld  d, h    ;; | DE = 4*ty
    ld  e, l    ;; |
    add hl, hl  ;; HL = 8*ty
    add hl, hl  ;; HL = 16*ty
    add hl, de  ;; HL = 20*ty

    ;; A = x
    ld a, (tile_margin_x)
    add a, e_xpos(ix)

    ; add e_vx(ix)
    add c
    srl a ;; | A = tx(x/4)
    srl a ;; |

    add_hl_a    ;; HL = ty * tw + tx
    push hl

    ld hl, #_m_render_tilemap
    ld e, (hl)
    inc hl
    ld d, (hl)

    pop hl
    add hl, de

    ;; HL = tilemap + ty * tw + tx
    ;; Ya tenemos a hl apuntando al byte que queríamos
    ld  a, (hl) ;; A ld a, #0x03
    and #0b1100000 
       ;;0b1100000 = 96d  - 60x = No me deja moverme en absoluto
       ;;0b1110000 = 112d - 70x = Borr

      ret nz
    ;; COLISION DETECTADA

    ;; Dependiendo de la colision del axis setea a 0 la vel.
    CHECK_ORIENTATION_AXIS_PLAYER e_orient(ix)
    inc a
    dec a
    jp z, _stop_x_axis
    ld  e_vy(ix), #0    ;; Para a la entidad
    jp _is_none_axis

    _stop_x_axis:
    ld  e_vx(ix), #0    ;; Para a la entidad

    _is_none_axis:

      ld a, #e_type_bullet
      cp e_type(ix)
      jr z, is_type_bullet

      ld a, #e_type_enemy_bullet
      cp e_type(ix)
      jr z, is_type_enemy_bullet

      ld a, #e_type_enemy
      cp e_type(ix)
      jr z, is_type_enemy
      ret

      is_type_enemy_bullet:
         push ix
         pop hl
         ;; mandamos la bala a una zona del tile que siempr es amarilla 
         ; porque las diagonales no se borran es como la peor solucion pero mira que
         ; bien funcioona ole ole oleee
         ld e_xpos(ix), #8
         ld e_ypos(ix), #8
         call z, _m_game_destroyEntity

         ; porque las tipo sp no colisionan
         dec e_inputbeh1(ix)
         ret z

         ; en patrol esta la direction del enemy que la ha disparado
         ld h, e_patrol_step_h(ix)
         ld l, e_patrol_step_l(ix)
         push hl
         pop iy

         ; si es enemy_no_shoot salimos
         ; no esla mejor forma poruqe si de casualidad
         ; el label acaba en 0 tambien se sale
         ld a, #0
         cp e_inputbeh1(iy)
         ret z

         call _sys_ai_random_0_1
         or a
         jr z, set_fixed_tile

         ld e_aictr(iy), #t_shoot_timer_tile_collision - 4

         ret

         ;; TODO: a veces salen dos
         ; ld a, r
         ; ld l, #4
         ; cp l
         ; ; a < n
         ; jr c, set_fixed_tile
         ; ld l, #12
         ; cp l
         ; ; a >= n
         ; jr nc, set_fixed_tile
         ;
         ; ld e_aictr(ix), a
         ; ret

         ; ld a, r
         ;
         ; ld l, #0
         ; cp l
         ; jr z, set_fixed_tile
         ;
         ; ld l, #12
         ; cp l
         ; jr nc, set_fixed_tile
         ;
         ; ld e_aictr(iy), a
         ; ret
         set_fixed_tile:
            ld e_aictr(iy), #t_shoot_timer_tile_collision

         ret

      is_type_enemy:
         ; push ix
         ; pop hl
         ld  e_vx(ix), #0
         ld  e_vy(ix), #0
         ret

      is_type_bullet:

         push ix
         pop hl
         ld a, #i_id_rotator
         cp e_inputbeh1(ix)
         jp z, is_type_rotator

         ; ld e_vx(ix), #0
         ; ld e_vy(ix), #0
         ; ld e_cmp(ix), #0x39

         call _m_game_destroyEntity
         ; GET_PLAYER_ENTITY iy
         ; ld e_aictr(iy), #0
         call reset_player_aictr

         call _m_game_bulletDestroyed

      ;; TODO[Edu]: mejorar !!
      is_type_rotator:
         ld  e_vx(ix), #0
         ld  e_vy(ix), #0
         ret

   ret


;===================================================================================================================================================
; FUNCION _sys_setEntityCollisionPoints
; Según la orientación de la entidad. Setea los puntos a comprobar en las variables
; BC : El punto en el que se va a comprobar la colision
;===================================================================================================================================================
_sys_setEntityCollisionPoints:
    ld c, a

    ;; RIGHT = 0
    ld b, #0x00
    sub b
    jr z, _setCollisionRight
    ld a, c

    ;; DOWN = 1
    ld b, #0x01
    sub b
    jr z, _setCollisionDown
    ld a, c

    ;; LEFT = 2
    ld b, #0x02
    sub b
    jr z, _setCollisionLeft
    ld a, c

    ;; UP = 3
    ld b, #0x03
    sub b
    jr z, _setCollisionUp

    _setCollisionRight:
        ;; Establecemos los parametros a usar
        ;; que ayudaran a saber en que tile se encuentra
        ;; el punto

        ;; Punto 1
        ld a, e_width(ix)
        ld (#_sys_entityColisionPos1_X), a

        ld a, #0x00
        ld (#_sys_entityColisionPos1_Y), a

        ;; Punto 2
        ld a, e_width(ix)
        ld (#_sys_entityColisionPos2_X), a

        ld a, #0x00 - 1  ;; El "- 1" es para que pueda pegarse mas a la pared
        add e_heigth(ix)
        ld (#_sys_entityColisionPos2_Y), a

        jp _stopCheckingCollisionPoints

    _setCollisionDown:
        ;; Punto 1
        ld a, #0x00
        ld (#_sys_entityColisionPos1_X), a

        ld a, e_heigth(ix)
        ld (#_sys_entityColisionPos1_Y), a

        ;; Punto 2
        ld a, #0x00 - 1
        add e_width(ix)
        ld (#_sys_entityColisionPos2_X), a

        ld a, e_heigth(ix)
        ld (#_sys_entityColisionPos2_Y), a

        jp _stopCheckingCollisionPoints

    _setCollisionLeft:
        ;; Punto 1
        ld a, #0xFF
        ld (#_sys_entityColisionPos1_X), a

        ld a, #0x00
        ld (#_sys_entityColisionPos1_Y), a

        ;; Punto 2
        ld a, #0xFF
        ld (#_sys_entityColisionPos2_X), a

        ld a, #0x00 - 1
        add e_heigth(ix)
        ld (#_sys_entityColisionPos2_Y), a

        jp _stopCheckingCollisionPoints

    _setCollisionUp:
        ;; Punto 1
        ld a, #0x00
        ld (#_sys_entityColisionPos1_X), a

        ld a, #0xFF
        ld (#_sys_entityColisionPos1_Y), a

        ;; Punto 2
        ld a, #0x00 - 1
        add e_width(ix)
        ld (#_sys_entityColisionPos2_X), a

        ld a, #0xFF
        ld (#_sys_entityColisionPos2_Y), a

    _stopCheckingCollisionPoints:

ret


;===================================================================================================================================================
; FUNCION playerCollisionBehaviour
; Comportamiento de las colisiones del jugador
; NO llega nada
;===================================================================================================================================================
no_collision_player_die = (e_type_bullet | e_type_item)

playerCollisionBehaviour:
    ; GET_PLAYER_ENTITY iy
    ld a, #no_collision_player_die
    and e_type(iy)
    call Z, _man_game_decreasePlayerLife

    ld a, #e_type_item
    and e_type(iy)
    call NZ, _man_game_getItem

    ret



;===================================================================================================================================================
; FUNCION enemyCollisionBehaviour
; Comportamiento de las colisiones del enemigo
; NO llega nada
;===================================================================================================================================================
enemyCollisionBehaviour:
    ld a, #0x04
    and e_type(iy)
    ret Z

    ;; TODO: esto es una cochinada !! >:(
    ld a, #0x84
    and e_type(iy)
    ret z

    ld a, #10
    cp e_width(ix)
    jr z, is_final_boss

    ld a, (player_has_sharp_bullet)
    cp #0
    jr z, not_sharp_bullet_2
    jr has_sharp_bullet_2

    not_sharp_bullet_2:
       push iy
       pop hl
       call _m_game_destroyEntity

    has_sharp_bullet_2:

    call _sys_ai_prepare_ovni_die

    call reset_player_aictr
    call _m_game_bulletDestroyed

    ret

    is_final_boss:
      call decrease_boss_hp
      push iy
      pop hl
      call _m_game_destroyEntity
      call reset_player_aictr

    ret


;===================================================================================================================================================
; FUNCION destroyPairOfEntities
; Método encargado las dos entidades que colisionan
; NO llega nada
;===================================================================================================================================================
destroyPairOfEntities:
    push iy
    pop hl 
    call _m_game_destroyEntity

    push ix
    pop hl 
    call _m_game_destroyEntity  
    
    ret


;===================================================================================================================================================
; FUNCION enemySpawnerCollisionBehaviour
; Método encargado de las colisiones del enemySpawner
; NO llega nada
;===================================================================================================================================================
enemySpawnerCollisionBehaviour:

    ld a, #0x04
    and e_type(iy)
    ret Z

    call _sys_ai_decrement_spawner_hp
    push iy
    pop hl
    call _m_game_destroyEntity
    call _m_game_bulletDestroyed
    ; call reset_player_aictr

    ret


; e_type_bullet                = si choca con un enemy se destruye así mismo, al enemy tambien se destruye, si es un spawner se le resta una vida al spawner,
;                                Y SE BORRA ASÍ MISMO
;                                si es una enemyBullet se eliminan las 2

;===================================================================================================================================================
; FUNCION bulletCollisionBehaviour
; Método encargado de las colisiones del bullet
; NO llega nada
;===================================================================================================================================================
bulletCollisionBehaviour:
    ld a, #e_type_enemy
    and e_type(iy)
    jr NZ, destroyEnityOvni

    ld a, #e_type_enemy_bullet
    and e_type(iy)
    jr NZ, destroyEnity

    ld a, #e_type_spawner
    and e_type(iy)
    jr NZ, decreaseLifeSpawner

    ; ld a, #i_id_rotator
    ; cp e_inputbeh1(ix)
    ; call z, _m_game_quit_rotator

    ret
    decreaseLifeSpawner:
    ;;Llamar método resta via al spawner
       call _sys_ai_decrement_spawner_hp
       call reset_player_aictr

    push ix
    pop hl 
    call _m_game_destroyEntity
    call _m_game_bulletDestroyed
    
    ret
    destroyEnity:

    ;; TODO: CREO QUE SIEMPRE VA BIEN
    call destroyPairOfEntities 
    call reset_player_aictr

    ld bc, #0x0001
    call _m_HUD_addPoints
    ld a, #0x01
    call _m_HUD_renderScore

    ret

    destroyEnityOvni:
    call reset_player_aictr

    ld a, (player_has_sharp_bullet)
    cp #0
    jr z, not_sharp_bullet_1
    jr has_sharp_bullet_1

    not_sharp_bullet_1:
       ld__hl_ix
       call _m_game_destroyEntity

    has_sharp_bullet_1:
    push iy
    pop ix
    call _sys_ai_prepare_ovni_die

    ld a, #0x20
    and e_type(iy)

    jr Z, dontAddPoints

    dontAddPoints:

    ret



;===================================================================================================================================================
; FUNCION enemyBulletCollisionBehaviour
; Método encargado de las colisiones del enemyBullet
; NO llega nada
;===================================================================================================================================================
enemyBulletCollisionBehaviour:
    ld a, #0x04
    and e_type(iy)
    ret Z

    call _m_game_bulletDestroyed
    ld bc, #0x0001
    call _m_HUD_addPoints
    ld a, #0x01
    call _m_HUD_renderScore

    call destroyPairOfEntities
    call reset_player_aictr

    ret

; bug:colateral si pulsas seguid
; el cooldown para poder disprar
reset_player_aictr:
   push iy
   GET_PLAYER_ENTITY iy
   ld e_aictr(iy), #8
   pop iy
   ret
