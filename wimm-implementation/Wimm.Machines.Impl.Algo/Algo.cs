﻿using System.Windows.Interop;
using Wimm.Machines.Tpip3;
using Wimm.Machines.Video;
using Wimm.Machines.Impl.Algo.Component;
using System.Collections.Immutable;
using Wimm.Machines.Extension;
using Wimm.Machines.Tpip3.Import;
using System.Runtime.InteropServices;
using Wimm.Common;

namespace Wimm.Machines.Impl.Algo
{
    [LoadTarget]
    public sealed class Algo : Tpip3Machine
    {

        public ModuleGroup Wheels { get; }
        public ModuleGroup Arm { get; }
        public override string Name => "アルゴ";

        public AlgoControlProcess? ControlProcess{ get; set; }

        internal event Action<ArmControlCanData>? SetArmDefault;
        internal event Action<WheelControlCanData>? SetWheelDefault;
        internal event Action<ContainerControlCanData>? SetContainerDefault;
        internal event Action<LiftControlCanData>? SetLiftDefault;
        internal event Action<TopCameraCanData>? SetTopCameraDefault;
        protected override ControlProcess StartControlProcess()
        {
            ControlProcess = new AlgoControlProcess(this,() => { this.ControlProcess = null; });
            return ControlProcess;
        }
        private static ModuleGroup CreateWheels(Algo algo)
        {
            var wheels = 
                ImmutableArray.Create<Module>(
                    new AlgoWheelMotor(
                        "r_front_wheel", "機動用右前メカナムホイール",
                        WheelMotorDataIndex.RightFront, algo
                    ),
                    new AlgoWheelMotor(
                        "r_back_wheel", "機動用右後メカナムホイール",
                        WheelMotorDataIndex.RightBack, algo
                    ),
                    new AlgoWheelMotor(
                        "l_front_wheel", "機動用左前メカナムホイール",
                        WheelMotorDataIndex.LeftFront, algo
                    ),
                    new AlgoWheelMotor(
                        "l_back_wheel", "機動用左後メカナムホイール",
                        WheelMotorDataIndex.LeftBack, algo
                    )
                );
            return new ModuleGroup(
                "wheels",
                [],
                wheels
            );
        }
        private static ModuleGroup CreateArm(Algo algo)
        {
            var motors =
                ImmutableArray.Create<Module>(
                    new AlgoArmServo(
                        "roll_servo", "アームのひねりを扱うサーボ",
                        ArmDataIndex.Roll, 80, -80, algo
                    ),
                    new AlgoArmServo(
                        "pitch_servo", "アームの上下回転を扱うサーボ",
                        ArmDataIndex.Pitch, 85, -85, algo
                    ),
                    new AlgoArmServo(
                        "grip_servo", "アームのつかみを扱うサーボ",
                        ArmDataIndex.Grip, 55, 0, algo
                    ),
                    new AlgoArmServo(
                        "top_camera_servo", "上部のカメラの回転を扱うサーボ",
                        ArmDataIndex.Camera, 30, -45, algo
                    ),
                    new AlgoArmRootServo(
                        "root_servo","アームの根本のピッチ回転を扱うサーボ",
                        110,0,algo
                    )
                );
            return new ModuleGroup(
                "arms",
                [],
                motors
            );
        }
        public Algo(MachineConstructorArgs? args) : base(args)
        {
            Camera = new Tpip3Camera(
                "フロント", "バック", "アーム","トップ"
            );
            if(args is not null && Camera is Tpip3Camera camera)
            {
                Hwnd?.AddHook(camera.WndProc);
            }
            Wheels = CreateWheels(this);
            Arm = CreateArm(this);
            StructuredModules
                = new ModuleGroup(
                    "modules",
                    ImmutableArray.Create(Wheels,Arm),
                    ImmutableArray.Create<Module>(
                        new AlgoInnerContainer("container", this),
                        new OtherFeatureModule("others","その他機能を提供するモジュール",this)
                    )
                );
        }
        public sealed class AlgoControlProcess : ControlProcess
        {
            Action FinishedHander { get; }
            public AlgoControlProcess(Algo parent,Action processFinishedHandler)
            {
                FinishedHander = processFinishedHandler;
                parent.SetArmDefault?.Invoke(ArmControlData);
                parent.SetWheelDefault?.Invoke(WheelControlData);
                parent.SetContainerDefault?.Invoke(ContainerData);
                parent.SetLiftDefault?.Invoke(LiftControlCanData);
                parent.SetTopCameraDefault?.Invoke(TopCameraCanData);
            }
            public ContainerControlCanData ContainerData { get; } = new ContainerControlCanData();
            public ArmControlCanData ArmControlData { get; } = new ArmControlCanData();
            public WheelControlCanData WheelControlData { get; } = new WheelControlCanData();
            public LiftControlCanData LiftControlCanData { get; } = new LiftControlCanData();
            public TopCameraCanData TopCameraCanData { get; } = new TopCameraCanData();
            public override void Dispose()
            {
                ArmControlData.Send();
                WheelControlData.Send();
                ContainerData.Send();
                LiftControlCanData.Send();
                FinishedHander();
                base.Dispose();
            }
        }
    }
}