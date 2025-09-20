#ifndef TradeStrategy_type
#define TradeStrategy_type

#include "Candlestick-Pattern/CandlePattern.mqh"
#include "Data.mqh"
#include "Support-Resistance-System/HighLowData.mqh"
#include "Support-Resistance-System/LineSystems.mqh"

class TradeStrategy {

private:
    CandlePattern M15candle;
    CandlePattern H1candle;

    string trade_symbol;
    ENUM_TIMEFRAMES timeframe;
    ENUM_TIMEFRAMES timeframe_refer;

    //S&R system 
    HLowHigh support_resistance_data;

    //S&R levels 
    double resistance_100, resistance_50, resistance_20;
    double support_100, support_50, support_20;

    //S&R parameters
    double support_resistance_buffer_points;
    bool show_support_resistance_lines;

public:
    TradeStrategy(string, ENUM_TIMEFRAMES, ENUM_TIMEFRAMES);

    // Core strategy logic
    string candlestick();

    //S&R functions
    void support_resistance_refresh();
    void draw_sr_lines();
    bool is_price_near_support(double);
    bool is_price_near_resistance(double);
    double get_nearest_support(double);
    double get_nearest_resistance(double);

    // Trade signal
    string trade_signal(Data &);
};

#endif
