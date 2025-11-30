
pub mod parser;
pub mod utils;
pub mod commands {
    pub mod dotfiles;
    pub mod wallpaper;
}

use commands::{
    dotfiles::execute_dotfiles_command,
    wallpaper::execute_wallpaper_command
};

use std::io::Write;

use clap::Parser;
use parser::{
    ArgumentParser,
    Commands
};
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

    let args = ArgumentParser::parse();

    match args.option.unwrap() {
        Commands::Wallpaper { image_dir } => execute_wallpaper_command(image_dir),
        Commands::Dotfiles { link, source, destination } => execute_dotfiles_command(link, source, destination)
    }

}
