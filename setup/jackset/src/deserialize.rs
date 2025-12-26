
use std::path::PathBuf;
use std::env::current_dir;
use serde::Deserialize;
use toml;


#[derive(Deserialize)]
pub struct Config {
    pub pacman: PackageList,
    pub paru: PackageList,
    pub dotfiles: Dotfiles
}

#[derive(Deserialize)]
pub struct PackageList {
    pub packages: Vec<String>
}

#[derive(Deserialize)]
pub struct Dotfiles {
    pub dirs: Vec<PathBuf>
}


pub fn read_config(config_file: PathBuf) -> Config {

    let conf_path = current_dir().unwrap().join(config_file);
    let content_config = std::fs::read_to_string(conf_path).expect("Unable to read config file");
    let conf: Config = toml::from_str(&content_config).expect("Could not parse toml file");

    conf

}
