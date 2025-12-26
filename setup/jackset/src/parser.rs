
use std::path::PathBuf;

use clap::{Parser, ValueEnum};

/// A JackRais' specific setup tool
#[derive(Parser, Debug)]
pub struct SetupArgs {

    /// What configuration file to use
    #[arg(short, long)]
    pub config: Option<PathBuf>,

    /// Wether to link/copy/do nothing the dots files
    #[arg(short, long, value_enum, default_value_t = ModeLoad::Nothing)]
    pub mode: ModeLoad,

    /// Wether to update the system
    #[arg(short, long)]
    pub update: bool,

    /// Wether to install pacman dependencies
    #[arg(short, long)]
    pub pacman_dep: bool,

    /// Wether to install aur dependencies
    #[arg(short, long, action = clap::ArgAction::SetFalse, default_value_t = true)]
    pub aur_dep: bool,

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
