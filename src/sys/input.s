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

;===================================================================================================================================================
; FUNCION _sys_input_update
; Llama a la inversión de control para updatear las fisicas de cada entidad que coincida con e_type_movable
; NO llega ningun dato
;===================================================================================================================================================
_sys_input_update:
    ld hl, #_sys_input_updateOneEntity
    ld (_m_functionMemory), hl
    ld hl , #_m_signatureMatch 
    ld (hl), #0x04  ; e_type_input
    call _man_entityForAllMatching
    ret

;===================================================================================================================================================
; FUNCION _sys_input_updateOneEntity
; Updatea cada una de las entidades que tiene componente input
; HL : Entidad a updatear
;===================================================================================================================================================
_sys_input_updateOneEntity:    
    
    push hl
    pop ix

    ld hl, #0x8005  ;;Key Space
    call cpct_isKeyPressed_asm
    jp NZ, spacePressed

    ld hl, #0x0807  ;;Key W
    call cpct_isKeyPressed_asm
    jp NZ, upPressed

    ld hl, #0x2008  ;;Key A
    call cpct_isKeyPressed_asm
    jp NZ, leftPressed

    ld hl, #0x1007  ;;Key S
    call cpct_isKeyPressed_asm
    jp NZ, downPressed

    ld hl, #0x2007  ;;Key D
    call cpct_isKeyPressed_asm
    jp NZ, rightPressed

    ld hl, #Joy0_Fire1
    call cpct_isKeyPressed_asm
    jp NZ, spacePressed

    ld hl, #Joy0_Up
    call cpct_isKeyPressed_asm
    jp NZ, upPressed

    ld hl, #Joy0_Left
    call cpct_isKeyPressed_asm
    jp NZ, leftPressed

    ld hl, #Joy0_Down
    call cpct_isKeyPressed_asm
    jp NZ, downPressed

    ld hl, #Joy0_Right
    call cpct_isKeyPressed_asm
    jp NZ, rightPressed

    ; ld hl, #Key_N
    ; call cpct_isKeyPressed_asm
    ; jp NZ, NPressed


    ;EN caso de no pulsar nada se queda quieto
    ld a, #0x00
    ld e_vx(ix), a
    ld e_vy(ix), a

    jp stopCheckMovement

    upPressed:
        ;; Cambiamos la posicion
        ld a, #player_vel_y
        NEGATE_NUMBER d
        ld a, #0xFC
        ;; Meto dos dec para que avance byte y no pixels
        ld e_vy(ix), a
        ld a, #0x00
        ld e_vx(ix), a
        ;; Actualizamos la orientación
        ld a, #0x03
        ld e_orient(ix), a
        jp stopCheckMovement

    leftPressed:
        ;; Cambiamos la posicion
        ld d, #player_vel_x
        NEGATE_NUMBER d
        ld e_vx(ix), a
        ld a, #0x00
        ld e_vy(ix), a
        ;; Actualizamos la orientación
        ld a, #0x02
        ld e_orient(ix), a
        jp stopCheckMovement

    downPressed:
        ;; Cambiamos la posicion
        ld a, #player_vel_y
        ld e_vy(ix), a
        ld a, #0x00
        ld e_vx(ix), a
        ;; Actualizamos la orientación
        ld a, #0x01
        ld e_orient(ix), a
        jp stopCheckMovement

    rightPressed:
        ;; Cambiamos la posicion
        ld a, #player_vel_x
        ld e_vx(ix), a
        ld a, #0x00
        ld e_vy(ix), a
        ;; Actualizamos la orientación
        ld a, #0x00
        ld e_orient(ix), a
        jp stopCheckMovement

    spacePressed:
        ld a, #0x00
        ld e_vx(ix), a
        ld a, #0x00
        ld e_vy(ix), a   
        call _m_game_playerShot
        jp stopCheckMovement

      .globl nextLevel
      NPressed:
         call nextLevel


    stopCheckMovement:
   ret
