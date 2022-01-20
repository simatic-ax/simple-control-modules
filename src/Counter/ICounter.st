NAMESPACE Simatic.Ax.SimpleControlModules
    INTERFACE ICounter
        METHOD CountForward
            VAR_INPUT
               increment : LINT;
            END_VAR
        END_METHOD
        METHOD CountReverse
            VAR_INPUT
                decrement : LINT;
            END_VAR
        END_METHOD
        METHOD CounterValue : LINT
        END_METHOD
        METHOD UpperLimitReached : BOOL
        END_METHOD        
        METHOD LowerLimitReached : BOOL
        END_METHOD        
    END_INTERFACE    
END_NAMESPACE