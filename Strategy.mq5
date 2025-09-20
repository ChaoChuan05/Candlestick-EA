#include "Strategy.mqh"
#include "Data.mq5"

TradeStrategy::TradeStrategy(string strategy_symbol, ENUM_TIMEFRAMES strategy_timeframe) {
    trade_symbol = strategy_symbol;
    timeframe = strategy_timeframe;

    //S&R levels initialise
    resistance_15 = 0;
    support_15 = 0;
}

void TradeStrategy::support_resistance_refresh() {

    support_resistance_data.Add_Array_Data();

    //Resistance level
    resistance_15 = support_resistance_data.High_Value(1, 15);

    //Support level
    support_15 = support_resistance_data.Low_Value(1, 15);

    draw_sr_lines();

}

void TradeStrategy::draw_sr_lines() {

    Create_Horizontal_Line("Highest 15", resistance_15, clrBlue);
    Create_Horizontal_Line("Lowest 15", support_15, clrRed);

}

bool TradeStrategy::is_price_near_support(double price) {
    
    // Check if price is within buffer of any support level
    return price < support_15;
}

bool TradeStrategy::is_price_near_resistance(double price) {
    
    // Check if price is within buffer of any resistance level
    return price > resistance_15;
}

string TradeStrategy::trade_signal(Data &data) {

    //1. Refresh S&R level 
    support_resistance_refresh();

    //2. Get current prices using data class
    double bid = data.get_bid_price();
    double ask = data.get_ask_price();

    //4. Combine candlestick with S&R analysis
    if(is_price_near_resistance(ask)) return "BUY SIGNAL";
    if(is_price_near_support(bid)) return "SELL SIGNAL";

    return "NONE SIGNAL";
}