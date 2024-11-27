use core::pedersen::PedersenTrait;
use core::hash::HashStateTrait;

pub fn hash_value(mut input: Span<felt252>) -> felt252 {
    // Your code go there.
    // 1. Create a new pedersen hasher

    // 2. Iterate over all the values in `input` and use them to update the hasher

    // 3. Finalize the hash

    // 4. Return the hash
    return 0;
}

/// A cairo function that returns true if you pass an input and its pedersen hash
///
/// If you prove this execution while keeping `secret_input` private,
/// you will have proved that you know a value such as it's pedersen hash is `hash`.
fn is_valid_hash(secret_input: Array<felt252>, hash: felt252) -> bool {
    let computed_hash = hash_value(secret_input.span());

    return computed_hash == hash;
}
