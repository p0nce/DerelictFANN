DerelictFANN
============

*Warning: this an unofficial Derelict binding.*

A dynamic binding to [FANN](http://leenissen.dk/fann/wp/) for the D Programming Language.

For information on how to build DerelictFANN and link it with your programs, please see the post [Using Derelict](http://dblog.aldacron.net/derelict-help/using-derelict/) at The One With D.

For information on how to load the FANN library via DerelictFANN, see the page [DerelictUtil for Users](https://github.com/DerelictOrg/DerelictUtil/wiki/DerelictUtil-for-Users) at the DerelictUtil Wiki. In the meantime, here's some sample code.

```D
import derelict.fann.fann;

void main() {
    // Load the FANN library.
    DerelictFANN.load();

    // Now FANN functions can be called, or FANN wrapper be used
    ...
}
```
