.module Items

.include "items.h.s"
.include "man/game.h.s"
.include "resources/templates.h.s"
.include "resources/macros.s"
.include "resources/entityInfo.s"

;===============================================================================
; Item picks
;===============================================================================
item_pick_heart:
   call _man_game_increasePlayerLife
   ret

item_pick_skip:
   call nextLevel
   ret

item_pick_restart:
   call restartLevel
   ret

item_pick_speed_bullet:
   ld hl, #player_bullet_vel_x
   ld (hl), #4
   ld hl, #player_bullet_vel_y
   ld (hl), #8

   ld hl, #player_has_speed_bullet
   ld (hl), #1
   ret

item_pick_shield:
   call item_create_ingame_shield
   ret

item_pick_rotator:
   ld hl, #player_has_rotator
   ld (hl), #1
   call item_create_ingame_rotator
   ret

item_pick_sharp_bullet:
   ld hl , #player_has_sharp_bullet
   ld (hl), #1
   ret

;===============================================================================
; Item create
;===============================================================================

; iy: item colision
item_create_ingame_shield:
   ld bc, #t_ingame_shield
   call _m_game_createInitTemplate
   push hl
   pop ix

   ld a, e_xpos(iy)
   ld e_xpos(ix), a

   ld a, e_ypos(iy)
   ld e_ypos(ix), a

   ret

item_create_ingame_rotator:
   ld bc, #t_ingame_rotator
   call _m_game_createInitTemplate
   push hl
   pop ix

   ld a, e_xpos(iy)
   ld e_xpos(ix), a
   ld e_ai_aux_l(ix), a

   ld a, e_ypos(iy)
   ld e_ypos(ix), a
   ld e_ai_aux_h(ix), a

   ; ld a, e_xpos(iy)
   ;
   ; ld a, e_ypos(iy)

   ret
