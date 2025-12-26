
use std::env::{current_dir, var};
use std::fs::{ReadDir, read_dir};
use std::io::Result;
use std::path::{Path, PathBuf};
use std::process::Command;

use log::{debug, info};


struct Finder {
    stack: Vec<ReadDir>
}
impl Finder {

    fn new(root: &Path) -> Self {
        let mut stack = Vec::new();
        if let Ok(rd) = read_dir(root) {
            stack.push(rd);
        }
        Self { stack }
    }

}
impl Iterator for Finder {
    type Item = PathBuf;

    fn next(&mut self) -> Option<Self::Item> {

        while let Some(parent) = self.stack.last_mut() {

            if let Some(child) = parent.next() {
                let path = child.ok()?.path();
                if path.is_dir() && let Ok(child_parent) = read_dir(&path) {
                    self.stack.push(child_parent);
                }
                return Some(path)
            }
            else {
                self.stack.pop();
            }
        }

        None
    }

}


pub fn setup_files(program: &str, args: &str, dirs: Vec<PathBuf>) -> Result<()> {

    info!("Setting up files in .config");

    let dir = current_dir().unwrap().join(PathBuf::from("../../")).canonicalize().unwrap();
    for input_dir in dirs {
        info!("Scanning {input_dir:?}");

        let origin = dir.join(&input_dir);
        let dest = PathBuf::from(var("HOME").expect("Could not get HOME var")).join(".config").join(&input_dir);

        let find = Finder::new(&origin);
        for origin_file in find {

            let dest_file = dest.join(origin_file.strip_prefix(&origin).unwrap());

            debug!("{origin_file:?} -> {dest_file:?}");
            Command::new(program)
                .arg(args)
                .arg(&origin_file)
                .arg(dest_file)
                .spawn()?
                .wait()?;

        }

    }

    Ok(())

}
