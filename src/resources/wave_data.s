
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

init_wave_time = 80

wave_01:

   ; ==============================================================================
   ; Wave 1
   ; ==============================================================================
   ; .dw 10
   ; .dw #t_final_boss
   ; .db 48, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_02
   ; .dw #enemy_no_shoot

   .dw 22
   .dw #t_e_patrol_blue
   .db 8, 56
   .dw #ia_no_move
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_01
   .dw #_sys_ai_beh_shoot_y


   .dw 23
   .dw #t_e_patrol_blue
   .db 16, 56
   .dw #ia_no_move
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_01
   .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 24
   ; .dw #t_e_patrol_blue
   ; .db 24, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 25
   ; .dw #t_e_patrol_blue
   ; .db 32, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ;
   .dw 43
   .dw #t_item_speed_bullet
   .db 55, 171
   .dw #_sys_ai_beh_item_update
   ITEM_WAVE_ZEROS

   .dw #0x0000
   .db wave_separator 

   ; ==============================================================================
   ; Wave 2
   ; ==============================================================================
   ; .dw 22
   ; .dw #t_e_patrol_blue
   ; .db 8, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 23
   ; .dw #t_e_patrol_blue
   ; .db 16, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 24
   ; .dw #t_e_patrol_blue
   ; .db 24, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 25
   ; .dw #t_e_patrol_blue
   ; .db 32, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw #0x0000
   ; .db wave_separator 

   ; .dw 22
   ; .dw #t_e_patrol_blue
   ; .db 8, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 23
   ; .dw #t_e_patrol_blue
   ; .db 16, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 24
   ; .dw #t_e_patrol_blue
   ; .db 24, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 25
   ; .dw #t_e_patrol_blue
   ; .db 32, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y

   ; .dw #0x0000
   ; .db wave_separator 

   ; .dw 22
   ; .dw #t_e_patrol_blue
   ; .db 8, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 23
   ; .dw #t_e_patrol_blue
   ; .db 16, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 24
   ; .dw #t_e_patrol_blue
   ; .db 24, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw 25
   ; .dw #t_e_patrol_blue
   ; .db 32, 56
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_01
   ; .dw #_sys_ai_beh_shoot_y
   ;
   ; .dw #0x0000
   ; .db wave_separator 



   ; .dw 50
   ; .dw #t_e_patrol_blue
   ; .db 48, 156
   ; .dw #ia_no_move
   ; .db 0                                 ; e_ai_aux_l
   ; .db 0
   ; .dw #patrol_02
   ; .dw #enemy_no_shoot

   .dw init_wave_time

   .dw #t_e_patrol_blue
   .db 48, 156
   .dw #ia_no_move
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_03
   .dw #enemy_no_shoot

   .dw #0x0000
   .db wave_separator 
   ;
   ; ==============================================================================
   ; Wave 3
   ; ==============================================================================
   .dw init_wave_time

   .dw #t_e_patrol_blue
   .db 16, 168
   .dw #_sys_ai_behaviourPatrolRelative
   .db #16                                 ; e_ai_aux_l
   .db #168
   .dw #patrol_relative_x_36
   .dw #_sys_ai_beh_shoot_y

   .dw 121
   .dw #t_e_patrol_blue
   .db 40, 56
   .dw #_sys_ai_behaviourPatrol
   .db #0                                 ; e_ai_aux_l
   .db #0
   .dw #patrol_06
   .dw #enemy_no_shoot

   ; .dw 200
   ; .dw #t_item_heart
   ; .db 55, 171
   ; .dw #_sys_ai_beh_item_update
   ; ITEM_WAVE_ZEROS


   ; ==============================================================================
   ; END GAME
   ; ==============================================================================
   .dw #0x0000
   .db wave_separator 
   .dw #0x0000

; .dw 26
; .dw #t_e_patrol_blue
; .db 40, 56
; .dw #ia_no_move
; .db 0                                 ; e_ai_aux_l
; .db 0
; .dw #patrol_01
; .dw #_sys_ai_beh_shoot_y

; .dw 42
; .dw #t_e_patrol_blue
; .db 68, 56
; .dw #ia_no_move
; .db 0                                 ; e_ai_aux_l
; .db 0
; .dw #patrol_01
; .dw #enemy_no_shoot
;
