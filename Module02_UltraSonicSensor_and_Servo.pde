// Module 02 Ultra Sonic Sensor & Servo Fast Speed _ Albert Cordero - 3292866

#include <Servo.h>
Servo myservo01;

int myservopin01 = 9;

int pos01 = 0;

unsigned long lastmoved;

const int pingPin = 7;

void setup() {
  Serial.begin(9600);
  myservo01.attach(myservopin01);
  lastmoved = millis();
}

void loop()
{
  long duration, inches, cm;

  pinMode(pingPin, OUTPUT);
  digitalWrite(pingPin, LOW);
  delayMicroseconds(2);
  digitalWrite(pingPin, HIGH);
  delayMicroseconds(5);
  digitalWrite(pingPin, LOW);

  pinMode(pingPin, INPUT);
  duration = pulseIn(pingPin, HIGH);

  inches = microsecondsToInches(duration);
  cm = microsecondsToCentimeters(duration);
  float servoangle = map(cm, 10, 400, 0, 180);
  unsigned long currenttime = millis();
  unsigned long offset = currenttime - lastmoved;
  Serial.println(offset);
  if(cm >= 300 && offset > 2000){
    myservo01.write(180);
  }
  if(cm <= 100 && offset > 2000){
    myservo01.write(0);
    lastmoved = currenttime;
  
  Serial.print(inches);
  Serial.print("in, ");
  Serial.print(cm);
  Serial.print("cm");
  Serial.println();
  
  delay(100);
}

long microsecondsToInches(long microseconds)
{
  return microseconds / 74 / 2;
}

long microsecondsToCentimeters(long microseconds)
{
  return microseconds / 29 / 2;
}

}
