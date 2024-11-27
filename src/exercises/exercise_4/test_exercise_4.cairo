use s42_starknet_workshop::exercises::exercise_4::exercise_4::verify_proof_of_inclusion;
use s42_starknet_workshop::exercises::exercise_4::exercise_4::Position;
use core::pedersen::pedersen;


#[test]
fn test_ok() {
    // Root of [1, 2, 3, 4]
    let root = 3000975577331064457418989440417805546270001226817465829206893032529539211230;

    let value = 2;
    let pedersen_of_3_and_4 = pedersen(3, 4);

    let proof = array![(Position::Left, 1), (Position::Right, pedersen_of_3_and_4)];

    assert!(verify_proof_of_inclusion(root, value, proof));
}

#[test]
fn test_wrong_root() {
    let root = 0xbabe;

    let value = 2;
    let pedersen_of_3_and_4 = pedersen(3, 4);

    let proof = array![(Position::Left, 1), (Position::Right, pedersen_of_3_and_4)];

    assert!(!verify_proof_of_inclusion(root, value, proof));
}

#[test]
fn test_wrong_value() {
    // Root of [1, 2, 3, 4]
    let root = 3000975577331064457418989440417805546270001226817465829206893032529539211230;

    let value = 0xbabe;
    let pedersen_of_3_and_4 = pedersen(3, 4);

    let proof = array![(Position::Left, 1), (Position::Right, pedersen_of_3_and_4)];

    assert!(!verify_proof_of_inclusion(root, value, proof));
}

#[test]
fn test_wrong_proof_extra_elem() {
    // Root of [1, 2, 3, 4]
    let root = 3000975577331064457418989440417805546270001226817465829206893032529539211230;

    let value = 2;
    let pedersen_of_3_and_4 = pedersen(3, 4);

    let proof = array![
        (Position::Left, 1), (Position::Right, pedersen_of_3_and_4), (Position::Left, 0xbabe)
    ];

    assert!(!verify_proof_of_inclusion(root, value, proof));
}

#[test]
fn test_wrong_proof_missing_elem() {
    // Root of [1, 2, 3, 4]
    let root = 3000975577331064457418989440417805546270001226817465829206893032529539211230;

    let value = 2;

    let proof = array![(Position::Left, 1)];

    assert!(!verify_proof_of_inclusion(root, value, proof));
}

#[test]
fn test_wrong_proof() {
    // Root of [1, 2, 3, 4]
    let root = 3000975577331064457418989440417805546270001226817465829206893032529539211230;

    let value = 2;
    let pedersen_of_3_and_4 = pedersen(3, 4);

    let proof = array![(Position::Right, 1), (Position::Right, pedersen_of_3_and_4)];

    assert!(!verify_proof_of_inclusion(root, value, proof));
}
