NAMESPACE Simatic.Ax.SimpleControlModules
    INTERFACE ICounter
        METHOD CountForward
            VAR_INPUT
               increment : DINT;
            END_VAR
        END_METHOD
        METHOD CountReverse
            VAR_INPUT
                decrement : DINT;
            END_VAR
        END_METHOD
        METHOD CounterValue : DINT
        END_METHOD
        METHOD UpperLimitReached : BOOL
        END_METHOD        
        METHOD LowerLimitReached : BOOL
        END_METHOD        
    END_INTERFACE    
END_NAMESPACE