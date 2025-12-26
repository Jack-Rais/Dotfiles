
use clap::{Parser, ValueEnum};
use std::path::PathBuf;

/// A JackRais' dotfiles specific wallpaper setup
#[derive(Parser, Debug)]
#[command(version, about)]
pub struct WallArguments {

    /// Image to be used
    #[arg(short, long)]
    pub image: PathBuf,

    /// Wether to set the image as the wallpaper
    #[arg(short, long, value_enum, default_value_t = TargetImage::Wallpaper)]
    pub target: TargetImage

}

#[derive(ValueEnum, Clone, Debug)]
pub enum TargetImage {

    #[value(alias = "w")]
    Wallpaper,

    #[value(alias = "p")]
    Profile,

    #[value(alias = "dm")]
    DisplayManager

}
