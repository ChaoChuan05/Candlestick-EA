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

void Data::refresh_support_and_resistance(int bar_amount = 100) {

   ArraySetAsSeries(close_data, true);

   if(CopyClose(trade_symbol, _Period, 0, bar_amount, close_data) != bar_amount) {
      Print("Copy close can't work properly", GetLastError());
      return;
   }

}

double Data::set_buffer_to(int buffer_amount) {
   return buffer_amount * pip;

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

double Data::get_support(int start_period, int end_period) {
   close_price = close_data[1];
   support = -1; //no support found yet

   for(int i = start_period; i < end_period; i++) {
      //below the current close
      if((close_data[i] < close_price) && (support < 0 || close_data[i] > support)) {
         support = close_data[i];
      }
   }

   return support;
}

double Data::get_resistance(int start_period, int end_period) {
   close_price = close_data[1];
   resistance = -1;

   for(int i = start_period; i < end_period; i++) {
      if((close_data[i] > close_price) && (resistance < 0 || close_data[i] < resistance)) {
         resistance = close_data[i];
      }
   }

   return resistance;

}

void Data::create_horizontal_line(string period_name, double period_price, int line_color = clrYellow) {

   if(ObjectFind(0, period_name) == -1) ObjectCreate(0, period_name, OBJ_HLINE, 0, 0, period_price);
   else ObjectMove(0, period_name, 0, 0, period_price);

   ObjectSetInteger(0, period_name, OBJPROP_COLOR, line_color);

}