#ifndef CandlePattern_type 
#define CandlePattern_type

class CandlePattern {

private:


   string trade_symbol;
   ENUM_TIMEFRAMES timeframe;

   MqlRates candle[];

public:

   CandlePattern(string, ENUM_TIMEFRAMES);

   bool refresh_candlestick();

   bool get_bull_engulfing();
   bool get_bear_engulfing();
   bool get_double_bull_engulfing();
   bool get_double_bear_engulfing();

};




#endif