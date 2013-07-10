import java.io.InputStream;
import java.io.InputStreamReader;


class Print {
    
   PVector printLocs[] = {new PVector(86,106), 
                          new PVector(26,505),  
                          new PVector(11,125)};
  
   
   PGraphics pg;
   PImage base;
 
   PFont f, f0;
  
   
   String path;
   int imgWidth;
   int imgHeight;
   
   Print(){
  
    path  = sketchPath;
   // System.out.println("path should be here");
    //System.out.println(path);
    f = createFont("Arial", 16, true);
    f0 = createFont("Arial", 10, true);
    
    base = loadImage(path + "/data/print_base.jpg");
    pg = createGraphics(base.width, base.height);
    //load base image
    
   }  
   
   public void createImage(String id, String text){
     
     pg.beginDraw();
     pg.image(base,0,0);
     pg.textFont(f,16);
    
     pg.fill(255);
     pg.text("TSD"+id, printLocs[0].x, printLocs[0].y);
     
     pg.fill(0);
     pg.textFont(f0);
     
    
     String s = "LET THE AUTHOR SEE YOUR REPLY: TWEET @TSD_FABRICA USING THIS UNIQUE HASHTAG: "+ "TSD"+ id;
     pg.text(s, printLocs[1].x, printLocs[1].y, base.width -30, 300);
     
     pg.text(text, printLocs[2].x, printLocs[2].y, base.width -30, 800);
     
     
     pg.save( sketchPath + "/data/" + id + ".png");
     pg.endDraw();
    
    
  
   if(printout){
     try {
        Runtime rt = Runtime.getRuntime();
        Process proc = rt.exec(new String[] { "lpr", path + "/data/" + id +".png" } );
      
        InputStream stderr = proc.getErrorStream();
        InputStreamReader isr = new InputStreamReader(stderr);
        
        BufferedReader br = new BufferedReader(isr);
        
        String line = null;
        
        while ( (line = br.readLine ()) != null) {
            System.out.println(line);
        }
      } 
      catch (Throwable t)
      {
        t.printStackTrace();
      }
   }
   }
}

