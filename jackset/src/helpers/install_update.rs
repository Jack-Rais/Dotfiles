
use std::process::Command;
use std::io::ErrorKind;

use log::{info, debug};


pub fn install_pacman_deps(deps: Vec<String>) {

    info!("Installing pacman dependencies");
    Command::new("sudo")
        .args(["pacman", "-S"])
        .arg("--needed")
        .args(deps)
        .spawn().expect("Could not install pacman's dependencies")
        .wait().expect("Could not install pacman's dependencies");

}

fn install_paru() {

    info!("Installing paru");
    debug!("Cloning paru");
    Command::new("git")
        .current_dir("/tmp")
        .args(["clone", "https://aur.archlinux.org/paru.git"])
        .spawn().expect("Could not clone paru")
        .wait().expect("Could not clone paru");

    debug!("Making paru");
    Command::new("makepkg")
        .current_dir("/tmp/paru")
        .arg("-si")
        .spawn().expect("Could not make paru")
        .wait().expect("Could not make paru");

}

pub fn install_paru_deps(deps: Vec<String>) {

    info!("Checking paru existence");
    match Command::new("paru").output() {
        Err(e) if e.kind() == ErrorKind::NotFound => { install_paru(); }
        _ => {}
    };

    info!("Installing paru dependencies");
    Command::new("paru")
        .arg("-S")
        .arg("--needed")
        .args(deps)
        .spawn().expect("Could not install paru's dependencies")
        .wait().expect("Could not install paru's dependencies");

}
