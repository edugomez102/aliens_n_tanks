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

.module Game
;====================================================================
; includes
;====================================================================
.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/HUD.h.s"
.include "resources/sprites.h.s"
.include "resources/levels.h.s"
.include "man/interruptions.h.s"
.include "assets/music/ArcadeGameSong.h.s"
.include "assets/compress/screenmenu.h.s"
.include "assets/compress/screenend.h.s"
.include "assets/compress/screenvictory.h.s"
 
.include "sys/render.h.s"
.include "sys/ai.h.s"
.include "sys/ai_beh.h.s"
.include "sys/animator.h.s"
.include "sys/collision.h.s"
.include "sys/input.h.s"
.include "sys/physics.h.s"
.include "resources/macros.s"
.include "resources/entityInfo.s"
.include "resources/templates.h.s"
.include "resources/sprites.h.s"
.include "game.h.s"
.include "resources/tilemaps.h.s"
.include "sys/items.h.s"
.include "man/waves.h.s"


;====================================================================
; Manager data
;====================================================================

;;Descripcion : Contador de las interrupciones por la que vamos
_m_irCtr:
   .db 1

;;Descripcion : Posición de memoria de la entidad del jugador 1
_m_player1Entity:
   .dw #0x0000

;;Descripcion : Posición de memoria de la entidad del jugador 2
_m_player2Entity:
   .dw #0x0000

;;Descripcion : Número de vidas restantes
_m_lifePlayer:
   .ds 1

;;Descripcion : Nivel actual del juego
_m_gameLevel:
   .ds 2

;;Descripcion : Siguiente nivel del juego
_m_nextLevel:
   .ds 2

;;Descripcion : Numero enemigos
_m_enemyCounter:
   .ds 1

;;Current game mode
_m_gameMode:
   .ds 1

_m_current_level_counter: .db #0
_m_max_level = #24

;; TODO: nose poner mejor
player_shoot_cooldown = 12

player_vel_x = 2
player_vel_y = 4

player_bullet_vel_x: .db #2
player_bullet_vel_y: .db #4

player_has_rotator: .db #0
player_has_shield: .db #0

player_has_sharp_bullet: .db #1
player_has_speed_bullet: .db #0

player_max_rotators = 2

; TODO pasar a t_player
player_has_shot: .db #0


player_blink_time = 20


;====================================================================
; FUNCION _m_game_createInitTemplate   
; ; Crea la entidad con el template indicado
; BC : Valor de template a crear
;====================================================================
_m_game_createInitTemplate:
   call _man_createEntity
   push hl
   ex de,hl
   ld h, b
   ld l, c
   ld b,#0x00
   LOAD_VARIABLE_IN_REGISTER _m_sizeOfEntity, C
   call cpct_memcpy_asm
   pop hl
ret


;====================================================================
; FUNCION _m_game_init   
; Inicializa el juego y sus entidades
; NO llega ningun dato
;====================================================================
_m_game_init:
   call _sys_init_render

   ;; TODO: me salia undefined
   ; ld de, #_GameSong
   ld de, #_gameSong
   call cpct_akp_musicInit_asm

   call _man_int_setIntHandler
   
ret

;====================================================================
; FUNCION waitKeyPressed
; Funcion encargada de esperar a que se pulse de forma única la tecla pasada por registro
; HL = Tecla para pulsar
;====================================================================
waitKeyPressed:
   push hl
   call cpct_isKeyPressed_asm
   pop hl
   jr  nz, waitKeyPressed

   loopWaitKey:
      push hl
      call cpct_isKeyPressed_asm
      pop hl
      jr  z, loopWaitKey
   
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Makes the loop for the menu
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_menu_update:
   ;;Check if is the key 1 pressed for individual mode
   ld hl, #Key_1
   call cpct_isKeyPressed_asm
   jr nz, set_gamemode_individual

   ;;Check if is the key 2 pressed for individual mode
   ld hl, #Key_2
   call cpct_isKeyPressed_asm
   jr nz, set_gamemode_multiplayer

   jr man_menu_update

   set_gamemode_individual:
      ld hl, #_m_gameMode
      ld (hl), #0
      ret

   set_gamemode_multiplayer:
      ld hl, #_m_gameMode
      ld (hl), #1
ret

;====================================================================
; FUNCION _m_game_play   
; Bucle del juego
; NO llega ningun dato
;====================================================================
_m_game_play:
;==================
;Pantalla inicio
;==================
startGame:

   call _m_game_StartMenu

   ;;ld hl, #Key_Return
   ;;call waitKeyPressed

   call man_menu_update

   ld a, #_m_gameMode
   cp #0
   ;;jr z, modo individual

   ld a, #_m_gameMode
   cp #1
   ;;jr z, modo multiplayer

   cpctm_clearScreen_asm 0

;Set de variables de juego ()
call _man_game_initGameVar
call _m_HUD_initHUD
call _m_game_restart_level_counter


;==================
;Carga de Nivel
;==================
restartLevel:
di
SET_TILESET _tileset_00
ld hl, #_m_enemyCounter
ld (hl), #0x00
call _man_entityInit

call man_wave_init
call _man_game_loadLevel
; call _sys_render_renderTileMap

ld hl, #_screenvictory_end
ld de, #0xFFFF
call cpct_zx7b_decrunch_s_asm

call _m_HUD_renderLifes

ld a, #0x01
call _m_HUD_renderScore

;==================
;Inicio Juego
;==================
ei

   call _man_int_setIntHandler

   testIr:

      cpctm_setBorder_asm HW_BLACK
      ld a, (_man_int_current)
      cp #2
      jr nz, testIr

      cpctm_setBorder_asm HW_BLACK
      call _man_entityUpdate

      cpctm_setBorder_asm HW_RED
      call _sys_input_update

      ;cpctm_setBorder_asm HW_GREEN
      ;call _sys_animator_update

      cpctm_setBorder_asm HW_WHITE
      call _sys_ai_update

      cpctm_setBorder_asm HW_BRIGHT_RED
      call _sys_collision_update

      cpctm_setBorder_asm HW_BRIGHT_YELLOW
      call _sys_physics_update
      
      wait_render:

      ld a, (_man_int_current)
      cp #0
      jr nz, wait_render

      cpctm_setBorder_asm HW_BLUE
      call _sys_render_update

      cpctm_setBorder_asm HW_BRIGHT_GREEN
      call _man_game_updateGameStatus
      call man_wave_update

      cpctm_setBorder_asm HW_BLACK

      jr testIr

   endGame:

   ;TODO : Hacer una pantalla de endgame bonica y cargarla aquí
   ld hl, #_screenend_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm

   ld a, #0x00
   call _m_HUD_renderScore

   call _m_game_inc_level_counter
   call _sys_render_level_counter_end


   ld hl, #Key_Return
   call waitKeyPressed
   cpctm_clearScreen_asm 0

   call _m_game_reset_items_endgame

   jp startGame


ret

victoryScreen:
   ;TODO : Hacer una pantalla de victoria bonica y cargarla aquí
   cpctm_clearScreen_asm 0

   ld hl, #_screenvictory_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm

   ld a, #0x00
   call _m_HUD_renderScore


   ld hl, #Key_Return
   call waitKeyPressed
   cpctm_clearScreen_asm 0

   jp startGame
   ret


;====================================================================
; FUNCION _m_game_destroyEntity
; Funcion que destruye la entidad indicada
; HL : Llega el valor de la entidad
;====================================================================
_m_game_destroyEntity:
   call _man_setEntity4Destroy
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Crear la axe 
;; Guardar dir de axe en patrol de player y viceversa
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_m_game_createAxe:
   GET_PLAYER1_ENTITY iy
   ; ix: axe
   CREATE_ENTITY_FROM_TEMPLATE t_axe_player ; hl
   ld e_patrol_step_l(iy), l
   ld e_patrol_step_h(iy), h
   ld__ix_hl ; ix: axe
   ld__hl_iy
   ld e_patrol_step_l(ix), l
   ld e_patrol_step_h(ix), h

   ld e_xpos(ix), #4
   ld e_ypos(ix), #48

   ;;If there is individual gamemode return
   ld a, (#_m_gameMode)
   cp #0
   ret z

   ;;Create the axe for the player 2
   GET_PLAYER2_ENTITY iy
   ; ix: axe
   CREATE_ENTITY_FROM_TEMPLATE t_axe_player2 ; hl
   ld e_patrol_step_l(iy), l
   ld e_patrol_step_h(iy), h
   ld__ix_hl ; ix: axe
   ld__hl_iy
   ld e_patrol_step_l(ix), l
   ld e_patrol_step_h(ix), h

   ld e_xpos(ix), #6
   ld e_ypos(ix), #48


ret

_m_game_createPlayer:

   ld bc, #t_player
   call _m_game_createInitTemplate
   ex de, hl

   ld hl, #_m_player1Entity
   ld (hl), d
   inc hl
   ld (hl), e

   ld__iy_de
   ld e_xpos(iy), #36
   ld e_ypos(iy), #104

   ;;If there is individual gamemode return
   ld a, (#_m_gameMode)
   cp #0
   ret z

   ;;Create the player 2
   ld bc, #t_player2
   call _m_game_createInitTemplate
   ex de, hl

   ld hl, #_m_player2Entity
   ld (hl), d
   inc hl
   ld (hl), e

   ld__iy_de
   ld e_xpos(iy), #40
   ld e_ypos(iy), #104

ret

; TODO ix: current player
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Input de player. Lanzar o recoger axe
;; En e_ai_aux_l esta la variable del estado de la axe
;;   0 no se hace nada
;;   1 player puede lanzar
;;   2 player puede recoger
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_m_game_playerFire:
   ; axe in ix
   ld l, e_patrol_step_l(iy)
   ld h, e_patrol_step_h(iy)
   ld__ix_hl

   ld a, e_ai_aux_l(iy)

   cp #1
   jp z, _m_game_playerThrow

   cp #2
   jp z, _m_game_playerGetAxe

ret

_m_game_playerGetAxe:
   ; ld e_ai_aux_l(iy), #0

   ld hl, #sys_ai_beh_axe_pickup
   call _sys_ai_changeBevaviour

   ret 

; iy: Player
; TODO: centrar
_m_game_playerThrow:
   ld e_ai_aux_l(iy), #0
   ld e_cmp(ix), #0x6B

   ld hl, #sys_ai_beh_axe_throw
   call _sys_ai_changeBevaviour

   ld b, e_xpos(iy) 
   ld c, e_ypos(iy)

   ; bala en pos de player
   ld e_xpos(ix), b
   ld e_ypos(ix), c
   ld e_vx(ix), #0
   ld e_vy(ix), #0

   ld a, e_orient(iy)

   cp #0
   jr z, righOrientation ;; Si es 0 va a la derecha

   cp #1
   jr z, downOrientation ;; Si es 0 va a la abajo

   cp #2
   jr z, leftOrientation ;; Si es 0 va a la izquierda

   cp #3
   jr z, upOrientation ;; Si es 0 va a la arriba

   ret

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ;; Depues de vx se corrige margen 
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   righOrientation:
      ld a, (player_bullet_vel_x)
      ld e_vx(ix), a

      ld a, e_ypos(ix)
      add #3
      ld e_ypos(ix), a
      ret

   downOrientation:
      ld a, (player_bullet_vel_y)
      ld e_vy(ix), a

      ld a, e_xpos(ix)
      add #1
      ld e_xpos(ix), a
      ret

   leftOrientation:
      ld a, (player_bullet_vel_x)
      ld d, a
      NEGATE_NUMBER d
      ld e_vx(ix), a

      ld a, e_ypos(ix)
      add #3
      ld e_ypos(ix), a
      ret

   upOrientation:
      ld a, (player_bullet_vel_y)
      ld d, a
      NEGATE_NUMBER d
      ld e_vy(ix), a

      ld a, e_xpos(ix)
      add #1
      ld e_xpos(ix), a
      ret

ret

;====================================================================
; FUNCION _wait   
; Espera un tiempo antes de realizar otra iteracion del bucle de juego
; NO llega ningun dato
;====================================================================

_wait:
   ld h, #0x05
      waitLoop:
         ld b, #0x02
         call cpct_waitHalts_asm
         call cpct_waitVSYNC_asm
         dec h
         jr NZ, waitLoop
   ret


;====================================================================
; FUNCION _man_game_initGameVar   
; Función encargada de iniciar/resetear los valores del juego
; NO llega ningun dato
;====================================================================
_man_game_initGameVar:

   ld hl, #_m_lifePlayer
   ld (hl), #0x03

   ld hl, #_m_gameLevel 
   ld de, #_level1
   ld (hl), e
   inc hl
   ld (hl), d

   ld hl, #_m_enemyCounter
   ld (hl), #0x00

ret


;====================================================================
; FUNCION _man_game_loadLevel   
; Función encargada de cargar los datos y crear entidades del nivel
; NO llega ningun dato
;====================================================================
_man_game_loadLevel:
   call _m_game_createPlayer
   call _m_game_createAxe
ret


; TODO  FINISH
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IY: player
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_man_game_player_blink:
   ; ld a, (player_blink_time)
   ; cp e_anim2(iy)
   ; jr nc, is_blinking
   ; ret
   ;
   ; is_blinking:
   ;    ld e_cmp(iy), #0x07
   ;    ret
   
   ret

;====================================================================
; FUNCION _man_game_updateGameStatus   
; Función encargada de updatear el estado del juego y nivel
; NO llega ningun dato
;====================================================================
_man_game_updateGameStatus:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   ; GET_PLAYER1_ENTITY iy
   ;
   ; ld a, e_anim1(iy)
   ; cp #1
   ; call z, _man_game_player_blink

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   ; /
   ; ; | Se checkea si el jugador ha perdido las 3 vidas
   ; \
   ld hl , #_m_lifePlayer
   inc (hl)
   dec (hl)
   jr NZ, checkEnemy
   ; call _m_HUD_resetLevelScore
   pop hl
   jp  endGame
   checkEnemy:

   ; /
   ; | Se checkea si el jugador ha acabado con los enemigos y pasa de nivel
   ; \
   ; ld hl, #_m_enemyCounter
   ; inc (hl)
   ; dec (hl)
   jr NZ, dontPassLevel

   ld ix, #_m_nextLevel
   
   ;/
   ;| Llegados a este punto vamos a cargar el siguiente nivel o la pantalla de victoria 
   ;| entonces al hacer jp hay que desacerse del ret de la pila
   ;\
   pop hl 

   ld a, 0(ix)
   ld l, a
   ld a, 1(ix)
   ld h, a

   ld a, (hl)

   inc a
   dec a
   jr NZ, nextLevel
   
   jp victoryScreen
   
   nextLevel:
   call _m_game_inc_level_counter

   ;TODO : Meter aquñi el sprite de " Ready?" 
   call _m_HUD_saveScore
   ld ix, #_m_nextLevel
   ld hl, #_m_gameLevel
   ld a, (ix)  
   ld (hl), a
   inc hl
   ld a, 1(ix)
   ld (hl), a

   ;; Dibujamos el sprite para pasar de lvl
   LOAD_PNG_TO_SCREEN #0x09, #0x48, #0x3E, #0x2C, #_nextStage

   call _sys_render_level_counter_next

   ld hl, #Key_Return
   call waitKeyPressed
   
   jp restartLevel

   dontPassLevel:
ret

;====================================================================
; FUNCION _man_game_decreasePlayerLife   
; Función encargada de decrementar la vida del jugador
; NO llega ningun dato
;====================================================================
_man_game_decreasePlayerLife:

   ld hl, #_m_lifePlayer
   dec (hl)
   call _m_HUD_decreaseLife
   call _m_HUD_renderLifes
   ld hl, #_m_lifePlayer
   ld a,(hl)
   dec a
   inc a
   jr Z, dontResetScore
   call _m_HUD_resetLevelScore
   dontResetScore:
   ; pop hl ;Aqui quitamos lo ultimo de la pila pues no vamos a hacer un ret
   ; jp restartLevel

   ; TODO blink
   ; GET_PLAYER1_ENTITY iy
   ; ld e_anim1(iy), #1
   ; ld a, (player_blink_time)
   ; ld e_anim2(iy), a

ret


_man_game_increasePlayerLife:
   ld hl, #_m_lifePlayer
   ld a,(hl)
   cp #3
   jr Z, dontIncrease
   inc (hl)
   call _m_HUD_increaseLife
   call _m_HUD_renderLifes
   dontIncrease:

ret

;====================================================================
; iy: item entity
;====================================================================
_man_game_getItem:

   ld b, #0
   ld c, e_ai_aim_y(iy)

   ld hl, #_m_playerScore
   inc hl
   ld a, (hl)

   ; if score >= precio NC flag
   cp c
   jr nc, can_pick_item

   ret

   can_pick_item:
      ld a, #i_id_rotator
      cp e_ai_aim_x(iy)
      jp z, player_picking_rotator

      ld a, #i_id_heart
      cp e_ai_aim_x(iy)
      jp z, player_picking_heart

      ld a, #i_id_sharp_bullet
      cp e_ai_aim_x(iy)
      jp z, player_picking_sharp_bullet

      ld a, #i_id_speed_bullet
      cp e_ai_aim_x(iy)
      jp z, player_picking_speed_bullet

      can_pick_ingame_item:
      ; usa bc
      call _m_HUD_subPoints

      ld a, #free_item
      cp e_ai_aim_y(ix)
      call nz, _m_HUD_saveScore

      ld a, #1
      call _m_HUD_renderScore

      pop hl

      ld bc, #after_item_jp
      push bc

      ld h, e_anim2(iy)
      ld l, e_anim1(iy)
      jp (hl)

      after_item_jp:
      push iy
      pop hl

      call _m_game_destroyEntity
ret

player_picking_rotator:
   ld a, (player_has_rotator)
   cp #0
   jp z, can_pick_ingame_item
ret

player_picking_heart:
   ld a, (_m_lifePlayer)
   cp #3
   jp nz, can_pick_ingame_item
ret

player_picking_sharp_bullet:
   ld a, (player_has_sharp_bullet)
   cp #0
   jp z, can_pick_ingame_item
ret

player_picking_speed_bullet:
   ld a, (player_has_speed_bullet)
   cp #0
   jp z, can_pick_ingame_item
ret

;====================================================================
; Función encargada de decrementar el número de enemigos
; NO llega ningun dato
;====================================================================
man_game_enemy_die:
   ld hl, #_m_enemyCounter
   dec (hl)
   ld bc, #0x0002
   call _m_HUD_addPoints
   ld a, #0x01
   call _m_HUD_renderScore
ret

;====================================================================
; FUNCION _m_game_StartMenu   
; Funcion que manda a renderizar la pantalla de inicio del juego
; NO llega ningun dato
; ;====================================================================
_m_game_StartMenu:

   ld hl, #_screenmenu_end
   ld de, #0xFFFF
   call cpct_zx7b_decrunch_s_asm
ret


_m_game_reg_ingame_items:
   GET_PLAYER1_ENTITY iy

   ld a, (player_has_rotator)
   cp #1
   call z, item_create_ingame_rotator
ret

_m_game_reset_items_endgame:
   ld a, #2
   ld (player_bullet_vel_x), a
   ld a, #4
   ld (player_bullet_vel_y), a
   ld a, #0
   ld (player_has_rotator), a
   ld a, #0
   ld (player_has_sharp_bullet), a
ret

_m_game_quit_rotator:
   ld hl, #player_has_rotator
   dec (hl)
ret

;; Destroy HL
_m_game_restart_level_counter:
   ld hl, #_m_current_level_counter
   ld (hl), #0
ret


; esto lo hicimos el ultimo dia a ultima hora vale pedimos perdon
;; ES HORRIBLE PERO LO HICE EN DOS HORAS E LDIA DE LA ENTRGA 
;; Destroy HL
_m_game_inc_level_counter:
   ld hl, #_m_current_level_counter
   inc (hl)

   ld a, #1
   cp (hl)
   jp z, lvl_01

   ld a, #2
   cp (hl)
   jp z, lvl_02

   ld a, #3
   cp (hl)
   jp z, lvl_03

   ld a, #4
   cp (hl)
   jp z, lvl_04

   ld a, #5
   cp (hl)
   jp z, lvl_05

   ld a, #6
   cp (hl)
   jp z, lvl_06

   ld a, #7
   cp (hl)
   jp z, lvl_07

   ld a, #8
   cp (hl)
   jp z, lvl_08

   ld a, #9
   cp (hl)
   jp z, lvl_09

   ld a, #10
   cp (hl)
   jp z, lvl_10

   ld a, #11
   cp (hl)
   jp z, lvl_11

   ld a, #12
   cp (hl)
   jp z, lvl_12

   ld a, #13
   cp (hl)
   jp z, lvl_13

   ld a, #14
   cp (hl)
   jp z, lvl_14

   ld a, #15
   cp (hl)
   jp z, lvl_15

   ld a, #16
   cp (hl)
   jp z, lvl_16

   ld a, #17
   cp (hl)
   jp z, lvl_17

   ld a, #18
   cp (hl)
   jp z, lvl_18

   ld a, #19
   cp (hl)
   jp z, lvl_19

   ld a, #20
   cp (hl)
   jp z, lvl_20

   ld a, #21
   cp (hl)
   jp z, lvl_21

   ld a, #22
   cp (hl)
   jp z, lvl_22

   ld a, #23
   cp (hl)
   jp z, lvl_23

   ld a, #24
   cp (hl)
   jp z, lvl_24

   ld a, #25
   cp (hl)
   jp z, lvl_25

   ld a, #26
   cp (hl)
   jp z, lvl_26

   ld a, #27
   cp (hl)
   jp z, lvl_27

   ld a, #28
   cp (hl)
   jp z, lvl_28

   ld a, #29
   cp (hl)
   jp z, lvl_29

   ld a, #30
   cp (hl)
   jp z, lvl_30

   ld a, #31
   cp (hl)
   jp z, lvl_31

   ld a, #32
   cp (hl)
   jp z, lvl_32

   ld a, #32
   cp (hl)
   jp z, lvl_32

   ld a, #33
   cp (hl)
   jp z, lvl_33

   ld a, #34
   cp (hl)
   jp z, lvl_34

ret

lvl_01:
   ; pintamos el primero de 0 por si viene de un nivel superior a 10
   ld hl, #_spriteScore_00
   call load_lvl_ctr_sprite_1

   ld hl, #_spriteScore_01
   call load_lvl_ctr_sprite_2
   ret
lvl_02:
   ld hl, #_spriteScore_02
   call load_lvl_ctr_sprite_2
   ret
lvl_03:
   ld hl, #_spriteScore_03
   call load_lvl_ctr_sprite_2
   ret

lvl_04:
   ld hl, #_spriteScore_04
   call load_lvl_ctr_sprite_2
   ret

lvl_05:
   ld hl, #_spriteScore_05
   call load_lvl_ctr_sprite_2
   ret

lvl_06:
   ld hl, #_spriteScore_06
   call load_lvl_ctr_sprite_2
   ret

lvl_07:
   ld hl, #_spriteScore_07
   call load_lvl_ctr_sprite_2
   ret
lvl_08:
   ld hl, #_spriteScore_08
   call load_lvl_ctr_sprite_2
   ret

lvl_09:
   ld hl, #_spriteScore_09
   call load_lvl_ctr_sprite_2
   ret

lvl_10:
   ld hl, #_spriteScore_00
   call load_lvl_ctr_sprite_2
   ld hl, #_spriteScore_01
   call load_lvl_ctr_sprite_1
   ret
lvl_11:
   ; el primero numero ya tiene un 1
   ld hl, #_spriteScore_01
   call load_lvl_ctr_sprite_2
   ret
lvl_12:
   ld hl, #_spriteScore_02
   call load_lvl_ctr_sprite_2
   ret
lvl_13:
   ld hl, #_spriteScore_03
   call load_lvl_ctr_sprite_2
   ret
lvl_14:
   ld hl, #_spriteScore_04
   call load_lvl_ctr_sprite_2
   ret
lvl_15:
   ld hl, #_spriteScore_05
   call load_lvl_ctr_sprite_2
   ret
lvl_16:
   ld hl, #_spriteScore_06
   call load_lvl_ctr_sprite_2
   ret
lvl_17:
   ld hl, #_spriteScore_07
   call load_lvl_ctr_sprite_2
   ret
lvl_18:
   ld hl, #_spriteScore_08
   call load_lvl_ctr_sprite_2
   ret
lvl_19:
   ld hl, #_spriteScore_09
   call load_lvl_ctr_sprite_2
   ret
lvl_20:
   ld hl, #_spriteScore_00
   call load_lvl_ctr_sprite_2
   ld hl, #_spriteScore_02
   call load_lvl_ctr_sprite_1
   ret
lvl_21:
   ; el primero numero ya tiene un 2
   ld hl, #_spriteScore_01
   call load_lvl_ctr_sprite_2
   ret
lvl_22:
   ld hl, #_spriteScore_02
   call load_lvl_ctr_sprite_2
   ret
lvl_23:
   ld hl, #_spriteScore_03
   call load_lvl_ctr_sprite_2
   ret
lvl_24:
   ld hl, #_spriteScore_04
   call load_lvl_ctr_sprite_2
   ret

lvl_25:
   ld hl, #_spriteScore_05
   call load_lvl_ctr_sprite_2
   ret
lvl_26:
   ld hl, #_spriteScore_06
   call load_lvl_ctr_sprite_2
   ret
lvl_27:
   ld hl, #_spriteScore_07
   call load_lvl_ctr_sprite_2
   ret
lvl_28:
   ld hl, #_spriteScore_08
   call load_lvl_ctr_sprite_2
   ret
lvl_29:
   ld hl, #_spriteScore_09
   call load_lvl_ctr_sprite_2
   ret
lvl_30:
   ld hl, #_spriteScore_00
   call load_lvl_ctr_sprite_2
   ld hl, #_spriteScore_03
   call load_lvl_ctr_sprite_1
   ret
lvl_31:
   ld hl, #_spriteScore_01
   call load_lvl_ctr_sprite_2
   ret
lvl_32:
   ld hl, #_spriteScore_02
   call load_lvl_ctr_sprite_2
   ret
lvl_33:
   ld hl, #_spriteScore_03
   call load_lvl_ctr_sprite_2
   ret
lvl_34:
   ld hl, #_spriteScore_04
   call load_lvl_ctr_sprite_2
   ret


inc_lvl_ctr_var:
   ld hl, #_m_current_level_counter
   inc (hl)
ret

; hl: new sprite
load_lvl_ctr_sprite_2:
   ld de, #lvl_ctr_sprite_2
   ; ld hl, #_spriteScore_01
   ld a, l
   ld (de), a
   inc de
   ld a, h
   ld (de), a
ret

; hl: new sprite
load_lvl_ctr_sprite_1:
   ld de, #lvl_ctr_sprite_1
   ; ld hl, #_spriteScore_01
   ld a, l
   ld (de), a
   inc de
   ld a, h
   ld (de), a
ret
