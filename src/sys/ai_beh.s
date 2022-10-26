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

.include "sys/ai.h.s"

.include "man/entity.h.s"
.include "man/game.h.s"
.include "resources/entityInfo.s"
.include "resources/templates.h.s"
.include "resources/macros.s"
.include "sys/physics.h.s"
.include "sys/patrol.h.s"
.include "sys/ai.h.s"
.include "resources/sprites.h.s"
.include "collision.h.s"
.include "resources/animations.h.s"


;;--------------------------------------------------------------------------------
;; BULLET
;;--------------------------------------------------------------------------------

;===================================================================================================================================================
; FUNCION _sys_ai_behaviourBullet
; Updatea el contador de existencia de la bala y la destruye si hace falta
; BC : Entidad a updatear
;===================================================================================================================================================
_sys_ai_behaviourBullet:
    ld h, b
    ld l, c
    push hl
    pop ix

    ;; Se comprueba que el contador de mov. restantes de las
    ;; balas sea 0. En ese caso se manda a destruir
    ld a, e_aictr(ix)
    dec a
    jr z, destroyBullet ;; Si es 0 se destruye la bala

    jp stopUpdateBullet

    destroyBullet:
        ;; Volvemos a indicar que no tiene balas y re-seteamos el contador
        push hl
        call _m_game_bulletDestroyed
        pop hl
        call _m_game_destroyEntity


    stopUpdateBullet:
    ld e_aictr(ix), a
   ret

;===============================================================================
; Esta bala muere cuado aictr llega a 0
;===============================================================================
_sys_ai_behaviourBulletLinear:
   push bc
   pop ix

   ; call _sys_ai_check_tile_collision_from_ai
   ;; si colisiona
   ; CHECK_VX_VY_ZERO_JR has_to_destroy_bullet

   dec e_aictr(ix)
   jr z, has_to_destroy_bullet
   ret


   has_to_destroy_bullet:
      push ix
      pop hl
      call _m_game_destroyEntity
      ; call _man_setEntity4Destroy
   ret

;===============================================================================
; Esta bala muere cuado llega al ai_aim
;===============================================================================
_sys_ai_behaviourBulletSeektoPlayer:
   push bc
   pop ix

   GET_PLAYER_ENTITY iy
   CHECK_NO_AIM_XY _sys_ai_aim_to_entity

   ; mira la verdad no se como esto funciona
   ld a, e_ai_aim_x(ix)
   ld d, e_ai_aim_y(ix)
   add a, d
   or a

   jr nz, skip_set_coords

   call _sys_ai_aim_to_entity
   skip_set_coords:

   ld d, #2
   call _sys_ai_seekCoords_y
   ld d, #1
   call _sys_ai_seekCoords_x

   push ix
   pop hl
   CHECK_VX_VY_ZERO _man_setEntity4Destroy

   ret

;;--------------------------------------------------------------------------------
;; AI MOVE BEHAVIOURS
;;--------------------------------------------------------------------------------

enemy_no_move:
   push bc
   pop ix
   ld e_vx(ix), #0
   ld e_vy(ix), #0
   ret

;===============================================================================
; actualiza _sys_ai_nextPatrolCoords
; Destroy: HL, BC
;===============================================================================
_sys_ai_behaviourPatrol:
   push bc
   pop ix

   CHECK_VX_VY_ZERO _sys_patrol_next

   ld d, #2
   ; el orden importa para la colision no se
   call _sys_ai_seekCoords_y
   ld d, #1
   call _sys_ai_seekCoords_x

   call _sys_ai_check_tile_collision_from_ai

   ret

_sys_ai_behaviourPatrol_f:
   push bc
   pop ix

   CHECK_VX_VY_ZERO _sys_patrol_next

   ld d, #4
   ; el orden importa para la colision no se
   call _sys_ai_seekCoords_y
   ld d, #2
   call _sys_ai_seekCoords_x

   call _sys_ai_check_tile_collision_from_ai

   ret

;===============================================================================
; Patron con posiones relativas a xy, actualiza _sys_ai_nextPatrolCoords
; !!! Necesario poner en e_ai_aux mismas posiciones que en xpos ypos
; Destroy: HL, BC
;===============================================================================
_sys_ai_behaviourPatrolRelative:
   push bc
   pop ix
   ;; TODO: ver como poner el origen solo una vez 
   push ix
   pop iy
   ; dec e_aictr(ix)
   ; call z, _sys_patrol_set_relative_origin
   ; ld e_aictr(ix), #2

   CHECK_VX_VY_ZERO _sys_patrol_next_relative

   ld d, #2
   call _sys_ai_seekCoords_y
   ld d, #1
   call _sys_ai_seekCoords_x

   call _sys_ai_check_tile_collision_from_ai

   ret

_sys_ai_behaviourPatrolRelative_f:
   push bc
   pop ix
   ;; TODO: ver como poner el origen solo una vez 
   push ix
   pop iy
   ; dec e_aictr(ix)
   ; call z, _sys_patrol_set_relative_origin
   ; ld e_aictr(ix), #2

   CHECK_VX_VY_ZERO _sys_patrol_next_relative

   ld d, #4
   call _sys_ai_seekCoords_y
   ld d, #2
   call _sys_ai_seekCoords_x

   call _sys_ai_check_tile_collision_from_ai

   ret
;; TODO: si pos inicial 1 peta no se
;===============================================================================
; Sigue al jugador cambiando y se para a hacer un patron
; Usa el aictr
;===============================================================================
_sys_ai_behaviourSeekAndPatrol:
   push bc
   pop ix

   GET_PLAYER_ENTITY iy
   CHECK_NO_AIM_XY _sys_ai_aim_to_entity

   dec e_ai_aux_l(ix)
   call z, _sys_patrol_set_relative_origin

   CHECK_VX_VY_ZERO _sys_patrol_next_relative

   ld d, #1
   call _sys_ai_seekCoords_x
   call _sys_ai_check_tile_collision_from_ai
   ld d, #2
   call _sys_ai_seekCoords_y

   call _sys_ai_check_tile_collision_from_ai

   ret

_sys_ai_behaviourSeekAndPatrol_f:
   push bc
   pop ix

   GET_PLAYER_ENTITY iy
   CHECK_NO_AIM_XY _sys_ai_aim_to_entity

   dec e_ai_aux_l(ix)
   call z, _sys_patrol_set_relative_origin

   CHECK_VX_VY_ZERO _sys_patrol_next_relative

   ld d, #2
   call _sys_ai_seekCoords_x
   call _sys_ai_check_tile_collision_from_ai
   ld d, #4
   call _sys_ai_seekCoords_y

   call _sys_ai_check_tile_collision_from_ai

   ret

;; FOLLOW PLAYER IN AXIS

; require e_ai_aux_l
_sys_ai_beh_follow_player_x:
   call _sys_ai_beh_follow_player
   call z, do_follow_player_x
   ret

_sys_ai_beh_follow_player_x_f:
   call _sys_ai_beh_follow_player
   call z, do_follow_player_x_f
   ret

; require e_ai_aux_l
_sys_ai_beh_follow_player_y:
   call _sys_ai_beh_follow_player
   call z, do_follow_player_y
   ret

_sys_ai_beh_follow_player_y_f:
   call _sys_ai_beh_follow_player
   call z, do_follow_player_y_f
   ret

; deja en z la condicion
_sys_ai_beh_follow_player:
   push bc
   pop ix
   GET_PLAYER_ENTITY iy
   call _sys_ai_aim_to_entity
   dec e_ai_aux_l(ix)
   ret

do_follow_player_x:
   ld a, e_ai_aux_h(ix)
   ld e_ai_aux_l(ix), a
   ld d, #1
   call _sys_ai_seekCoords_x
   call _sys_ai_check_tile_collision_from_ai
   ret

do_follow_player_x_f:
   ld a, e_ai_aux_h(ix)
   ld e_ai_aux_l(ix), a
   ld d, #2
   call _sys_ai_seekCoords_x
   call _sys_ai_check_tile_collision_from_ai
   ret


do_follow_player_y:
   ld a, e_ai_aux_h(ix)
   ld e_ai_aux_l(ix), a
   ld d, #2
   call _sys_ai_seekCoords_y
   call _sys_ai_check_tile_collision_from_ai
   ret

do_follow_player_y_f:
   ld a, e_ai_aux_h(ix)
   ld e_ai_aux_l(ix), a
   ld d, #4
   call _sys_ai_seekCoords_y
   call _sys_ai_check_tile_collision_from_ai
   ret

; IX: entidad
_sys_ai_check_tile_collision_from_ai:
   push ix
   pop hl
   ;; haciendo un buen uso de nuestro maravilloso ECS
   ;; porque sino en la siguiente itereacion se mete en el tilemap
   call _sys_collision_updateOneEntity
   ret


;===============================================================================
; SPAWNER
;===============================================================================
_sys_ai_behaviourSpawner_template_f:
   call _sys_ai_beh_spawner_commmon_f
   call c, _sys_ai_spawnEnemy_template
   ret

_sys_ai_behaviourSpawner_template:
   call _sys_ai_beh_spawner_commmon
   call c, _sys_ai_spawnEnemy_template
   ret

_sys_ai_behaviourSpawner_plist:
   call _sys_ai_beh_spawner_commmon
   call c, _sys_ai_spawnEnemy_plist
   ret

;; TODO: hacer estructura de datos para generar segun templates con un invalid al finla
_sys_ai_beh_spawner_commmon:
   push bc
   pop ix

   ;; TODO: menor tiempo de spawn
   ; ld h, e_orient(ix)
   ; ld l, e_aictr(ix)
   ; dec hl
   ; ld a, e_aictr(ix)
   ; ld h, #16
   ; cp h
   ; call c, _sys_ai_prepare_spawn

   or #0
   ; call c, _sys_ai_prepare_spawn

   ld b, e_xpos(ix)
   ld c, e_ypos(ix)
   dec e_aictr(ix)

   jr z, check_if_spawn_enemy
   ret
   check_if_spawn_enemy:
      ld d, #enemy_max_spawn
      ld a, (_m_enemyCounter)
      cp d
   ret

; igual que el normal pero puede spawnar con enemy_max_spawn = 5
_sys_ai_beh_spawner_commmon_f:
   push bc
   pop ix

   ;; TODO: menor tiempo de spawn
   ; ld h, e_orient(ix)
   ; ld l, e_aictr(ix)
   ; dec hl
   ; ld a, e_aictr(ix)
   ; ld h, #16
   ; cp h
   ; call c, _sys_ai_prepare_spawn

   ; or #0
   ; call c, _sys_ai_prepare_spawn

   ld b, e_xpos(ix)
   ld c, e_ypos(ix)
   dec e_aictr(ix)

   jr z, check_if_spawn_enemy_f
   ret
   check_if_spawn_enemy_f:
      ; ld d, #enemy_max_spawn+2
      ; no va con globales solo si lo pongo justo asi1!
      ; ld d, #0x05
      ld d, #enemy_max_spawn + 1
      ld a, (_m_enemyCounter)
      cp d
   ret

_sys_ai_beh_ovni_die:
   push bc
   pop ix

   dec e_aictr(ix)
   jr z, ovni_set_4_destroy
   ret
   ovni_set_4_destroy:
      push ix
      pop hl
      call _m_game_destroyEntity
      call _man_game_decreaseEnemyCounter
   ret

;; IX: enemy entity
_sys_ai_prepare_ovni_die:
   ld hl, #enemy_no_shoot
   ld e_inputbeh1(ix), l
   ld e_inputbeh2(ix), h

   ld e_aictr(ix), #7
   ld hl, #_sys_ai_beh_ovni_die
   call _sys_ai_changeBevaviour
   ld e_vx(ix), #0
   ld e_vy(ix), #0

   ld hl, #_man_anim_exp
   ld e_anim1(ix), l
   ld e_anim2(ix), h
   ld e_animctr(ix), #3

   ld hl, #_ovni_exp_0
   ld e_sprite1(ix), l
   ld e_sprite2(ix), h

   ret

_sys_ai_beh_boss_move:
   push bc
   pop ix

   ld a, #66
   cp e_xpos(ix)
   call z, boss_in_x_66

   ld a, #4
   cp e_xpos(ix)
   call z, boss_in_x_4
   jr change_boss_velocity

   change_boss_velocity:
   ld a, #6
   cp e_animctr(ix)

   push ix
   pop bc
   jp c, _sys_ai_behaviourPatrol
   jp _sys_ai_behaviourPatrol
   ;; TODO[Edu]: ver si es viable
   ; jp _sys_ai_behaviourSeekAndPatrol

   ret

boss_in_x_66:
   ld a, #168
   cp e_ypos(ix)
   call z, boss_in_x_66_y_170
   ret

boss_in_x_66_y_170:
   ld bc, #t_spawner_from_plist_01
   call _m_game_createInitTemplate
   push hl
   pop iy
   ld e_xpos(iy), #66
   ld e_ypos(iy), #170

   ld hl, #_m_enemyCounter
   inc (hl)
   ret

boss_in_x_4:
   ld a, #166
   cp e_ypos(ix)
   call z, boss_in_x_4_y_168
   ret

boss_in_x_4_y_168:
   ld bc, #t_es_09
   call _m_game_createInitTemplate
   push hl
   pop iy
   ld e_xpos(iy), #4
   ld e_ypos(iy), #168

   ld hl, #_m_enemyCounter
   inc (hl)
   ret

_sys_ai_beh_boss_shoot:
   call _sys_ai_shoot_condition_common
   call z, boss_multi_shoot

   ret

boss_multi_shoot:
   push bc
   call _sys_ai_shoot_bullet_l_y_f
   pop bc

   push bc
   call _sys_ai_shoot_bullet_l_d_f
   pop bc

   push ix
   call _sys_ai_shootBulletSeek
   pop ix

   ret

;;--------------------------------------------------------------------------------
;; AI SHOOT BEHAVIOURS
;;--------------------------------------------------------------------------------

;===============================================================================
; dec e_aictr y si es cero llama a un shoot
; Destroy: BC
;===============================================================================
_sys_ai_shoot_condition_common:
   dec e_aictr(ix)
   ld b, e_xpos(ix)
   ld c, e_ypos(ix)
   ret

;===============================================================================
; dispara bala tipo SeektoPlayer
; Destroy: BC
;===============================================================================
; _sys_ai_shoot_condition_sp:
_sys_ai_beh_shoot_seekplayer:
   call _sys_ai_shoot_condition_common

   push ix
   call z, _sys_ai_shootBulletSeek
   pop ix
   ret


_sys_ai_beh_shoot_x:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_x
   ret

;; fast version
_sys_ai_beh_shoot_x_f:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_x_f
   or #0
   ret

_sys_ai_beh_shoot_y:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_y
   ret

;; fast version
_sys_ai_beh_shoot_y_f:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_y_f
   ret

; no diagonal x y un poco cuando quiere
_sys_ai_beh_shoot_xy_rand:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_xy_rand
   ret

_sys_ai_beh_shoot_xy_rand_f:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_xy_rand_f
   ret

; si esta justo en frente dispara en axis
_sys_ai_beh_shoot_d:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_d
   ret

_sys_ai_beh_shoot_d_f:
   call _sys_ai_shoot_condition_common
   call z, _sys_ai_shoot_bullet_l_d_f
   ret

;;--------------------------------------------------------------------------------
;; AI INGAME ITEMS
;;--------------------------------------------------------------------------------

_sys_ai_beh_ingame_shield:
   push bc
   pop ix

   GET_PLAYER_ENTITY iy
   ld a, e_xpos(iy)
   sub #1
   ld e_xpos(ix), a

   ld a, e_ypos(iy)
   sub #2
   ld e_ypos(ix), a

   ret

_sys_ai_beh_ingame_rotator:
   push bc
   pop ix

   ; GET_PLAYER_ENTITY iy
   ; ld a, e_xpos(iy)
   ; ; add #2
   ; ld e_xpos(ix), a
   ;
   ; ld a, e_ypos(iy)
   ; ; add #1
   ; ld e_ypos(ix), a

   GET_PLAYER_ENTITY iy
   ld a, e_xpos(iy)
   ld e_ai_aux_l(ix), a

   ld a, e_ypos(iy)
   ld e_ai_aux_h(ix), a

   push ix
   pop bc
   call _sys_ai_behaviourPatrolRelative_f

   ret
