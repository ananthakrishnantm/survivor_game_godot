extends CharacterBody3D

@export var speed = 14
@export var fall_acceleration = 75
@onready var anim_tree = $AnimationTree
var target_velocity = Vector3.ZERO


func _process(_delta):
	_update_animation_paramaeters()
	
	



func _physics_process(delta):
	var direction = Vector3.ZERO
	var blend_x = 0.0
	var blend_y = 0.0
	
	# Get the mouse position and calculate the direction towards it
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_length = 50
	var from = $Marker3D/Camera.project_ray_origin(mouse_pos)
	var to = from + $Marker3D/Camera.project_ray_normal(mouse_pos) * ray_length
	var space = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collide_with_areas = true
	var raycast_result = space.intersect_ray(ray_query)
	
	#check raycast with mouse to see if it hits a surface
	if raycast_result.size()>0:
		if raycast_result["collider"] != null:
			var target_position = raycast_result["position"]
			$Armature.look_at(Vector3(target_position.x, 0, target_position.z), Vector3.UP)

			# Calculate the direction towards the mouse position
			var mouse_direction = target_position - global_transform.origin
			mouse_direction.y = 0  # Ensure direction is in the XZ plane

			# Calculate the angle between character's forward direction and mouse direction
			var forward = global_transform.basis.z.normalized()
			var mouse_dir_normalized = mouse_direction.normalized()
			var angle = atan2(forward.x * mouse_dir_normalized.z - forward.z * mouse_dir_normalized.x,
							  forward.x * mouse_dir_normalized.x + forward.z * mouse_dir_normalized.z)
			if angle < 0:
				angle += 2 * PI

			# Set animation blend parameters based on the angle between forward direction and mouse direction
			
			# when mouse location at below
			if angle < PI / 4 or angle > 7 * PI / 4:
				#print("Mouse is below")
				if Input.is_action_pressed("Right"):
					direction += global_transform.basis.x
					blend_x = -1.0
				if Input.is_action_pressed("Left"):
					direction -= global_transform.basis.x
					blend_x = 1.0
				if Input.is_action_pressed("Back"):
					direction += global_transform.basis.z
					blend_y = -1.0
				if Input.is_action_pressed("Forward"):
					direction -= global_transform.basis.z
					blend_y = 1.0
					
			# when mouse location at Left        
			elif angle >= PI / 4 and angle < 3 * PI / 4:
				#print("Mouse is left")
				if Input.is_action_pressed("Right"):
					direction += global_transform.basis.x
					blend_y = 1.0
				if Input.is_action_pressed("Left"):
					direction -= global_transform.basis.x
					blend_y = -1.0
				if Input.is_action_pressed("Back"):
					direction += global_transform.basis.z
					blend_x = -1.0
				if Input.is_action_pressed("Forward"):
					direction -= global_transform.basis.z
					blend_x = 1.0
					
			# when mouse is at top
			elif angle >= 3 * PI / 4 and angle < 5 * PI / 4:
				#print("Mouse is top")
				if Input.is_action_pressed("Right"):    
					direction += global_transform.basis.x
					blend_x = 1.0
				if Input.is_action_pressed("Left"):
					direction -= global_transform.basis.x
					blend_x = -1.0
				if Input.is_action_pressed("Back"):
					direction += global_transform.basis.z
					blend_y = 1.0
				if Input.is_action_pressed("Forward"):
					direction -= global_transform.basis.z
					blend_y = -1.0
					
			# when mouse location at right
			elif angle >= 5 * PI / 4 and angle < 7 * PI / 4:
				#print("Mouse is right")
				if Input.is_action_pressed("Right"):
					direction += global_transform.basis.x  # Change to basis.z for moving in the correct direction
					blend_y = -1.0
				if Input.is_action_pressed("Left"):
					direction -= global_transform.basis.x  # Change to basis.z for moving in the correct direction
					blend_y = 1.0
				if Input.is_action_pressed("Back"):
					direction += global_transform.basis.z
					blend_x = 1.0
				if Input.is_action_pressed("Forward"):
					direction -= global_transform.basis.z
					blend_x = -1.0
	else:
		pass
		
	
	# Normalize the direction
	if direction != Vector3.ZERO:
		direction = direction.normalized()

	# Calculate the target velocity based on the direction and speed
	target_velocity = direction * speed
	
	
	
	# Apply gravity if the character is not on the floor
	if !is_on_floor():
		target_velocity.y -= fall_acceleration * delta

	# Set the character's velocity
	velocity = target_velocity

	# Update animation tree parameters based on the movement and mouse direction
	anim_tree.set("parameters/BlendTree/BlendSpace2D/blend_position", Vector2(blend_x, blend_y))


	# Move and slide the character
	move_and_slide()

func _update_animation_paramaeters():
	
	#Attack Animation
	if Input.is_action_just_pressed("Attack"):
		anim_tree.set("parameters/BlendTree/OneShot/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
