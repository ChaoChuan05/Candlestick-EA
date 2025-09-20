

class HLowHigh{
   
   protected:
      double high_data[];
      
      double low_data[];
      
   public:
      HLowHigh();
      void Add_Array_Data();
      
      int High_Value_Index(int pStart=0, int pEnd=10);
      int Low_Value_Index(int pStart=0, int pEnd=10);
      double High_Value(int pStart=0, int pEnd=10);
      double Low_Value(int pStart=0, int pEnd=10);
};


HLowHigh::HLowHigh(void){
   
   ArraySetAsSeries(high_data, true);
   
   ArraySetAsSeries(low_data, true);
   
}


void HLowHigh::Add_Array_Data(void){
   
   CopyHigh(_Symbol, _Period, 0, 100, high_data);
   
   CopyLow(_Symbol, _Period, 0, 100, low_data);
   
}


int HLowHigh::High_Value_Index(int pStart=0,int pEnd=10){
   
   int max_index = ArrayMaximum(high_data, pStart, pEnd);
   
   return(max_index);
   
}


int HLowHigh::Low_Value_Index(int pStart=0,int pEnd=10){
   
   int low_index = ArrayMinimum(low_data, pStart, pEnd);
   
   return(low_index);
   
}


double HLowHigh::High_Value(int pStart=0,int pEnd=10){
   
   int high_index = High_Value_Index(pStart, pEnd);
   
   double high_value = high_data[high_index];
   
   return(high_value);
   
}


double HLowHigh::Low_Value(int pStart=0,int pEnd=10){

   int low_index = Low_Value_Index(pStart, pEnd);
   
   double low_value = low_data[low_index];
   
   return(low_value);

}
