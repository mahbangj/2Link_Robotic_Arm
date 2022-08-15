#include <Servo.h>
Servo servo;

int motorpin1_1 = 2;
int motorpin2_1 = 3;

int motorpin1_2 = 4;
int motorpin2_2 = 5;

int motorpin1_3 = 6;
int motorpin2_3 = 7;

int pwmpin_1 = 9;
int pwmpin_2 = 10;
int pwmpin_3 = 11;

int pot_1 = A0; 
int pot_2 = A1;
int pot_3 = A2;

int val_1;
int val_2;
int val_3;

float Kp_1 = 0;
float Kp_2 = 0;
float Kp_3 = 0;

float Ki_1 = 0.002;
float Ki_2 = 0.004;
float Ki_3 = 1;

float setpoint_1 = 200;
float setpoint_2 = 200;
float setpoint_3 = 50;

float error_1 = 0;
float error_2 = 0;
float error_3 = 0;

float controllerOut_1;
float controllerOut_2;
float controllerOut_3;

float currentTime = 0;
float elapsedTime = 0;
float previousedTime = 0;

float cumError = 0;

// pin2 = LOW and pin3=HIGH----> positive direction

// motor3 --> abi:ghermez banafash:sefid out3:ghermez and out4:abi
//motor1 --> sefid:abi, toosi:zard
//motor2 --> sabz:banafsh and zard:abi

void setup() {
  // put your setup code here, to run once:
  pinMode(motorpin1_1, OUTPUT);
  pinMode(motorpin2_1, OUTPUT);
  pinMode(pwmpin_1, OUTPUT);
  
  pinMode(motorpin1_2, OUTPUT);
  pinMode(motorpin2_2, OUTPUT);
  pinMode(pwmpin_2, OUTPUT);
  

  servo.attach(11);

  Serial.begin(9600);

}
//optional
void reset()
{
  digitalWrite(motorpin1_1, LOW);
  digitalWrite(motorpin2_1, HIGH);
  analogWrite(pwmpin_1, 255);
  delay(1000);
  
}
//optional

void Controller(int motorpin1, int motorpin2, int pwmpin, float kp, float ki, float error ){
  currentTime = millis();
  elapsedTime = currentTime - previousedTime;
  cumError += error*elapsedTime;
  float controllerOut = error*kp + ki*cumError;
 //saturation
  if(controllerOut > 255)
    controllerOut = 200;
  else if(controllerOut < -255)
    controllerOut = -200;
//stop
  if(error < 10 && error > -10)
  {
    analogWrite(pwmpin, 0);
  }
//set pwm
  else{
  if(controllerOut > 0 ){
    digitalWrite(motorpin1, LOW);
    digitalWrite(motorpin2, HIGH);
    analogWrite(pwmpin, controllerOut);
  }
  else
  {
    digitalWrite(motorpin1, HIGH);
    digitalWrite(motorpin2, LOW);
    analogWrite(pwmpin, -1*controllerOut);
    }
  }

  previousedTime = currentTime;

}

void loop() {
 ///read feedbacks
  val_1 = analogRead(pot_1);  
  val_1 = map(val_1, 0, 1023, 0, 270);
  error_1 = setpoint_1 - val_1;
  

  val_2 = analogRead(pot_2);
  val_2 = map(val_2, 0, 1023, 0, 270);
  error_2 = setpoint_2 - val_2;
  


//  val_3 = analogRead(pot_3);
//  val_3 = map(val_3, 0, 1023, 0, 270);
//  error_3 = setpoint_3 - val_3;
  


  Serial.print(val_1);
  Serial.print(" ");
  Serial.println(val_3);
  
  
  //set kp for each motors controller
  if(error_1 > -30 && error_1 < 30)
    Kp_1 = 2;
  else if(error_1 > 200 || error_1 < -200)
    Kp_1 = 1.4;
  else
    Kp_1 = 1.6;

  if(error_2 > -50 && error_2 < 50)
    Kp_2 = 2.5;
  else if(error_2 > 200 || error_2 < -200)
    Kp_2 = 1.5;
  else
    Kp_2 = 1.8;


  

  Controller(motorpin1_1, motorpin2_1, pwmpin_1, Kp_1, Ki_1, error_1);
//  Controller(motorpin1_2, motorpin2_2, pwmpin_2, Kp_2, Ki_2, error_2);
//  Controller(motorpin1_3, motorpin2_3, pwmpin_3, Kp_3,Ki_3, error_3);
  val_3 = 180;
  servo.write(val_3);
  
  
  
  delay(100);



  

}
