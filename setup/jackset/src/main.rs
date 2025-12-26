
pub mod updating_installing;
pub mod parser;
pub mod deserialize;
pub mod helpers {
    pub mod load_mode;
    pub mod install_update;
}

use parser::{
    SetupArgs,
    ModeLoad
};
use deserialize::read_config;
use helpers::{
    load_mode::setup_files,
    install_update::{
        update_sys,
        install_pacman
    }
};

use std::{io::Write, path::PathBuf};

use clap::Parser;
use chrono::Local;
use env_logger::{Builder, Env, Target, WriteStyle};
use log::info;


fn main() {

    Builder::from_env(Env::default().default_filter_or("debug"))
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

    info!("Reading args");
    let args = SetupArgs::parse();

    info!("Reading configuration");
    let config_file = args.config.unwrap_or(PathBuf::from("config.toml"));
    let configuration = read_config(config_file);


    match args.mode {
        ModeLoad::Link => setup_files("ln", "-sfn", configuration.dotfiles.dirs),
        ModeLoad::Copy => setup_files("cp", "", configuration.dotfiles.dirs),
        ModeLoad::Nothing => Ok(())
    }.expect("Could not copy or link files");

    if args.update {
        update_sys();
    }

    if args.pacman_dep {
        install_pacman(configuration.pacman.packages);
    }

}
