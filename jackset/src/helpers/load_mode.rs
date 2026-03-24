
use std::fs;
use std::os::unix::fs::symlink;
use std::path::{Path, PathBuf};
use std::env::var;
use std::process::Command;

use log::{debug, info};


struct Finder {
    stack: Vec<PathBuf>
}
impl Finder {

    fn new(dir: &Path) -> Self {

        Self {
            stack: fs::read_dir(dir).expect("Could not read dir").filter_map(|x| {
                if let Ok(y) = x {
                    Some(y.path())
                }
                else {
                    None
                }
            }).collect()
        }

    }
}
impl Iterator for Finder {

    type Item = PathBuf;
    fn next(&mut self) -> Option<Self::Item> {

        while let Some(item) = self.stack.pop() {

            if item.is_dir() {
                if let Ok(rd) = fs::read_dir(item) {
                    let children: Vec<_> = rd.filter_map(|x| {
                        if let Ok(y) = x {
                            return Some(y.path());
                        }
                        None
                    }).collect();
                    self.stack.extend_from_slice(&children);
                }
            }
            else {
                return Some(item.to_path_buf())
            }

        }
        None

    }

}


fn setup_single_directory(source: &Path, destination: &Path, link: bool) {

    if destination.exists() {
        info!("Cleaning {destination:?}");
        fs::remove_dir_all(destination).expect("Could not clean dir");
    }

    info!("Copying {source:?} into {destination:?}");

    let finder = Finder::new(source);
    for origin_file in finder {

        let dest_file = destination.join(origin_file.strip_prefix(source).unwrap());
        fs::create_dir_all(dest_file.parent().unwrap()).unwrap();

        debug!("{origin_file:?} -> {dest_file:?}");

        if link {
            symlink(origin_file, dest_file).unwrap();
        }
        else {
            fs::copy(origin_file, dest_file).unwrap();
        }
    }

}

pub fn setup_files(source: &Path, destination: &Path, targets: Vec<String>, link: bool) {

    for name_dir in targets {
        setup_single_directory(&source.join(&name_dir), &destination.join(&name_dir), link);
    }

}


pub fn reload_config() {

    if var("HYPRLAND_INSTANCE_SIGNATURE").is_ok() {

        info!("Reloading configuration");
        Command::new("hyprctl")
        .arg("reload")
        .spawn().expect("Could not reload hyprland")
        .wait().expect("Could not reload hyprland");

    }

}
