USING Simatic.Ax.IO.Output;
USING Simatic.Ax.IO.Output;
USING AxUnit.Assert;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.SimpleControlModules.Test
    {TestFixture}
    CLASS Test_PusherBiDirTimeBased // IMPLEMENTS AxUnit.Mocking.IPayload
        
        VAR
            pusher : PusherBiDirTimeBased := (OnDuration := T#5s, OffDuration := T#5s);
            sig : BinOutput;
            sigOff : BinOutput;
            q : BOOL;
        END_VAR

        METHOD PUBLIC Setup
            pusher.ControlPush := sig;
            pusher.ControlRetract := sigOff;
        END_METHOD

        {Test}
        // Initial State
        METHOD PUBLIC Initial_State_expect_Retracted
            THIS.Setup();
            Equal(expected := TRUE, actual :=  pusher.GetState() = PusherState#Retracted);
            Equal(expected := FALSE, actual :=  q);
            pusher.Evaluate();
            Equal(expected := TRUE, actual :=  pusher.GetState() = PusherState#Retracted);
            Equal(expected := FALSE, actual :=  sig.IsOn());
        END_METHOD    
    
        {Test}
        // Test Pushing
        METHOD PUBLIC Push_Expect_State_Pushing_Q_TRUE
            THIS.Setup();
            pusher.Push();
            pusher.Evaluate();
            Equal(expected := TRUE, actual :=  pusher.GetState() = PusherState#Pushing);
            Equal(expected := TRUE, actual :=  sig.IsOn());
        END_METHOD    

        // {Test}
        // METHOD PUBLIC Retract_After_time
        //     THIS.Push_Expect_State_Pushing_Q_TRUE();
        //     AxUnit.Mocking.Mock(name_of(System.Timer.OnDelay), name_of(Simatic.Ax.Mocks.OnDelayMock_true));
        //     pusher.Evaluate();
        //     Equal(expected := TRUE, actual :=  pusher.GetState() = PusherState#Pushed);
        //     Equal(expected := TRUE, actual :=  sig.IsOn());
        //     Equal(expected := FALSE, actual :=  sigOff.IsOn());
        //     pusher.Evaluate();
        //     // Equal(expected := TRUE, actual :=  pusher.GetState() = PusherState#Retracting);
        //     // Equal(expected := FALSE, actual :=  sig.IsOn());
        //     // Equal(expected := TRUE, actual :=  sigOff.IsOn());
        //     // pusher.Evaluate();
        //     // Equal(expected := TRUE, actual :=  pusher.GetState() = PusherState#Retracted);
        //     // Equal(expected := FALSE, actual :=  sig.IsOn());
        //     // Equal(expected := FALSE, actual :=  sigOff.IsOn());
        // END_METHOD

    END_CLASS


END_NAMESPACE