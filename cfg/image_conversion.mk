##-----------------------------LICENSE NOTICE------------------------------------
##  This file is part of CPCtelera: An Amstrad CPC Game Engine 
##  Copyright (C) 2018 ronaldo / Fremos / Cheesetea / ByteRealms (@FranGallegoBR)
##
##  This program is free software: you can redistribute it and/or modify
##  it under the terms of the GNU Lesser General Public License as published by
##  the Free Software Foundation, either version 3 of the License, or
##  (at your option) any later version.
##
##  This program is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU Lesser General Public License for more details.
##
##  You should have received a copy of the GNU Lesser General Public License
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.
##------------------------------------------------------------------------------
############################################################################
##                        CPCTELERA ENGINE                                ##
##                 Automatic image conversion file                        ##
##------------------------------------------------------------------------##
## This file is intended for users to automate image conversion from JPG, ##
## PNG, GIF, etc. into C-arrays.                                          ##
############################################################################

##
## NEW MACROS
##

## 16 colours palette
#PALETTE=0 1 2 3 6 9 11 12 13 15 16 18 20 24 25 26

## Default values
#$(eval $(call IMG2SP, SET_MODE        , 0                  ))  { 0, 1, 2 }
#$(eval $(call IMG2SP, SET_MASK        , none               ))  { interlaced, none }
#$(eval $(call IMG2SP, SET_FOLDER      , src/               ))
#$(eval $(call IMG2SP, SET_EXTRAPAR    ,                    ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))	{ sprites, zgtiles, screen }
#$(eval $(call IMG2SP, SET_OUTPUT      , c                  ))  { bin, c }
#$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
#$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette ))
#$(eval $(call IMG2SP, CONVERT         , img.png , w, h, array, palette, tileset))


PALETTE=0 2 3 6 13 14 15 16 18 20 21 22 23 24 25 26

## ========== MAPA ========== 
$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette ))
$(eval $(call IMG2SP, SET_FOLDER      , src/assets/maps  ))
$(eval $(call IMG2SP, SET_IMG_FORMAT  , zgtiles  ))
$(eval $(call IMG2SP, CONVERT         , assets/tileset.png , 8, 8, tileset,,))

## ========== TANQUE Y BALAS ========== 
$(eval $(call IMG2SP, SET_FOLDER      , src/assets/sprites               ))
# $(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette ))
$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            )) #	{ sprites, zgtiles, screen }
$(eval $(call IMG2SP, CONVERT         , assets/tanque.png , 8, 12, tanque,,))
$(eval $(call IMG2SP, CONVERT         , assets/verticalBullet.png , 6, 6, vBullet,,))
$(eval $(call IMG2SP, CONVERT         , assets/horizBullet.png , 4, 8, hBullet,,))
$(eval $(call IMG2SP, CONVERT         , assets/test.png , 4, 4, test,,))
$(eval $(call IMG2SP, CONVERT         , assets/HUD.png , 12, 16, HUDLife,,))
$(eval $(call IMG2SP, CONVERT         , assets/scoreNumeros.png , 8, 8, spriteScore,,))

# 24, 16
$(eval $(call IMG2SP, CONVERT         , assets/ovniGreen.png , 8, 12, ovni_green,,))
$(eval $(call IMG2SP, CONVERT         , assets/ovniBlue.png , 8, 12, ovni_blue,,))
$(eval $(call IMG2SP, CONVERT         , assets/ovniPurple.png , 8, 12, ovni_purple,,))
$(eval $(call IMG2SP, CONVERT         , assets/ovniRed.png , 8, 12, ovni_red,,))
$(eval $(call IMG2SP, CONVERT         , assets/ovniExplosion.png , 8, 12, ovni_exp,,))

$(eval $(call IMG2SP, CONVERT         , assets/final_boss2.png , 20, 22, final_boss,,))

# 3
$(eval $(call IMG2SP, CONVERT         , assets/ovniPortal.png , 12, 16, ovni_portal,,))

$(eval $(call IMG2SP, CONVERT         , assets/ovniBullet.png , 4, 6, ovni_bullet,,))

## ========== NEXT STAGE ========== 
$(eval $(call IMG2SP, SET_FOLDER      , src/assets/sprites               ))
$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            )) #	{ sprites, zgtiles, screen }
$(eval $(call IMG2SP, CONVERT         , assets/png/nextStage.png , 124, 44, nextStage,,))

$(eval $(call IMG2SP, CONVERT         , assets/png/numback.png , 24, 16, numback,,))

## ========== ITEMS ========== 
$(eval $(call IMG2SP, CONVERT         , assets/item_heart.png, 14, 16, heart_item_sprite,,))
$(eval $(call IMG2SP, CONVERT         , assets/item_heart_free.png, 14, 16, heart_item_free_sprite,,))
$(eval $(call IMG2SP, CONVERT         , assets/item_shield.png, 14, 16, shield_item_sprite,,))
$(eval $(call IMG2SP, CONVERT         , assets/item_restart.png, 14, 16, restart_item_sprite,,))
$(eval $(call IMG2SP, CONVERT         , assets/item_skip.png, 14, 16, skip_item_sprite,,))
$(eval $(call IMG2SP, CONVERT         , assets/item_skip_to_boss.png, 14, 16, skip_to_boss_item_sprite,,))
$(eval $(call IMG2SP, CONVERT         , assets/item_speed_bullet.png, 14, 16, speed_b_item_sprite,,))
$(eval $(call IMG2SP, CONVERT         , assets/item_rotator.png, 14, 16, rotator_item_sprite,,))
$(eval $(call IMG2SP, CONVERT         , assets/item_sharp_bullet.png, 14, 16, sharp_bullet_sprite,,))

$(eval $(call IMG2SP, CONVERT         , assets/shield_ingame.png, 12, 16, shield_ingame_sprite,,))
$(eval $(call IMG2SP, CONVERT         , assets/rotator_ingame.png , 4, 6, rotator_ingame_sprite,,))


## ========== PNG ENTEROS ========== 
$(eval $(call IMG2SP, SET_IMG_FORMAT  , screen  ))
$(eval $(call IMG2SP, SET_OUTPUT      , bin ))

$(eval $(call IMG2SP, CONVERT         , assets/png/MenuPrincipal.png , 160, 200, MenuPrincipal,,))
$(eval $(call IMG2SP, CONVERT         , assets/png/GameEnd.png , 160, 200, GameEnd,,))
$(eval $(call IMG2SP, CONVERT         , assets/png/victoryScreen.png , 160, 200, victoryScreen,,))


##
## OLD MACROS (For compatibility)
##

## Example firmware palette definition as variable in cpct_img2tileset format

# PALETTE={0 1 3 4 7 9 10 12 13 16 19 20 21 24 25 26}

## AUTOMATED IMAGE CONVERSION EXAMPLE (Uncomment EVAL line to use)
##
##    This example would convert img/example.png into src/example.{c|h} files.
##    A C-array called pre_example[24*12*2] would be generated with the definition
##    of the image example.png in mode 0 screen pixel format, with interlaced mask.
##    The palette used for conversion is given through the PALETTE variable and
##    a pre_palette[16] array will be generated with the 16 palette colours as 
##	  hardware colour values.

#$(eval $(call IMG2SPRITES,img/example.png,0,pre,24,12,$(PALETTE),mask,src/,hwpalette))



############################################################################
##              DETAILED INSTRUCTIONS AND PARAMETERS                      ##
##------------------------------------------------------------------------##
##                                                                        ##
## Macro used for conversion is IMG2SPRITES, which has up to 9 parameters:##
##  (1): Image file to be converted into C sprite (PNG, JPG, GIF, etc)    ##
##  (2): Graphics mode (0,1,2) for the generated C sprite                 ##
##  (3): Prefix to add to all C-identifiers generated                     ##
##  (4): Width in pixels of each sprite/tile/etc that will be generated   ##
##  (5): Height in pixels of each sprite/tile/etc that will be generated  ##
##  (6): Firmware palette used to convert the image file into C values    ##
##  (7): (mask / tileset / zgtiles)                                       ##
##     - "mask":    generate interlaced mask for all sprites converted    ##
##     - "tileset": generate a tileset array with pointers to all sprites ##
##     - "zgtiles": generate tiles/sprites in Zig-Zag pixel order and     ##
##                  Gray Code row order                                   ##
##  (8): Output subfolder for generated .C/.H files (in project folder)   ##
##  (9): (hwpalette)                                                      ##
##     - "hwpalette": output palette array with hardware colour values    ##
## (10): Aditional options (you can use this to pass aditional modifiers  ##
##       to cpct_img2tileset)                                             ##
##                                                                        ##
## Macro is used in this way (one line for each image to be converted):   ##
##  $(eval $(call IMG2SPRITES,(1),(2),(3),(4),(5),(6),(7),(8),(9), (10))) ##
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##                                                                        ##
##  * You can omit parameters but leaving them empty. Therefore, if you   ##
##  wanted to specify an output folder but do not want your sprites to    ##
##  have mask and/or tileset, you may omit parameter (7) leaving it empty ##
##     $(eval $(call IMG2SPRITES,imgs/1.png,0,g,4,8,$(PAL),,src/))        ##
############################################################################
