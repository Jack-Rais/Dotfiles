
use std::fs::{copy, create_dir};
use std::process::Command;
use std::path::PathBuf;
use std::env::var;

use log::{info, debug};


#[derive(Debug)]
enum CacheState {
    Error,
    Created(PathBuf),
    Found(PathBuf)
}



pub fn execute_wallpaper_command(image_path: PathBuf, reload: bool) {

    info!("Setting up the wallpaper");

    let home_path = PathBuf::from(var("HOME").expect("Could not resolve HOME var"));
    let wall_path = home_path.join(".config/quickshell/assets/wallpaper.png");
    let blur_path = home_path.join(".config/hypr/wallpapers/current_blurred.png");

    // Copying the image into the right place
    copy_converted(&image_path, &wall_path);

    run_matugen(&wall_path);
    blur_wallpaper(
        &wall_path,
        &blur_path,
        &image_path
    );


    if reload {
        reload_hyprland();
        // reload_quickshell();
    }

}


fn copy_converted(image_path: &PathBuf, image_dest: &PathBuf) {

    match image_path.extension().expect("Input image doesn't have an extension").to_str() {
        Some("png") => {
            info!("Copying the image in config");

            copy(
                image_path,
                image_dest
            ).expect("Could not copy image in wallpaper path");

        },
        _ => {
            info!("Converting the image in png and moving it");

            Command::new("magick")
                .arg(image_path)
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

    info!("Matugen executed correctfully");

}

fn blur_wallpaper(converted_image: &PathBuf, path_blurred: &PathBuf, original_img: &PathBuf) {

    fn run_blur(image_path: &PathBuf, image_blurred: &PathBuf) {

        info!("Running imagemagick to blur the wallpaper");
        Command::new("magick")
            .arg(image_path)
            .args(["-blur", "0x8"])
            .arg(image_blurred)
            .spawn().expect("There was an error with blurring (magick)")
            .wait().expect("There was an error with blurring (magick)");

    }

    info!("Checking for a cache dir");
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

            let cache_file = dir.join(original_img.file_name().expect("Could not get basename of file"));
            if cache_file.exists() {

                info!("Using image found in cache");
                Command::new("cp")
                    .arg(cache_file)
                    .arg(path_blurred)
                    .spawn().expect("Could not copy image in cache to correct location")
                    .wait().expect("Could not copy image in cache to correct location");

            }
            else {
                info!("Blurring wallpaper");
                run_blur(converted_image, path_blurred);

                info!("Creating image on cache");
                Command::new("cp")
                    .arg(path_blurred)
                    .arg(cache_file)
                    .spawn().expect("Could not copy image in cache to correct location")
                    .wait().expect("Could not copy image in cache to correct location");
            }

        },

        CacheState::Created(dir) => {
            info!("Blurring wallpaper");
            run_blur(converted_image, path_blurred);

            info!("Creating image on cache");
            let cache_file = dir.join(original_img.file_name().expect("Could not get basename of file"));
            Command::new("cp")
                .arg(path_blurred)
                .arg(cache_file)
                .spawn().expect("Could not copy image in cache to correct location")
                .wait().expect("Could not copy image in cache to correct location");

        },

        CacheState::Error => {
            info!("Blurring wallpaper");
            run_blur(original_img, path_blurred);
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
