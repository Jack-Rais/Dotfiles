
pub mod parser;
pub mod targets {
    pub mod wallpaper;
    pub mod profile;
}

use std::io::Write;

use targets::{
    wallpaper::execute_wallpaper_command,
    profile::execute_profile_command
};
use parser::{
    WallArguments,
    TargetImage
};

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
    match args.target {
        TargetImage::Wallpaper => execute_wallpaper_command(args.image),
        TargetImage::Profile => execute_profile_command(args.image),
        TargetImage::DisplayManager => {}
    }

}
