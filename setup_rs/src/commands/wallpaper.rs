
use std::fs::copy;
use std::process::{Command, Stdio};
use std::path::PathBuf;
use std::env::var;

use log;


pub fn execute_wallpaper_command(image_dir: PathBuf) {


    let home_path = PathBuf::from(var("HOME").expect("Could not resolve HOME var"));
    let wallpaper_path = home_path.join(".config/hypr/wallpapers/");

    // Copying the image into the right place
    setup_wallpaper(&image_dir, &wallpaper_path.join("current.png"));

    run_matugen(&image_dir);
    blur_wallpaper(&wallpaper_path.join("current.png"), &wallpaper_path.join("current_blurred.png"));

    
    reload_hyprland();
    reload_waybar();
    reload_swaync();

}


fn setup_wallpaper(image_inp: &PathBuf, image_dest: &PathBuf) {
    
    match image_inp.extension().expect("Input image doesn't have an extension").to_str() {
        Some("png") => {
            log::info!("Copying the image in config");

            copy(
                image_inp, 
                image_dest
            ).expect("Could not copy image in wallpaper path");

        },
        _ => {
            log::info!("Converting the image in png and moving it");

            Command::new("magick")
                .arg(image_inp)
                .arg(image_dest)
                .stdout(Stdio::inherit())
                .output()
                .expect("There was an error with coverting the image in png (magick)");

        }
    }
    
}

fn run_matugen(image_dir: &PathBuf) {

    log::info!("Running matugen");

    Command::new("matugen")
        .arg("image")
        .arg(image_dir)
        .arg("--debug")
        .stdout(Stdio::inherit())
        .output()
        .expect("There was an error with matugen");

}

fn blur_wallpaper(image_path: &PathBuf, image_blurred: &PathBuf) {
    
    log::info!("Running imagemagick to blur the wallpaper");

    Command::new("magick")
        .arg(image_path)
        .args(["-blur", "0x8"])
        .arg(image_blurred)
        .stdout(Stdio::inherit())
        .output()
        .expect("There was an error with blurring (magick)");

}


fn reload_hyprland() {

    log::info!("Reloading hyprland");

    log::debug!("Reloading hyprctl");
    Command::new("hyprctl")
        .arg("reload")
        .stdout(Stdio::inherit())
        .output()
        .expect("There was an error with reloading hyprland");

    log::debug!("Killing hyprpaper");
    Command::new("killall")
        .arg("hyprpaper")
        .output()
        .expect("There was an error while killing hyprpaper");

    log::debug!("Starting hyprpaper");
    Command::new("hyprctl")
        .args(["dispatch", "exec", "hyprpaper"])
        .output()
        .expect("There was an error while starting hyprpaper");

}


fn reload_waybar() {

    log::info!("Reloading waybar");

    log::debug!("Killing waybar");
    Command::new("killall")
        .arg("waybar")
        .stdout(Stdio::inherit())
        .output()
        .expect("There was an error with killing waybar");
    
    log::debug!("Starting waybar");
    Command::new("hyprctl")
        .args(["dispatch", "exec", "waybar"])
        .stdout(Stdio::inherit())
        .output()
        .expect("There was an error while reloading waybar");

}


fn reload_swaync() {

    log::info!("Reloading swaync");

    log::debug!("Killing swaync");
    Command::new("killall")
        .arg("swaync")
        .stdout(Stdio::inherit())
        .output()
        .expect("There was an error while killing swaync");
    
    log::debug!("Starting swaync daemon");
    Command::new("hyprctl")
        .args(["dispatch", "exec", "swaync"])
        .stdout(Stdio::inherit())
        .output()
        .expect("There was an error while starting swaync");

    log::debug!("Reloading swaync configuration");
    Command::new("swaync-client")
        .arg("-R")
        .output()
        .expect("There was an error while reloading swaync configuration");

    Command::new("swaync-client")
        .arg("-rs")
        .output()
        .expect("There was an error while reloading swaync configuration");

}
