
pub mod parser;
pub mod deserialize;
pub mod helpers {
    pub mod load_mode;
    pub mod install_update;
    pub mod display_manager;
}


use std::io::Write;

use clap::Parser;
use env_logger::{Builder, Env, Target, WriteStyle};
use chrono::Local;
use log::{debug, info};

use crate::deserialize::Config;
use crate::helpers::display_manager::setup_display_manager;
use crate::helpers::install_update::{install_pacman_deps, install_paru_deps};
use crate::parser::{Cli, Commands, LinkMode};
use crate::helpers::load_mode::{reload_config, setup_files};


fn main() {

    Builder::from_env(Env::default().default_filter_or("info"))
        .target(Target::Stdout)
        .write_style(WriteStyle::Always)
        .format(|buf, record| {

            writeln!(
                buf,
                "[{}][{}] - {}",
                Local::now().format("%d-%m-%Y %H:%M:%S"),
                record.level(),
                record.args()
            )

        })
        .init();


    debug!("Reading parameters");

    let args = Cli::parse();
    let config = Config::load(args.config);

    match args.command {

        Commands::Link { source, destination, target, mode, reload } => {

            setup_files(&source, &destination, target.unwrap_or(config.directories.unwrap()), mode == LinkMode::Link);
            if reload {
                reload_config();
            }

        },
        Commands::Setup { pacman, aur, display } => {

            if pacman {
                install_pacman_deps(config.pacman.unwrap());
            }

            if aur {
                install_paru_deps(config.aur.unwrap());
            }

            if display {
                setup_display_manager(config.display_manager_conf.unwrap());
            }

        }

    }

}
