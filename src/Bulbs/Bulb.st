USING Simatic.Ax.Io.Output;
USING Simatic.Ax.Io.Input;


NAMESPACE Simatic.Ax.SimpleControlModules
    
    /// Class to handle a bulb
    CLASS Bulb
        VAR PUBLIC
            Output : ItfBinOutput;        
        END_VAR

        /// Switch the lamp on (value := TRUE) or off (value := FALSE)
        /// value : Value to set
        METHOD PUBLIC Set
            VAR_INPUT
                value : bool;                 
            END_VAR
            IF (Output = NULL) THEN
                RETURN;
            END_IF;
            Output.SetQ(value := value);

        END_METHOD

        /// Switch the lamp on
        METHOD PUBLIC SwitchOn
            IF (Output = NULL) THEN
                RETURN;
            END_IF;
            Output.SetQ(value := TRUE);
        END_METHOD        

        /// Switch the lamp off
        METHOD PUBLIC SwitchOff
            IF (Output = NULL) THEN
                RETURN;
            END_IF;
            Output.SetQ(value := FALSE);
        END_METHOD        

        /// Toggle the lamp
        METHOD PUBLIC Toggle
            IF (Output = NULL) THEN
                RETURN;
            END_IF;
            Output.Toggle();
        END_METHOD        


    END_CLASS
END_NAMESPACE

