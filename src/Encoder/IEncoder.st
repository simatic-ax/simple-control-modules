NAMESPACE Simatic.Ax.SimpleControlModules
    INTERFACE IEncoder
        METHOD Evaluate
        END_METHOD
        METHOD Reset
        END_METHOD
        METHOD SetValue
            VAR_INPUT
                value : DINT;
            END_VAR
        END_METHOD
        METHOD GetValue : DINT
        END_METHOD
        METHOD SetDirection
            VAR_INPUT
                mode : CountMode;
            END_VAR
        END_METHOD
        METHOD RelativeCount : DINT
        END_METHOD
        METHOD ResetRelative
        END_METHOD
    END_INTERFACE
END_NAMESPACE