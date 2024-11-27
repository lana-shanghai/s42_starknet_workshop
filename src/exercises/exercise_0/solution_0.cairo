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
}
