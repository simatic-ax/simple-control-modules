USING Simatic.Ax.Io.Input;
NAMESPACE Simatic.Ax.SimpleControlModules
    /// <summary>
    /// Class to handle a counter with an A and B signal
    /// </summary>
    CLASS ABSTRACT AbstractEncoder IMPLEMENTS IEncoder

        VAR PUBLIC
            Modulo : LINT := LINT#9223372036854775807;
        END_VAR

        VAR PROTECTED
            _encoderHasMoved : BOOL;
            _countMode : CountMode;
            _actualDirection : Direction;        
            _encoderAbsCounter : Counter;
            _encoderRelativeCounter : Counter;
        END_VAR

        /// Reset encoder position to zero
        METHOD PUBLIC Reset
            _encoderAbsCounter.SetCounterValue(LINT#0);
            _encoderRelativeCounter.SetCounterValue(LINT#0);           
            _actualDirection := Direction#Undefined; 
        END_METHOD

        /// Set encoder to specific position
        /// value : Position which is set
        METHOD PUBLIC SetValue
            VAR_INPUT
                value : LINT;
            END_VAR
                _encoderAbsCounter.SetCounterValue(value := value);
                _encoderRelativeCounter.SetCounterValue(value := 0);
        END_METHOD

        /// Returns the actual encoder position
        /// Actual encoder position
        METHOD PUBLIC GetValue : LINT
            GetValue := _encoderAbsCounter.CounterValue() MOD Modulo;
        END_METHOD  

        /// Evaluate encoder signals
        METHOD PUBLIC ABSTRACT Evaluate
        END_METHOD

        /// Returns if the encoder has moved
        /// Encoder has moved
        METHOD PUBLIC HasMoved : BOOL
            HasMoved := _encoderHasMoved;
            _encoderHasMoved := FALSE;
        END_METHOD        


        /// Counts the relative pulses since the last Reset or ResetRelative command
        METHOD PUBLIC RelativeCount : LINT
            RelativeCount := _encoderRelativeCounter.CounterValue() MOD Modulo;
        END_METHOD

        /// Reset the relative counter
        METHOD PUBLIC ResetRelative
            _encoderRelativeCounter.SetCounterValue(LINT#0);
        END_METHOD

    
        METHOD PUBLIC SetDirection
            VAR_INPUT
                mode : CountMode;
            END_VAR
            _countMode := mode;
        END_METHOD


        METHOD PUBLIC GetModulo : LINT
            GetModulo := Modulo;
        END_METHOD
END_CLASS
END_NAMESPACE
