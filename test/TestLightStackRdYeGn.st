// USING AxUnit;
// USING Simatic.Ax.SimpleControlModules;

// NAMESPACE Simatic.Ax.SimpleControlModules.Test

//     {Test}
//     FUNCTION TestLightStackInitialAllLampsOff
//         VAR_EXTERNAL
//             ls1 : LightStackRdYeGn;
//         END_VAR
//         VAR_TEMP            
//             qRd, qYe, qGn : BOOL;
//         END_VAR;

//         ls1.WriteOutputs(qRd, qYe, qGn);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qRd);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qYe);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qGn);
//     END_FUNCTION

//     {Test}
//     FUNCTION TestLightStackOnRedAllOthersOff
//         VAR_EXTERNAL
//             ls2 : LightStackRdYeGn;
//         END_VAR
//         VAR_TEMP            
//             qRd, qYe, qGn : BOOL;
//         END_VAR;

//         ls2.SwitchOnRd();
//         ls2.WriteOutputs(qRd, qYe, qGn);
//         AxUnit.Assert.Equal(expected := TRUE, actual := qRd);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qYe);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qGn);
//     END_FUNCTION

//     {Test}
//     FUNCTION TestLightStackOnYeAllOthersOff
//         VAR_EXTERNAL
//             ls3 : LightStackRdYeGn;
//         END_VAR
//         VAR_TEMP            
//             qRd, qYe, qGn : BOOL;
//         END_VAR;

//         ls3.SwitchOnYe();
//         ls3.WriteOutputs(qRd, qYe, qGn);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qRd);
//         AxUnit.Assert.Equal(expected := TRUE, actual := qYe);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qGn);
//     END_FUNCTION

//     {Test}
//     FUNCTION TestLightStackOnGnAllOthersOff
//         VAR_EXTERNAL
//             ls4 : LightStackRdYeGn;
//         END_VAR
//         VAR_TEMP            
//             qRd, qYe, qGn : BOOL;
//         END_VAR;

//         ls4.SwitchOnGn();
//         ls4.WriteOutputs(qRd, qYe, qGn);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qRd);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qYe);
//         AxUnit.Assert.Equal(expected := TRUE, actual := qGn);
//     END_FUNCTION

//     {Test}
//     FUNCTION TestLightStackAllOnAndAllOff
//         VAR_EXTERNAL
//             ls5 : LightStackRdYeGn;
//         END_VAR
//         VAR_TEMP            
//             qRd, qYe, qGn : BOOL;
//         END_VAR;

//         ls5.SwitchOnRd();
//         ls5.SwitchOnYe();
//         ls5.SwitchOnGn();
//         ls5.WriteOutputs(qRd, qYe, qGn);
//         AxUnit.Assert.Equal(expected := TRUE, actual := qRd);
//         AxUnit.Assert.Equal(expected := TRUE, actual := qYe);
//         AxUnit.Assert.Equal(expected := TRUE, actual := qGn);

//         ls5.SwitchOffRd();
//         ls5.SwitchOffYe();
//         ls5.SwitchOffGn();
//         ls5.WriteOutputs(qRd, qYe, qGn);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qRd);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qYe);
//         AxUnit.Assert.Equal(expected := FALSE, actual := qGn);
//     END_FUNCTION

// END_NAMESPACE