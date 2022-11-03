
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
   ; Wave 1
   ; ==============================================================================
   ; .dw init_wave_time
   ; .dw #t_e_patrol_blue
   ; .db 8, 56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #enemy_no_shoot
   ;
   ; .dw 140
   ; .dw #t_e_patrol_blue
   ; .db 16, 136
   ; .dw #_sys_ai_behaviourPatrol
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_02
   ; .dw #enemy_no_shoot
   ;
   ; .dw 190
   ; .dw #t_e_follow_blue
   ; .db 32, 170
   ; .dw #_sys_ai_beh_follow_player_y
   ; .db 10                                 ; e_ai_aux_l
   ; .db 10
   ; .dw 0
   ; .dw #enemy_no_shoot
   ;
   ; .dw 200
   ; .dw #t_item_heart_free
   ; .db 55, 171
   ; .dw #_sys_ai_beh_item_update
   ; ITEM_WAVE_ZEROS
   ;
   ; .dw #0x0000
   ; .db wave_separator 
   ;
   ; ; ==============================================================================
   ; ; Wave 2
   ; ; ==============================================================================
   ; .dw init_wave_time
   ; .dw #t_e_patrol_blue
   ; .db 8, 56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_05
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 80
   ; .dw #t_e_patrol_blue
   ; .db 8, 56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_05
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 180
   ; .dw #t_e_patrol_blue
   ; .db #16
   ; .db #48
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #16                                 ; e_ai_aux_l
   ; .db #48                                 ; e_ai_aux_h
   ; .dw #patrol_relative_x_36
   ; .dw #_sys_ai_beh_shoot_xy_rand
   ;
   ; .dw 260
   ; .dw #t_e_patrol_blue
   ; .db #16
   ; .db #78
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #16                                 ; e_ai_aux_l
   ; .db #78                                 ; e_ai_aux_h
   ; .dw #patrol_relative_x_36
   ; .dw #_sys_ai_beh_shoot_xy_rand
   ;
   ; .dw #0x0000
   ; .db wave_separator 
   ;
   ; ; ==============================================================================
   ; ; Wave 2
   ; ; ==============================================================================
   ; .dw init_wave_time
   ; .dw #t_e_patrol_blue
   ; .db 8, 56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_08
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 80
   ; .dw #t_e_patrol_blue
   ; .db 8, 56
   ; .dw #_sys_ai_behaviourPatrol
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_05
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 180
   ; .dw #t_e_patrol_blue
   ; .db #16
   ; .db #48
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #16                                 ; e_ai_aux_l
   ; .db #48                                 ; e_ai_aux_h
   ; .dw #patrol_relative_x_36
   ; .dw #_sys_ai_beh_shoot_xy_rand
   ;
   ; .dw 260
   ; .dw #t_e_patrol_blue
   ; .db #16
   ; .db #78
   ; .dw #_sys_ai_behaviourPatrolRelative
   ; .db #16                                 ; e_ai_aux_l
   ; .db #78                                 ; e_ai_aux_h
   ; .dw #patrol_relative_x_36
   ; .dw #_sys_ai_beh_shoot_xy_rand
   ;
   ;
   ; ; .dw init_wave_time
   ; ;
   ; ; .dw #t_e_patrol_blue
   ; ; .db 48, 156
   ; ; .dw #ia_no_move
   ; ; .db 0                                 ; e_ai_aux_l
   ; ; .db 0
   ; ; .dw #patrol_03
   ; ; .dw #enemy_no_shoot
   ;
   ; .dw #0x0000
   ; .db wave_separator 
   ; .dw #0x0000
   ; ;
   ; ; ==============================================================================
   ; ; Wave 3
   ; ; ==============================================================================
   ; ; .dw init_wave_time
   ;
   ; ; .dw #t_e_patrol_blue
   ; ; .db 16, 168
   ; ; .dw #_sys_ai_behaviourPatrolRelative
   ; ; .db #16                                 ; e_ai_aux_l
   ; ; .db #168
   ; ; .dw #patrol_relative_x_36
   ; ; .dw #_sys_ai_beh_shoot_y
   ; ;
   ; ; .dw 121
   ; ; .dw #t_e_patrol_blue
   ; ; .db 40, 56
   ; ; .dw #_sys_ai_behaviourPatrol
   ; ; .db #0                                 ; e_ai_aux_l
   ; ; .db #0
   ; ; .dw #patrol_06
   ; ; .dw #enemy_no_shoot
   ;
   ; .dw 140
   ; .dw #t_item_heart
   ; .db 55, 171
   ; .dw #_sys_ai_beh_item_update
   ; ITEM_WAVE_ZEROS

   ; ==============================================================================
   ; Wave 3
   ; ==============================================================================

   ; ==============================================================================
   ; END GAME
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

