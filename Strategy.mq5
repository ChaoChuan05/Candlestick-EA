#include "Strategy.mqh"

TradeStrategy::TradeStrategy(string strategy_symbol, ENUM_TIMEFRAMES strategy_timeframe, ENUM_TIMEFRAMES reference_timeframe) : M15candle(strategy_symbol, strategy_timeframe), H1candle(strategy_symbol, reference_timeframe) {
    trade_symbol = strategy_symbol;
    timeframe = strategy_timeframe;
    timeframe_refer = reference_timeframe;

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

string TradeStrategy::trade_signal() {
    if(candlestick() == "BUY") return "BUY SIGNAL";
    if(candlestick() == "SELL") return "SELL SIGNAL";
    else return "NONE SIGNAL";

}