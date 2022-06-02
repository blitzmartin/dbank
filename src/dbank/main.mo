import Debug "mo:base/Debug";
import Float "mo:base/Float";
import Time "mo:base/Time";

actor DBank {

  stable var currentValue: Float = 300;
  //currentValue := 300;

  stable var startTime = Time.now();
  //startTime := Time.now();

  public func topUp(amount: Float) {
    currentValue += amount;
    //Debug.print(debug_show(currentValue));
  };

  public func withdrawl(amount: Float) {
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
    } else {
      Debug.print("Not enough funds!");
    }
  };
 
  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime - startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.01  ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };
}

