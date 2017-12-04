import java.util.Date;

public class GpsEntry {
  
  // time, lat, lon, elevation, accuracy, bearing, speed
  private Date time;
  private float latitude;
  private float longitude;
  private float elevation;
  private float accuracy;
  private float bearing;
  private float speed;
  
  public GpsEntry(Date time, float latitude, float longitude, float elevation, 
      float accuracy, float bearing, float speed){
    this.time = time;
    this.latitude = latitude;
    this.longitude = longitude;
    this.elevation = elevation;
    this.accuracy = accuracy;
    this.bearing = bearing;
    this.speed = speed;
  }

  public Date getTime() { return time; }
  public void setTime(Date time) { this.time = time; }
  public float getLatitude() { return latitude; }
  public void setLatitude(float latitude) { this.latitude = latitude; }
  public float getLongitude() { return longitude; }
  public void setLongitude(float longitude) { this.longitude = longitude; }
  public float getElevation() { return elevation; }
  public void setElevation(float elevation) { this.elevation = elevation; }
  public float getAccuracy() { return accuracy; }
  public void setAccuracy(float accuracy) { this.accuracy = accuracy; }
  public float getBearing() { return bearing; }
  public void setBearing(float bearing) { this.bearing = bearing; }
  public float getSpeed() { return speed; }
  public void setSpeed(float speed) { this.speed = speed; }

  @Override
  public String toString() {
    return "GpsEntry [time=" + time + ", latitude=" + latitude
        + ", longitude=" + longitude + ", elevation=" + elevation
        + ", accuracy=" + accuracy + ", bearing=" + bearing
        + ", speed=" + speed + "]";
  }
}