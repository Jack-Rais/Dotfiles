
use clap::{ ArgAction, Parser, Subcommand };
use std::path::PathBuf;

use crate::utils::get_source_dir;


#[derive(Parser, Debug)]
#[command(version, about, long_about = None)]
pub struct ArgumentParser {
    
    #[command(subcommand)]
    pub option: Option<Commands>,

}

#[derive(Subcommand, Debug)]
pub enum Commands {
    
    /// Setup a new wallpaper
    #[command(visible_aliases = &["w", "wall"])]
    Wallpaper {
        
        #[arg(short, long)]
        image_dir: PathBuf,

    },
    
    /// Manage dotfiles
    #[command(visible_aliases = &["d", "dot"])]
    Dotfiles {
        
        #[arg(short = 'c', long = "copy", action = ArgAction::SetFalse, default_value_t = true)]
        link: bool,

        #[arg(
            short, 
            long, 
            help = "Source directory", 
            value_name = "DIR",
            default_value = get_source_dir().into_os_string()
        )]
        source: PathBuf,

        #[arg(
            short, 
            long, 
            help = "Destination directory", 
            value_name = "DIR",
            default_value = "~/.config"
        )]
        destination: PathBuf

    }
}



