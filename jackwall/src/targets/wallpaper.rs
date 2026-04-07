
use std::fs::{copy, create_dir_all};
use std::process::Command;
use std::path::Path;

use log::{info, debug};
use dirs::{cache_dir, config_dir};


pub fn execute_wallpaper_command(image_path: &Path, reload: bool) {

    info!("Setting up the wallpaper");

    let home_path = config_dir().expect("Could not resolve config directory");
    let wall_path = home_path.join("quickshell/assets/wallpaper.png");
    let blur_path = home_path.join("hypr/wallpapers/current_blurred.png");

    preprocess_image(image_path, &wall_path);

    run_matugen(&wall_path);
    blur_wallpaper(
        &wall_path,
        &blur_path,
        &image_path
    );


    if reload {
        reload_hyprland();
    }

}


fn run_command(cmd: &str, build: impl FnOnce(&mut Command)) {

    let mut command = Command::new(cmd);
    build(&mut command);

    let status = command.status().unwrap_or_else(|_| panic!("Failed to run {}", cmd));

    if !status.success() {
        panic!("Failed to run {}", cmd);
    }

}


fn preprocess_image(image_path: &Path, wall_path: &Path) {

    match image_path.extension().and_then(|e| e.to_str()) {
        Some("png") => {

            info!("Copying the image in config");
            copy(image_path, &wall_path).expect("Could not copy image in wallpaper path");

        },
        _ => {

            info!("Converting the image in png and moving it");
            run_command("magick", |cmd| {
                cmd.args([image_path, &wall_path]);
            });

        }
    }



}


fn run_matugen(image_dir: &Path) {

    info!("Running matugen");

    run_command("matugen", |cmd| {
        cmd
            .arg("image")
            .arg(image_dir)
            .arg("--verbose");
    });

    info!("Matugen executed succesfully");

}

fn blur_wallpaper(converted_image: &Path, path_blurred: &Path, original_img: &Path) {

    fn run_blur(img_in: &Path, img_out: &Path) {

        info!("Running imagemagick to blur the wallpaper");
        run_command("magick", |cmd| {
            cmd
                .arg(img_in)
                .args(["-blur", "0x8"])
                .arg(img_out);
        });

    }

    info!("Checking for a cache dir");
    match cache_dir() {
        Some(cache_dir) => {

            let cache_jackwall = cache_dir.join("jackwall");
            let cache_file = cache_jackwall.join(original_img.file_name().unwrap());

            if cache_file.exists() {

                debug!("Cache file exists, using that");
                copy(cache_file, path_blurred).expect("Could not copy cached image in config");
                return;

            }

            debug!("Cache file not found, blurring image");
            run_blur(converted_image, path_blurred);

            debug!("Creating memory in cache");
            create_dir_all(cache_dir.join("jackwall")).expect("Could not create cache directory");
            copy(path_blurred, cache_file).expect("Could not copy blurred file in cache");

        },
        None => {

            debug!("Cache file not found, blurring image");
            run_blur(converted_image, path_blurred);

        }
    }

}

fn reload_hyprland() {

    info!("Reloading hyprland");

    debug!("Reloading hyprctl");
    run_command("hyprctl", |cmd| { cmd.arg("reload"); });

}
