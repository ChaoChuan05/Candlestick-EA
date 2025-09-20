#ifndef TradeCompute_type
#define TradeCompute_type

#include "Strategy.mqh"
#include "Data.mqh"
#include <Trade/Trade.mqh>

class TradeCompute {

private:
   CTrade trade;

   TradeStrategy M15strategy;
   TradeStrategy H1strategy;

   string symbol_pair;
   ENUM_TIMEFRAMES timeframe;
   double lot_size;

   datetime last_trade_time;
   datetime last_exit_time;
   datetime current_time_bar;

   //reference timeframe
   ENUM_TIMEFRAMES timeframe_refer;

public:

   TradeCompute(double, string, ENUM_TIMEFRAMES, ENUM_TIMEFRAMES);

   void trade_execution(Data &);
};

#endif