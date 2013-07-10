
boolean debug = true;
boolean printout = false;
long time;
TextMagic tm;
void setup(){
  
  tm = new TextMagic();
  time = millis();
    tm.run();
}



void draw(){
  
  if(millis() - time > 5000){
    tm.run();
    time = millis();
  }

}
