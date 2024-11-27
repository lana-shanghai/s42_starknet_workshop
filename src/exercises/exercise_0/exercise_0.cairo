use core::pedersen::PedersenTrait;
use core::hash::HashStateTrait;

pub fn hash_value(mut input: Span<felt252>) -> felt252 {
    // Your code go there.
    // 1. Create a new pedersen hasher
    let mut state = PedersenTrait::new(0);
    // 2. Iterate over all the values in `input` and use them to update the hasher
    while !SpanTrait::is_empty(input) {
        let value = input.pop_front().unwrap();
        state = state.update(*value);
    };
    // 3. Finalize the hash
    let hash_final = state.finalize();
    // 4. Return the hash
    return hash_final;
    // return 0;
}

/// A cairo function that returns true if you pass an input and its pedersen hash
///
/// If you prove this execution while keeping `secret_input` private,
/// you will have proved that you know a value such as it's pedersen hash is `hash`.
fn is_valid_hash(secret_input: Array<felt252>, hash: felt252) -> bool {
    let candidate_hash = hash_value(secret_input.span());

    return candidate_hash == hash;
}
