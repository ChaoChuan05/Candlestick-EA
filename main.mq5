#include "Strategy.mqh"
#include "Strategy.mq5"
#include "Trade.mqh"
#include "Trade.mq5"
#include "Data.mqh"
#include "Data.mq5"

input group "Basic Configuration"
input int maximum_open_position = 5;
input double lot_size = 0.01;
input int profit = 10;
input int stop_loss = 15;
input ENUM_TIMEFRAMES timeframe = PERIOD_M15;
input ENUM_TIMEFRAMES refer_period = PERIOD_H1;

input group "Trade Symbol"
input string trade_pair = "EURUSD";

TradeStrategy *main_strategy;
TradeCompute *main_compute;
Data *main_data;


int OnInit() {

    main_strategy = new TradeStrategy(trade_pair, timeframe, refer_period);
    main_compute = new TradeCompute(lot_size, trade_pair, timeframe);
    main_data = new Data(profit, stop_loss, trade_pair);

   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {

    
    if(main_strategy != NULL) {
        delete main_strategy;
        main_strategy = NULL;
    }

    if(main_compute != NULL) {
        delete main_compute;
        main_compute = NULL;
    }

    if(main_data != NULL) {
        delete main_data;
        main_data = NULL;
    }
}

void OnTick() {

    if(PositionsTotal() >= maximum_open_position) return;

    if(main_strategy != NULL && main_compute != NULL && main_data != NULL) {
        main_compute.trade_execution(main_strategy, main_data);
    }
    

}
