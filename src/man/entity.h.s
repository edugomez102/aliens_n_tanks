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

;================================================================================
; Function declaration
;================================================================================

.globl _man_entityInit
.globl _man_createEntity
.globl _man_entityForAllMatching
.globl _man_setEntity4Destroy
.globl _man_entityDestroy
.globl _man_entityUpdate
; .globl _man_entity_freeSpace
.globl _man_getEntityArray
.globl _man_getNumEntities
.globl _man_getSizeOfEntity

;================================================================================
; Manager Data
;================================================================================
.globl _m_entities
.globl _m_emptyMemCheck
.globl _m_next_free_entity
.globl _m_functionMemory
.globl _m_signatureMatch
.globl _m_numEntities
.globl _m_sizeOfEntity
.globl _m_playerEntity

