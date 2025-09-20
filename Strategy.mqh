#ifndef TradeStrategy_type
#define TradeStrategy_type

#include "Data.mqh"
#include "Support-Resistance-System/HighLowData.mqh"
#include "Support-Resistance-System/LineSystems.mqh"

class TradeStrategy {

private:

    string trade_symbol;
    ENUM_TIMEFRAMES timeframe;

    //S&R system 
    HLowHigh support_resistance_data;

    //S&R levels 
    double resistance_15;
    double support_15;

public:
    TradeStrategy(string, ENUM_TIMEFRAMES);

    //S&R functions
    void support_resistance_refresh();
    void draw_sr_lines();
    bool is_price_near_support(double);
    bool is_price_near_resistance(double);

    // Trade signal
    string trade_signal(Data &);
};

#endif
