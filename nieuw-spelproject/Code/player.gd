extends RigidBody2D

# Exported variables (adjustable in inspector)
@export var speed: float = 60000.0
@export var max_speed: float = 100.0
@export var fuel_capacity: float = 100.0
@export var fuel_consumption_rate: float = 10.0

# Internal variables
var wheels: Array = []
var fuel: float = 100.0

func _ready():
	# Find all wheels in the "wheel" group
	wheels = get_tree().get_nodes_in_group("wheel")
	if wheels.is_empty():
		print("Warning: No wheels found in group 'wheel'!")
	else:
		print("Found ", wheels.size(), " wheels")
	
	# Update UI with initial fuel value
	get_parent().update_fuel_ui(fuel)

func _physics_process(delta):
	# Don't move if no fuel
	if fuel <= 0:
		return
	
	# Handle input
	if Input.is_action_pressed("ui_right"):
		use_fuel(delta)
		apply_torque_to_wheels(speed * delta * 50)
		
	if Input.is_action_pressed("ui_left"):
		use_fuel(delta)
		apply_torque_to_wheels(-speed * delta * 50)
	
	# Debug output
	

func apply_torque_to_wheels(torque: float):
	for wheel in wheels:
		if torque > 0 and wheel.angular_velocity < max_speed:
			wheel.apply_torque_impulse(torque)
		elif torque < 0 and wheel.angular_velocity > -max_speed:
			wheel.apply_torque_impulse(torque)

func refuel(amount: float = fuel_capacity):
	# Add fuel, but don't exceed capacity
	fuel = min(fuel + amount, fuel_capacity)
	
	
	# Update UI
	get_parent().update_fuel_ui(fuel)

func use_fuel(delta):
	# Consume fuel over time
	fuel -= fuel_consumption_rate * delta
	fuel = clamp(fuel, 0.0, fuel_capacity)
	
	# Update UI
	get_parent().update_fuel_ui(fuel)
