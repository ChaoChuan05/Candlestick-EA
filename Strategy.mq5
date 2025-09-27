#include "Strategy.mqh"
#include "Data.mq5"

TradeStrategy::TradeStrategy(string strategy_symbol, ENUM_TIMEFRAMES strategy_timeframe) {
    trade_symbol = strategy_symbol;
    timeframe = strategy_timeframe;
}

string TradeStrategy::trade_signal(Data &data) {

    //1. Get current S&R level
    double support = data.get_support(1, 50);
    double resistance = data.get_resistance(1, 50);

    //2. Get current prices using data class
    double bid = data.get_bid_price();
    double ask = data.get_ask_price();

    //3. Get the buffer
    double buffer = data.set_buffer_to(3.0);

    //4. Set signal equal to none
    string signal = "NONE SIGNAL";

    //5. if the resistance value is valid and the price is close enough to the resistance or support
    if(resistance > 0 && MathAbs(ask - resistance) <= buffer) {
        data.create_horizontal_line("Resistance", resistance, clrYellow);
        signal = "BUY SIGNAL";
    } 

    if(support > 0 && MathAbs(bid - support) <= buffer)  {
        data.create_horizontal_line("Support", support, clrBlue);
        signal = "SELL SIGNAL";
    }

    return signal;
}