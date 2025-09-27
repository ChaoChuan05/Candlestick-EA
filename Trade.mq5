#include "Trade.mqh"
#include "Strategy.mq5"

TradeCompute::TradeCompute(double lot_volume, string trade_symbol, ENUM_TIMEFRAMES trade_timeframe, ENUM_TIMEFRAMES time_refer) : M15strategy(trade_symbol, trade_timeframe), H1strategy(trade_symbol, time_refer) {
   lot_size = lot_volume;
   symbol_pair = trade_symbol;
   timeframe = trade_timeframe;
   timeframe_refer = time_refer;

   last_exit_time = 0;
   last_trade_time = 0;
   current_time_bar = 0;

}

void TradeCompute::trade_execution(Data &data) {

   data.refresh_price();
   data.refresh_support_and_resistance(50);

   current_time_bar = iTime(symbol_pair, timeframe, 0);

   if(current_time_bar == last_trade_time) {
      Print("Trade already executed on this bar, skipping...");
      return;
   }

   double buy_tp = data.buy_profit();
   double buy_sl = data.buy_loss();
   double sell_tp = data.sell_profit();
   double sell_sl = data.sell_loss();

   string M15trade_signal = M15strategy.trade_signal(data);
   string H1trade_signal = H1strategy.trade_signal(data);

   if(M15trade_signal == "BUY SIGNAL" && H1trade_signal == "BUY SIGNAL") {
      trade.Buy(lot_size, symbol_pair, 0, buy_sl, buy_tp);
      Print("Buy ", lot_size, " on ", symbol_pair, " success!");
      last_trade_time = current_time_bar;
   }
   
   else if(M15trade_signal == "SELL SIGNAL" && H1trade_signal == "SELL SIGNAL") {
      trade.Sell(lot_size, symbol_pair, 0, sell_sl, sell_tp);
      Print("Sell ", lot_size, " on ", symbol_pair, " success!");
      last_trade_time = current_time_bar;
   }

   else {
      Print("No trade signal");
      
   }
   
}