//! Binary used to sign a payload
//!
//! This has been used to generate the values used for the ex02 tests

use starknet::{core::types::Felt, signers::SigningKey};

fn main() {
    // The private key we want to use
    let pk = SigningKey::from_secret_scalar(Felt::from_hex_unchecked(
        "0x05da0aa1fe03401cee5be996538aacd2a2eb03b5f6f9294b647b3c8cab1c7fa5",
    ));
    // The hash of the b64 encoding of the "Hello world!"" string
    let hash_of_b64_of_hello_world = Felt::from_dec_str(
        "1133969339132307942360090870831411765742157091296973940006677197954296710935",
    )
    .unwrap();

    let signature = pk.sign(&hash_of_b64_of_hello_world).unwrap();

    println!("{:?}", signature);
}
