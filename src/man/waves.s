.module Spawner

.include "cpctelera.h.s"
.include "cpct_globals.h.s"
.include "game.h.s"
.include "resources/wave_data.h.s"
.include "resources/entityInfo.s"
.include "sys/render.h.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Public
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; man_wave_is_waiting: .dw #0

wave_wait_between = 40
wave_waiter_time: .db #0

wave_current_time: .dw #0
wave_next_time: .dw #0

wave_last_spawn: .dw #0
wave_current_dir: .dw #0

wave_timer_is_stop: .db #0
wave_counter: .dw #0

; TODO spawn warning


man_wave_init:
   ld hl, #wave_current_dir
   ld de, #wave_01

   ld (hl), d
   inc hl
   ld (hl), e

   ex de, hl
   call man_wave_set_next_entity_time

   inc hl
   call man_wave_set_last_dir

   ;; game restart

   ld hl, #wave_current_time
   ld (hl), #0
   inc hl
   ld (hl), #0

   ld hl, #wave_timer_is_stop
   ld (hl), #0
   ld hl, #wave_counter

   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Comprueba si no qeudan mas enemigos y llama a wave reset para 
;; pasar a la siguiente
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_wave_check_if_reset:
   ld hl, #_m_enemyCounter
   ld a, (hl)
   or a

   jr z, man_wave_reset_local
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Cuando se ha spawneado toda la wave y el jugador la ha matado toda
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_wave_reset_local:
   ld hl, #wave_current_time
   ld (hl), #0
   inc hl
   ld (hl), #0

   ld hl, #wave_timer_is_stop
   ld (hl), #0

   call man_wave_insert_cur_dir_hl
   inc hl

   call man_wave_set_next_entity_time
   inc hl
   call man_wave_set_last_dir

   ld hl, #wave_counter
   inc (hl)

   ; TODO render next wave
   call _sys_render_next_wave

   ret

man_wave_update:
   call man_wave_inc_timer

   ld a, (wave_timer_is_stop)
   cp #1
   call z, man_wave_check_if_reset
   jr  nz, wave_update_active_timer

   ret

   wave_update_active_timer:
      call man_wave_check_if_same_times
      call z, man_wave_spawn_next_entity

   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Incrementa el tiempo transurrido desde el incio de la wave
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_wave_inc_timer:
   ld a, (wave_timer_is_stop)
   or a
   ret nz

   ld hl, #wave_current_time
   inc (hl)

   ld a, (hl)
   cp #0xFF
   jp z, inc_time_second_byte
   ret

   inc_time_second_byte:
      inc hl
      inc (hl)
   ret

man_wave_stop_timer:
   ld hl, #wave_timer_is_stop
   ld (hl), #1
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Comprueba los contadores de las entidades con el wave_current_time
;; Deja Z en caso de tener que spawnear
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_wave_check_if_same_times:
   ld hl, #wave_current_time+1
   ld d, (hl)

   ld bc, #wave_next_time+1
   ld a, (bc)

   cp d
   jr z, first_timer_byte_same
   ret

   first_timer_byte_same:
      dec hl
      ld d, (hl)

      dec bc
      ld a, (bc)
      cp d

   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HL: dir que contiene next time
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_wave_set_next_entity_time:
   ld de, #wave_next_time

   ld a, (hl)
   ld (de), a

   inc de
   inc hl

   ld a, (hl)
   ld (de), a
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; HL: new last dir
;; return DE: current dir
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_wave_set_last_dir:
   ex de, hl
   ld hl, #wave_current_dir

   ld (hl), d
   inc hl
   ld (hl), e

   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Return HL: wave_current_dir dir
;; Destroy DE
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_wave_insert_cur_dir_hl:
   ld de, #wave_current_dir
   ld a, (de)
   ld h, a
   inc de
   ld a, (de)
   ld l, a
   ret

man_wave_spawn_next_entity:
   call man_wave_insert_cur_dir_hl

   ld c, (hl)
   inc hl
   ld b, (hl)

   push hl

   call _m_game_createInitTemplate
   ld__ix_hl

   ld a, e_type(ix)
   cp #e_type_item
   jr z, inc_enemy_counter_no

   inc_enemy_counter_yes:
      ld hl, #_m_enemyCounter
      inc (hl)
   inc_enemy_counter_no:

   pop hl

   ;; Set members of entity from dir
   inc hl
   ld a, (hl)
   ld e_xpos(ix), a

   inc hl
   ld a, (hl)
   ld e_ypos(ix), a

   inc hl
   ld a, (hl)
   ld e_aibeh1(ix), a

   inc hl
   ld a, (hl)
   ld e_aibeh2(ix), a

   inc hl
   ld a, (hl)
   ld e_ai_aux_l(ix), a

   inc hl
   ld a, (hl)
   ld e_ai_aux_h(ix), a

   inc hl
   ld a, (hl)
   ld e_patrol_step_l(ix), a

   inc hl
   ld a, (hl)
   ld e_patrol_step_h(ix), a

   inc hl
   ld a, (hl)
   ld e_inputbeh1(ix), a

   inc hl
   ld a, (hl)
   ld e_inputbeh2(ix), a

   inc hl
   call man_wave_set_next_entity_time

   inc hl
   call man_wave_set_last_dir

   call man_wave_check_if_wave_end
   call z, man_wave_stop_timer

   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Activa el Flag Z si hay un wave_separator despues de la entidad 
;; spawneada de la lista
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
man_wave_check_if_wave_end:
   call man_wave_insert_cur_dir_hl
   ld a, (hl)
   cp #0xFF
   ret


; TODO
man_wave_check_end:
   ret


