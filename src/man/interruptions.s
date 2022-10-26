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

_int_handler_1::
	push af
	push bc
	push de
	push hl

    ld a, #5
    ld (#_man_int_current), a

	call cpct_scanKeyboard_if_asm

    ld de, #_int_handler_2
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

_int_handler_2::
	push af
	push bc
	push de
	push hl

    ld a, #4
    ld (#_man_int_current), a

    ld de, #_int_handler_3
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

_int_handler_3::
	push af
	push bc
	push de
	push hl

    ld a, #3
    ld (#_man_int_current), a
	call cpct_scanKeyboard_if_asm

    ld de, #_int_handler_4
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

_int_handler_4::
	push af
	push bc
	push de
	push hl

    ld a, #2
    ld (#_man_int_current), a
    ld de, #_int_handler_5
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

_int_handler_5::
	push af
	push bc
	push de
	push hl

    ld a, #1
    ld (#_man_int_current), a
	call cpct_akp_musicPlay_asm

	call cpct_scanKeyboard_if_asm

    ld de, #_int_handler_6
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

_int_handler_6::
	push af
	push bc
	push de
	push hl

    ld a, #0
    ld (#_man_int_current), a

	ld hl, #_man_frames_counter
	dec (hl)
	jr Z, followHandler
	ld a, #1
	ld (hl), a
	followHandler:
	ld de, #_int_handler_1
    call man_interruptions_set_next_interruption

	pop hl
	pop de
	pop bc
	pop af
ei
reti

man_interruptions_set_next_interruption:
	ld hl, #0x38
	ld (hl), #0xC3
	inc hl
	ld (hl), e
	inc hl
	ld (hl), d
	inc hl
	ld (hl), #0xC9
ret

_man_int_setIntHandler::
   	ei
   	im 1
	call cpct_waitVSYNC_asm
	halt 
	halt
	call cpct_waitVSYNC_asm

	ld hl, #0x38
	ld (hl), #0xC3
	inc hl
	ld (hl), #<_int_handler_1
	inc hl
	ld (hl), #>_int_handler_1
	inc hl
	ld (hl), #0xC9
	ei
ret