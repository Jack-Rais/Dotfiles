
use std::path::PathBuf;

use serde::Deserialize;


#[derive(Debug, Default, Deserialize)]
pub struct Config {

    #[serde(default)]
    pub pacman: Option<Vec<String>>,

    #[serde(default)]
    pub aur: Option<Vec<String>>,

    #[serde(default)]
    pub directories: Option<Vec<String>>,

    #[serde(default)]
    pub display_manager_conf: Option<String>

}

impl Config {

    pub fn empty() -> Self {
        Self {
            pacman: None,
            aur: None,
            directories: None,
            display_manager_conf: None
        }
    }

    pub fn load(config_path: Option<PathBuf>) -> Self {

        let default_config = include_str!("../config.toml");
        let mut config: Self = toml::from_str(default_config).expect("Failed to parse internal config");

        if let Some(user_path) = config_path {
            if user_path.exists() {

                let user_config_string = std::fs::read_to_string(user_path).expect("Could not read user config path");
                let user_config: Self = toml::from_str(&user_config_string).expect("Could not parse user config");

                if user_config.pacman.is_none() { config.pacman = user_config.pacman; }
                if user_config.aur.is_none() { config.aur = user_config.aur; }
                if user_config.directories.is_none() { config.directories = user_config.directories; }
                if user_config.display_manager_conf.is_some() { config.display_manager_conf = user_config.display_manager_conf; }

            }
        }

        config
    }

}
