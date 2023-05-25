-- 毎制御ごとに呼び出します。以下引数
-- {Root Module Name} - StructuredModlues これの名前はマシンDLL依存なんだけどよくないかな
-- buttons : Votice.XInput.GamepadButtons - https://github.com/amerkoleci/Vortice.Windows/blob/main/src/Vortice.XInput/GamepadButtons.cs
-- gamepad : Vortice.Xinput.Gamepad - https://github.com/amerkoleci/Vortice.Windows/blob/main/src/Vortice.XInput/Gamepad.cs
-- input : Wimm.Model.Control.Script.InputSupporter
-- wimm : Wimm.Model.Control.Script.WimmFeatureProvider

if input.IsRightThumbUp(gamepad) then
	modules.arms.pitch_servo.rotate(1)
end
if input.IsRightThumbDown(gamepad) then
	modules.arms.pitch_servo.rotate(-1)
end
if input.IsRightThumbRight(gamepad) then
	modules.arms.roll_servo.rotate(1)
end
if input.IsRightThumbLeft(gamepad) then
	modules.arms.roll_servo.rotate(-1)
end
if input.IsLeftThumbUp(gamepad) then
	modules.arms.root_servo.rotate(1)
end
if input.IsLeftThumbDown(gamepad) then
	modules.arms.root_servo.rotate(-1)
end
if input.IsLeftThumbRight(gamepad) then
	turn_right()
end
if input.IsLeftThumbLeft(gamepad) then
	turn_left()
end
if input.IsButtonDown(gamepad,buttons.RightShoulder) then
	modules.container.rotate_belt(1)
end
if gamepad.RightTrigger > 30 then
	modules.container.rotate_belt(-1)
end
if input.IsButtonDown(gamepad,buttons.LeftShoulder) then
	modules.container.lift_updown(1)
end
if gamepad.LeftTrigger > 30 then
	modules.container.lift_updown(-1)
end