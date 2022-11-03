
.include "resources/templates.h.s"
.include "resources/patrol_data.h.s"
.include "sys/ai.h.s"
.include "sys/ai_beh.h.s"
.include "resources/macros.s"

wave_separator = 0xFF

; todo posicines randomn a veces
; todo spawn warning

; EL TIMER DE EL SIGUEINTE ENEMIGIO TIENE QUE SER SIEMPRE
; MAYOR QUE EL DEL ANTERIOR

; 6 disparando
; tema item

init_wave_time = 50

wave_01:
   ; ==============================================================================
   ; Wave 1 ok
   ; ==============================================================================
   .dw init_wave_time
   .dw #t_e_patrol_blue
   .db 8, 56
   .dw #_sys_ai_behaviourPatrol
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_01
   .dw #enemy_no_shoot

   .dw 140
   .dw #t_e_patrol_blue
   .db 16, 136
   .dw #_sys_ai_behaviourPatrol
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_02
   .dw #enemy_no_shoot

   .dw 190
   .dw #t_e_follow_blue
   .db 32, 170
   .dw #_sys_ai_beh_follow_player_y
   .db 10                                 ; e_ai_aux_l
   .db 10
   .dw 0
   .dw #enemy_no_shoot

   .dw 200
   .dw #t_item_heart_free
   .db 55, 171
   .dw #_sys_ai_beh_item_update
   ITEM_WAVE_ZEROS

   .dw #0x0000
   .db wave_separator 
   ;
   ; ; ==============================================================================
   ; ; Wave 2 ok
   ; ; ==============================================================================
   .dw init_wave_time
   .dw #t_e_patrol_blue
   .db 8, 56
   .dw #_sys_ai_behaviourPatrol
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_05
   .dw #_sys_ai_beh_shoot_y

   .dw 80
   .dw #t_e_patrol_blue
   .db 8, 56
   .dw #_sys_ai_behaviourPatrol
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_05
   .dw #_sys_ai_beh_shoot_y

   .dw 180
   .dw #t_e_patrol_blue
   .db #16
   .db #48
   .dw #_sys_ai_behaviourPatrolRelative
   .db #16                                 ; e_ai_aux_l
   .db #48                                 ; e_ai_aux_h
   .dw #patrol_relative_x_36
   .dw #_sys_ai_beh_shoot_xy_rand

   .dw 260
   .dw #t_e_patrol_blue
   .db #16
   .db #78
   .dw #_sys_ai_behaviourPatrolRelative
   .db #16                                 ; e_ai_aux_l
   .db #78                                 ; e_ai_aux_h
   .dw #patrol_relative_x_36
   .dw #_sys_ai_beh_shoot_xy_rand

   .dw #0x0000
   .db wave_separator 
   ;
   ; ==============================================================================
   ; Wave 3 ok
   ; ==============================================================================
   .dw init_wave_time
   .dw #t_e_patrol_orange
   .db 6, 104
   .dw #_sys_ai_behaviourPatrolRelative
   .db 6                                 ; e_ai_aux_l
   .db 104
   .dw #patrol_relative_y_48
   .dw #_sys_ai_beh_shoot_x

   .dw #100
   .dw #t_e_patrol_orange
   .db 14, 50
   .dw #_sys_ai_behaviourPatrolRelative
   .db 14                                 ; e_ai_aux_l
   .db 50
   .dw #patrol_relative_y_48
   .dw #_sys_ai_beh_shoot_x

   .dw #130
   .dw #t_e_patrol_orange
   .db 26, 50
   .dw #_sys_ai_behaviourPatrolRelative
   .db 26                                 ; e_ai_aux_l
   .db 50
   .dw #patrol_relative_y_48
   .dw #_sys_ai_beh_shoot_x

   .dw #200
   .dw #t_e_patrol_orange
   .db 40, 176
   .dw #_sys_ai_behaviourPatrolRelative
   .db 40                                 ; e_ai_aux_l
   .db 176
   .dw #patrol_relative_x_36
   .dw #_sys_ai_beh_shoot_y

   .dw 205
   .dw #t_item_heart_free
   .db 55, 171
   .dw #_sys_ai_beh_item_update
   ITEM_WAVE_ZEROS

   .dw #0x0000
   .db wave_separator 

   ; ==============================================================================
   ; Wave 4  ok
   ; ==============================================================================
   .dw init_wave_time
   .dw #t_e_seek_blue
   .db 12, 64
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db 24
   .db 24
   .dw #patrol_seeknpatrol_01
   .dw #enemy_no_shoot

   .dw 114
   .dw #t_e_patrol_pink
   .db 6, 104
   .dw #_sys_ai_behaviourPatrolRelative
   .db 6                                 ; e_ai_aux_l
   .db 104
   .dw #patrol_relative_y_48
   .dw #_sys_ai_beh_shoot_x_f

   .dw 132
   .dw #t_e_seek_blue
   .db 32, 64
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db 24
   .db 24
   .dw #patrol_seeknpatrol_01
   .dw #enemy_no_shoot

   .dw 162
   .dw #t_e_seek_blue
   .db 32, 64
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db 24
   .db 24
   .dw #patrol_seeknpatrol_01
   .dw #enemy_no_shoot

   .dw 182
   .dw #t_e_seek_orange
   .db 32, 154
   .dw #_sys_ai_behaviourSeekAndPatrol
   .db 24
   .db 24
   .dw #patrol_seeknpatrol_01
   .dw #_sys_ai_beh_shoot_x

   .dw #0x0000
   .db wave_separator 
   ; ==============================================================================
   ; Wave 5 ok cartas
   ; ==============================================================================
   .dw init_wave_time
   .dw #t_e_letter
   .db 6, 60
   .dw #_sys_ai_behaviourPatrolRelative
   .db 6                                 ; e_ai_aux_l
   .db 160
   .dw #patrol_relative_x_36
   .dw #enemy_no_shoot

   .dw 120
   .dw #t_e_letter
   .db 14, 60
   .dw #_sys_ai_behaviourPatrolRelative
   .db 14                                 ; e_ai_aux_l
   .db 60
   .dw #patrol_relative_x_36
   .dw #enemy_no_shoot

   .dw 140
   .dw #t_e_letter
   .db 22, 60
   .dw #_sys_ai_behaviourPatrolRelative
   .db 22                                 ; e_ai_aux_l
   .db 60
   .dw #patrol_relative_x_36
   .dw #enemy_no_shoot

   .dw 170
   .dw #t_e_letter
   .db 32, 60
   .dw #_sys_ai_behaviourPatrolRelative
   .db 32                                 ; e_ai_aux_l
   .db 60
   .dw #patrol_relative_x_36
   .dw #enemy_no_shoot

   .dw 175
   .dw #t_item_heart_free
   .db 36, 170
   .dw #_sys_ai_beh_item_update
   ITEM_WAVE_ZEROS

   .dw #0x0000
   .db wave_separator 

   ; ==============================================================================
   ; Wave 6 ok cartas
   ; ==============================================================================

   ; .dw 120
   ; .dw #t_e_patrol_pink
   ; .db 6, 60
   ; .dw #_sys_ai_behaviourPatrol
   ; .db 0
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_d
   ;
   ; .dw 120
   ; .dw #t_e_patrol_orange
   ; .db 46, 60
   ; .dw #_sys_ai_behaviourPatrol
   ; .db 0
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_d

   ; .dw 190
   ; .dw #t_e_patrol_pink
   ; .db 6, 160
   ; .dw #_sys_ai_behaviourPatrol
   ; .db 0
   ; .db 0
   ; .dw #patrol_02
   ; .dw #_sys_ai_shoot_bullet_l_xy_rand
   ;
   ; .dw 210
   ; .dw #t_e_patrol_pink
   ; .db 36, 60
   ; .dw #_sys_ai_behaviourPatrol
   ; .db 0
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_shoot_bullet_l_xy_rand

   ; .dw 220
   ; .dw #t_item_heart
   ; .db 60, 170
   ; .dw #_sys_ai_beh_item_update
   ; ITEM_WAVE_ZEROS
   ;
   ; .dw #0x0000
   ; .db wave_separator 

   ; ==============================================================================
   ; BOSS 1
   ; ==============================================================================
   .dw init_wave_time
   .dw #t_final_boss
   .db 33, 88
   .dw #_sys_ai_beh_boss_move
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_boss
   .dw #_sys_ai_beh_boss_shoot

   .dw #0x0000
   .db wave_separator 
   .dw #0x0000
   ; ==============================================================================
   ; GAME END
   ; ==============================================================================


