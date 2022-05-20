# encodeToString

Encodes REAL(8) to CHARACTER(16) and INTEGER(4) to CHARACTER(8) and vice versa.

## Compile

Tested with ```gfortran```, compile using ```make```.

## Usage

Include the module to your project, i.e.

```
use encodeToString
```

then to encode a real to a string use
```
real(8) r
character(16) s

r = sqrt(2.0D0)
s = ets_real2string(r)
```

To decode, use
```
r = ets_string2real(s)
```