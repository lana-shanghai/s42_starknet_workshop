use s42_starknet_workshop::exercises::exercise_3::exercise_3::is_hash_root_of_input_trie;

#[test]
fn test_even() {
    let mut inputs = array![0x1, 0x2, 0x3, 0x4,];

    let expected_merkle_root =
        3000975577331064457418989440417805546270001226817465829206893032529539211230;

    assert!(is_hash_root_of_input_trie(inputs, expected_merkle_root));
}

#[test]
fn test_odd() {
    let mut inputs = array![0x1, 0x2, 0x3, 0x4, 0x5,];

    let expected_merkle_root =
        2828376545101278113329724642903426034037626907805734589301789029815568034811;

    assert!(is_hash_root_of_input_trie(inputs, expected_merkle_root));
}

#[test]
fn test_empty() {
    let mut inputs = array![];

    let expected_merkle_root = 0;

    assert!(is_hash_root_of_input_trie(inputs, expected_merkle_root));
}

#[test]
fn test_single_element() {
    let mut inputs = array![0xbabe];

    let expected_merkle_root = 0xbabe;

    assert!(is_hash_root_of_input_trie(inputs, expected_merkle_root));
}
