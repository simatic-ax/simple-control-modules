USING Simatic.Ax.IO.Input;
NAMESPACE Simatic.Ax.SimpleControlModules
    /// <summary>
    /// Class to handle a counter with an A and B signal
    /// </summary>
    CLASS EncoderAB EXTENDS AbstractEncoder
        VAR PUBLIC
            SignalA : IBinSignal;
            SignalB : IBinSignal;
        END_VAR

        /// Evaluate encoder for A B track
        METHOD PUBLIC OVERRIDE Evaluate

            VAR_TEMP
                _A : IBinSignal;
                _B : IBinSignal;
            END_VAR
            IF (_countMode = CountMode#Forward) THEN
                _A := SignalA;
                _B := SignalB;
            ELSE
                _A := SignalB;
                _B := SignalA;
            END_IF;

            IF (THIS.ForwardPulse(_A, _B)) THEN   
                _encoderHasMoved := TRUE;
                _actualDirection := Direction#FORWARD;
                _encoderAbsCounter.CountForward();
                _encoderRelativeCounter.CountForward();
            //Reverse detection
            ELSIF (THIS.ReversePulse(_A, _B)) THEN
                _encoderHasMoved := TRUE;
                _actualDirection := Direction#REVERSE;
                _encoderAbsCounter.CountReverse();
                _encoderRelativeCounter.CountReverse();                
            ELSE
                _actualDirection := Direction#FORWARD;
            END_IF;

        END_METHOD

        /// Pulse for two direction evaluation
        /// A : A signal from encoder
        /// B : B signal from encoder
        /// Returns Encoder signal A and/or B made pulse forward
        METHOD ForwardPulse : BOOL
            VAR_INPUT
                A : IBinSignal;
                B : IBinSignal;
            END_VAR
            ForwardPulse := A.QRis() AND NOT(B.Q())
                OR A.Q() AND B.QRis()
                OR A.QFal() AND B.Q()
                OR NOT(A.Q()) AND B.qFal();
        END_METHOD

        /// Pulse for two direction evaluation
        /// A : A signal from encoder
        /// B : B signal from encoder
        /// Returns Encoder signal A and/or B made pulse reverse
        METHOD ReversePulse : BOOL
            VAR_INPUT
                A : IBinSignal;
                B : IBinSignal;
            END_VAR
            ReversePulse := A.QRis() AND B.Q()
                OR NOT(A.Q()) AND B.QRis()
                OR A.QFal() AND NOT(B.Q())
                OR A.Q() AND B.qFal();
        END_METHOD

    END_CLASS
END_NAMESPACE
