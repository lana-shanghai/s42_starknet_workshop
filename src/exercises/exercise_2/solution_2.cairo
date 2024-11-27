pub fn check_sig(
    input: Span<felt252>, signature_r: felt252, signature_s: felt252, pubkey: felt252
) -> bool {
    let base64 = input.encode();

    let message_hash = hash_value(base64.span());

    return check_ecdsa_signature(message_hash, pubkey, signature_r, signature_s);
}
