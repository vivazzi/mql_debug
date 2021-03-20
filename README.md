# MQL debug

mql_debug is additional instrument for code debugging for mql language. With mql_debug you can save result of your function 
and code of call function like a string to file or print to MetaTrader: `Terminal\Experts`

## Installing

Download repo and copy `mql_debug/Include/debug.mqh` folder to `<TERMINAL DIR>/MQL(4/5)/Include`

## Usage

Add include `<debug/debug.mqh>` and use `_d` wrapper to save result of function call:

```mql4
#include <debug/debug.mqh>

int OnInit(){
    _d(MathPow(2, 1) + MathAbs(-10) / 2);
    _d(StringFormat("Length of 1234567890 = %d", StringLen("1234567890")));
}
```

Compile and run this your expert in terminal in a window of any trading pair and look debug result in `<TERMINAL DIR>/Files/debug/<ACCOUNT NUMBER>/debug.txt`.
You can see something like:
```
MyExpert.mq4: int OnInit(), line 3:
    MathPow(2,1)+MathAbs(-10)/2 :: 7
MyExpert.mq4: int OnInit(), line 4:
    StringFormat(Length of 1234567890 = %d,StringLen(1234567890)) :: Length of 1234567890 = 10
```

In log file you can see next information:

- file, function and line of `_d` call,
- string of function call and its result after `::`,

You can use any nesting `_d` calls:

```mql4
#include <debug/debug.mqh>

int OnInit(){
    _d(_d(MathPow(2, 1)) + _d(MathAbs(-10) / 2));
}
```

Result of run this code:

```
TestDebug.mq4: int OnInit(), line 3:
    MathPow(2,1) :: 2
TestDebug.mq4: int OnInit(), line 3:
    MathAbs(-10)/2 :: 5
TestDebug.mq4: int OnInit(), line 3:
    MathPow(2,1)+MathAbs(-10)/2 :: 7
```

First, the `_d()` run with the deepest nesting, and then higher.

In any time in code you can change a name of debug log file with method `_d_set_log_path()`:

```mql4
#include <debug/debug.mqh>

int OnInit(){
    _d(MathPow(2, 1));
    _d_set_log_path("example_debug.txt");
    _d(MathAbs(-10));
}
```

After run code you get two result files:

```
1. <TERMINAL DIR>/Files/debug/<ACCOUNT NUMBER>/debug.txt:
TestDebug.mq4: int OnInit(), line 3:
    MathPow(2,1) :: 2

2. <TERMINAL DIR>/Files/example_debug.txt:
TestDebug.mq4: int OnInit(), line 3:
    MathAbs(-10) :: 10
```

To clear debug file, use method `_d_clear()`:

```mql4
#include <debug/debug.mqh>

int OnInit(){
    _d(MathPow(2, 1));
    _d_clear();
    _d(MathAbs(-10));
}
```

It is useful when you debug your code in MetaEditor and want to clear result file.


## Debug to terminal journal

In most cases, the saving of results to file is better case, but you can print debug result to terminal journal (section: `Terminal\Experts`) using `_dp()`:

```mql4
#include <debug/debug.mqh>

int OnInit(){
    _dp(MathPow(2, 3));
}
```

After run code you can see result in journal like:

```
2021.02.28 13:50:25.956	MyExpert EURUSD,H1: MyExpert.mq4: int OnInit(), line 43:    MathPow(2,3) :: 8
```


## Usage of some debugs

Using `_d` and `_dp` you work with default debug.  
You can define some debug for flex usage, adding Debug object and calling `d` and `df` methods:

```mql4
#include <debug/debug.mqh>

int OnInit(){
    // first debug
    Debug d_1("debug_1.txt");

    d(d_1, MathPow(4, 1));
    dp(d_1, MathPow(4, 2));
    
    // second debug
    Debug d_2("debug_2.txt");

    d(d_2, MathPow(4, 1));
    dp(d_2, MathPow(4, 2));
}
```

You can use a default and custom debugs at the same time.

To change path to result file, use `d_set_log_path(d_object, log_path)`.

To clear result file, use `d_clear(d_object)`.

## Synonyms

Instead of usage `_d` you can use `_df` - they are equivalent. `_df` is added for common code style, if anybody wants to write so. 
In most cases it is used the saving to file, so `_d` is used for brevity.

For your custom debug objects there is appropriate `df`.

## Run tests

1. Copy `mql_debug/Experts/TestDebug.mq4` to `<TERMINAL DIR>/MQL(4/5)/Experts`
2. Compile `TestDebug.mq4` and run `TestDebug.ex4` in terminal in a window of any trading pair.
3. Look test result in `<TERMINAL DIR>/Files/TestDebug_unit_test_log.txt`

# CONTRIBUTING

To reporting bugs or suggest improvements, please use the [issue tracker](https://github.com/vivazzi/mql_debug/issues).

Thank you very much, that you would like to contribute to mql_debug. Thanks to the [present, past and future contributors](https://github.com/vivazzi/mql_debug/contributors).

If you think you have discovered a security issue in our code, please do not create issue or raise it in any public forum until we have had a chance to deal with it.
**For security issues use security@vuspace.pro**


# LINKS

- Project's home: https://github.com/vivazzi/mql_debug
- Report bugs and suggest improvements: https://github.com/vivazzi/mql_debug/issues
- Author's site, Artem Maltsev: https://vivazzi.pro
    
# LICENCE

Copyright © 2021 Artem Maltsev and contributors.

MIT licensed.