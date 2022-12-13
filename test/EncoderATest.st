USING Simatic.Ax.IO.Input;
USING AxUnit.Assert;
USING Simatic.Ax.SimpleControlModules;

NAMESPACE Simatic.Ax.SimpleControlModules.Test
    {TestFixture}
    CLASS Test_EncoderA // IMPLEMENTS AxUnit.Mocking.IPayload
        
        VAR
            enc : EncoderA;
            sig : BinSignal;
            signalMock : BinSignalQMock;
        END_VAR

        {Test}
        // Encoder Forward Test
        METHOD PUBLIC Single_Track_Encoder_A_Forward_test_Expect_6
                VAR_TEMP
                    i : INT;
                END_VAR

                // 3 Rising edges 3 Falling edges --> 6 pulses
                enc.SignalA := sig;
                FOR i := 0 TO 13 DO
                    sig.ReadCyclic(signal := signalMock.Q());
                    enc.Evaluate();
                END_FOR;
               
                Equal(expected := LINT#6, actual := enc.GetValue());
                Equal(expected := LINT#6, actual := enc.RelativeCount());
                ;
        END_METHOD

        // Encoder Reverse Test
        {Test}
        METHOD PUBLIC Single_Track_Encoder_A_Reverse_test_Expect_Minus_6
            VAR_TEMP
                i : INT;
            END_VAR

            // 3 Rising edges 3 Falling edges --> 6 pulses
            enc.SignalA := sig;
            enc.SetDirection(mode := CountMode#Reverse);
            FOR i := 0 TO 13 DO
                sig.ReadCyclic(signal := signalMock.Q());
                enc.Evaluate();
            END_FOR;
           
            Equal(expected := LINT#-6, actual := enc.GetValue());
            Equal(expected := LINT#-6, actual := enc.RelativeCount());
            ;
        END_METHOD  


        // Encoder Reverse Test
        {Test}
        METHOD PUBLIC Single_Track_Encoder_4_Forward_2_Reverse_expet_2
            VAR_TEMP
                i : INT;
            END_VAR

            // 3 Rising edges 3 Falling edges --> 6 pulses
            enc.SignalA := sig;
            FOR i := 0 TO 9 DO
                sig.ReadCyclic(signal := signalMock.Q());
                enc.Evaluate();
            END_FOR;
            Equal(expected := LINT#4, actual := enc.GetValue());

            enc.SetDirection(mode := CountMode#Reverse);
            FOR i := 0 TO 3 DO
                sig.ReadCyclic(signal := signalMock.Q());
                enc.Evaluate();
            END_FOR;
            Equal(expected := LINT#2, actual := enc.GetValue());
            Equal(expected := LINT#2, actual := enc.RelativeCount());
            ;
        END_METHOD  

        {Test}
        METHOD PUBLIC Single_Track_Test_Reset
            VAR_TEMP
                i : INT;
            END_VAR
            
            THIS.Single_Track_Encoder_A_Forward_test_Expect_6();


            enc.Reset();
            Equal(expected := LINT#0, actual := enc.GetValue());
        END_METHOD  

        {Test}
        METHOD PUBLIC Single_Track_Encoder_RelativeValue
            VAR_TEMP
                i : INT;
            END_VAR

            // 3 Rising edges 3 Falling edges --> 6 pulses
            enc.SignalA := sig;
            FOR i := 0 TO 9 DO
                sig.ReadCyclic(signal := signalMock.Q());
                enc.Evaluate();
            END_FOR;
            Equal(expected := LINT#4, actual := enc.GetValue());
            Equal(expected := LINT#4, actual := enc.RelativeCount());
            enc.ResetRelative();
            
            FOR i := 0 TO 3 DO
                sig.ReadCyclic(signal := signalMock.Q());
                enc.Evaluate();
            END_FOR;
            Equal(expected := LINT#6, actual := enc.GetValue());
            Equal(expected := LINT#2, actual := enc.RelativeCount());
            ;
        END_METHOD  

    END_CLASS

    CLASS BinSignalQMock 
        VAR PUBLIC
            signal : BOOL;
            pos : INT;
            signals : ARRAY[0..13] OF BOOL := [FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE];
        END_VAR
        METHOD PUBLIC Q : BOOL
            Q := signals[pos];
            pos := pos + 1;
            pos := pos MOD 12;
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE