NAMESPACE Simatic.Ax.SimpleControlModules

    /// Class to handle a counter
    CLASS Counter IMPLEMENTS ICounter
        VAR PUBLIC
            UpperLimit : LINT;
            LowerLimit : LINT;        
        END_VAR
        
        VAR
            _counterIsEnabled : BOOL := TRUE;
            _actualCounterValue : LINT;
            _counterConfigError : BOOL;
        END_VAR

        /// Configuration of the counter
        /// ll : Lower limit of the counter
        /// ul : Upper limit of the counter
        /// Returns result of the counter configuration 
        /// (TRUE = counter configuration succeded, FALSE = Error counter configuration
        METHOD PUBLIC Config : BOOL
            VAR_INPUT
                ll : LINT;
                ul : LINT;
            END_VAR
            IF (ul >= ll) THEN
                UpperLimit := ul;   
                LowerLimit := ll;     
                _counterConfigError := FALSE;
                Config := TRUE;
            ELSE
                _counterConfigError := TRUE;
                Config := FALSE;
            END_IF;
        END_METHOD

        /// Set actual counter value to value
        /// value : Value to set the actual counter value
        METHOD PUBLIC SetCounterValue
            VAR_INPUT
                value : LINT := LINT#0;
            END_VAR
            _actualCounterValue := value;            
        END_METHOD

        /// Returns actual counter value
        METHOD PUBLIC CounterValue : LINT
            CounterValue := _actualCounterValue;
        END_METHOD

        /// Increment Counter by 1 or by increment
        /// increment : Value to increment the counter
        METHOD PUBLIC CountForward
            VAR_INPUT
                increment : LINT := LINT#1;
            END_VAR
             _actualCounterValue := _actualCounterValue + increment;
        END_METHOD

        /// Decrement Counter by 1 or by decrement
        /// decrement : Value to decrement the counter
        METHOD PUBLIC CountReverse
            VAR_INPUT
                decrement : LINT := LINT#1;
            END_VAR
            _actualCounterValue := _actualCounterValue - decrement;
        END_METHOD
        
        /// Returns if the upper limit is reached (TRUE = upper limit is reached, FALSE = upper limit is not reached)
        /// Upper limit is reached or not
        METHOD PUBLIC UpperLimitReached : BOOL
            IF (NOT(_counterConfigError)) THEN
                UpperLimitReached := _actualCounterValue >= UpperLimit;   
            ELSE
                UpperLimitReached := FALSE;
            END_IF;
        END_METHOD

        /// Returns if the lower limit is reached (TRUE = lower limit is reached, FALSE = lower limit is not reached)
        /// Lower limit is reached or not
        METHOD PUBLIC LowerLimitReached : BOOL
            IF (NOT(_counterConfigError)) THEN
                LowerLimitReached := _actualCounterValue <= LowerLimit;   
            ELSE
                LowerLimitReached := FALSE;
            END_IF;
        END_METHOD
    END_CLASS
END_NAMESPACE
