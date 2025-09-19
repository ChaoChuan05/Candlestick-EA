#ifndef Data_type
#define Data_type

class Data {
   
private:
   string trade_symbol;
   int trade_profit;
   int trade_loss;
   double ask;
   double bid;
   int symbol_digits;
   double symbol_point;
   double pip;
   
public:
   
   Data(int, int, string);
   void refresh_price();

   double get_ask_price();
   double get_bid_price();

   double buy_profit();
   double buy_loss();
   double sell_profit();
   double sell_loss();
};

#endif