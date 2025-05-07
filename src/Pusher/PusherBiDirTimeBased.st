USING System.Timer;
USING Simatic.Ax.Io.Output;

NAMESPACE Simatic.Ax.SimpleControlModules
    CLASS PusherBiDirTimeBased IMPLEMENTS IPusher
        
        VAR PUBLIC
            ControlPush : ItfBinOutput;
            ControlRetract : ItfBinOutput;
            OnDuration : TIME;
            OffDuration : TIME;
            AutoRetract : BOOL := TRUE;
        END_VAR
        VAR
            _tonOnDuration : OnDelay;
            _tonOffDuration : OnDelay;
            _state : PusherState; 
        END_VAR
    
        METHOD PUBLIC Evaluate
            _tonOnDuration(signal := _state = PusherState#Pushing);
            _tonOffDuration(signal := _state = PusherState#Retracting);
            
            CASE _state OF
                PusherState#Retracted : 
                    ControlRetract.SetOff();

                PusherState#Pushing : 
                    ControlPush.SetOn();
                    IF (_tonOnDuration.output) THEN 
                        _state := PusherState#Pushed;
                    END_IF;
        
                PusherState#Pushed : 
                    ControlPush.SetOff();
                    IF (AutoRetract) THEN
                        _state := PusherState#Retracting;
                    END_IF;

                PusherState#Retracting : 
                    ControlRetract.SetOn();
                    IF (_tonOffDuration.output) THEN 
                        _state := PusherState#Retracted;
                    END_IF;
            END_CASE;

        END_METHOD

        METHOD PUBLIC Push
            IF (_state = PusherState#Retracted OR _state = PusherState#Retracting) THEN
                _state := PusherState#Pushing;
                _tonOnDuration.duration := OnDuration;
            END_IF;
        END_METHOD

        METHOD PUBLIC Retract
            _state := PusherState#Retracting;
        END_METHOD
        
        METHOD PUBLIC GetState : PusherState
            GetState := _state;
        END_METHOD
    END_CLASS
END_NAMESPACE