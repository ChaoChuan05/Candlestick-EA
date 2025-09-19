#ifndef TradeCompute_type
#define TradeCompute_type

#include "Strategy.mqh"
#include "Data.mqh"
#include <Trade/Trade.mqh>

class TradeCompute {

private:
   CTrade trade;

   string symbol_pair;
   ENUM_TIMEFRAMES timeframe;
   double lot_size;

   datetime last_trade_time;
   datetime last_exit_time;
   datetime current_time_bar;

public:

   TradeCompute(double, string, ENUM_TIMEFRAMES);

   void trade_execution(TradeStrategy &, Data &);
};

#endif