
use std::process::Command;
use std::env::var;
use std::path::PathBuf;

use log::{info, debug};

pub fn execute_profile_command(image_dir: PathBuf, user: Option<String>) {

    info!("Setting up the profile picture for the current user");

    let username = user.unwrap_or(var("USER").expect("Could not extract current user, specify it"));

    debug!("Copying image into tmp file");
    Command::new("sudo")
        .arg("cp")
        .arg(image_dir)
        .arg("/usr/share/sddm/faces/tmp_face")
        .spawn().expect("Could not copy profile image in the right path")
        .wait().expect("Could not copy profile image in the right path");

    debug!("Cropping image");
    Command::new("sudo")
        .arg("mogrify")
        .args(["-gravity", "center"])
        .args(["-crop", "1:1"])
        .arg("+repage")
        .arg("/usr/share/sddm/faces/tmp_face")
        .spawn().expect("Could not run mogrify on image")
        .wait().expect("Could not run mogrify on image");

    debug!("Resizing image");
    Command::new("sudo")
        .arg("mogrify")
        .args(["-resize", "256x256"])
        .arg("/usr/share/sddm/faces/tmp_face")
        .spawn().expect("Could not run mogrify on image")
        .wait().expect("Could not run mogrify on image");

    debug!("Moving image in correct position");
    Command::new("sudo")
        .arg("mv")
        .args(["/usr/share/sddm/faces/tmp_face", &format!("/usr/share/sddm/faces/{username}.face.icon")])
        .spawn().expect("Could not move tmp_image into correct position")
        .wait().expect("Could not move tmp_image into correct position");

}
