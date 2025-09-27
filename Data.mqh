#ifndef Data_type
#define Data_type

class Data {
   
private:
   //Price
   string trade_symbol;
   int trade_profit;
   int trade_loss;
   double ask;
   double bid;
   int symbol_digits;
   double symbol_point;
   double pip;

   //Support and resistance
   double close_price;
   double support;
   double resistance;
   double close_data[];

   
public:
   
   Data(int, int, string);

   //Refresh
   void refresh_price();
   void refresh_support_and_resistance(int);

   //Buffer
   double set_buffer_to(int);
 
   //Bid and ask
   double get_ask_price();
   double get_bid_price();

   //TP and SL
   double buy_profit();
   double buy_loss();
   double sell_profit();
   double sell_loss();

   //Support and resistance
   double get_support(int, int);
   double get_resistance(int, int);

   //Line
   void create_horizontal_line(string, double, int);

};

#endif