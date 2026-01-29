
pub mod parser;
pub mod deserialize;
pub mod helpers {
    pub mod load_mode;
    pub mod install_update;
    pub mod display_manager;
    pub mod setup;
}

use parser::{
    SetupArgs,
    ModeLoad
};
use deserialize::{
    deserialize_toml,
    read_config
};
use helpers::{
    load_mode::setup_files,
    install_update::{
        update_sys,
        install_pacman_deps,
        install_paru_deps
    },
    display_manager::setup_display_manager,
    setup::setup_system
};

use std::io::Write;

use clap::Parser;
use chrono::Local;
use env_logger::{Builder, Env, Target, WriteStyle};
use log::info;

use crate::deserialize::Config;

const TOML_DEFAULT: &str = include_str!("../config.toml");

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
    let default_conf = deserialize_toml(TOML_DEFAULT.to_string());
    let configuration = if args.config.is_none() { Config::empty() } else { read_config(args.config.unwrap()) };


    let dirs = configuration.dotfiles.unwrap_or(default_conf.dotfiles.unwrap()).dirs;
    match args.mode {
        ModeLoad::Link => setup_files(dirs, &args.source, true),
        ModeLoad::Copy => setup_files(dirs, &args.source, false),
        ModeLoad::Nothing => {},
    };

    if args.update {
        update_sys();
    }

    let pac_packs = configuration.pacman.unwrap_or(default_conf.pacman.unwrap()).packages;
    if args.pacman_dep {
        install_pacman_deps(pac_packs);
    }

    let aur_packs = configuration.paru.unwrap_or(default_conf.paru.unwrap()).packages;
    if args.aur_dep {
        install_paru_deps(aur_packs);
    }

    let dm = configuration.display_manager.unwrap_or(default_conf.display_manager.unwrap()).conf;
    if args.display {
        setup_display_manager(dm);
    }

    if args.setup {
        setup_system();
    }

}
