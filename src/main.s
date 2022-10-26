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

.module Main

.include "cpctelera.h.s"
.include "man/game.h.s"
.include "cpct_globals.h.s"
.include "resources/macros.h.s"

;;
;; Start of _DATA area 
;;  SDCC requires at least _DATA and _CODE areas to be declared, but you may use
;;  any one of them for any purpose. Usually, compiler puts _DATA area contents
;;  right after _CODE area contents.
;;
.area _DATA
;==========
;TODO : Ver donde meto esto es una guarrada tener lo de los macros aqui
;==========
_macro_addresAux:
    .dw #0x0000

.area _CODE

;;
;;MAIN
;;
;===================================================================================================================================================
; FUNCION main
; Inicio del programa
; NO llega ningun valor
;===================================================================================================================================================
_main:
    call	cpct_disableFirmware_asm

    cpctm_setBorder_asm HW_BRIGHT_CYAN
    call _m_game_init
    call _m_game_play
