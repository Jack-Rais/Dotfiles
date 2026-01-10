
use std::process::Command;

use log::{info, debug};

pub fn setup_display_manager(sddm_conf: String) {

    info!("Setting up display manager");
    debug!("Trying to write to /etc/sddm.conf");

    Command::new("sudo")
        .arg("sh")
        .arg("-c")
        .arg(format!("printf '%s' \"{}\" > /etc/sddm.conf", sddm_conf))
        .spawn().expect("Could not create or write to sddm.conf")
        .wait().expect("Could not create or write to sddm.conf");

}
