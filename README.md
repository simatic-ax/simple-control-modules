# Simple control modules

## Description

## Install this package

Enter:

```cli
apax add @simatic-ax/simple-control-modules
```

> to install this package you need to login into the GitHub registry. You'll find more information [here](https://github.com/simatic-ax/.github/blob/main/docs/personalaccesstoken.md)

## Namespace

```sh
Simatic.Ax.SimpleControlModules
```

## Encoder

### Encoder A

The EncoderA counts the rising and falling edges of a binary signal.

### EncoderAB

The EncoderAB is similar to EnocderA but it counts the rising and falling edges of two 90 dregree phase shifted binary signals (SignalA and SignalB). So the counting direction is evaluated automatically.

### Methods of EncoderA and EncoderAB

|||
|-|-|
| Evaluate() | Evaluate the SignalA for rising and falling edges and counts them
| GetValue() : DINT   | Returns the actual counter value |
| RelativeCount() | Retunrs the relative counter value |
| Reset | Reset the counter value to 0
| ResetRelative() | Reset the relative counter value to 0 |
| SetDirection(mode : CountMode) | Set the counting direction FORWARD or REVERSE
| SetValue(value : DINT) | Set the actual counter value to value |

Configuration:

```iec-st
USING Siemens.Ax.IO.Input;
USING Simatic.Ax.SimpleControlModules;

VAR_GLOBAL
    sigA : BinSignal;
    enc : EncoderAB(SignalA := sigA);
END_VAR
```

Configuration:

```iec-st
USING Siemens.Ax.IO.Input;
USING Simatic.Ax.SimpleControlModules;

VAR_GLOBAL
    sigA : BinSignal;
    sigB : BinSignal;
    enc : EncoderAB(SignalA := sigA, SignalB := sigB);
END_VAR
```

### Example

```iec-st
USING Siemens.Ax.Io.Input;
USING Simatic.Ax.SimpleControlModules;

CONFIGURATION PLC_1

    TASK Main(Priority := 1);

    PROGRAM P1 WITH Main : SampleProgram;

    VAR_GLOBAL
        aIn AT %I0.0 : BOOL ;
        bIn AT %I0.0 : BOOL ;
        sigA : BinSignal;
        sigB : BinSignal;
        actPos : DINT;
        enc : EncoderAB := (SignalA := sigA, SignalB := sigB);
    END_VAR
    
END_CONFIGURATION

PROGRAM SampleProgram
    VAR_EXTERNAL
        aIn : BOOL ;
        bIn : BOOL ;
        sigA : BinSignal;
        sigB : BinSignal;
        actPos : DINT;
        enc : EncoderAB;
    END_VAR

    sigA.ReadCyclic(signal := aIn);
    sigB.ReadCyclic(signal := bIn);
    enc.Evaluate();
    actPos := enc.GetValue();
END_PROGRAM
```

## Counter

The Counter counts with the methods CountForward(increment : DINT) or CountReverse(decrement : DINT). The parameter `increment` or `decrement` is 1 by default.

Methods:
|||
|-|-|
| Config(ll : DINT ul : DINT) | set the upper and lower limit |
| SetCounterValue(value : DINT) | Set the counterf value to value (default 0) |
| CounterValue() : DINT | Retunrs the actual counter value
| CountForward(increment : DINT) | Count forward by increment (default 1) |
| CountReverse(decrement : DINT) | Count reverse by decrement (default 1) |
| UpperLimitReached() : BOOL | Returns TRUE when the counter value >= upper limit |
| LowerLimitReached() : BOOL | Returns TRUE when the counter value <= lower limit |

### Markdownlint-cli

This workspace will be checked by the [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli) (there is also documented ho to install the tool) tool in the CI workflow automatically.  
To avoid, that the CI workflow fails because of the markdown linter, you can check all markdown files locally by running the markdownlint with:

```sh
markdownlint **/*.md --fix
```

## Contribution

Thanks for your interest in contributing. Anybody is free to report bugs, unclear documentation, and other problems regarding this repository in the Issues section or, even better, is free to propose any changes to this repository using Merge Requests.

## License and Legal information

Please read the [Legal information](LICENSE.md)
