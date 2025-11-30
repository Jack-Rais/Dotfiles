
use std::path::PathBuf;

const PATHS: [&str; 13] = [
    "alacritty",
    "fastfetch", 
    "fish",
    "fontconfig",
    "gtk-3.0",
    "gtk-4.0",
    "hellwal",
    "hypr",
    "kitty",
    "nvim",
    "starship",
    "waybar",
    "wofi",
];

fn get_path_bufs() -> Vec<PathBuf> {
    PATHS.iter().map(|&s| PathBuf::from(s)).collect()
}


pub fn execute_dotfiles_command(link: bool, source: PathBuf, destination: PathBuf) {

}
