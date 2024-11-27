/// Write a function, so that, given an array of
/// values, it outputs the root hash of a merkle-tree
///
/// If the inputs is empty return 0
/// If the inputs contain a single element, return it's value
/// Otherwise compute the merkle trie following those rules:
/// - recursively hash values two by two using pedersen hash
/// - if the number of values is odd, hash the last element with itself

use core::pedersen::pedersen;

pub fn merkle_root(inputs: Span<felt252>) -> felt252 {
    return 0xbabe;
}

pub fn is_hash_root_of_input_trie(input: Array<felt252>, hash_candidate: felt252) -> bool {
    let root = merkle_root(input.span());

    return root == hash_candidate;
}

