
use std::process::Command;
use log::{info, debug};


pub fn start_services(services: Vec<String>) {

    info!("Enabling configured services");

    for service in services {

        debug!("Enabling '{service}' service");
        Command::new("sudo")
            .args(["systemctl", "enable"])
            .arg(service)
            .status().expect("Could not start service");

    }

}
