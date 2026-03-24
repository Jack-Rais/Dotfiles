
use std::path::PathBuf;
use std::env::current_dir;

use dirs::config_dir;
use clap::{Parser, ValueEnum, Subcommand};


/// A JackRais' specific setup tool
#[derive(Parser, Debug)]
pub struct Cli {

    /// What configuration file to use
    #[arg(short, long, global = true, value_name = "FILE")]
    pub config: Option<PathBuf>,

    #[command(subcommand)]
    pub command: Commands

}

#[derive(Subcommand, Debug)]
pub enum Commands {

    /// Link or copy configuration files
    Link {

        /// The source directory where the program searches for the directories
        #[arg(short, long, default_value = default_current_dir(), value_name = "DIR")]
        source: PathBuf,

        /// The destination path where the program copies or link the files
        #[arg(short, long, default_value = default_config_dir(), value_name = "DIR")]
        destination: PathBuf,

        /// Link or copy directories (comma separated list)
        #[arg(short, long, value_delimiter = ',')]
        target: Option<Vec<String>>,

        /// How to handle the files
        #[arg(short, long, value_enum, default_value_t = LinkMode::Link)]
        mode: LinkMode,

        /// Whether to reload hyprland config
        #[arg(short, long)]
        reload: bool

    },

    /// Setup dependencies
    Setup {

        /// Install pacman dependencies
        #[arg(short, long)]
        pacman: bool,

        /// Install aur dependencies
        #[arg(short, long)]
        aur: bool,

        /// Setup the display manager
        #[arg(short, long)]
        display: bool

    }

}

#[derive(ValueEnum, Clone, Debug, Default, PartialEq)]
pub enum LinkMode {

    #[default]
    #[value(alias = "l")]
    Link,

    #[value(alias = "c")]
    Copy

}

fn default_current_dir() -> String {
    current_dir().expect("Could not determine current directory").to_string_lossy().into()
}

fn default_config_dir() -> String {
    config_dir().expect("Could not determine configuration directory").to_string_lossy().into()
}
