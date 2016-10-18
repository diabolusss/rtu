
#define GAIN  7  //GAIN of the sensor stage
#define GAIN2  100  //GAIN of the sensor stage
#define GAIN3  1      // GAIN of the sensor stage
#define RESISTOR 100  // LOAD RESISTOR of the sensor stage

void setup()
{
  //Turn on the USB and print a start message
  USB.begin();
  USB.println("start");
  delay(100);
  //Turn on the sensor board and wait for stabilization and sensor response time
  SensorGasv20.ON();
}
 
void loop()
{
  USB.print("Temperature: ");
  USB.print(getTemp());
  USB.println(" *C");
  
  USB.print("Pressure: ");
  USB.print(getPres());
  USB.println(" kPa");
  
  USB.print("Humidity: ");
  USB.print(getHumid());
  USB.println(" %RH");
  
  USB.print("CO2: ");
  USB.print(getCO2());
  USB.println("V");
  
  USB.print("O2: ");
  USB.print(getO2());
  USB.println("V");
  
  USB.print("CO: ");
  USB.print(getCO());
  USB.print("V");
  
  delay(5000);
}

int getTemp()
{
  int tempRound;
  SensorGasv20.setSensorMode(SENS_ON, SENS_TEMPERATURE);
  delay(10);
  tempRound = round(SensorGasv20.readValue(SENS_TEMPERATURE));
  SensorGasv20.setSensorMode(SENS_OFF, SENS_TEMPERATURE);
  return tempRound;
}

int getPres()
{
  int presRound;
  SensorGasv20.setSensorMode(SENS_ON, SENS_PRESSURE);
  delay(20); 
  presRound = round(SensorGasv20.readValue(SENS_PRESSURE));
  SensorGasv20.setSensorMode(SENS_OFF, SENS_PRESSURE);
  return presRound;
}

int getHumid()
{
  int humidRound;
  SensorGasv20.setSensorMode(SENS_ON, SENS_HUMIDITY);
  delay(2000); 
  humidRound = round(SensorGasv20.readValue(SENS_HUMIDITY));
  SensorGasv20.setSensorMode(SENS_OFF, SENS_HUMIDITY);
  return humidRound;
}

int getCO()
{
  int coRound;
  RTC.ON();
  SensorGasv20.configureSensor(SENS_SOCKET4CO, GAIN, RESISTOR);
  coRound = SensorGasv20.readValue(SENS_SOCKET4CO);
  delay(400);
  return coRound; 
}

int getCO2()
{
  int co2Round;
  RTC.ON();
  SensorGasv20.configureSensor(SENS_CO2, GAIN);
  SensorGasv20.setSensorMode(SENS_ON, SENS_CO2);
  delay(400);
  co2Round = round(SensorGasv20.readValue(SENS_CO2));
  SensorGasv20.setSensorMode(SENS_OFF, SENS_CO2);
  return co2Round; 
}

int getO2()
{
  int o2Round;
  RTC.ON();
  SensorGasv20.configureSensor(SENS_O2, GAIN2);
  SensorGasv20.setSensorMode(SENS_ON, SENS_O2);
  delay(10);
  o2Round = round(SensorGasv20.readValue(SENS_O2));
  SensorGasv20.setSensorMode(SENS_OFF, SENS_O2);
  return o2Round;
}
