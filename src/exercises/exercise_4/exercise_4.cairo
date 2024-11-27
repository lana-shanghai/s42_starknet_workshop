use core::pedersen::pedersen;

#[derive(Drop)]
/// Describe wether the proof element should be the lhs or rhs of the pedersen call
pub enum Position {
    Left,
    Right
}

pub fn verify_proof_of_inclusion(
    root_hash: felt252, leaf_value: felt252, proof: Array<(Position, felt252)>
) -> bool {
    let mut hash = leaf_value;

    for (
        position, p
    ) in proof {
        hash = match position {
            Position::Left => pedersen(p, hash),
            Position::Right => pedersen(hash, p),
        };
    };

    hash == root_hash
}

