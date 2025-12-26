
use std::process::Command;

use log::info;


pub fn update_sys() {

    info!("Running 'pacman -Syu' to update the system");
    Command::new("sudo")
        .args(["pacman", "-Syu"])
        .spawn().expect("Could not execute full update")
        .wait().expect("Could not execute full update");

}


pub fn install_pacman(deps: Vec<String>) {

    info!("Installing pacman dependencies");
    Command::new("sudo")
        .args(["pacman", "-S"])
        .args(deps)
        .spawn().expect("Could not execute install command")
        .wait().expect("Could not execute install command");

}

fn install_paru() ->
