USING AxUnit.Assert;
USING AxUnit.Assert;
USING Simatic.Ax.SimpleControlModules;
NAMESPACE Simatic.Ax.SimpleControlModules.Test
    {TestFixture}
    CLASS TestCounterClass
        VAR
            cnt : Counter;

        END_VAR

        {Test}
        METHOD PUBLIC Count_Forward_3_times_Expect_3;
            cnt.CountForward();
            Equal(expected := 1, actual := cnt.CounterValue());
            cnt.CountForward();
            cnt.CountForward();
            Equal(expected := 3, actual := cnt.CounterValue());
        END_METHOD

        {Test}
        METHOD PUBLIC Count_Reverse_3_times_From_3_Expect_0;
            cnt.SetCounterValue(value := 3);
            Equal(expected := 3, actual := cnt.CounterValue());
            cnt.CountReverse();
            Equal(expected := 2, actual := cnt.CounterValue());
            cnt.CountReverse();
            cnt.CountReverse();
            Equal(expected := 0, actual := cnt.CounterValue());
        END_METHOD
    

        {Test}
        METHOD PUBLIC Count_Forward_3_times_by_2_Expect_3;
            cnt.CountForward(increment := 2);
            Equal(expected := 2, actual := cnt.CounterValue());
            cnt.CountForward(increment := 2);
            cnt.CountForward(increment := 2);
            Equal(expected := 6, actual := cnt.CounterValue());
        END_METHOD

        {Test}
        METHOD PUBLIC Count_Reverse_3_timesby_2_From_6_Expect_0;
            cnt.SetCounterValue(value := 6);
            Equal(expected := 6, actual := cnt.CounterValue());
            cnt.CountReverse(decrement := 2);
            Equal(expected := 4, actual := cnt.CounterValue());
            cnt.CountReverse(decrement := 2);
            cnt.CountReverse(decrement := 2);
            Equal(expected := 0, actual := cnt.CounterValue());
        END_METHOD

        {Test}
        METHOD PUBLIC Counter_Lower_Limit_Reached
            cnt.Config(ll := DINT#-4, ul := DINT#4);
            Equal(expected := FALSE, actual := cnt.LowerLimitReached());
            Equal(expected := FALSE, actual := cnt.UpperLimitReached());
            cnt.CountReverse();
            cnt.CountReverse();
            cnt.CountReverse();
            Equal(expected := FALSE, actual := cnt.LowerLimitReached());
            cnt.CountReverse();
            Equal(expected := TRUE, actual := cnt.LowerLimitReached());
            Equal(expected := FALSE, actual := cnt.UpperLimitReached());
        END_METHOD
    
        {Test}
        METHOD PUBLIC Counter_Lower_Limit_Reached_When_Limit_Is_1
            cnt.Config(ll := DINT#1, ul := DINT#4);
            Equal(expected := TRUE, actual := cnt.LowerLimitReached());
            Equal(expected := FALSE, actual := cnt.UpperLimitReached());
            cnt.CountReverse();
            cnt.CountReverse();
            cnt.CountReverse();
            Equal(expected := TRUE, actual := cnt.LowerLimitReached());
            cnt.CountReverse();
            Equal(expected := TRUE, actual := cnt.LowerLimitReached());
            Equal(expected := FALSE, actual := cnt.UpperLimitReached());
        END_METHOD

        {Test}
        METHOD PUBLIC Counter_Upper_Limit_Reached_When_UpperLimit_Is4
            cnt.Config(ll := DINT#-4, ul := DINT#4);
            Equal(expected := FALSE, actual := cnt.LowerLimitReached());
            Equal(expected := FALSE, actual := cnt.UpperLimitReached());
            cnt.CountForward();
            cnt.CountForward();
            cnt.CountForward();
            Equal(expected := FALSE, actual := cnt.UpperLimitReached());
            cnt.CountForward();
            Equal(expected := TRUE, actual := cnt.UpperLimitReached());
            Equal(expected := FALSE, actual := cnt.LowerLimitReached());
            cnt.CountReverse();
            Equal(expected := FALSE, actual := cnt.UpperLimitReached());
        END_METHOD

        {Test}
        METHOD PUBLIC Counter_Upper_Limit_Reached_When_UpperLimit_Is0
            cnt.Config(ll := DINT#-4, ul := DINT#0);
            Equal(expected := FALSE, actual := cnt.LowerLimitReached());
            Equal(expected := TRUE, actual := cnt.UpperLimitReached());
            cnt.CountForward();
            cnt.CountForward();
            cnt.CountForward();
            Equal(expected := TRUE, actual := cnt.UpperLimitReached());
            cnt.CountForward();
            Equal(expected := TRUE, actual := cnt.UpperLimitReached());
            Equal(expected := FALSE, actual := cnt.LowerLimitReached());
        END_METHOD
    END_CLASS
END_NAMESPACE    