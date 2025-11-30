
use std::path::PathBuf;
use std::env::current_dir;

pub fn get_source_dir() -> PathBuf {
    current_dir()
        .unwrap_or_else(|_| PathBuf::from("./"))
        .join("..")
        .canonicalize()
        .expect("Could not canonicalize source directory")
}
