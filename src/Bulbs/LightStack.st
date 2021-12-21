USING Simatic.Ax.IO;

NAMESPACE Simatic.Ax.SimpleControlModules
    
    
    /// Class of a lightstack with 3 lamps (Red, Yellow, Green)
    
    CLASS LightStackRdYeGnBl
        VAR
            lampRd : Bulb;        
            lampYe : Bulb;        
            lampGn : Bulb;  
            lampBl : Bulb;      
        END_VAR

        
        /// Switch on the lamp of color c
        
        METHOD PUBLIC SwitchOn
            VAR_INPUT
                c : Colors;
            END_VAR;
            CASE c OF
                Colors#Red      : lampRd.SwitchOn();
                Colors#Yellow   : lampYe.SwitchOn();
                Colors#Green    : lampGn.SwitchOn();
                Colors#Blue     : lampBl.SwitchOn();
            ELSE
                ;
            END_CASE;

        END_METHOD

        
        /// Switch off the lamp of color c
        
        METHOD PUBLIC SwitchOff
            VAR_INPUT
                c : Colors;
            END_VAR;
            CASE c OF
                Colors#Red      : lampRd.SwitchOff();
                Colors#Yellow   : lampYe.SwitchOff();
                Colors#Green    : lampGn.SwitchOff();
                Colors#Blue     : lampBl.SwitchOff();
            ELSE
                ;
            END_CASE;

        END_METHOD

    END_CLASS
END_NAMESPACE

