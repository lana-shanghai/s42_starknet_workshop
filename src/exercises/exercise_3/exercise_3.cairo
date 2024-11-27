/// Write a function, so that, given an array of
/// values, it outputs the root hash of a merkle-tree
///
/// If the inputs is empty return 0
/// If the inputs contain a single element, return it's value
/// Otherwise compute the merkle trie following those rules:
/// - recursively hash values two by two using pedersen hash
/// - if the number of values is odd, hash the last element with itself

use core::pedersen::pedersen;

pub fn merkle_root(hashes: Span<felt252>) -> felt252 {
    let len = hashes.len();

    if len == 0 {
        return 0;
    }
    if len == 1 {
        return *hashes[0];
    }

    let (_, is_odd) = core::traits::DivRem::div_rem(len, 2);
    let mut arr = hashes;
    let mut next_hashes: Array<felt252> = array![];

    while let Option::Some(v) = arr.multi_pop_front::<2>() {
        let [a, b] = (*v).unbox();
        next_hashes.append(pedersen(a, b));
    };

    if (is_odd == 1) {
        let last = *arr.pop_front().unwrap();
        next_hashes.append(pedersen(last, last));
    } else if (*hashes[len - 1] == *hashes[len - 2]) {
        // CVE-2012-2459 bug fix
        panic!("unexpected node duplication in merkle tree");
    }

    merkle_root(next_hashes.span())
}

pub fn is_hash_root_of_input_trie(input: Array<felt252>, hash_candidate: felt252) -> bool {
    let root = merkle_root(input.span());

    return root == hash_candidate;
}

