import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class GpsReader {

  // 2015-07-18T18:54:01Z
  private static final SimpleDateFormat simpleDateFormat = 
      new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      //new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
  public static final String delimiter = ",";
  
  public static List<GpsEntry> getGpsEntries(String filePath){
    List<GpsEntry> entries = new ArrayList<GpsEntry>();
    int counter = 0;
    
    try {
      BufferedReader bufferedReader = new BufferedReader(new FileReader(filePath));
      bufferedReader.readLine(); // First line are the names
      
      String line = null;
      String[] splits = null;
      
      while((line = bufferedReader.readLine()) != null){
        splits = line.split(delimiter);
        
        // Format Date String
        splits[0] = splits[0].replace('T', ' ');
        splits[0] = splits[0].replace('Z', ' ');
        splits[0] = splits[0].trim();
        
        try{
          // time, lat, lon, elevation, accuracy, bearing, speed
          GpsEntry entry = new GpsEntry(
              simpleDateFormat.parse(splits[0]),
              Float.parseFloat(splits[1]), 
              Float.parseFloat(splits[2]),
              Float.parseFloat(splits[3]),
              Float.parseFloat(splits[4]),
              Float.parseFloat(splits[5]),
              Float.parseFloat(splits[6]));
          
          entries.add(entry);
          counter++;
        } catch(ParseException e){
          System.out.println(e.getMessage() + ", " + line);
        }
      }
      bufferedReader.close();
    } catch (IOException e) {
      System.err.println(e.getMessage());
    }
    return entries;
  }
}