/// A cairo program that returns true if you pass an input (a number) and its hash

use core::pedersen::PedersenTrait;
use core::hash::HashStateTrait;

pub fn hash_value(mut arr: Array<felt252>) -> felt252 {
    let mut state = PedersenTrait::new(0);

    while arr.len() > 0 {
        let value = arr.pop_front().unwrap();
        state = state.update(value);
    };

    let hash_final = state.finalize();
    return hash_final;
}

fn is_hash(value: Array<felt252>, hash: felt252) -> bool {
    let value_hashed = hash_value(value);
    value_hashed == hash
}
