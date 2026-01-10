
use std::path::PathBuf;
use std::process::Command;

use log::{debug, info};

pub fn execute_display_manager_command(image_dir: PathBuf) {

    info!("Setting wallpaper for display manager");
    debug!("Setting image in default.jpg");
    Command::new("sudo")
        .arg("magick")
        .arg(image_dir)
        .arg("/usr/share/sddm/themes/silent/backgrounds/default.jpg")
        .spawn().expect("Could not copy image in the right position")
        .wait().expect("Could not copy image in the right position");

    debug!("Setting image in smoky.jpg");
    Command::new("sudo")
        .arg("cp")
        .arg("/usr/share/sddm/themes/silent/backgrounds/default.jpg")
        .arg("/usr/share/sddm/themes/silent/backgrounds/smoky.jpg")
        .spawn().expect("Could not copy image in the right position")
        .wait().expect("Could not copy image in the right position");

}
