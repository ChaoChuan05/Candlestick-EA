#ifndef TradeStrategy_type
#define TradeStrategy_type

#include "Data.mqh"

class TradeStrategy {

private:

    string trade_symbol;
    ENUM_TIMEFRAMES timeframe;

public:
    TradeStrategy(string, ENUM_TIMEFRAMES);
    
    // Trade signal
    string trade_signal(Data &);
};

#endif
