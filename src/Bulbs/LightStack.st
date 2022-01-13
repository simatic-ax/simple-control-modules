USING Simatic.Ax.IO.Output;

NAMESPACE Simatic.Ax.SimpleControlModules
    
    
    /// Class of a lightstack with 3 lamps (Red, Yellow, Green)
    
    CLASS LightStackRdYeGnBl
        VAR PUBLIC
            QRed : IBinOutput;
            QYellow : IBinOutput;
            QGreen : IBinOutput;
            QBlue : IBinOutput;
        END_VAR
        
        /// Switch on the lamp of color c
        
        METHOD PUBLIC SwitchOn
            VAR_INPUT
                c : Colors;
            END_VAR;
            CASE c OF
                Colors#Red      : QRed.SetOn();
                Colors#Yellow   : QYellow.SetOn();
                Colors#Green    : QGreen.SetOn();
                Colors#Blue     : QBlue.SetOn();
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
                Colors#Red      : QRed.SetOff();
                Colors#Yellow   : QYellow.SetOff();
                Colors#Green    : QGreen.SetOff();
                Colors#Blue     : QBlue.SetOff();
            ELSE
                ;
            END_CASE;

        END_METHOD
        
        METHOD PUBLIC GetState : BOOL
            VAR_INPUT
                c : Colors;
            END_VAR
            VAR_TEMP
                q : BOOL;
            END_VAR 
            CASE c OF
                Colors#Red      : GetState := QRed.IsOn();
                Colors#Yellow   : GetState := QYellow.IsOn();
                Colors#Green    : GetState := QGreen.IsOn();
                Colors#Blue     : GetState := QBlue.IsOn();
            ELSE
                GetState := FALSE;
            END_CASE;
            
        END_METHOD

    END_CLASS
END_NAMESPACE

