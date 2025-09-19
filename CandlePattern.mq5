#include "CandlePattern.mqh"

CandlePattern::CandlePattern(string candlestick_symbol, ENUM_TIMEFRAMES candlestick_timeframe) {
   trade_symbol = candlestick_symbol;
   timeframe = candlestick_timeframe;
   ArraySetAsSeries(candle, true);
}

bool CandlePattern::refresh_candlestick() {
   if(CopyRates(trade_symbol, timeframe, 0, 4, candle) != 4) {
      ArrayResize(candle, 0);
      Print("Bar or Moving average handle unable to copy buffer! ", GetLastError());
      return false;
   } 
   return true;
}

bool CandlePattern::get_bull_engulfing() {
   bool bull_engulfing = candle[2].close < candle[2].open &&
                         candle[1].close > candle[1].open &&
                         candle[1].close > candle[2].open &&
                         candle[1].open < candle[2].close;
   return bull_engulfing;
}

bool CandlePattern::get_bear_engulfing() {
   bool bear_engulfing = candle[2].close > candle[2].open &&
                         candle[1].close < candle[1].open &&
                         candle[1].close < candle[2].open &&
                         candle[1].open > candle[2].close;
   return bear_engulfing;
}

bool CandlePattern::get_double_bull_engulfing() {
   bool double_bull_engulfing = candle[3].close < candle[3].open &&
                                candle[2].close > candle[2].open &&
                                candle[2].open < candle[3].close &&
                                candle[2].close > candle[3].open &&
                                candle[2].close > candle[2].open &&
                                candle[1].close > candle[1].open &&
                                candle[1].open < candle[2].close &&
                                candle[1].close > candle[2].open;
   return double_bull_engulfing;
}

bool CandlePattern::get_double_bear_engulfing() {
   bool double_bear_engulfing = candle[3].close > candle[3].open &&
                                candle[2].close < candle[2].open &&
                                candle[2].open > candle[3].close &&
                                candle[2].close < candle[3].open &&
                                candle[2].close < candle[2].open &&
                                candle[1].close < candle[1].open &&
                                candle[1].open > candle[2].close &&
                                candle[1].close < candle[2].open;
   return double_bear_engulfing;
}