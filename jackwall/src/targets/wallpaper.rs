
use std::fs::{copy, create_dir};
use std::process::Command;
use std::path::{PathBuf, Path};
use std::env::var;

use log::{info, debug};


enum CacheState {
    Error,
    Created(PathBuf),
    Found(PathBuf)
}



pub fn execute_wallpaper_command(image_dir: PathBuf, reload: bool) {

    info!("Setting up the wallpaper");

    let home_path = PathBuf::from(var("HOME").expect("Could not resolve HOME var"));
    let hypridle_path = home_path.join(".config/hypr/wallpapers/");
    let quickshell_path = home_path.join(".config/quickshell/assets/background.png");

    // Copying the image into the right place
    setup_wallpaper(&image_dir, &quickshell_path);

    run_matugen(&image_dir);
    blur_wallpaper(
        &quickshell_path,
        &hypridle_path,
        &image_dir
    );


    if reload {
        reload_hyprland();
        reload_quickshell();
        // reload_waybar();
        // reload_swaync();
    }

}


fn setup_wallpaper(image_inp: &PathBuf, image_dest: &PathBuf) {

    match image_inp.extension().expect("Input image doesn't have an extension").to_str() {
        Some("png") => {
            info!("Copying the image in config");

            copy(
                image_inp,
                image_dest
            ).expect("Could not copy image in wallpaper path");

        },
        _ => {
            info!("Converting the image in png and moving it");

            Command::new("magick")
                .arg(image_inp)
                .arg(image_dest)
                .spawn().expect("There was an error with coverting the image in png (magick)")
                .wait().expect("There was an error with coverting the image in png (magick)");

        }
    }

}

fn run_matugen(image_dir: &PathBuf) {

    info!("Running matugen");

    Command::new("matugen")
        .arg("image")
        .arg(image_dir)
        .arg("--verbose")
        .spawn().expect("There was an error with matugen")
        .wait().expect("There was an error with matugen");

}

fn blur_wallpaper(image_path: &PathBuf, image_blurred: &PathBuf, original_image: &Path) {


    fn run_blur(image_path: &PathBuf, image_blurred: &PathBuf) {

        info!("Running imagemagick to blur the wallpaper");
        Command::new("magick")
            .arg(image_path)
            .args(["-blur", "0x8"])
            .arg(image_blurred)
            .spawn().expect("There was an error with blurring (magick)")
            .wait().expect("There was an error with blurring (magick)");

    }

    info!("Checking the cache for an already blurred wallpaper");
    let cache_dir = match var("HOME") {
        Ok(home) => {
            let home_path = PathBuf::from(home).join(".cache").join("jackwall");
            if home_path.exists() {
                CacheState::Found(home_path)
            }
            else {
                match create_dir(&home_path) {
                    Ok(_) => CacheState::Created(home_path),
                    _ => CacheState::Error
                }
            }
        }
        _ => CacheState::Error
    };


    match cache_dir {

        CacheState::Found(dir) => {

            let cache_file = dir.join(original_image.file_name().expect("Could not get basename of file"));
            if cache_file.exists() {

                info!("Using image found in cache");
                Command::new("cp")
                    .arg(cache_file)
                    .arg(image_blurred)
                    .spawn().expect("Could not copy image in cache to correct location")
                    .wait().expect("Could not copy image in cache to correct location");

            }
            else {
                info!("Blurring wallpaper");
                run_blur(image_path, image_blurred);

                info!("Creating image on cache");
                Command::new("cp")
                    .arg(image_blurred)
                    .arg(cache_file)
                    .spawn().expect("Could not copy image in cache to correct location")
                    .wait().expect("Could not copy image in cache to correct location");
            }

        },

        CacheState::Created(dir) => {
            info!("Blurring wallpaper");
            run_blur(image_path, image_blurred);

            info!("Creating image on cache");
            let cache_file = dir.join(original_image.file_name().expect("Could not get basename of file"));
            Command::new("cp")
                .arg(image_blurred)
                .arg(cache_file)
                .spawn().expect("Could not copy image in cache to correct location")
                .wait().expect("Could not copy image in cache to correct location");

        },

        CacheState::Error => {
            info!("Blurring wallpaper");
            run_blur(image_path, image_blurred);
        }

    }

}


fn reload_quickshell() {

    info!("Reloading quickshell");

    debug!("Killing quickshell");
    Command::new("killall")
        .arg("quickshell")
        .spawn().expect("There was an error while killing quickshell")
        .wait().expect("There was an error while killing quickshell");

    debug!("Starting quickshell");
    Command::new("hyprctl")
        .args(["dispatch", "exec", "quickshell"])
        .spawn().expect("There was an error while starting quickshell")
        .wait().expect("There was an error while starting quickshell");
}



fn reload_hyprland() {

    info!("Reloading hyprland");

    debug!("Reloading hyprctl");
    Command::new("hyprctl")
        .arg("reload")
        .spawn().expect("There was an error with reloading hyprland")
        .wait().expect("There was an error with reloading hyprland");

    // debug!("Killing hyprpaper");
    // Command::new("killall")
    //     .arg("hyprpaper")
    //     .spawn().expect("There was an error while killing hyprpaper")
    //     .wait().expect("There was an error while killing hyprpaper");
    //
    // debug!("Starting hyprpaper");
    // Command::new("hyprctl")
    //     .args(["dispatch", "exec", "hyprpaper"])
    //     .spawn().expect("There was an error while starting hyprpaper")
    //     .wait().expect("There was an error while starting hyprpaper");

}


// fn reload_waybar() {
//
//     info!("Reloading waybar");
//
//     debug!("Killing waybar");
//     Command::new("killall")
//         .arg("waybar")
//         .spawn().expect("There was an error with killing waybar")
//         .wait().expect("There was an error with killing waybar");
//
//     debug!("Starting waybar");
//     Command::new("hyprctl")
//         .args(["dispatch", "exec", "waybar"])
//         .spawn().expect("There was an error while reloading waybar")
//         .wait().expect("There was an error while reloading waybar");
//
// }


// fn reload_swaync() {
//
//     info!("Reloading swaync");
//
//     debug!("Killing swaync");
//     Command::new("killall")
//         .arg("swaync")
//         .spawn().expect("There was an error while killing swaync")
//         .wait().expect("There was an error while killing swaync");
//
//     debug!("Starting swaync daemon");
//     Command::new("hyprctl")
//         .args(["dispatch", "exec", "swaync"])
//         .spawn().expect("There was an error while starting swaync")
//         .wait().expect("There was an error while starting swaync");
//
//     debug!("Reloading swaync configuration");
//     Command::new("swaync-client")
//         .arg("-R")
//         .spawn().expect("There was an error while reloading swaync configuration")
//         .wait().expect("There was an error while reloading swaync configuration");
//
//     Command::new("swaync-client")
//         .arg("-rs")
//         .spawn().expect("There was an error while reloading swaync configuration")
//         .wait().expect("There was an error while reloading swaync configuration");
//
// }
