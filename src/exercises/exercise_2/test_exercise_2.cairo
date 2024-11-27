use s42_starknet_workshop::exercises::exercise_2::exercise_2::check_sig;

const PUBKEY: felt252 = 0x04846cc59dffd74ac01f566f3278a9e66e150b12c8d7fc6ebd1fad7395bee61f;

#[test]
fn test_ok() {
    let r = 0x3495de65f6683ed7574ee43c4916813adfd848dafef6b62a78b97d3112e3993;
    let s = 0x23ece8f926f9c73a78cd268796da9a272d176fb51ee0c5bd70a5095b13a0308;
    let message = array!['Hello world!'];

    let is_valid_signature = check_sig(message.span(), r, s, PUBKEY);

    assert!(is_valid_signature);
}

#[test]
fn test_bad_signature() {
    let r = 0xbabe;
    let s = 0xcafe;
    let message = array!['Hello world!'];

    let is_valid_signature = check_sig(message.span(), r, s, PUBKEY);

    assert!(!is_valid_signature);
}

#[test]
fn test_valid_signature_but_wrong_message() {
    let r = 0x3495de65f6683ed7574ee43c4916813adfd848dafef6b62a78b97d3112e3993;
    let s = 0x23ece8f926f9c73a78cd268796da9a272d176fb51ee0c5bd70a5095b13a0308;
    let message = array!['Hello planet earth!'];

    let is_valid_signature = check_sig(message.span(), r, s, PUBKEY);

    assert!(!is_valid_signature);
}

#[test]
fn test_wrong_pubkey() {
    let r = 0x3495de65f6683ed7574ee43c4916813adfd848dafef6b62a78b97d3112e3993;
    let s = 0x23ece8f926f9c73a78cd268796da9a272d176fb51ee0c5bd70a5095b13a0308;
    let message = array!['Hello world!'];

    let is_valid_signature = check_sig(message.span(), r, s, PUBKEY - 1);

    assert!(!is_valid_signature);
}
