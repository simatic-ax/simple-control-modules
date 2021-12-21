USING AxUnit.Assert;
USING Simatic.Ax.Io.Output;
USING Simatic.Ax.Io;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.SimpleControlModules.Test
    {TestFixture}
    CLASS TestClassBulb
        VAR PRIVATE
            b : Bulb;
            o : BinOutput;    
            q : BOOL;
        END_VAR

        {Test}
        METHOD PUBLIC TestSwitchOn
            b.Output := o;
            Equal(expected := FALSE, actual := q);
            b.SwitchOn();
            o.WriteCyclic(q);
            Equal(expected := TRUE, actual := q);
        END_METHOD

        {Test}
        METHOD PUBLIC TestSwitchOff
            this.TestSwitchOn();
            
            Equal(expected := TRUE, actual := q);
            b.SwitchOff();
            o.WriteCyclic(q);
            Equal(expected := FALSE, actual := q);
        END_METHOD

        {Test}
        METHOD PUBLIC TestSwitchToggle
            this.TestSwitchOn();
            
            Equal(expected := TRUE, actual := q);
            b.Toggle();
            o.WriteCyclic(q);
            Equal(expected := FALSE, actual := q);
            b.Toggle();
            o.WriteCyclic(q);
            Equal(expected := TRUE, actual := q);
        END_METHOD

    END_CLASS
END_NAMESPACE
