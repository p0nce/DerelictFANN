DerelictFANN
============

*Warning: this an unofficial Derelict binding.*

A dynamic binding to [FANN](http://leenissen.dk/fann/wp/) for the D Programming Language.

Please see the pages [Building and Linking Derelict](http://derelictorg.github.io/compiling.html) and [Using Derelict](http://derelictorg.github.io/using.html), or information on how to build DerelictFANN and load the FANN library at run time. In the meantime, here's some sample code.

```D
import derelict.fann.fann;

void main() {
    // Load the FANN library.
    DerelictFANN.load();

    // Now FANN functions can be called, or FANN wrapper be used
    ...
}
```
