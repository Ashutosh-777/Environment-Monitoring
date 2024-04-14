#include <WiFi.h>
#include <ThingSpeak.h>
#include <DHT11.h>
#include <MQ135.h>
int statuscode;
//wifi setup
char ssid[]="Alpha";
char pass[]="12345678";
WiFiClient client;
unsigned long mychannelNumber=2432080;
const char * myWriteAPIKey="RUENPKVU6Q3I9IVF";
//MQ135 CODE
int mq135_sensor = 34;
int mq135_ppm = 0;
//DHT 11
const int DHT_PIN=27;
int temperature = 0;
int humidity = 0;
DHT11 dht11(DHT_PIN);
//TDS
#define TdsSensorPin 35
#define VREF 3.3              // analog reference voltage(Volt) of the ADC
#define SCOUNT  30            // sum of sample point

int analogBuffer[SCOUNT];     // store the analog value in the array, read from ADC
int analogBufferTemp[SCOUNT];
int analogBufferIndex = 0;
int copyIndex = 0;

float averageVoltage = 0;
float tdsValue = 0;
float tdsTemperature = 25;       // current temperature for compensation
//SOIL MOISTURE
#define soilSensorPin 32
float soilMoisturePercentage=0;

void setup() {
    Serial.begin(115200);
    WiFi.mode(WIFI_STA);
    pinMode(TdsSensorPin,INPUT);
    ThingSpeak.begin(client);
}
void loop() {
  connectWifi();
  readDHT11();
  readTDS();
  readSoilMoisture();
  readMQ135();
  postData();
  delay(2000);
}

//Connect with WiFi
void connectWifi(){
    if(WiFi.status() !=WL_CONNECTED){
    Serial.print("Attempting to connect");
    while(WiFi.status() !=WL_CONNECTED)
    {
      WiFi.begin(ssid,pass);
      Serial.print(".");
      delay(5000);
    }
    Serial.println("\nConnected.");
  }
}
//ThingsSpeak API upload
void postData(){
  ThingSpeak.setField(1,temperature);
  ThingSpeak.setField(2,humidity);
  ThingSpeak.setField(4,tdsValue);
  ThingSpeak.setField(5,soilMoisturePercentage);
  statuscode=ThingSpeak.writeFields(mychannelNumber,myWriteAPIKey);
   if(statuscode==200){
     Serial.println("channel update successfully");
      }
   else{
    Serial.println("Problem Writing data. HTTP error code:" + String(statuscode));
   }
}
//DHT11
//Field 1 & Field 2
void readDHT11(){
    int result = dht11.readTemperatureHumidity(temperature, humidity);
    // Check the results of the readings.
    // If the reading is successful, print the temperature and humidity values.
    // If there are errors, print the appropriate error messages.
    if (result == 0) {
        Serial.print("Temperature: ");
        Serial.print(temperature);
        Serial.print(" °C\tHumidity: ");
        Serial.print(humidity);
        Serial.println(" %");
        tdsTemperature = temperature;
    } else {
        // Print error message based on the error code.
        Serial.println(DHT11::getErrorString(result));
    }
}
//TDS VALUE READING
//Field 4
void readTDS(){
    static unsigned long analogSampleTimepoint = millis();
  if(millis()-analogSampleTimepoint > 40U){     //every 40 milliseconds,read the analog value from the ADC
    analogSampleTimepoint = millis();
    analogBuffer[analogBufferIndex] = analogRead(TdsSensorPin);    //read the analog value and store into the buffer
    analogBufferIndex++;
    if(analogBufferIndex == SCOUNT){ 
      analogBufferIndex = 0;
    }
  }   
  
  static unsigned long printTimepoint = millis();
  if(millis()-printTimepoint > 800U){
    printTimepoint = millis();
    for(copyIndex=0; copyIndex<SCOUNT; copyIndex++){
      analogBufferTemp[copyIndex] = analogBuffer[copyIndex];
      
      // read the analog value more stable by the median filtering algorithm, and convert to voltage value
      averageVoltage = getMedianNum(analogBufferTemp,SCOUNT) * (float)VREF / 4096.0;
  
      //temperature compensation formula: fFinalResult(25^C) = fFinalResult(current)/(1.0+0.02*(fTP-25.0)); 
      float compensationCoefficient = 1.0+0.02*(tdsTemperature-25.0);
      //temperature compensation
      float compensationVoltage=averageVoltage/compensationCoefficient;
      
      //convert voltage value to tds value
      tdsValue=(133.42*compensationVoltage*compensationVoltage*compensationVoltage - 255.86*compensationVoltage*compensationVoltage + 857.39*compensationVoltage)*0.5;
      
      //Serial.print("voltage:");
      //Serial.print(averageVoltage,2);
      //Serial.print("V   ");
      // Serial.print("TDS Value:");
      // Serial.print(tdsValue,0);
      // Serial.println("ppm");
    }
  }
    Serial.print("TDS Value:");
    Serial.print(tdsValue,0);
    Serial.println("ppm");
}
//TDS median filtering algorithm
int getMedianNum(int bArray[], int iFilterLen){
  int bTab[iFilterLen];
  for (byte i = 0; i<iFilterLen; i++)
  bTab[i] = bArray[i];
  int i, j, bTemp;
  for (j = 0; j < iFilterLen - 1; j++) {
    for (i = 0; i < iFilterLen - j - 1; i++) {
      if (bTab[i] > bTab[i + 1]) {
        bTemp = bTab[i];
        bTab[i] = bTab[i + 1];
        bTab[i + 1] = bTemp;
      }
    }
  }
  if ((iFilterLen & 1) > 0){
    bTemp = bTab[(iFilterLen - 1) / 2];
  }
  else {
    bTemp = (bTab[iFilterLen / 2] + bTab[iFilterLen / 2 - 1]) / 2;
  }
  return bTemp;
}
//SOIL MOISTURE READING
//Field 5
void readSoilMoisture(){
  soilMoisturePercentage = ( 100.00 - ( (analogRead(soilSensorPin)/(4095.00)) * 100.00 ) );
  if(soilMoisturePercentage<0){
    soilMoisturePercentage=0;
  }
  Serial.print("Soil Moisture(in Percentage) = ");
  Serial.print(soilMoisturePercentage);
  Serial.println("%");
}
//MQ 135
void readMQ135(){
  int gasValue = analogRead(mq135_sensor);
  if(gasValue<2000){
    mq135_ppm = map(gasValue,0,2000,0,200);
  }else if(gasValue <= 3000){
    mq135_ppm = map(gasValue,2000,3000,200,300);
  }else{
    mq135_ppm = map(gasValue,3000,4096,450,750);
  }
  Serial.print("Analog read: ");
  Serial.println(gasValue);
  Serial.print("Air Quality in ppm: ");
  Serial.println(mq135_ppm);
}