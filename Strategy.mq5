#include "Strategy.mqh"
#include "Candlestick-Pattern/CandlePattern.mq5"
#include "Data.mq5"

TradeStrategy::TradeStrategy(string strategy_symbol, ENUM_TIMEFRAMES strategy_timeframe, ENUM_TIMEFRAMES reference_timeframe) : M15candle(strategy_symbol, strategy_timeframe), H1candle(strategy_symbol, reference_timeframe) {
    trade_symbol = strategy_symbol;
    timeframe = strategy_timeframe;
    timeframe_refer = reference_timeframe;

    //S&R parameters initialise
    support_resistance_buffer_points = 15.0;
    show_support_resistance_lines = true;

    //S&R levels initialise
    resistance_100 = resistance_50 = resistance_20 = 0;
    support_100 = support_50 = support_20 = 0;
}

string TradeStrategy::candlestick() {

    M15candle.refresh_candlestick();
    H1candle.refresh_candlestick();

    if((M15candle.get_bull_engulfing() && H1candle.get_bull_engulfing()) || (M15candle.get_bull_engulfing() && H1candle.get_double_bull_engulfing())) return "BUY";
    if((M15candle.get_bear_engulfing() && H1candle.get_bear_engulfing()) || (M15candle.get_bear_engulfing() && H1candle.get_double_bear_engulfing())) return "SELL";
    if((M15candle.get_double_bull_engulfing() && H1candle.get_bull_engulfing()) || (M15candle.get_double_bull_engulfing() && H1candle.get_double_bull_engulfing())) return "BUY";
    if((M15candle.get_double_bear_engulfing() && H1candle.get_bear_engulfing()) || (M15candle.get_double_bear_engulfing() && H1candle.get_double_bear_engulfing())) return "SELL";

    return "NONE";
}

void TradeStrategy::support_resistance_refresh() {

    support_resistance_data.Add_Array_Data();

    //Resistance level
    resistance_100 = support_resistance_data.High_Value(50, 100);
    resistance_50 = support_resistance_data.High_Value(20, 50);
    resistance_20 = support_resistance_data.High_Value(5, 20);

    //Support level
    support_100 = support_resistance_data.Low_Value(50, 100);
    support_50 = support_resistance_data.Low_Value(20, 50);
    support_20 = support_resistance_data.Low_Value(5, 20);

    if(show_support_resistance_lines) draw_sr_lines();

}

void TradeStrategy::draw_sr_lines() {

    Create_Horizontal_Line("Highest 100", resistance_100, clrBlue);
    Create_Horizontal_Line("Highest 50", resistance_50, clrBlue);
    Create_Horizontal_Line("Highest 20", resistance_20, clrBlue);
    
    Create_Horizontal_Line("Lowest 100", support_100, clrRed);
    Create_Horizontal_Line("Lowest 50", support_50, clrRed);
    Create_Horizontal_Line("Lowest 20", support_20, clrRed);

}

bool TradeStrategy::is_price_near_support(double price) {
    double buffer = support_resistance_buffer_points * _Point;
    
    // Check if price is within buffer of any support level
    return ((price >= (support_100 - buffer) && price <= (support_100 + buffer)) ||
            (price >= (support_50 - buffer) && price <= (support_50 + buffer)) ||
            (price >= (support_20 - buffer) && price <= (support_20 + buffer)));
}

bool TradeStrategy::is_price_near_resistance(double price) {
    double buffer = support_resistance_buffer_points * _Point;
    
    // Check if price is within buffer of any resistance level
    return ((price >= (resistance_100 - buffer) && price <= (resistance_100 + buffer)) ||
            (price >= (resistance_50 - buffer) && price <= (resistance_50 + buffer)) ||
            (price >= (resistance_20 - buffer) && price <= (resistance_20 + buffer)));
}

double TradeStrategy::get_nearest_support(double price) {
    // Find the highest support level below current price
    double nearest = 0;
    
    if(support_20 < price && support_20 > nearest) nearest = support_20;
    if(support_50 < price && support_50 > nearest) nearest = support_50;
    if(support_100 < price && support_100 > nearest) nearest = support_100;
    
    // If no support below price, return the strongest (100-period)
    return (nearest == 0) ? support_100 : nearest;
}

double TradeStrategy::get_nearest_resistance(double price) {
    // Find the lowest resistance level above current price
    double nearest = DBL_MAX;
    
    if(resistance_20 > price && resistance_20 < nearest) nearest = resistance_20;
    if(resistance_50 > price && resistance_50 < nearest) nearest = resistance_50;
    if(resistance_100 > price && resistance_100 < nearest) nearest = resistance_100;
    
    // If no resistance above price, return the strongest (100-period)
    return (nearest == DBL_MAX) ? resistance_100 : nearest;
}

string TradeStrategy::trade_signal(Data &data) {

    //1. Refresh S&R level 
    support_resistance_refresh();

    //2. Get current prices using data class
    double bid = data.get_bid_price();
    double ask = data.get_ask_price();

    //3. check candlestick pattern
    string candle_signal = candlestick();

    //4. Combine candlestick with S&R analysis
    if(candle_signal == "BUY" && is_price_near_resistance(ask)) return "BUY SIGNAL";
    if(candle_signal == "SELL" && is_price_near_support(bid)) return "SELL SIGNAL";

    return "NONE SIGNAL";
}