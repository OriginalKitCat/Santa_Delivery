extends Node

var was_killed
var lives = 3
var playerhealth = 40
var weaponcooldown = 1.0
var bullet_damage = 5.0
var place_timer = 0.0
var timeToPlace = 3.0
var place_bar_needed = false
var go_transparency_up = false
var go_transparency_down = false

var currentplayerpos
# Checkpoint
var checkpoint_loc
var start_loc
