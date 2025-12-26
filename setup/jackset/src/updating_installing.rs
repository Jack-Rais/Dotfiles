
use std::process::{Command, Stdio};
use std::ffi::OsString;
use std::fs::File;
use std::io::{ErrorKind, Read, Stderr};

use log::info;

pub fn update_system() {

    info!("Running 'pacman -Syu' to update the system");
    Command::new("sudo")
        .args(["pacman", "-Syu"])
        .spawn().expect("Could not execute full update")
        .wait().expect("Could not execute full update");

}

pub fn read_dependencies(path: &str) -> std::io::Result<Vec<OsString>> {

    let mut buffer = String::new();
    let mut file_inp = File::open(path).expect("Could not open dependencies file");

    file_inp.read_to_string(&mut buffer).expect("Could not read dependencies file");

    Ok(buffer.split_whitespace().map(OsString::from).collect())

}

pub fn install_dependencies_pacman() -> std::io::Result<()> {


    info!("Installing packages");
    Command::new("sudo")
        .args(["pacman", "-S"])
        .arg("--needed")
        .args(read_dependencies("dependencies")?)
        .spawn()?
        .wait()?;

    Ok(())

}

fn install_paru() -> std::io::Result<()> {

    info!("Installing paru");
    info!("Cloning paru");
    Command::new("git")
        .current_dir("/tmp")
        .args(["clone", "https://aur.archlinux.org/paru.git"])
        .status()?;

    info!("Making paru");
    Command::new("makepkg")
        .current_dir("/tmp/paru")
        .arg("-si")
        .output()?;

    Ok(())
}

pub fn install_dependencies_paru() -> std::io::Result<()> {

    info!("Checking paru existence");
    match Command::new("paru").output() {
        Err(e) if e.kind() == ErrorKind::NotFound => { install_paru()? }
        _ => {}
    };

    info!("Installing packages");
    Command::new("paru")
        .arg("-S")
        .arg("--needed")
        .args(read_dependencies("dependencies_aur")?)
        .spawn()?
        .wait()?;

    Ok(())

}
