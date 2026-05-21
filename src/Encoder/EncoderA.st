USING Simatic.Ax.IO.Input;

NAMESPACE Simatic.Ax.SimpleControlModules


    /// Class to handle a counter with an A signal
    CLASS EncoderA EXTENDS AbstractEncoder
        
        VAR PUBLIC
            SignalA : IBinSignal;
        END_VAR
        
        
        /// Evaluate encoder signal A
        METHOD PUBLIC OVERRIDE Evaluate

            IF (THIS.ForwardPulse(SignalA)) THEN                
                IF (_countMode = CountMode#FORWARD) THEN
                    _encoderAbsCounter.CountForward();
                    _encoderRelativeCounter.CountForward();             
                ELSE
                    _encoderAbsCounter.CountReverse();
                    _encoderRelativeCounter.CountReverse();             
                END_IF;
            END_IF;

        END_METHOD

        /// Returns if the encoder made a pulse
        /// A : A signal from encoder
        METHOD ForwardPulse : BOOL
            VAR_INPUT
                A : IBinSignal;
            END_VAR
            ForwardPulse := A.QRis() OR A.QFal();
        END_METHOD
  
    END_CLASS
END_NAMESPACE
