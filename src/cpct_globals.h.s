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

;===================================================================================================================================================
; CPCTelera functions
;===================================================================================================================================================
.globl cpct_disableFirmware_asm
.globl cpct_memset_asm
.globl cpct_memcpy_asm
.globl cpct_scanKeyboard_f_asm
.globl cpct_isKeyPressed_asm
.globl cpct_waitHalts_asm
.globl cpct_waitVSYNC_asm
.globl cpct_memcpy_asm
.globl cpct_setDrawCharM0_asm
.globl cpct_drawStringM0_asm
.globl cpct_scanKeyboard_if_asm
.globl cpct_akp_musicInit_asm
.globl cpct_akp_musicPlay_asm
.globl cpct_zx7b_decrunch_s_asm

.globl cpct_drawCharM2_asm


;; TODO: estos van en render
.globl cpct_getScreenPtr_asm
.globl cpct_setVideoMode_asm
.globl cpct_setPALColour_asm
.globl cpct_drawSolidBox_asm
.globl cpct_drawSprite_asm
.globl cpct_drawSpriteVFlip_f_asm
.globl cpct_drawSpriteHFlip_at_asm
