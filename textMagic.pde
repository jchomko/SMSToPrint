import java.util.Date;
import java.util.List;
import java.util.TimerTask;

import com.textmagic.sms.TextMagicMessageService;
import com.textmagic.sms.dto.ReceivedMessage;
import com.textmagic.sms.exception.ServiceBackendException;
import com.textmagic.sms.exception.ServiceException;
import com.textmagic.sms.exception.ServiceTechnicalException;



class TextMagic{
List<ReceivedMessage> messages;
   Date latestSms;
   TextMagicMessageService service;
   Print print;
   int messageId;
   String baseReply;
   
  public TextMagic(){
      messageId = 0;
      System.out.print("starting ");
      service = new TextMagicMessageService ("chomko","j8pIYP8YkCQhn4J");
      latestSms = new Date();
      print = new Print();
      baseReply = "Thanks for your message, follow your story on https://twitter.com/search?q=";
          
  }
  

  
  public void run() {
 
     if(debug){
      messageId ++ ;
      String id = String.format("%04d", messageId);
      print.createImage(id, "Once I had a dog, but my mom said we had to give it away cause we were bad at taking care of it. The dog always was worried when we went swimming and would bark at us");
      
     }
          try {
                    //service.send("Hello, Jonathan!", dummyPhone);
             messages = service.receive();
             if(!messages.isEmpty()){
             processMessage();
             }
       
          } catch(ServiceException ex) {
              System.out.println(" :-( ");
         }
   
  }

  public void processMessage(){
    
    
      
      //may need to go around backwards
    for(int i = 0; i < messages.size(); i ++){
        
       //Get message 
        ReceivedMessage rm = messages.get(i);
         
         if(rm.getReceivedDate().after(latestSms)){
             
             //Save date received - lets hope they send them oldest first
             //otherwise we need a better system
             latestSms = rm.getReceivedDate();
             
             //Get an id
             messageId ++ ;
             //Format into string
             String id = "TSD" +String.format("%04d", messageId);
             
             //Make a print
             print.createImage(id, rm.getText());
             
             //Send a reply
             try {
                
                String reply = baseReply += id;
                service.send(reply , rm.getSenderPhone());
              
                 } catch (Exception e) {
                    e.printStackTrace();
                 }
             }
        }
    }
}
