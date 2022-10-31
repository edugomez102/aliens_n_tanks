
.include "resources/templates.h.s"
.include "resources/patrol_data.h.s"
.include "sys/ai.h.s"
.include "sys/ai_beh.h.s"
.include "resources/macros.s"

wave_separator = 0xFF

wave_new_entity = 0x01
wave_restart = 0x00

wave_01:

   ; ==============================================================================
   ; Wave 1
   ; ==============================================================================
   .dw 12
   .dw #t_enemy_basic_green
   .db 48, 56
   .dw #ia_no_move
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_02
   .dw #enemy_no_shoot

   .dw 42
   .dw #t_enemy_basic_green
   .db 68, 56
   .dw #ia_no_move
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_01
   .dw #enemy_no_shoot

   .dw #0x000
   .db wave_separator 


   ; ==============================================================================
   ; Wave 2
   ; ==============================================================================
   .dw 20
   .dw #t_enemy_basic_green
   .db 48, 156
   .dw #ia_no_move
   .db 0                                 ; e_ai_aux_l
   .db 0
   .dw #patrol_02
   .dw #enemy_no_shoot

   .dw #0x000
   .db wave_separator 

