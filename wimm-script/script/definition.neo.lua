function go_straight()
	modules.wheels.r_front_wheel.rotate(1)
	modules.wheels.r_back_wheel.rotate(1)
	modules.wheels.l_front_wheel.rotate(1)
	modules.wheels.l_back_wheel.rotate(1)
end

function go_back()
	modules.wheels.r_front_wheel.rotate(1)
	modules.wheels.r_back_wheel.rotate(1)
	modules.wheels.l_front_wheel.rotate(1)
	modules.wheels.l_back_wheel.rotate(1)
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
function reset_arm()
	modules.others.reset_arm()
end