/// Write a cairo program that verifies that given an input, 
/// a signature and a pubkey, the signature is valid for the 
/// hash of the base64 encoding of input (reuse ex. 0 & 1)

use core::ecdsa::check_ecdsa_signature;
use s42_starknet_workshop::exercises::exercise_0::exercise_0::hash_value;
use s42_starknet_workshop::exercises::exercise_1::exercise_1::Base64;

fn check_sig(input: Array<felt252>, signature_r: felt252, signature_s: felt252, pubkey: felt252) -> bool {
    let base64 = input.encode();
    let message_hash = hash_value(base64.span());
    return (check_ecdsa_signature(message_hash, pubkey, signature_r, signature_s) == true);
}
