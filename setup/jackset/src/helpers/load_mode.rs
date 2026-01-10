
use std::fs;
use std::os::unix::fs::symlink;
use std::path::{Path, PathBuf};
use std::env::var;

use log::{debug, info};


struct Finder {
    stack: Vec<PathBuf>
}
impl Finder {

    fn new(dir: &Path) -> Self {

        Self {
            stack: fs::read_dir(dir).expect("Could not read dir").filter_map(|x| {
                if let Ok(y) = x {
                    Some(y.path())
                }
                else {
                    None
                }
            }).collect()
        }

    }
}
impl Iterator for Finder {

    type Item = PathBuf;
    fn next(&mut self) -> Option<Self::Item> {

        while let Some(item) = self.stack.pop() {

            if item.is_dir() {
                if let Ok(rd) = fs::read_dir(item) {
                    let children: Vec<_> = rd.filter_map(|x| {
                        if let Ok(y) = x {
                            return Some(y.path());
                        }
                        None
                    }).collect();
                    self.stack.extend_from_slice(&children);
                }
            }
            else {
                return Some(item.to_path_buf())
            }

        }
        None

    }

}



pub fn setup_files(configs: Vec<String>, source: &Path, link: bool) {

    let destination = PathBuf::from(var("HOME").expect("Could not get HOME dir")).join(".config");

    for name_conf in configs {
        info!("Processing: {name_conf}");

        let dest_conf = destination.join(&name_conf);
        let origin_conf = source.join(&name_conf);

        if dest_conf.exists() {
            info!("Cleaning {name_conf}");
            fs::remove_dir_all(&dest_conf).expect("Could not clean dir");
        }

        let finder = Finder::new(&origin_conf);
        for origin_file in finder {

            let dest_file = dest_conf.join(origin_file.strip_prefix(&origin_conf).unwrap());
            fs::create_dir_all(dest_file.parent().unwrap()).unwrap();

            debug!("{origin_file:?} -> {dest_file:?}");

            if link {
                symlink(origin_file, dest_file).unwrap();
            }
            else {
                fs::copy(origin_file, dest_file).unwrap();
            }
        }

    }

}
