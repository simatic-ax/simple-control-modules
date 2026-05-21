USING System.Timer;
USING Simatic.Ax.Io.Output;

NAMESPACE Simatic.Ax.SimpleControlModules
    CLASS PusherTimeBased IMPLEMENTS IPusher
        
        VAR PUBLIC
            ControlPush : IBinOutput;
            OnDuration : TIME;
        END_VAR
        VAR
            _tonOnDuration : OnDelay;
            _state : PusherState;
        END_VAR
    
        METHOD PUBLIC Evaluate
            _tonOnDuration(signal := _state = PusherState#Pushing, Duration := OnDuration);
            
            CASE _state OF
                PusherState#Retracted : 
                    ControlPush.SetOff();

                PusherState#Pushing : 
                    ControlPush.SetOn();
                    IF (_tonOnDuration.output) THEN 
                        _state := PusherState#Retracting;
                        ControlPush.SetOff();
                    END_IF;

                PusherState#Retracting : 
                    ControlPush.SetOff();
                    _state := PusherState#Retracted;
            END_CASE;

        END_METHOD

        METHOD PUBLIC Push
            _state := PusherState#Pushing;
        END_METHOD

        METHOD PUBLIC Retract
            _state := PusherState#Retracted;
        END_METHOD
        
        METHOD PUBLIC GetState : PusherState
            GetState := _state;
        END_METHOD
    END_CLASS
END_NAMESPACE