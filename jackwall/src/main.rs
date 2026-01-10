
pub mod parser;
pub mod targets {
    pub mod wallpaper;
    pub mod profile;
    pub mod display_manager;
}

use std::io::Write;

use targets::{
    wallpaper::execute_wallpaper_command,
    profile::execute_profile_command,
    display_manager::execute_display_manager_command
};
use parser::WallArguments;

use clap::Parser;
use env_logger::{Builder, Env, Target, WriteStyle};
use chrono::Local;




fn main() {

    //          ╭─────────────────────────────────────────────────────────╮
    //          │                Setup builder for logging                │
    //          ╰─────────────────────────────────────────────────────────╯

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

    log::info!("Applicazione Avviata");

    //          ╭─────────────────────────────────────────────────────────╮
    //          │             Parsing command line arguments              │
    //          ╰─────────────────────────────────────────────────────────╯

    let args = WallArguments::parse();

    if let Some(wallpaper_img) = args.wallpaper {
        execute_wallpaper_command(wallpaper_img, args.reload);
    }

    if let Some(profile_img) = args.profile {
        execute_profile_command(profile_img, args.user);
    }

    if let Some(dm_image) = args.display_manager {
        execute_display_manager_command(dm_image);
    }

}
