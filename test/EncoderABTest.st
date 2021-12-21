USING Simatic.Ax.IO.Input;
USING AxUnit.Assert;
USING Simatic.Ax.SimpleControlModules;
NAMESPACE Simatic.Ax.SimpleControlModules.Test
    {TestFixture}
    CLASS Test_EncoderAB IMPLEMENTS AxUnit.Mocking.IPayload
        
        VAR
            enc : EncoderAB;
            sigA : BinSignal;
            sigB : BinSignal;
            //signalMock : BinSignalQMockAB;

            signalsA : ARRAY[0..13] OF BOOL := [FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE];
            signalsB : ARRAY[0..13] OF BOOL := [FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE, TRUE, TRUE, FALSE, FALSE];

        END_VAR

        {Test}
        // Encoder Forward Test
        METHOD PUBLIC AB_Encoder_A_Forward_test_Expect_13
                VAR_TEMP
                    i : INT;
                END_VAR

                enc.SignalA := sigA;
                enc.SignalB := sigB;

                FOR i := 0 TO 13 DO
                    sigA.ReadCyclic(signal := signalsA[i]);
                    sigB.ReadCyclic(signal := signalsB[i]);
                    enc.Evaluate();
                END_FOR;
               
                Equal(expected := DINT#13, actual := enc.GetValue());
                Equal(expected := DINT#13, actual := enc.RelativeCount());
                ;
        END_METHOD

        // Encoder Count Reverse Test 
        {Test}
        METHOD PUBLIC AB_Encoder_A_Reverse_test_Expect_Minus_13
            VAR_TEMP
                i : INT;
            END_VAR
            
            enc.SignalA := sigA;
            enc.SignalB := sigB;

            enc.SetDirection(mode := CountMode#Reverse);
            FOR i := 0 TO 13 DO
                sigA.ReadCyclic(signal := signalsA[i]);
                sigB.ReadCyclic(signal := signalsB[i]);

                enc.Evaluate();
            END_FOR;
            
            Equal(expected := DINT#-13, actual := enc.GetValue());
            Equal(expected := DINT#-13, actual := enc.RelativeCount());
            ;
        END_METHOD  

        {Test}
        // Encoder Swap singnals Test
        METHOD PUBLIC AB_Encoder_Swap_AB_Signal_And_Expect_Minus_13
                VAR_TEMP
                    i : INT;
                END_VAR

                // Swap AB 
                enc.SignalA := sigB;
                enc.SignalB := sigA;

                FOR i := 0 TO 13 DO
                    sigA.ReadCyclic(signal := signalsA[i]);
                    sigB.ReadCyclic(signal := signalsB[i]);
                    enc.Evaluate();
                END_FOR;
               
                Equal(expected := DINT#-13, actual := enc.GetValue());
                Equal(expected := DINT#-13, actual := enc.RelativeCount());
                ;
        END_METHOD

        // Encoder change signal sequence to reverse
        {Test}
        METHOD PUBLIC AB_Encoder_9_Forward_5_Reverse_expect
            VAR_TEMP
                i : INT;
            END_VAR

            enc.SignalA := sigA;
            enc.SignalB := sigB;

            FOR i := 0 TO 9 DO
                sigA.ReadCyclic(signal := signalsA[i]);
                sigB.ReadCyclic(signal := signalsB[i]);
                enc.Evaluate();
            END_FOR;

            Equal(expected := DINT#9, actual := enc.GetValue());

            FOR i := 9 TO 0 BY -1 DO
                sigA.ReadCyclic(signal := signalsA[i]);
                sigB.ReadCyclic(signal := signalsB[i]);
                enc.Evaluate();
            END_FOR;
            Equal(expected := DINT#0, actual := enc.GetValue());
            Equal(expected := DINT#0, actual := enc.RelativeCount());
            ;
        END_METHOD  

        // Encoder Reverse Test
        {Test}
        METHOD PUBLIC AB_Encoder_9_Forward_4_Reverse_expet_5
            VAR_TEMP
                i : INT;
            END_VAR

            enc.SignalA := sigA;
            enc.SignalB := sigB;

            FOR i := 0 TO 9 DO
                sigA.ReadCyclic(signal := signalsA[i]);
                sigB.ReadCyclic(signal := signalsB[i]);

                enc.Evaluate();
            END_FOR;
            Equal(expected := DINT#9, actual := enc.GetValue());

            enc.SetDirection(mode := CountMode#Reverse);
            FOR i := 10 TO 13 DO
                sigA.ReadCyclic(signal := signalsA[i]);
                sigB.ReadCyclic(signal := signalsB[i]);
            enc.Evaluate();
            END_FOR;
            Equal(expected := DINT#5, actual := enc.GetValue());
            Equal(expected := DINT#5, actual := enc.RelativeCount());
            ;
        END_METHOD  

        {Test}
        METHOD PUBLIC Single_Track_Test_Reset
            VAR_TEMP
                i : INT;
            END_VAR
            
            THIS.AB_Encoder_A_Forward_test_Expect_13();


            enc.Reset();
            Equal(expected := DINT#0, actual := enc.GetValue());
        END_METHOD  

        {Test}
        METHOD PUBLIC AB_Encoder_RelativeValue
            VAR_TEMP
                i : INT;
            END_VAR

            // 3 Rising edges 3 Falling edges --> 6 pulses
            enc.SignalA := sigA;
            enc.SignalB := sigB;

            FOR i := 0 TO 9 DO
                sigA.ReadCyclic(signal := signalsA[i]);
                sigB.ReadCyclic(signal := signalsB[i]);
            enc.Evaluate();
            END_FOR;            Equal(expected := DINT#9, actual := enc.GetValue());
            Equal(expected := DINT#9, actual := enc.RelativeCount());
            enc.ResetRelative();
            
            FOR i := 10 TO 13 DO
                sigA.ReadCyclic(signal := signalsA[i]);
                sigB.ReadCyclic(signal := signalsB[i]);
            enc.Evaluate();
            END_FOR;
            Equal(expected := DINT#13, actual := enc.GetValue());
            Equal(expected := DINT#4, actual := enc.RelativeCount());
            ;
        END_METHOD  

    END_CLASS

END_NAMESPACE