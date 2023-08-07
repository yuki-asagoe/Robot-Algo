function go_straight()
	modules.wheels.r_front_wheel.rotate(1)
	modules.wheels.r_back_wheel.rotate(1)
	modules.wheels.l_front_wheel.rotate(1)
	modules.wheels.l_back_wheel.rotate(1)
end

function go_back()
	modules.wheels.r_front_wheel.rotate(-1)
	modules.wheels.r_back_wheel.rotate(-1)
	modules.wheels.l_front_wheel.rotate(-1)
	modules.wheels.l_back_wheel.rotate(-1)
end

function go_right()
	modules.wheels.r_front_wheel.rotate(-1)
	modules.wheels.r_back_wheel.rotate(1)
	modules.wheels.l_front_wheel.rotate(1)
	modules.wheels.l_back_wheel.rotate(-1)
end

function go_left()
	modules.wheels.r_front_wheel.rotate(1)
	modules.wheels.r_back_wheel.rotate(-1)
	modules.wheels.l_front_wheel.rotate(-1)
	modules.wheels.l_back_wheel.rotate(1)
end

function turn_right()
	modules.wheels.r_front_wheel.rotate(-1)
	modules.wheels.r_back_wheel.rotate(-1)
	modules.wheels.l_front_wheel.rotate(1)
	modules.wheels.l_back_wheel.rotate(1)
end

function turn_left()
	modules.wheels.r_front_wheel.rotate(1)
	modules.wheels.r_back_wheel.rotate(1)
	modules.wheels.l_front_wheel.rotate(-1)
	modules.wheels.l_back_wheel.rotate(-1)
end
function grip_down()
	modules.arms.grip_servo.rotate(-1)
end
function grip_up()
	modules.arms.grip_servo.rotate(1)
end

function reset_arm()
	modules.arms.roll_servo.setangle(0)
	modules.arms.grip_servo.setangle(0)
	modules.arms.pitch_servo.setangle(-85)
	modules.others.reset_arm()
end

function switch_slow_mode()
	is_slow_mode= not is_slow_mode
end