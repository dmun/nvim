(add :EggbertFluffle/beepboop.nvim)
(let [beepboop (require :beepboop)
      anvil [:random/anvil_land.ogg]
      stone [:dig/stone1.ogg
             :dig/stone2.ogg
             :dig/stone3.ogg
             :dig/stone4.ogg]
      amethyst_break [:block/amethyst/break1.ogg
                      :block/amethyst/break2.ogg
                      :block/amethyst/break3.ogg
                      :block/amethyst/break4.ogg]
      amethyst_cluster_break [:block/amethyst_cluster/break1.ogg
                              :block/amethyst_cluster/break2.ogg
                              :block/amethyst_cluster/break3.ogg
                              :block/amethyst_cluster/break4.ogg]
      door_open [:block/wooden_door/open.ogg
                 :block/wooden_door/open2.ogg
                 :block/wooden_door/open3.ogg
                 :block/wooden_door/open4.ogg]
      door_close [:block/wooden_door/close.ogg
                  :block/wooden_door/close2.ogg
                  :block/wooden_door/close3.ogg
                  :block/wooden_door/close4.ogg]
      copper_step [:block/copper/step1.ogg
                   :block/copper/step2.ogg
                   :block/copper/step3.ogg
                   :block/copper/step4.ogg
                   :block/copper/step5.ogg
                   :block/copper/step6.ogg]
      sound_map [{:auto_command :VimEnter :sounds door_open}
                 {:auto_command :VimLeave :sounds door_close}]]
                 ; {:auto_command :TextChangedI :sounds stone}
                 ; {:auto_command :TextYankPost :sounds amethyst_break}
                 ; {:auto_command :InsertEnter :sounds amethyst_break}
                 ; {:auto_command :InsertLeave :sounds amethyst_break}
                 ; {:key_map {:mode :n :key_chord :p} :sounds amethyst_cluster_break}]]
  (beepboop.setup {:audio_player :paplay :max_sounds 20 : sound_map}))

