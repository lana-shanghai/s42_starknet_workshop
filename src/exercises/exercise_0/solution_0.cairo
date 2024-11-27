use core::pedersen::PedersenTrait;
use core::hash::HashStateTrait;

pub fn hash_value(mut input: Span<felt252>) -> felt252 {
    let mut state = PedersenTrait::new(0);

    while !SpanTrait::is_empty(input) {
        let value = input.pop_front().unwrap();
        state = state.update(*value);
    };

    let hash_final = state.finalize();
    return hash_final;
}

fn is_valid_hash(secret_input: Array<felt252>, hash: felt252) -> bool {
    let candidate_hash = hash_value(secret_input.span());

    return candidate_hash == hash;
}
