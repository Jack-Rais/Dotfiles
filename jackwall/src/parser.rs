
use clap::Parser;
use std::path::PathBuf;

/// A JackRais' dotfiles specific wallpaper setup
#[derive(Parser, Debug)]
#[command(
    version, about,
    group(
        clap::ArgGroup::new("targets")
            .required(true)
            .multiple(true)
            .args(&["wallpaper", "profile", "display_manager"])
    )
)]
pub struct WallArguments {

    /// Image to be used
    #[arg(short, long)]
    pub wallpaper: Option<PathBuf>,

    /// Wether to reload all the widgets
    #[arg(short, long, default_value_t = false, action = clap::ArgAction::SetTrue, requires = "wallpaper")]
    pub reload: bool,

    /// Image to set to the profile picture
    #[arg(short, long)]
    pub profile: Option<PathBuf>,

    /// User to set the profile picture to
    #[arg(short, long, requires = "profile")]
    pub user: Option<String>,

    /// Image to set to the Display Manager
    #[arg(short, long)]
    pub display_manager: Option<PathBuf>,

}
