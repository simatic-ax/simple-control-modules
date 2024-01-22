USING Simatic.Ax.IO.Output;
USING Simatic.Ax.IO.Output;
USING AxUnit.Assert;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.SimpleControlModules.Test
    {TestFixture}
    CLASS Test_PusherTimeBased // IMPLEMENTS AxUnit.Mocking.IPayload
        
        VAR
            pusher : PusherTimeBased := (OnDuration := T#5s);
            pusherStateLess : PusherTimeBased := (OnDuration := T#5s);
            sig : BinOutput;
            sigStateLess : BinOutput;
            q : BOOL;
        END_VAR

        {TestSetup}
        METHOD PUBLIC MyTestSetup
        // Will be called before MyTest_A AND before Test_B are executed
            pusher := pusherStateLess;
            sig := sigStateLess;
            q := FALSE;
        END_METHOD

        METHOD PUBLIC Setup
            pusher.ControlPush := sig;
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
        //     Equal(expected := TRUE, actual :=  pusher.GetState() = PusherState#Retracting);
        //     Equal(expected := FALSE, actual :=  sig.IsOn());
        //     pusher.Evaluate();
        //     Equal(expected := TRUE, actual :=  pusher.GetState() = PusherState#Retracted);
        // END_METHOD

    END_CLASS


END_NAMESPACE