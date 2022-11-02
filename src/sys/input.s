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

.module Input
;===================================================================================================================================================
; Includes
;===================================================================================================================================================
.include "resources/macros.h.s" ;;Info : Hay un macro todo wapo para ver si se pulsan la tecla indicada
.include "resources/entityInfo.s"
.include "cpct_globals.h.s"
.include "man/entity.h.s"
.include "man/game.h.s"
.include "sys/input.h.s"
.include "resources/macros.s"
.include "macros/math.h.s"
.include "cpctelera.h.s"


;===================================================================================================================================================
; Keyboard  TODO : Intentar hacerlo con el joystick sería la polla lironda
;===================================================================================================================================================
;; TODO: esto no pillo para que sirve aqui
.globl Key_D
.globl Key_A
.globl Key_W
.globl Key_S
.globl Key_Space
.globl Key_I
.globl Key_J
.globl Key_K
.globl Key_L
.globl Key_M

;;KEY MAPPINGS
player1_keys:
    .dw Key_Space
    .dw Key_W
    .dw Key_A
    .dw Key_S
    .dw Key_D
    .dw 0

player2_keys:
    .dw Key_M
    .dw Key_I
    .dw Key_J
    .dw Key_K
    .dw Key_L
    .dw 0

current_player_input: .db 0

;===================================================================================================================================================
; FUNCION _sys_input_update
; Llama a la inversión de control para updatear las fisicas de cada entidad que coincida con e_type_movable
; NO llega ningun dato
;===================================================================================================================================================
_sys_input_update:
    call _sys_input_checkInput
ret

;===================================================================================================================================================
; FUNCION _sys_input_updateOneEntity
; Updatea cada una de las entidades que tiene componente input
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_input_checkInput:
    
    ld a, #0
    ld (#current_player_input), a
    
    GET_PLAYER1_ENTITY ix
    ld iy, #player1_keys

    loop_input:
        ;EN caso de no pulsar nada se queda quieto
        ld a, #0x00
        ld e_vx(ix), a
        ld e_vy(ix), a

        ;;FIRE BUTTON
        ld  l, 0(iy)
	    ld  h, 1(iy)

        ;;Check key Space behaviour
        call cpct_isKeyPressed_asm
        ld hl, #after_space_pressed
        jp NZ, spacePressed

        ;;UP BUTTON
        after_space_pressed:
        INCREMENT_REGISTER_2_BYTES iy, 2
        ld  l, 0(iy)
	    ld  h, 1(iy)

        call cpct_isKeyPressed_asm
        ld hl, #after_up_pressed
        jp NZ, upPressed

        ;;LEFT BUTTON
        after_up_pressed:
        INCREMENT_REGISTER_2_BYTES iy, 2
        ld  l, 0(iy)
	    ld  h, 1(iy)

        call cpct_isKeyPressed_asm
        ld hl, #after_left_pressed
        jp NZ, leftPressed

        ;;DOWN BUTTON
        after_left_pressed:
        INCREMENT_REGISTER_2_BYTES iy, 2
        ld  l, 0(iy)
	    ld  h, 1(iy)

        call cpct_isKeyPressed_asm
        ld hl, #after_down_pressed
        jp NZ, downPressed

        ;;RIGHT BUTTON
        after_down_pressed:
        INCREMENT_REGISTER_2_BYTES iy, 2
        ld  l, 0(iy)
	    ld  h, 1(iy)

        call cpct_isKeyPressed_asm
        ld hl, #after_right_pressed
        jp NZ, rightPressed

        after_right_pressed:

        ;;If there is multiplayer gamemode check the second player
        ld a, (#_m_gameMode)
        cp #0
        jp nz, check_player2

        ret

    check_player2:
        ;;Check if we've already checked the second player input
        ld a, (#current_player_input)
        cp #1
        ret z

        ;;Set the current player input checking to the second player
        ld a, #1
        ld (#current_player_input), a

        ;;Set the values to check the second player input
        GET_PLAYER2_ENTITY ix
        ld iy, #player2_keys
        jp loop_input

    upPressed:
        ;; Cambiamos la posicion
        ld a, #player_vel_y
        NEGATE_NUMBER a

        ;; Meto dos dec para que avance byte y no pixels
        ld e_vy(ix), a
        ld a, #0
        ld e_vx(ix), a

        ;; Actualizamos la orientación
        ld a, #0x03
        ld e_orient(ix), a
        jp (hl)

    leftPressed:
        ;; Cambiamos la posicion
        ld a, #player_vel_x
        NEGATE_NUMBER a

        ld e_vx(ix), a
        ld a, #0
        ld e_vy(ix), a

        ;; Actualizamos la orientación
        ld a, #0x02
        ld e_orient(ix), a
        jp (hl)

    downPressed:
        ;; Cambiamos la posicion
        ld a, #player_vel_y
        ld e_vy(ix), a
        ld a, #0
        ld e_vx(ix), a

        ;; Actualizamos la orientación
        ld a, #0x01
        ld e_orient(ix), a
        jp (hl)

    rightPressed:
        ;; Cambiamos la posicion
        ld a, #player_vel_x
        ld e_vx(ix), a
        ld a, #0
        ld e_vy(ix), a

        ;; Actualizamos la orientación
        ld a, #0x00
        ld e_orient(ix), a
        jp (hl)

    spacePressed:
        ld a, #0x00
        ld e_vx(ix), a
        ld a, #0x00
        ld e_vy(ix), a
        push hl
        push iy
        ld__iy_ix
        call _m_game_playerFire
        pop iy
        pop hl
        jp (hl)

      .globl nextLevel
      NPressed:
         call nextLevel
ret