RSRC                 	   Resource            ’’’’’’’’   SpawnDataResource                                             w      .    GPUParticles2D    resource_local_to_scene    resource_name 
   load_path    script    atlas    region    margin    filter_clip    animations    custom_solver_bias    radius 
   min_value 
   max_value    bake_resolution    _data    point_count    width    texture_mode    curve    interpolation_mode    interpolation_color_space    offsets    colors 	   gradient    use_hdr    lifetime_randomness    emission_shape    emission_sphere_radius    particle_flag_align_y    particle_flag_rotate_y    particle_flag_disable_z 
   direction    spread 	   flatness    gravity    initial_velocity_min    initial_velocity_max    angular_velocity_min    angular_velocity_max    angular_velocity_curve    orbit_velocity_min    orbit_velocity_max    orbit_velocity_curve    linear_accel_min    linear_accel_max    linear_accel_curve    radial_accel_min    radial_accel_max    radial_accel_curve    tangential_accel_min    tangential_accel_max    tangential_accel_curve    damping_min    damping_max    damping_curve 
   angle_min 
   angle_max    angle_curve 
   scale_min 
   scale_max    scale_curve    color    color_ramp    color_initial_ramp    hue_variation_min    hue_variation_max    hue_variation_curve    turbulence_enabled    turbulence_noise_strength    turbulence_noise_scale    turbulence_noise_speed    turbulence_noise_speed_random    turbulence_influence_min    turbulence_influence_max $   turbulence_initial_displacement_min $   turbulence_initial_displacement_max    turbulence_influence_over_life    anim_speed_min    anim_speed_max    anim_speed_curve    anim_offset_min    anim_offset_max    anim_offset_curve    sub_emitter_mode    sub_emitter_keep_velocity    attractor_interaction_enabled    collision_mode    collision_use_scale 	   _bundled    bullet_scene    move_speed    contact_damage    sprite    spawn_animation    collision_shape    collision_pos_offset    follow_range    keep_following    bullet_resource    bullet_damage    bullet_speed    bullet_lifetime    delay_betweeen_shots    enemy_ai_movement    enemy_icon    enemy_type    enemy_name    max_health    stage_xp_value    weapon_xp_value 
   drop_pool    enemy_shell_resource    time_start 	   time_end    enemy_resource    enemy_amount    spawn_delay 
      Script #   res://Scripits/Enemy/spawn_data.gd ’’’’’’’’   Script '   res://Scripits/Enemy/enemy_resource.gd ’’’’’’’’
   Texture2D $   res://Art/Enemies/DiamondTurret.png Š(>żŌlųT   Script /   res://Scripits/Enemy/shell_turrent_resource.gd ’’’’’’’’
   Texture2D    res://Art/EnemySpawn.png DDD'/c   Script "   res://Scripits/bullet_resource.gd ’’’’’’’’   Script    res://Scripits/bullet.gd ’’’’’’’’
   Texture2D    res://Art/Bubble.png ķõķ TA   Script )   res://Scripits/particle_system_bullet.gd ’’’’’’’’   Script '   res://Scripits/Enemy/grunt_enemy_ai.gd ’’’’’’’’    "   local://CompressedTexture2D_o3no4 Ę         local://AtlasTexture_x0a7u D         local://AtlasTexture_hqasl          local://AtlasTexture_ko0yb Ī         local://AtlasTexture_ovcuk          local://AtlasTexture_whrso X         local://AtlasTexture_onp1y          local://AtlasTexture_ht2ks ā         local://AtlasTexture_fbyrd '         local://AtlasTexture_a7bwq l         local://AtlasTexture_85ppk ±         local://AtlasTexture_b0gjs ö         local://AtlasTexture_kybqx ;         local://AtlasTexture_nm0ew          local://AtlasTexture_0xoyr Å         local://AtlasTexture_m47m6 
         local://SpriteFrames_22ciw O         local://CircleShape2D_ok3iv r         local://Curve_lmfq4          local://CurveTexture_wcsyp .         local://Curve_qi7yh [         local://CurveTexture_mvcyf e         local://Gradient_86feu           local://GradientTexture1D_vm8r4 ’      &   local://ParticleProcessMaterial_ti5rs 1         local://CircleShape2D_xs4dr A         local://PackedScene_yipnv k         local://Resource_wf6vs ”"         local://Resource_djwf3 Ņ"         local://Resource_5au2p ó"         local://Resource_gp4cj Ō#         local://Resource_cutcr `$         CompressedTexture2D          N   res://.godot/imported/DiamondTurret.png-f30e55883873fa42befdcd7956ab9c1a.ctex          AtlasTexture                                A  A         AtlasTexture                        A      A  A         AtlasTexture                         B      A  A         AtlasTexture                        @B      A  A         AtlasTexture                            A  A  A         AtlasTexture                        A  A  A  A         AtlasTexture                         B  A  A  A         AtlasTexture                        @B  A  A  A         AtlasTexture                             B  A  A         AtlasTexture                        A   B  A  A         AtlasTexture                         B   B  A  A         AtlasTexture                        @B   B  A  A         AtlasTexture                            @B  A  A         AtlasTexture                        A  @B  A  A         AtlasTexture                         B  @B  A  A         SpriteFrames    
                     name ,      default       speed       @      loop              frames                   texture             	   duration      ?            texture             	   duration      ?            texture             	   duration      ?            texture             	   duration      ?            texture             	   duration      ?            texture             	   duration      ?            texture             	   duration      ?            texture             	   duration      ?            texture       	      	   duration      ?            texture       
      	   duration      ?            texture             	   duration      ?            texture             	   duration      ?            texture             	   duration      ?            texture             	   duration      ?            texture             	   duration      ?         CircleShape2D             Curve            “Ć        “C      
   
   łČ;rĄ                            
   ±??  “Ć                                              CurveTexture                         Curve             
         ?                            
   ń?S??                            
   ¼9?B×>   /Ą   /Ą              
   äłt?­”¼>                            
     ?                                                  CurveTexture                      	   Gradient       !      Ėg”>¾L?[(A?   $      Śāā>=Æ°0>  ?”×?”×?”×?  ?ųŻ@?    ;ó<  ?         GradientTexture1D                         ParticleProcessMaterial            >                 ?          !            ?    "         B$                  %        ?&        @@)            *          +          ,          <      >=      333?>            @                     CircleShape2D             @         PackedScene    Z      	         names "         EnemyBullet    Area2D    texture_filter    collision_layer    collision_mask 	   priority    script    speed 	   lifetime    GPUParticles2D    GPUParticles2D    amount    process_material    texture 	   lifetime    speed_scale    trail_lifetime    script 	   Sprite2D 	   Sprite2D    texture    CollisionShape2D    CollisionShape2D    shape    _on_body_entered    body_entered    _on_bullet_destroy    destroy    _on_gpu_particles_2d_kill    kill    	   variants                                           2                                       A      @)   {®Gįz?                                 node_count             nodes     <   ’’’’’’’’       ’’’’                                                     @    
   	   ’’’’                  	      
                           @          ’’’’               @          ’’’’                   conn_count             conns          @  @                   @  @                   @  @                       node_paths    	                                                                                                 editable_instances              version             	   Resource                [            	   Resource             	   	   Resource                \      P   ]         ^             _            `            a   
           b      d   c          d            e         f      P   g         h         @i            	   Resource 	               j            k          l         Turret m      <   n        @o        ?p      q            	   Resource                 r      “   s      š   t            u         v         RSRC