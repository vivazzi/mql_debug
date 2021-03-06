#property copyright "Copyright © 2019-2021 Artem Maltsev (Vivazzi)"
#property link      "https://vivazzi.pro"
#property description   "Tests for mql_debug"
#property strict

#include <debug/debug.mqh>
#include <unit_test/unit_test.mqh>


class DebugTest : public TestCase {
    void test_handle_value_desc() {
        string data = "TestDebug.mq4: int OnInit(), line 15:\n    default_debug.debug_to_file(MathPow(2,1),__FILE__: __FUNCSIG__, line +(string)__LINE__+:\n    +MathPow(2,1))+default_debug.debug_to_file(MathAbs(-10)/2,__FILE__: __FUNCSIG__, line +(string)__LINE__+:\n    +MathAbs(-10)/2)";
        string checked_data = "TestDebug.mq4: int OnInit(), line 15:\n    MathPow(2,1)+MathAbs(-10)/2";
        default_debug._handle_value_desc(data);
        assert_equal(data, checked_data);
    }

    void declare_tests() {
        test_handle_value_desc();
    }
};


int OnInit(){
    DebugTest test;
    test.run();

    // simple usage with default log_path: MQL(4,5)/Files/debug/[account_number]/debug.txt
    _d(MathPow(2, 1) + MathAbs(-10) / 2);
    _d(StringFormat("Length of 1234567890 = %d", StringLen("1234567890")));

    _d(_d(MathPow(2, 1)) + _d(MathAbs(-10) / 2));
    _dp(_dp(MathPow(2, 1)) + _dp(MathAbs(-10) / 2));

    // --- default debug ---
    _d_set_log_path("example_debug.txt");

    // debug to file
    _d(MathPow(2, 1));
    _df(MathPow(2, 2));

    // debug to print
    _dp(MathPow(2, 3));

    // clear
    _d_clear();
    _d(MathPow(2, 4));
    _df(MathPow(2, 5));

    // --- custom debug ---
    Debug d_1("custom_debug.txt");

    // debug to file
    d(d_1, MathPow(4, 1));
    df(d_1, MathPow(4, 2));

    // debug to print
    dp(d_1, MathPow(4, 3));

    // clear
    d_clear(d_1);
    d(d_1, MathPow(4, 4));
    df(d_1, MathPow(4, 5));

	return(INIT_SUCCEEDED);
}