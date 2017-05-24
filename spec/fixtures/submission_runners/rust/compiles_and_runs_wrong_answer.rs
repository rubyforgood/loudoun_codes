use std::io::{self};
use std::io::prelude::*;

fn main() {
  let stdin = io::stdin();
  loop {
    match stdin.lock().lines().map(|x| x.unwrap()).next() {
      Some(x) => {
        let mut c = x.chars();
        let first = c.next().unwrap();
        println!("{}{}ape", c.as_str(), first);
      },
      None => {break},
    }
  }
}
