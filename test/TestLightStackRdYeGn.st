USING AxUnit.Assert;
USING Simatic.Ax.Io.Output;
USING Simatic.Ax.Io;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.SimpleControlModules.Test
    {TestFixture}
    CLASS TestLightStackRdYeGnBl
        VAR PRIVATE
            o : LightStackRdYeGnBl;
            QRed : BinOutput;
            QYellow : BinOutput;
            QGreen : BinOutput;
            QBlue : BinOutput;
        END_VAR

        METHOD PRIVATE Init
            o.QRed := QRed;
            o.QYellow := QYellow;
            o.QGreen := QGreen;
            o.QBlue := QBlue;
        END_METHOD

        {Test}
        METHOD PUBLIC InitialState
            THIS.Init();
            Equal(expected := FALSE, actual := o.GetState(Colors#Red));
            Equal(expected := FALSE, actual := o.GetState(Colors#Yellow));
            Equal(expected := FALSE, actual := o.GetState(Colors#Green));
            Equal(expected := FALSE, actual := o.GetState(Colors#Blue));
        END_METHOD
        {Test}
        METHOD PUBLIC TestSwitchOnRed_Expect_True
            THIS.Init();
            Equal(expected := FALSE, actual := o.GetState(Colors#Red));
            o.SwitchOn(Colors#Red);
            Equal(expected := TRUE, actual := o.GetState(Colors#Red));
            o.SwitchOff(Colors#Red);
            Equal(expected := FALSE, actual := o.GetState(Colors#Red));
        END_METHOD
        {Test}
        METHOD PUBLIC TestSwitchOnyellowExpect_True
            THIS.Init();
            Equal(expected := FALSE, actual := o.GetState(Colors#Yellow));
            o.SwitchOn(Colors#Yellow);
            Equal(expected := TRUE, actual := o.GetState(Colors#Yellow));
            o.SwitchOff(Colors#Yellow);
            Equal(expected := FALSE, actual := o.GetState(Colors#Yellow));
        END_METHOD
        {Test}
        METHOD PUBLIC TestSwitchOnGreenExpect_True
            THIS.Init();
            Equal(expected := FALSE, actual := o.GetState(Colors#Green));
            o.SwitchOn(Colors#Green);
            Equal(expected := TRUE, actual := o.GetState(Colors#Green));
            o.SwitchOff(Colors#Green);
            Equal(expected := FALSE, actual := o.GetState(Colors#Green));
        END_METHOD
        {Test}
        METHOD PUBLIC TestSwitchOnBlueExpect_True
            THIS.Init();
            Equal(expected := FALSE, actual := o.GetState(Colors#Blue));
            o.SwitchOn(Colors#Blue);
            Equal(expected := TRUE, actual := o.GetState(Colors#Blue));
            o.SwitchOff(Colors#Blue);
            Equal(expected := FALSE, actual := o.GetState(Colors#Blue));
        END_METHOD
    END_CLASS
END_NAMESPACE
