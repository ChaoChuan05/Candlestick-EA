#include "Data.mqh"

Data::Data(int take_profit_data, int stop_loss_data, string trade_symbol_data) {

   trade_symbol = trade_symbol_data;
   trade_profit = take_profit_data;
   trade_loss = stop_loss_data;
   ask = 0;
   bid = 0;

   symbol_digits = (int)SymbolInfoInteger(trade_symbol, SYMBOL_DIGITS);
   symbol_point = SymbolInfoDouble(trade_symbol, SYMBOL_POINT);

   pip = (symbol_digits == 3 || symbol_digits == 5) ? symbol_point * 10 : symbol_point;
}

void Data::refresh_price() {

   MqlTick tick;

   if(SymbolInfoTick(trade_symbol, tick)) {
      ask = tick.ask;
      bid = tick.bid;
   }

}

double Data::get_ask_price() {
   return NormalizeDouble(ask, symbol_digits);
}

double Data::get_bid_price() {

   return NormalizeDouble(bid, symbol_digits);
}

double Data::buy_profit() {
   return NormalizeDouble((ask + (trade_profit * pip)), symbol_digits);
}

double Data::buy_loss() {
   return NormalizeDouble((ask - (trade_loss * pip)), symbol_digits);
}

double Data::sell_profit() {
   return NormalizeDouble((bid - (trade_profit * pip)), symbol_digits);
}

double Data::sell_loss() {
   return NormalizeDouble((bid + (trade_loss * pip)), symbol_digits);
}