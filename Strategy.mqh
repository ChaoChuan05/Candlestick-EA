#ifndef TradeStrategy_type
#define TradeStrategy_type

#include "CandlePattern.mqh"

class TradeStrategy {

private:

    CandlePattern M15candle;
    CandlePattern H1candle;

    string trade_symbol;
    ENUM_TIMEFRAMES timeframe;
    ENUM_TIMEFRAMES timeframe_refer;

public:

    TradeStrategy(string, ENUM_TIMEFRAMES, ENUM_TIMEFRAMES);

    string candlestick();

    string trade_signal();
};


#endif 