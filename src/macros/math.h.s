;;-----------------------------LICENSE NOTICE------------------------------------
;;  This file is part of The Last Fungus: An Amstrad CPC Game 
;;  Copyright (C) 2021 Miguel Perez Tarruella / Antonio Jose Fernandez Belliure / 
;;                     David Martinez Garcia / Ocacho Games (@OcachoGames)
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Given a certain _increment, increment the _register
;; in _increment times. The register must contain 2 bytes
;;
;; Return: The _register incremented _increment times
;; Modifies: -
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro INCREMENT_REGISTER_2_BYTES _register, _increment

	push bc

	ld bc, #_increment
	add _register,  bc

	pop bc

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Given a certain _increment, increment the _register
;; in _increment times. The register must contain 1 bytes
;;
;; Return: The _register incremented _increment times
;; Modifies: -
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro INCREMENT_REGISTER_1_BYTE _register, _increment

	ld a, _register
	add a, #_increment
	ld _register, a

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Given a certain _decrement, decrement the _register
;; in _decrement times. The register must contain 1 bytes
;;
;; Return: The _register decremented _decrement times
;; Modifies: -
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DECREMENT_REGISTER_1_BYTE _register, _decrement

	ld a, _register
	sub a, #_decrement
	ld _register, a

.endm


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Increase in _n a variable,
;; given the memory direction of the variable itself
;; 
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro INCREMENT_VARIABLE _variable_md, _n
	
	ld hl, (#_variable_md)
	ld bc, #_n
	add hl, bc
	ld (_variable_md), hl

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Decrement in _n a variable,
;; given the memory direction of the variable itself
;; 
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro DECREMENT_VARIABLE _variable_md, _n
	
	ld a, (#_variable_md)
	DECREMENT_REGISTER_1_BYTE a, _n
	ld (_variable_md), a

.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  -
;; Objetive: Calculate the given number negated
;; Return: Return the number negated in the _register
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;.macro NEGATE_NUMBER _n1

;;	ld a, #_n1
;;	xor #FF
;;	add a, #0x01

;;.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  - A: should contain _n1
;; Objetive: Compare if _n1 and _n2 are equals
;;
;; Return: Z = 1 if _n1, _n2 are equals, otherwise Z = 0
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.macro IS_EQUALS _n2
	cp #_n2
.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  - A: should contain _n1
;; Objetive: Compare if _n1 and _n2 are equals
;;
;; Return: Z = 1 if _n1, _n2 are equals, otherwise Z = 0
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.macro IS_EQUALS_REGISTER _register
	cp _register
.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;;  - A: should contain _n1
;; Objetive: Compare if _n1 >  _n2
;;
;; Return: C = 0 if _n1, > _n2, otherwise C = 1
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

.macro IS_HIGHER _n2
	cp #_n2
.endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Pre requirements
;; Objetive: Set the _value as the value of the _variable
;;
;; Modifies: a
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro SET_VARIABLE_VALUE _variable, _value
	ld a, #_value
	ld (#_variable), a
.endm
