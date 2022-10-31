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

;;====================================================================
;; GLOBL INCLUDES
;;====================================================================
.include "interruptions.h.s"
.include "cpctelera.h.s"

;;Globals
.include "cpct_globals.h.s"


;;====================================================================
;; VARIABLES
;;====================================================================
_man_int_current:: .db 0

_man_frames_counter:: .db 0

;;====================================================================
;; INTERRUPTION FUNCTIONS
;;====================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 1 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_1::
	push af
	push bc
	push de
	push hl

    ld a, #11
    ld (#_man_int_current), a

	;;Here we set the next interruption to jump to the next int_handler
    ld de, #int_handler_2
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 2 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_2::
	push af
	push bc
	push de
	push hl

    ld a, #10
    ld (#_man_int_current), a

	;;Here we set the next interruption to jump to the next int_handler
    ld de, #int_handler_3
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 3 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_3::
	push af
	push bc
	push de
	push hl
	push ix

    ld a, #9
    ld (#_man_int_current), a

	;;Here we play the music, once per frame
	call cpct_akp_musicPlay_asm

	;;Here we scan the keyboard to see detect the pressed keys
	call cpct_scanKeyboard_if_asm

	;;Here we set the next interruption to jump to the next int_handler
    ld de, #int_handler_4
    call man_interruptions_set_next_interruption

	pop ix
	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 4 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_4::
	push af
	push bc
	push de
	push hl

    ld a, #8
    ld (#_man_int_current), a

	;;Here we set the next interruption to jump to the next int_handler
    ld de, #int_handler_5
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 5 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_5::
	push af
	push bc
	push de
	push hl

    ld a, #7
    ld (#_man_int_current), a

	;;Here we set the next interruption to jump to the next int_handler
    ld de, #int_handler_6
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 6 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_6::
	push af
	push bc
	push de
	push hl

    ld a, #6
    ld (#_man_int_current), a

    ;;Here we set the next interruption to jump to the next int_handler
	ld de, #int_handler_7
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 7 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_7::
	push af
	push bc
	push de
	push hl

    ld a, #5
    ld (#_man_int_current), a

    ;;Here we set the next interruption to jump to the next int_handler
	ld de, #int_handler_8
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 8 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_8::
	push af
	push bc
	push de
	push hl

    ld a, #4
    ld (#_man_int_current), a

    ;;Here we set the next interruption to jump to the next int_handler
	ld de, #int_handler_9
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 9 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_9::
	push af
	push bc
	push de
	push hl
	push ix

    ld a, #3
    ld (#_man_int_current), a

    ;;Here we set the next interruption to jump to the next int_handler
	ld de, #int_handler_10
    call man_interruptions_set_next_interruption

	pop ix
	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 10 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_10::
	push af
	push bc
	push de
	push hl

    ld a, #2
    ld (#_man_int_current), a

    ;;Here we set the next interruption to jump to the next int_handler
	ld de, #int_handler_11
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 11 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_11::
	push af
	push bc
	push de
	push hl

    ld a, #1
    ld (#_man_int_current), a

    ;;Here we set the next interruption to jump to the next int_handler
	ld de, #int_handler_12
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruption 12 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
int_handler_12::
	push af
	push bc
	push de
	push hl

    ld a, #0
    ld (#_man_int_current), a

    ;;Here we set the next interruption to jump to the next int_handler
	ld de, #int_handler_1
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  - DE: should contain the memory direction of the function to execute in the next interruption
;; Objetive: Set the interruption 6 code.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_interruptions_set_next_interruption:
    ;;Here we set the next interruption to jump to the next int_handler
	ld hl, #0x38
	ld (hl), #0xC3
	inc hl
	ld (hl), e
	inc hl
	ld (hl), d
	inc hl
	ld (hl), #0xC9
ret

;;====================================================================
;; INTERRUPTION SETTER
;;====================================================================
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -  
;; Objetive: Set the interruptions in the correct order.
;;
;; Modifies: HL
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
_man_int_setIntHandler::
	;;Here we wait to set always the first interruption to be the same
	call cpct_waitVSYNC_asm
	halt 
	halt
	call cpct_waitVSYNC_asm

	ld hl, #0x38
	ld (hl), #0xC3
	inc hl
	ld (hl), #<int_handler_1
	inc hl
	ld (hl), #>int_handler_1
	inc hl
	ld (hl), #0xC9
ret