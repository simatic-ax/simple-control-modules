NAMESPACE Simatic.Ax.SimpleControlModules
    INTERFACE IPusher
        METHOD Push END_METHOD
        METHOD Retract END_METHOD
        METHOD GetState : PusherState
        END_METHOD
    END_INTERFACE
END_NAMESPACE