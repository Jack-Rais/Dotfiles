
use std::path::PathBuf;
use std::env::current_dir;
use serde::Deserialize;
use toml;


#[derive(Deserialize)]
pub struct Config {
    pub pacman: Option<PackageList>,
    pub paru: Option<PackageList>,
    pub dotfiles: Option<Dotfiles>,
    pub display_manager: Option<DisplayManager>
}
impl Config {
    pub fn empty() -> Self {
        Self {
            pacman: None,
            paru: None,
            dotfiles: None,
            display_manager: None
        }
    }
}

#[derive(Deserialize)]
pub struct PackageList {
    pub packages: Vec<String>
}

#[derive(Deserialize)]
pub struct Dotfiles {
    pub dirs: Vec<String>
}

#[derive(Deserialize)]
pub struct DisplayManager {
    pub conf: String
}


pub fn deserialize_toml(toml_obj: String) -> Config {
    toml::from_str(&toml_obj).expect("Could not parse toml file")
}

pub fn read_config(config_file: PathBuf) -> Config {

    let conf_path = current_dir().unwrap().join(config_file);
    let content_config = std::fs::read_to_string(conf_path).expect("Unable to read config file");
    let conf: Config = toml::from_str(&content_config).expect("Could not parse toml file");

    conf

}
