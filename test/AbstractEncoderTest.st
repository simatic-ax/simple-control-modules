USING AxUnit.Assert;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.SimpleControlModules
    CLASS EncoderTest EXTENDS Simatic.Ax.SimpleControlModules.AbstractEncoder
        VAR
            
        END_VAR
    
        METHOD PUBLIC OVERRIDE Evaluate
            ;
        END_METHOD
    END_CLASS
END_NAMESPACE

NAMESPACE Simatic.Ax.SimpleControlModules.Test
    {TestFixture}
    CLASS Test_AbstractEncoder
        
        VAR
            enc : EncoderTest;
        END_VAR

        {Test}
        METHOD PUBLIC SetValue_to_555_expect_GetValue_555
            
            enc.SetValue(DINT#555);
        
            Equal(expected := DINT#555, actual := enc.GetValue());
            Equal(expected := DINT#0, actual := enc.RelativeCount());
            enc.Reset();        
            
            Equal(expected := DINT#0, actual := enc.GetValue());
            Equal(expected := DINT#0, actual := enc.RelativeCount());
        END_METHOD


        {Test}
        METHOD PUBLIC Test_Reset_Expect_value_0

            enc.SetValue(DINT#555);
            enc.Reset();        
            
            Equal(expected := DINT#0, actual := enc.GetValue());
            Equal(expected := DINT#0, actual := enc.RelativeCount());
        END_METHOD

    END_CLASS

END_NAMESPACE