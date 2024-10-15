use std::thread;use std::time::Duration;
use rppal::gpio::Gpio;
use rppal::system::DeviceInfo;

const GPIO_2: u8 = 2;
const GPIO_3: u8 = 3;
const GPIO_4: u8 = 4;

const GPIO_BUTTON: u8 = 17;


//fn main() { 
    //// Handle potential error from DeviceInfo::new()
    //let device_info = DeviceInfo::new();
    //match device_info {
        //Ok(info) => {
            //println!("Running LED sequence on a {}.", info.model());
        //}
        //Err(e) => {
            //eprintln!("Failed to get device info: {}", e);
            //return;
        //}
    //}
    //let gpio = Gpio::new().unwrap();
    //// Initialize the pins
    //let mut pin2 = gpio.get(GPIO_2).unwrap().into_output();
    //let mut pin3 = gpio.get(GPIO_3).unwrap().into_output();
    //let mut pin4 = gpio.get(GPIO_4).unwrap().into_output();
    //loop {
        //pin2.set_high();
        //pin3.set_high();
        //pin4.set_high();
        //thread::sleep(Duration::from_millis(500));
        //pin2.set_low();
        //pin3.set_low();
        //pin4.set_low();
        //thread::sleep(Duration::from_millis(500));
    //}
//}

//fn main() {
    //let mut gpio = Gpio::new().expect("Faild to access GIO");
    //let mut led = gpio.get(GPIO_LED).expect("Failed to get GPIO 2").into_output();
    //// Initialize GPIO 17 as an input pin with pull-down resistor for the push button
    //let button = gpio.get(GPIO_BUTTON).expect("Filed to get GPIO 17").into_input_pulldown();
    
    //// Varialble to track LED state
    //let mut led_on = false;
    
    //loop {
        //// Check if the button is pressed
        //if button.is_high() {
            //led_on = !led_on;
            //if led_on {
                //led.set_high(); // Turn on the LED
            //} else {
                //led.set_low(); // Turn off the LED
            //}
            //// Debounce: Wait until the button is released
            //while button.is_high() {
                //thread::sleep(Duration::from_millis(10));
            //}
        //}
        //// Small delay to prevent excessive CPU usage
        //thread::sleep(Duration::from_millis(10));
    //}
//}

fn main() {
    let mut gpio = Gpio::new().expect("Faild to access GIO");
    let mut count = 0;
    let mut led1 = gpio.get(GPIO_2).unwrap().into_output();
    let mut led2 = gpio.get(GPIO_3).unwrap().into_output();
    let mut led3 = gpio.get(GPIO_4).unwrap().into_output();
    let button = gpio.get(GPIO_BUTTON).expect("Filed to get GPIO 17").into_input_pulldown();
    
    // Initial state
    led1.set_low();
    led2.set_low();
    led3.set_low();
    
    loop {
        if button.is_high() {
            count = (count + 1) % 4;
            match count {
                1 => {
                    led1.set_high();
                    led2.set_low();
                }
                2 => {
                    led1.set_low();
                    led2.set_high();
                }
                3 => {
                    led2.set_low();
                    led3.set_high();
                }
                0 => {
                    led3.set_low();
                    led2.set_high();
                }
                _ => ()
            }
        thread::sleep(Duration::from_millis(250));
        }
    }
}
            
