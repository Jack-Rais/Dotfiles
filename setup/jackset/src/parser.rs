
use std::path::PathBuf;
use std::env::current_dir;

use clap::{Parser, ValueEnum};


/// A JackRais' specific setup tool
#[derive(Parser, Debug)]
#[command(
    version, about,
    group(
        clap::ArgGroup::new("commands")
            .required(true)
            .multiple(true)
            .args(&["config", "mode", "update", "pacman_dep", "aur_dep", "display", "setup"])
    )
)]
pub struct SetupArgs {

    /// What configuration file to use
    #[arg(short, long)]
    pub config: Option<PathBuf>,

    /// Wether to link/copy/do nothing the dots files
    #[arg(short, long, value_enum, default_value_t = ModeLoad::Nothing)]
    pub mode: ModeLoad,

    /// Dotfiles directory (defaults to current one)
    #[arg(short, long, default_value = current_dir().expect("Could not get current dir").into_os_string(), requires = "mode")]
    pub source: PathBuf,

    /// Wether to update the system
    #[arg(short, long)]
    pub update: bool,

    /// Wether to install pacman dependencies
    #[arg(short, long = "pacman")]
    pub pacman_dep: bool,

    /// Wether to install aur dependencies
    #[arg(short, long = "aur")]
    pub aur_dep: bool,

    /// Wether to setup display manager
    #[arg(short, long)]
    pub display: bool,

    /// Wether to setup the system
    #[arg(short = 'S', long)]
    pub setup: bool

}


#[derive(ValueEnum, Clone, Debug)]
pub enum ModeLoad {

    #[value(alias = "l")]
    Link,

    #[value(alias = "c")]
    Copy,

    #[value(alias = "n")]
    Nothing

}
